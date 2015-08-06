#!/bin/bash

cd ~/repos


git clone -b finalOPENiMerge https://github.com/peat-platform/cloudlet-platform.git
git clone -b finalOPENiMerge https://github.com/peat-platform/swagger-def.git
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
cd ~/repos/dao; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/notifications; git checkout finalOPENiMerge; npm install --no-bin-links
cd ~/repos/peat_rrd; git checkout finalOPENiMerge; npm install --no-bin-links


ln -s /home/vagrant/repos/mongrel2/uploads/ /opt/peat/cloudlet_platform/uploads
