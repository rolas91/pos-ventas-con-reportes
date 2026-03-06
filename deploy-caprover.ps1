# Build y deploy para CapRover (método build local + tar)
# Uso: .\deploy-caprover.ps1

$ErrorActionPreference = "Stop"

# Asegurar que estamos en la raíz del proyecto (donde está captain-definition)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

npm run build
if (-not (Test-Path "dist")) { Write-Error "No existe la carpeta dist. Revisa que npm run build haya terminado bien." }

# Empaquetar: contenido de dist + captain-definition en la raíz del tar
# Así evitamos problemas con la carpeta "dist" en Windows/Linux
$packDir = "deploy-pack"
New-Item -ItemType Directory -Force -Path $packDir | Out-Null
Copy-Item "captain-definition" $packDir\
Copy-Item -Path "dist\*" -Destination $packDir\ -Recurse -Force
# Excluir .map para reducir tamaño (opcional)
Get-ChildItem -Path $packDir -Recurse -Filter "*.map" | Remove-Item -Force -ErrorAction SilentlyContinue
tar -cvf deploy.tar -C $packDir .
Remove-Item -Path $packDir -Recurse -Force

if (-not (Test-Path "deploy.tar")) { Write-Error "No se creó deploy.tar." }
# Usar ruta relativa; la CLI de CapRover concatena el cwd y duplica la ruta si pasas absoluta
caprover deploy -t deploy.tar
