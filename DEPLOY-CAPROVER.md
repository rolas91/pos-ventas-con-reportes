# Despliegue en CapRover (método recomendado)

Este proyecto sigue el [recipe oficial de CapRover para apps React estáticas](https://caprover.com/docs/recipe-deploy-create-react-app.html): **construyes en tu máquina** y subes solo el bundle estático. Así el servidor no hace el build (menos RAM/CPU) y el deploy es más rápido.

## Ventajas de este método

- **Build en tu PC**: ya tienes `node_modules` y las variables de Supabase en `.env`; el build no se hace en el servidor.
- **Subes solo lo necesario**: `captain-definition` + carpeta `dist` (sin código fuente ni dependencias).
- **Imagen ligera**: se usa [socialengine/nginx-spa](https://hub.docker.com/r/socialengine/nginx-spa), que ya trae nginx configurado para SPA (todas las rutas → `index.html` para React Router).

## Requisitos

- CapRover instalado en tu servidor.
- [CLI de CapRover](https://caprover.com/docs/cli.html) instalado en tu máquina (`npm i -g caprover`).
- Tu proyecto con `.env` configurado (Supabase) para el build.

---

## Pasos

### 1. Crear la app en CapRover

1. Panel de CapRover → **Apps** → **Create New App**.
2. Nombre (ej: `pos-ventas`) → Crear.
3. En **App Configs** → **Domain**: asigna tu dominio y activa HTTPS si lo usas.

### 2. Build local (con tus variables de Supabase)

Desde la raíz del proyecto, con tu `.env` ya configurado:

```bash
npm run build
```

Esto genera la carpeta `dist/` con las variables `VITE_APP_SUPABASE_*` ya embebidas.

### 3. Crear el tar con lo que CapRover necesita

Se crea un tar cuya **raíz** contiene el contenido de `dist` (index.html, assets, etc.) más `captain-definition`. Así se evita el error "dist: file does not exist" que puede darse en Windows al empaquetar la carpeta `dist` directamente.

**Forma recomendada: usar el script** (crea el tar correctamente en cualquier OS):

```powershell
.\deploy-caprover.ps1
```

**Manual (PowerShell):** construir, luego empaquetar con una carpeta temporal para que la raíz del tar tenga los archivos a servir:

```powershell
npm run build
New-Item -ItemType Directory -Force -Path deploy-pack | Out-Null
Copy-Item captain-definition deploy-pack\
Copy-Item -Path dist\* -Destination deploy-pack\ -Recurse -Force
tar -cvf deploy.tar -C deploy-pack .
Remove-Item -Path deploy-pack -Recurse -Force
```

**Manual (Linux/macOS):** mismo concepto: copiar contenido de `dist` y `captain-definition` a una carpeta, luego `tar -cvf deploy.tar -C esa-carpeta .`

### 4. Desplegar con la CLI de CapRover

```bash
caprover deploy -t ./deploy.tar
```

La CLI te pedirá:

- URL del servidor CapRover (ej: `https://captain.tudominio.com`).
- Contraseña del panel.
- Nombre de la app (el que creaste en el paso 1).

Tras subir el tar, CapRover construye la imagen (solo copia `dist` a nginx-spa) y pone la app en marcha.

---

## Resumen de archivos para este método

| Archivo | Uso |
|--------|-----|
| `captain-definition` | Define la imagen: `socialengine/nginx-spa` + `COPY . /app` (el tar lleva el contenido de `dist` en la raíz). |
| `dist/` | Salida de `npm run build`; su contenido se empaqueta en la raíz del tar (no se sube a Git). |

La imagen usa **socialengine/nginx-spa**, que ya sirve la SPA correctamente (rutas como `/pos`, `/reportes` devuelven `index.html`).

---

## Script rápido (opcional)

Puedes usar un script para no repetir los comandos.

**`deploy-caprover.sh`** (Linux/macOS/Git Bash):

```bash
#!/bin/bash
set -e
echo "Building..."
npm run build
echo "Creating deploy.tar..."
tar -cvf deploy.tar --exclude='*.map' ./captain-definition ./dist
echo "Deploying..."
caprover deploy -t ./deploy.tar
echo "Done."
```

**PowerShell** (`deploy-caprover.ps1`):

```powershell
npm run build
tar -cvf deploy.tar --exclude='*.map' captain-definition dist
caprover deploy -t ./deploy.tar
```

---

## Alternativa: build en el servidor (desde Git)

Si prefieres que CapRover haga el build a partir del repositorio Git (por ejemplo para webhooks automáticos), puedes usar el **Dockerfile** que está en el proyecto:

1. Sustituir temporalmente el contenido de `captain-definition` por:
   ```json
   { "schemaVersion": 2, "dockerfilePath": "./Dockerfile" }
   ```
2. En CapRover, configurar las variables **VITE_APP_SUPABASE_URL** y **VITE_APP_SUPABASE_ANON_KEY** como Build Arguments (o en el método que use tu versión de CapRover para el build).
3. Desplegar desde Git como en la documentación estándar de CapRover.

Ese método consume más RAM/CPU en el servidor durante el build; el recomendado por CapRover es el de **build local + deploy con tar** que se describe arriba.
