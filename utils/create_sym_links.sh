#!/bin/bash
rm -fr ~/repos/cloudlet-platform/node_modules/dao
rm -fr ~/repos/cloudlet-platform/node_modules/cloudlet-api
rm -fr ~/repos/cloudlet-platform/node_modules/object-api
rm -fr ~/repos/cloudlet-platform/node_modules/attachment-api
rm -fr ~/repos/cloudlet-platform/node_modules/search-api
rm -fr ~/repos/cloudlet-platform/node_modules/swagger-def
rm -fr ~/repos/cloudlet-platform/node_modules/type-api
rm -fr ~/repos/cloudlet-platform/node_modules/notifications
rm -fr ~/repos/cloudlet-platform/node_modules/permissions-api
rm -fr ~/repos/cloudlet-platform/node_modules/auth-api
rm -fr ~/repos/cloudlet-platform/node_modules/crud-api
rm -fr ~/repos/cloudlet-platform/node_modules/openi-aggregator

ln -s ~/repos/dao/             ~/repos/cloudlet-platform/node_modules/dao
ln -s ~/repos/cloudlet-api/    ~/repos/cloudlet-platform/node_modules/cloudlet-api
ln -s ~/repos/object-api/      ~/repos/cloudlet-platform/node_modules/object-api
ln -s ~/repos/attachment-api/      ~/repos/cloudlet-platform/node_modules/attachment-api
ln -s ~/repos/search-api/      ~/repos/cloudlet-platform/node_modules/search-api
ln -s ~/repos/swagger-def/     ~/repos/cloudlet-platform/node_modules/swagger-def
ln -s ~/repos/type-api/        ~/repos/cloudlet-platform/node_modules/type-api
ln -s ~/repos/notifications/   ~/repos/cloudlet-platform/node_modules/notifications
ln -s ~/repos/permissions-api/ ~/repos/cloudlet-platform/node_modules/permissions-api
ln -s ~/repos/auth-api/        ~/repos/cloudlet-platform/node_modules/auth-api
ln -s ~/repos/crud-api/        ~/repos/cloudlet-platform/node_modules/crud-api
ln -s ~/repos/openi-aggregator/        ~/repos/cloudlet-platform/node_modules/openi-aggregator
