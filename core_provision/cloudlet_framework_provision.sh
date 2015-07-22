#!/bin/bash

cd ~/repos


git clone https://github.com/peat-platform/cloudlet-platform.git
git clone https://github.com/peat-platform/swagger-def.git
git clone https://github.com/peat-platform/cloudlet-api.git
git clone https://github.com/peat-platform/object-api.git
git clone https://github.com/peat-platform/attachment-api.git
git clone https://github.com/peat-platform/type-api.git
git clone https://github.com/peat-platform/search-api.git
git clone https://github.com/peat-platform/permissions-api.git
git clone https://github.com/peat-platform/m2nodehandler.git
git clone https://github.com/peat-platform/dao.git
git clone https://github.com/peat-platform/mongrel2.git
git clone https://github.com/peat-platform/dbc.git
git clone https://github.com/peat-platform/cloudlet-utils.git
git clone https://github.com/peat-platform/peat-logger.git
git clone https://github.com/peat-platform/notifications.git
git clone https://github.com/peat-platform/peat-rrd.git
git clone https://github.com/peat-platform/admin-dashboard.git
git clone https://github.com/peat-platform/user-dashboard.git
git clone https://github.com/peat-platform/loglet.git
git clone https://github.com/peat-platform/peat-aggregator.git

cd ~/repos/admin-dashboard; npm install --no-bin-links
cd ~/repos/user-dashboard; npm install --no-bin-links
cd ~/repos/cloudlet-platform; npm install --no-bin-links
cd ~/repos/swagger-def; npm install --no-bin-links
cd ~/repos/cloudlet-api; npm install --no-bin-links
cd ~/repos/object-api; npm install --no-bin-links
cd ~/repos/attachment-api; npm install --no-bin-links
cd ~/repos/type-api; npm install --no-bin-links
cd ~/repos/search-api; npm install --no-bin-links
cd ~/repos/permissions-api; npm install --no-bin-links
cd ~/repos/dao; npm install --no-bin-links
cd ~/repos/notifications; npm install --no-bin-links
cd ~/repos/peat-rrd; npm install --no-bin-links


ln -s /home/vagrant/repos/mongrel2/uploads/ /opt/peat/cloudlet_platform/uploads
