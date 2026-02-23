# Build y deploy para CapRover (método build local + tar)
# Uso: .\deploy-caprover.ps1

$ErrorActionPreference = "Stop"
npm run build
if (-not (Test-Path "dist")) { Write-Error "No existe la carpeta dist. Revisa que npm run build haya terminado bien." }
tar -cvf deploy.tar --exclude='*.map' captain-definition dist
if (-not (Test-Path "deploy.tar")) { Write-Error "No se creó deploy.tar. Revisa el comando tar." }
caprover deploy -t (Resolve-Path "deploy.tar").Path
