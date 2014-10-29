#!/usr/bin/env bash

# Install Security req. (tomcat, posgres)
sudo apt-get install -y openjdk-7-jre-headless
sudo apt-get install -y tomcat7

sudo rm /var/lib/tomcat7/webapps/ROOT/index.html
sudo touch /var/lib/tomcat7/webapps/ROOT/index.html
sudo apt-get install -y postgresql

sudo cp -Rf core_bootstrap/static/etc/tomcat7/* /etc/tomcat7
sudo cp -Rf core_bootstrap/static/etc/postgresql/* /etc/postgresql

sudo /etc/init.d/postgresql restart
sudo /etc/init.d/tomcat7 start
