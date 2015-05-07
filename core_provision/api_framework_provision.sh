#!/bin/bash

cd ~/repos

git clone https://github.com/peat-platform/api-builder.git
git clone https://github.com/peat-platform/api-framework.git

cd ~/repos/api-framework/OPENiapp/
virtualenv venv

source ~/repos/api-framework/OPENiapp/venv/bin/activate
cd ~/repos/api-framework/OPENiapp/
pip install -r requirements.txt
python manage.py syncdb

cd