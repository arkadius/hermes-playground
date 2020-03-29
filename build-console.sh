#!/bin/bash

echo "Building hermes-console..."

rm -rf modules/console/*
cp -r ${HERMES_PATH}/hermes-console/ modules/console
cat config.json > modules/console/config.json


# replace getting configuration from /config endpoint to config.json file
sed -i -e 's#<script src="/console"></script>#<script src="config"></script>#g' modules/console/static/index.html
rm modules/console/static/index.html-e

# building app
cd modules/console
npm install --production --yes
bower install --allow-root -F
cp -r static dist
cd ../..

