#!/bin/bash
rm -fr ~/repos/cloudlet-platform/node_modules/dao
rm -fr ~/repos/cloudlet-platform/node_modules/swagger-def

ln -s ~/repos/dao/             ~/repos/cloudlet-platform/node_modules/dao
ln -s ~/repos/swagger-def/     ~/repos/cloudlet-platform/node_modules/swagger-def
