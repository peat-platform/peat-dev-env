#!/usr/bin/env bash

# Install Security req. (tomcat, posgres)
sudo apt-get install -y openjdk-7-jre-headless
sudo apt-get install -y tomcat7
sudo /etc/init.d/tomcat7 stop
printf $'@@ -1,1 +1,1 @@\n-    <Connector port=\"8080\" protocol=\"HTTP/1.1\"\n+    <Connector port=\"8877\" protocol=\"HTTP/1.1\"\n@@ -1,1 +1,1 @@\n-               redirectPort="8443" />\n+               />\n\n' | sudo patch /etc/tomcat7/server.xml -N
printf $'@@ -1,1 +1,1 @@\n-    <Connector port=\"8887\" protocol=\"HTTP/1.1\"\n+    <Connector port=\"8877\" protocol=\"HTTP/1.1\"\n\n' | sudo patch /etc/tomcat7/server.xml -N
sudo rm /var/lib/tomcat7/webapps/ROOT/index.html
sudo touch /var/lib/tomcat7/webapps/ROOT/index.html
sudo apt-get install -y postgresql
sudo su -l -c $'echo "CREATE DATABASE uaa; ALTER USER postgres PASSWORD \'fb20c47bffebca63\';" | psql' postgres
printf $'@@ -1,1 +1,1 @@\n-local   all             postgres                                peer\n+#local   all             postgres                                peer\n\n' | sudo patch /etc/postgresql/9.1/main/pg_hba.conf -N
printf $'@@ -1,1 +1,1 @@\n-local   all             all                                     peer\n+local   all             all                                     trust\n\n' | sudo patch /etc/postgresql/9.1/main/pg_hba.conf -N
sudo /etc/init.d/postgresql restart
sudo /etc/init.d/tomcat7 start


cd ~
mkdir .dep
cd .dep

sec_dep_url="https://raw.githubusercontent.com/OPENi-ict/uaa/master"

mkdir -p gradle/wrapper
cd gradle/wrapper
wget –-quiet $sec_dep_url/gradle/wrapper/gradle-wrapper.jar
wget --quiet $sec_dep_url/gradle/wrapper/gradle-wrapper.properties
cd ../..
wget --quiet $sec_dep_url/build.gradle
wget --quiet $sec_dep_url/gradle.properties
wget --quiet $sec_dep_url/settings.gradle
wget --quiet $sec_dep_url/shared_versions.gradle
wget --quiet $sec_dep_url/gradlew
chmod 755 gradlew

JAVA_HOME_=$JAVA_HOME
JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
PATH_=$PATH
PATH=$JAVA_HOME/bin:$PATH

bash gradlew

JAVA_HOME=$JAVA_HOME_
PATH=$PATH_

cd ..
rm -R .dep
