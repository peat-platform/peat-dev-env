#!/bin/bash

cd ~/repos


git clone -b finalOPENiMerge https://github.com/peat-platform/cloudlet-platform.git
git clone -b finalOPENiMerge https://github.com/peat-platform/swagger-def.git
git clone -b finalOPENiMerge https://github.com/peat-platform/cloudlet-api.git
git clone -b finalOPENiMerge https://github.com/peat-platform/object-api.git
git clone -b finalOPENiMerge https://github.com/peat-platform/attachment-api.git
git clone -b finalOPENiMerge https://github.com/peat-platform/type-api.git
git clone -b finalOPENiMerge https://github.com/peat-platform/search-api.git
git clone -b finalOPENiMerge https://github.com/peat-platform/permissions-api.git
git clone -b finalOPENiMerge https://github.com/peat-platform/m2nodehandler.git
git clone -b finalOPENiMerge https://github.com/peat-platform/dao.git
git clone -b finalOPENiMerge https://github.com/peat-platform/mongrel2.git
git clone -b finalOPENiMerge https://github.com/peat-platform/dbc.git
git clone -b finalOPENiMerge https://github.com/peat-platform/cloudlet-utils.git
git clone -b finalOPENiMerge https://github.com/peat-platform/peat-logger.git
git clone -b finalOPENiMerge https://github.com/peat-platform/notifications.git
git clone -b finalOPENiMerge https://github.com/peat-platform/peat-rrd.git
git clone -b finalOPENiMerge https://github.com/peat-platform/admin-dashboard.git
git clone -b finalOPENiMerge https://github.com/peat-platform/user-dashboard.git

cd ~/repos/admin-dashboard; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/user-dashboard; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/cloudlet-platform; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/swagger-def; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/cloudlet-api; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/object-api; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/attachment-api; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/type-api; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/search_api; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/permissions_api; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/dao; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/notifications; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/peat_rrd; git checkout finalOPENiMerge; npm install --no-bin-links


ln -s /home/vagrant/repos/mongrel2/uploads/ /opt/peat/cloudlet_platform/uploads
