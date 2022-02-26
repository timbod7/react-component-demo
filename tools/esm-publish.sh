#!/bin/bash
set -e

REPO=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )
echo "** Building...."
(cd $REPO; yarn build)

# Update the dist dir reaady for publishing
cp -r $REPO/src $REPO/dist
jq 'del(.scripts)|del(.devDependencies)|del(.files)' <$REPO/package.json  >$REPO/dist/package.json

echo "** Publishing...."
(cd $REPO/dist; npm publish)