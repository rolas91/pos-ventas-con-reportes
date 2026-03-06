#!/bin/bash
set -e
cd "$(dirname "$0")"
echo "Building..."
npm run build
echo "Creating deploy.tar..."
# Contenido de dist + captain-definition en la raíz del tar (evita problemas dist en Windows/Linux)
PACK_DIR=deploy-pack
mkdir -p "$PACK_DIR"
cp captain-definition "$PACK_DIR/"
cp -r dist/* "$PACK_DIR/"
find "$PACK_DIR" -name "*.map" -delete
tar -cvf deploy.tar -C "$PACK_DIR" .
rm -rf "$PACK_DIR"
echo "Deploying..."
caprover deploy -t ./deploy.tar
echo "Done."
