#!/bin/bash

cd ~/repos


git clone https://github.com/OPENi-ict/cloudlet-platform.git
git clone https://github.com/OPENi-ict/swagger-def.git
git clone https://github.com/OPENi-ict/cloudlet-api.git
git clone https://github.com/OPENi-ict/object-api.git
git clone https://github.com/OPENi-ict/attachment-api.git
git clone https://github.com/OPENi-ict/type-api.git
git clone https://github.com/OPENi-ict/search_api.git
git clone https://github.com/OPENi-ict/permissions_api.git
git clone https://github.com/OPENi-ict/m2nodehandler.git
git clone https://github.com/OPENi-ict/dao.git
git clone https://github.com/OPENi-ict/mongrel2.git
git clone https://github.com/OPENi-ict/dbc.git
git clone https://github.com/OPENi-ict/cloudlet-utils.git
git clone https://github.com/OPENi-ict/openi-logger.git
git clone https://github.com/OPENi-ict/notifications.git
git clone https://github.com/OPENi-ict/openi_rrd.git


cd ~/repos/cloudlet-platform; npm install --no-bin-links


ln -s /home/vagrant/repos/mongrel2/uploads/ /opt/openi/cloudlet_platform/uploads
