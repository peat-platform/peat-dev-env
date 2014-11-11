#!/bin/bash

cd ~/repos


git clone https://github.com/OPENi-ict/cloudlet-platform.git
git clone https://github.com/OPENi-ict/swagger-def.git
git clone https://github.com/OPENi-ict/cloudlet-api.git
git clone https://github.com/OPENi-ict/object-api.git
git clone https://github.com/OPENi-ict/type-api.git
git clone https://github.com/OPENi-ict/m2nodehandler.git
git clone https://github.com/OPENi-ict/dao.git
git clone https://github.com/OPENi-ict/mongrel2.git
git clone https://github.com/OPENi-ict/dbc.git
git clone https://github.com/OPENi-ict/cloudlet-utils.git
git clone https://github.com/OPENi-ict/openi-logger.git
git clone https://github.com/OPENi-ict/notifications.git



sudo mv /tmp/kibana-3.1.1 /home/vagrant/repos/mongrel2/kibana

cd ~/repos/cloudlet-platform; npm install --no-bin-links
