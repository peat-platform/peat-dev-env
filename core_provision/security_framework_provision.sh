#!/bin/bash

cd ~/repos

git clone https://github.com/OPENi-ict/auth-api.git
git clone https://github.com/OPENi-ict/crud-api.git

cd ~/repos/auth-api; npm install --no-bin-links
cd ~/repos/crud-api; npm install --no-bin-links