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
git clone https://github.com/OPENi-ict/admin-dashboard.git
git clone https://github.com/OPENi-ict/user-dashboard.git

cd ~/repos/admin-dashboard; npm install --no-bin-links
cd ~/repos/user-dashboard; npm install --no-bin-links
cd ~/repos/cloudlet-platform; npm install --no-bin-links
cd ~/repos/swagger-def; npm install --no-bin-links
cd ~/repos/cloudlet-api; npm install --no-bin-links
cd ~/repos/object-api; npm install --no-bin-links
cd ~/repos/attachment-api; npm install --no-bin-links
cd ~/repos/type-api; npm install --no-bin-links
cd ~/repos/search_api; npm install --no-bin-links
cd ~/repos/permissions_api; npm install --no-bin-links
cd ~/repos/dao; npm install --no-bin-links
cd ~/repos/notifications; npm install --no-bin-links
cd ~/repos/openi_rrd; npm install --no-bin-links


ln -s /home/vagrant/repos/mongrel2/uploads/ /opt/openi/cloudlet_platform/uploads
