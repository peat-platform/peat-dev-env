#!/bin/bash

cd /home/vagrant/repos


git clone https://github.com/OPENi-ict/cloudlet-platform.git
git clone https://github.com/OPENi-ict/cloudlet-api.git
git clone https://github.com/OPENi-ict/swagger-def.git
git clone https://github.com/OPENi-ict/object-api.git
git clone https://github.com/OPENi-ict/type-api.git
git clone https://github.com/OPENi-ict/m2nodehandler.git
git clone https://github.com/OPENi-ict/dao.git
git clone https://github.com/OPENi-ict/mongrel2.git
git clone https://github.com/OPENi-ict/dbc.git
git clone https://github.com/OPENi-ict/cloudlet-utils.git
git clone https://github.com/OPENi-ict/openi-logger.git
git clone https://github.com/OPENi-ict/cloudlet-store
git clone https://github.com/OPENi-ict/api-builder.git
git clone https://github.com/OPENi-ict/api-framework.git
git clone https://github.com/OPENi-ict/openi_android_sdk
git clone https://github.com/OPENi-ict/cloudlet.git
git clone https://github.com/OPENi-ict/uaa.git


cd /home/vagrant/repos/cloudlet-platform; npm install --no-bin-links
cd /home/vagrant/repos/cloudlet-api;      npm install --no-bin-links
cd /home/vagrant/repos/swagger-def;       npm install --no-bin-links
cd /home/vagrant/repos/object-api;        npm install --no-bin-links
cd /home/vagrant/repos/type-api;          npm install --no-bin-links
cd /home/vagrant/repos/m2nodehandler;     npm install --no-bin-links
cd /home/vagrant/repos/dao;               npm install --no-bin-links
cd /home/vagrant/repos/dbc;               npm install --no-bin-links
cd /home/vagrant/repos/cloudlet-utils;    npm install --no-bin-links
cd /home/vagrant/repos/openi-logger;      npm install --no-bin-links
cd /home/vagrant/repos/cloudlet-store;    npm install --no-bin-links
cd /home/vagrant/repos/cloudlet;      npm install --no-bin-links


cd /home/vagrant/repos/cloudlet; bash patch.sh import --quit-no-color
cd /home/vagrant/repos/uaa; bash setup.sh
cd /home/vagrant/repos/openi_android_sdk; bash setup.sh

cd /home/vagrant/repos/api-framework/OPENiapp/
virtualenv venv

source /home/vagrant/repos/api-framework/OPENiapp/venv/bin/activate
cd /home/vagrant/repos/api-framework/OPENiapp/
sudo pip install -r requirements.txt
sudo python manage.py syncdb

cd