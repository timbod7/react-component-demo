#!/bin/bash
set -e

ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )
echo "** Building...."
(cd $ROOT_DIR; yarn build)

# Tidy the package file for publishing
jq 'del(.scripts)|del(.devDependencies)|del(.files)' <$ROOT_DIR/package.json  >$ROOT_DIR/dist/package.json

echo "** Publishing...."
(cd $ROOT_DIR/dist; npm publish)