#!/bin/bash
rm -fr ~/repos/cloudlet-platform/node_modules/dao
rm -fr ~/repos/cloudlet-platform/node_modules/cloudlet_api
rm -fr ~/repos/cloudlet-platform/node_modules/object_api
rm -fr ~/repos/cloudlet-platform/node_modules/attachment_api
rm -fr ~/repos/cloudlet-platform/node_modules/search_api
rm -fr ~/repos/cloudlet-platform/node_modules/swagger-def
rm -fr ~/repos/cloudlet-platform/node_modules/type_api
rm -fr ~/repos/cloudlet-platform/node_modules/notifications
rm -fr ~/repos/cloudlet-platform/node_modules/permissions_api
rm -fr ~/repos/cloudlet-platform/node_modules/auth-api
rm -fr ~/repos/cloudlet-platform/node_modules/crud-api

ln -s ~/repos/dao/             ~/repos/cloudlet-platform/node_modules/dao
ln -s ~/repos/cloudlet-api/    ~/repos/cloudlet-platform/node_modules/cloudlet_api
ln -s ~/repos/object-api/      ~/repos/cloudlet-platform/node_modules/object_api
ln -s ~/repos/attachment-api/      ~/repos/cloudlet-platform/node_modules/attachment_api
ln -s ~/repos/search_api/      ~/repos/cloudlet-platform/node_modules/search_api
ln -s ~/repos/swagger-def/     ~/repos/cloudlet-platform/node_modules/swagger-def
ln -s ~/repos/type-api/        ~/repos/cloudlet-platform/node_modules/type_api
ln -s ~/repos/notifications/   ~/repos/cloudlet-platform/node_modules/notifications
ln -s ~/repos/permissions_api/ ~/repos/cloudlet-platform/node_modules/permissions_api
ln -s ~/repos/auth-api/        ~/repos/cloudlet-platform/node_modules/auth-api
ln -s ~/repos/crud-api/        ~/repos/cloudlet-platform/node_modules/crud-api
