#!/bin/bash

cd ~/repos

echo api-builder        && cd api-builder       && git pull ; cd ../
echo api-framework      && cd api-framework     && git pull ; cd ../
echo cloudlet-api       && cd cloudlet-api      && git pull ; cd ../
echo cloudlet-platform  && cd cloudlet-platform && git pull ; cd ../
echo cloudlet-utils     && cd cloudlet-utils    && git pull ; cd ../
echo dao                && cd dao               && git pull ; cd ../
echo dbc                && cd dbc               && git pull ; cd ../
echo m2nodehandler      && cd m2nodehandler     && git pull ; cd ../
echo mongrel2           && cd mongrel2          && git pull ; cd ../
echo notifications      && cd notifications     && git pull ; cd ../
echo object-api         && cd object-api        && git pull ; cd ../
echo openi-logger       && cd openi-logger      && git pull ; cd ../
echo openi_android_sdk  && cd openi_android_sdk && git pull ; cd ../
echo swagger-def        && cd swagger-def       && git pull ; cd ../
echo type-api           && cd type-api          && git pull ; cd ../
echo auth-api           && cd auth-api          && git pull ; cd ../
echo crud-api           && cd crud-api          && git pull ; cd ../
echo uaa                && cd uaa               && git pull ; cd ../