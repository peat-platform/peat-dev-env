#!/bin/bash

cd ~/repos

git clone https://github.com/OPENi-ict/auth-api.git
git clone https://github.com/OPENi-ict/crud-api.git
git clone https://github.com/OPENi-ict/openi-auth-dialogs.git

cd ~/repos/openi-auth-dialogs npm install --no-bin-links
cd ~/repos/auth-api; npm install --no-bin-links
cd ~/repos/crud-api; npm install --no-bin-links