#!/bin/bash
rm -fr ~/repos/cloudlet-platform/node_modules/DAO/
rm -fr ~/repos/cloudlet-platform/node_modules/cloudlet_api/
rm -fr ~/repos/cloudlet-platform/node_modules/object_api
rm -fr ~/repos/cloudlet-platform/node_modules/swagger-def
rm -fr ~/repos/cloudlet-platform/node_modules/type_api

ln -s ~/repos/dao/          ~/repos/cloudlet-platform/node_modules/DAO
ln -s ~/repos/cloudlet-api/ ~/repos/cloudlet-platform/node_modules/cloudlet_api
ln -s ~/repos/object-api/   ~/repos/cloudlet-platform/node_modules/object_api
ln -s ~/repos/swagger-def/  ~/repos/cloudlet-platform/node_modules/swagger-def
ln -s ~/repos/type-api/     ~/repos/cloudlet-platform/node_modules/type_api