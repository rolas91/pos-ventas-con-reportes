#!/bin/bash
set -e
echo "Building..."
npm run build
echo "Creating deploy.tar..."
tar -cvf deploy.tar --exclude='*.map' ./captain-definition ./dist
echo "Deploying..."
caprover deploy -t ./deploy.tar
echo "Done."
