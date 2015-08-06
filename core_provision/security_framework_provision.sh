#!/bin/bash

cd ~/repos

git clone https://github.com/peat-platform/auth-api.git
git clone https://github.com/peat-platform/crud-api.git
git clone https://github.com/peat-platform/auth-dialogs.git

cd ~/repos/auth-dialogs; npm install --no-bin-links
cd ~/repos/auth-api; npm install --no-bin-links
cd ~/repos/crud-api; npm install --no-bin-links

npm install couchbase
node /vagrant/core_provision/security_framework_init.js
rm -r node_modules
