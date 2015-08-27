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
git clone https://github.com/peat-platform/admin-dashboard.git
git clone https://github.com/peat-platform/user-dashboard.git
git clone https://github.com/peat-platform/loglet.git
git clone https://github.com/peat-platform/peat-aggregator.git
git clone https://github.com/peat-platform/acceptancetests.git


cd ~/repos/admin-dashboard; npm install --no-bin-links
cd ~/repos/user-dashboard; npm install --no-bin-links
cd ~/repos/cloudlet-platform; npm install --no-bin-links
cd ~/repos/swagger-def; npm install --no-bin-links
cd ~/repos/dao; npm install --no-bin-links
cd ~/repos/notifications; npm install --no-bin-links
cd ~/repos/peat-rrd; npm install --no-bin-links


ln -s /home/vagrant/repos/mongrel2/uploads/ /opt/peat/cloudlet_platform/uploads
