# Build y deploy para CapRover (método build local + tar)
# Uso: .\deploy-caprover.ps1

npm run build
tar -cvf deploy.tar --exclude='*.map' captain-definition dist
caprover deploy -t ./deploy.tar
