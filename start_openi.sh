#!/bin/bash
cd /home/vagrant/repos/api-framework/OPENiapp/
python manage.py runserver 0.0.0.0:8889 &
cd /home/vagrant/repos/mongrel2/
sh start_mongrel2.sh
cd /home/vagrant/repos/cloudlet-platform/
node lib/main.js &
cd /home/vagrant/repos/uaa/proxy
supervisor proxy.js &