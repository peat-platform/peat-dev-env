#!/bin/bash

cd /home/vagrant/repos

echo cloudlet-platform  && cd cloudlet-platform && git pull ; npm install --no-bin-links ; cd ../
echo cloudlet-api       && cd cloudlet-api      && git pull ; npm install --no-bin-links ; cd ../
echo object-api         && cd object-api        && git pull ; npm install --no-bin-links ; cd ../
echo type-api           && cd type-api          && git pull ; npm install --no-bin-links ; cd ../
echo m2nodehandler      && cd m2nodehandler     && git pull ; npm install --no-bin-links ; cd ../
echo dao                && cd dao               && git pull ; npm install --no-bin-links ; cd ../
echo swagger-def        && cd swagger-def       && git pull ; npm install --no-bin-links ; cd ../
echo mongrel2           && cd mongrel2          && git pull ; cd ../
echo dbc                && cd dbc               && git pull ; npm install --no-bin-links ; cd ../
echo cloudlet-utils     && cd cloudlet-utils    && git pull ; npm install --no-bin-links ; cd ../
echo openi-logger       && cd openi-logger      && git pull ; npm install --no-bin-links ; cd ../
echo cloudlet-store     && cd cloudlet-store    && git pull ; npm install --no-bin-links ; cd ../
echo api-builder        && cd api-builder       && git pull ; cd ../
echo api-framework      && cd api-framework     && git pull ; cd ../
echo openi_android_sdk  && cd openi_android_sdk && git pull ; cd ../
echo api-builder        && cd api-builder       && git pull ; cd ../
echo cloudlet           && cd cloudlet          && git pull ; npm install --no-bin-links ; cd ../
echo uaa                && cd uaa               && git pull ; cd ../