#!/bin/bash
rm -fr /home/vagrant/repos/cloudlet-platform/node_modules/DAO/
rm -fr /home/vagrant/repos/cloudlet-platform/node_modules/cloudlet_api/
rm -fr /home/vagrant/repos/cloudlet-platform/node_modules/object_api
rm -fr /home/vagrant/repos/cloudlet-platform/node_modules/swagger-def
rm -fr /home/vagrant/repos/cloudlet-platform/node_modules/type_api

ln -s /home/vagrant/repos/dao/          /home/vagrant/repos/cloudlet-platform/node_modules/DAO
ln -s /home/vagrant/repos/cloudlet-api/ /home/vagrant/repos/cloudlet-platform/node_modules/cloudlet_api
ln -s /home/vagrant/repos/object-api/   /home/vagrant/repos/cloudlet-platform/node_modules/object_api
ln -s /home/vagrant/repos/swagger-def/  /home/vagrant/repos/cloudlet-platform/node_modules/swagger-def
ln -s /home/vagrant/repos/type-api/     /home/vagrant/repos/cloudlet-platform/node_modules/type_api