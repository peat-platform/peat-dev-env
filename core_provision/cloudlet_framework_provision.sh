#!/bin/bash

cd ~/repos


git clone https://github.com/peat-platform/cloudlet-platform.git
git clone https://github.com/peat-platform/swagger-def.git
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

mkdir ~/node_modules/admin-dashboard
ln -s ~/node_modules/admin-dashboard    ~/repos/admin-dashboard/node_modules
mkdir ~/node_modules/user-dashboard
ln -s ~/node_modules/user-dashboard     ~/repos/user-dashboard/node_modules
mkdir ~/node_modules/cloudlet-platform
ln -s ~/node_modules/cloudlet-platform  ~/repos/cloudlet-platform/node_modules
mkdir ~/node_modules/swagger-def
ln -s ~/node_modules/swagger-def        ~/repos/swagger-def/node_modules
mkdir ~/node_modules/dao
ln -s ~/node_modules/dao                ~/repos/dao/node_modules
mkdir ~/node_modules/notifications
ln -s ~/node_modules/notifications      ~/repos/notifications/node_modules
mkdir ~/node_modules/peat_rrd
ln -s ~/node_modules/peat_rrd           ~/repos/peat_rrd/node_modules


cd ~/repos/admin-dashboard; npm install --no-bin-links
cd ~/repos/user-dashboard; npm install --no-bin-links
cd ~/repos/cloudlet-platform; npm install --no-bin-links
cd ~/repos/swagger-def; npm install --no-bin-links
cd ~/repos/dao; npm install --no-bin-links
cd ~/repos/notifications; npm install --no-bin-links
cd ~/repos/peat-rrd; npm install --no-bin-links


ln -s /home/vagrant/repos/mongrel2/uploads/ /opt/openi/cloudlet_platform/uploads
