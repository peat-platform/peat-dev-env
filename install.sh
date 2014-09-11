#!/bin/bash

sudo apt-get update -q

sudo apt-get install -y software-properties-common

sudo apt-get install -y git tmux vim
sudo apt-get install -qy wget curl
sudo apt-get install -qy g++ curl libssl-dev apache2-utils
sudo apt-get install -y make
sudo apt-get install -y nmap
sudo apt-get install -y vim
sudo apt-get install -y libssl0.9.8



#Install requirements for Android sdk generation
sudo apt-get install -y openjdk-7-jdk
sudo apt-get install -y maven=3.0.4-2
sudo apt-get install -y libjansi-java

sudo apt-get remove -y  scala-library scala
wget www.scala-lang.org/files/archive/scala-2.10.3.deb
sudo dpkg -i scala-2.10.3.deb
sudo apt-get update -y
sudo apt-get install -y scala
#sudo apt-get -f install
#sudo apt-get install scala

wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt//0.12.3/sbt.deb
sudo dpkg -i sbt.deb
sudo apt-get update
sudo apt-get install sbt



#INSTALL node.js
cd /tmp/
rm install.sh
wget https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh
sh install.sh
echo 'source ~/.nvm/nvm.sh' >> ~/.bashrc
source ~/.bashrc

nvm install 0.10 && nvm alias default 0.10 && sudo npm install -g grunt-cli

rm install.sh

#INSTALL ZMQ
sudo apt-get install -y g++ uuid-dev binutils libtool autoconf automake
cd /tmp ; wget http://download.zeromq.org/zeromq-3.2.4.tar.gz ; tar -xzvf zeromq-3.2.4.tar.gz
cd /tmp/zeromq-3.2.4/ ;
./configure ;
make ;
sudo make install
sudo ldconfig

cd /home/ubuntu

# INSTALL SQLite3

sudo apt-get install -y sqlite3
sudo apt-get install -y libsqlite3-dev

# INSTALL Mongrel2

cd /tmp ;
wget --no-check-certificate https://github.com/zedshaw/mongrel2/releases/download/v1.9.1/mongrel2-v1.9.1.tar.gz ;
tar -xzvf mongrel2-v1.9.1.tar.gz
cd /tmp/mongrel2-v1.9.1/ ;
make clean all
sudo make install

# INSTALL Couchbase
cd /tmp ;
wget http://packages.couchbase.com/releases/2.5.1/couchbase-server-enterprise_2.5.1_x86_64.deb
sudo dpkg -i /tmp/couchbase-server-enterprise_2.5.1_x86_64.deb
rm /tmp/couchbase-server-enterprise_2.5.1_x86_64.deb
/bin/sleep 5
/opt/couchbase/bin/couchbase-cli cluster-init -c 127.0.0.1:8091 --cluster-init-username=admin --cluster-init-password=password --cluster-init-ramsize=2372
/opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=openi --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
/opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=attachments --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
/opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=permissions --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password

# Install Elasticsearch
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.deb
sudo dpkg -i elasticsearch-1.0.1.deb

# Install and Configure the Couchbase/Elasticsearch Plugin
sudo /usr/share/elasticsearch/bin/plugin -install transport-couchbase -url http://packages.couchbase.com.s3.amazonaws.com/releases/elastic-search-adapter/1.3.0/elasticsearch-transport-couchbase-1.3.0.zip
sudo /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
sudo mkdir /usr/share/elasticsearch/templates
sudo wget https://raw2.github.com/couchbaselabs/elasticsearch-transport-couchbase/master/src/main/resources/couchbase_template.json -P /usr/share/elasticsearch/templates

#TODO: Passwd should be a randomized default
sudo bash -c "echo couchbase.password: password >> /etc/elasticsearch/elasticsearch.yml"
sudo bash -c "echo couchbase.username: admin >> /etc/elasticsearch/elasticsearch.yml"
sudo bash -c "echo couchbase.maxConcurrentRequests: 1024 >> /etc/elasticsearch/elasticsearch.yml"
sudo service elasticsearch start


# Setup the Elasticsearch indexing parameters
until $(curl --output /dev/null --silent --head --fail http://localhost:9200); do
    printf '.'
    sleep 5
done

curl --retry 10 -XPUT http://localhost:9200/openi/ -d '{"index":{"analysis":{"analyzer":{"default":{"type":"whitespace","tokenizer":"whitespace"}}}}}'

# Setup the replication from Couchbase to Elasticsearch
curl -v -u admin:password http://localhost:8091/pools/default/remoteClusters -d name=elasticsearch -d hostname=localhost:9091 -d username=admin -d password=password
curl -v -X POST -u admin:password http://localhost:8091/controller/createReplication -d fromBucket=openi -d toCluster=elasticsearch -d toBucket=openi -d replicationType=continuous -d type=capi


# usermod -a -G ubuntu ubuntu
#
sudo mkdir -p /opt/openi/cloudlet_platform/logs/
sudo chown -R ubuntu:ubuntu /opt/openi/cloudlet_platform/


sudo apt-get install -y openjdk-7-jre-headless
sudo apt-get install -y tomcat7
sudo apt-get install -y postgresql
sudo /etc/init.d/tomcat7 stop


cat > /home/ubuntu/.ssh/config <<DELIM
Host github.com
StrictHostKeyChecking no
DELIM


sudo apt-get install -y python-software-properties

sudo add-apt-repository -y ppa:fkrull/deadsnakes
sudo apt-get update  -y
sudo apt-get install python2.7  -y

#Install requirements for API platform

cd /tmp; wget https://www.djangoproject.com/download/1.6/tarball/; tar -xzvf index.html
cd /tmp/Django-1.6; sudo python setup.py install

cd tmp; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
python ez_setup.py

cd tmp; wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py;
python get-pip.py

pip install virtualenv

#install requirements for api builder

sudo apt-get install -y apache2
sudo apt-get install -y php5 libapache2-mod-php5

sudo rm /etc/apache2/sites-enabled/000-default

sudo sed -i -e 's/80/8888/g' /etc/apache2/ports.conf

sudo cat > /etc/apache2/sites-enabled/builder_apache_conf <<DELIM

<VirtualHost *:8888>
	ServerAdmin webmaster@localhost

	DocumentRoot /home/ubuntu/repos/api-builder
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /home/ubuntu/repos/api-builder>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride None
		Order allow,deny
		allow from all
	</Directory>

	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
	<Directory "/usr/lib/cgi-bin">
		AllowOverride None
		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
		Order allow,deny
		Allow from all
	</Directory>

	ErrorLog ${APACHE_LOG_DIR}/error.log

	# Possible values include: debug, info, notice, warn, error, crit,
	# alert, emerg.
	LogLevel warn

	CustomLog ${APACHE_LOG_DIR}/access.log combined

    Alias /doc/ "/usr/share/doc/"
    <Directory "/usr/share/doc/">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.0/255.0.0.0 ::1/128
    </Directory>

</VirtualHost>

DELIM


sudo /etc/init.d/apache2 restart
sudo service elasticsearch start
sudo service couchbase-server start

cat > /home/ubuntu/provision_openi.sh <<DELIM
#!/bin/bash

cd /home/ubuntu/repos


git clone https://github.com/OPENi-ict/cloudlet-platform.git
git clone https://github.com/OPENi-ict/mongrel2.git
git clone https://github.com/OPENi-ict/openi_android_sdk
git clone https://github.com/OPENi-ict/uaa.git


cd /home/ubuntu/repos/cloudlet-platform; npm install --no-bin-links --production
cd /home/ubuntu/repos/mongrel2;          npm install --no-bin-links --production

cd /home/ubuntu/repos/openi_android_sdk; bash setup.sh
cd /home/ubuntu/repos/uaa; bash setup.sh



cd /home/ubuntu/repos/api-framework/OPENiapp/

virtualenv venv

source /home/ubuntu/repos/api-framework/OPENiapp/venv/bin/activate

cd /home/ubuntu/repos/api-framework/OPENiapp/

sudo pip install -r requirements.txt

python manage.py syncdb

cd

DELIM

cat > /home/ubuntu/pull_all.sh <<DELIM
#!/bin/bash

cd /home/ubuntu/repos

echo cloudlet-platform  && cd cloudlet-platform && git pull ; npm install --no-bin-links ; cd ../	
echo cloudlet-api       && cd cloudlet-api      && git pull ; npm install --no-bin-links ; cd ../
echo object-api         && cd object-api        && git pull ; npm install --no-bin-links ; cd ../
echo type-api           && cd type-api          && git pull ; npm install --no-bin-links ; cd ../
echo m2nodehandler      && cd m2nodehandler     && git pull ; npm install --no-bin-links ; cd ../
echo dao                && cd dao               && git pull ; npm install --no-bin-links ; cd ../
echo swagger-def        && cd swagger-def       && git pull ; npm install --no-bin-links ; cd ../
echo mongrel2           && cd mongrel2          && git pull ; cd ../
echo dbc                && cd dbc               && git pull ; npm install --no-bin-links ; cd ../
echo cloudlet-utils     && cd cloudlet-utils    && git pull ; npm install --no-bin-links ; cd ../
echo openi-logger       && cd openi-logger      && git pull ; npm install --no-bin-links ; cd ../
echo cloudlet-store     && cd cloudlet-store    && git pull ; npm install --no-bin-links ; cd ../
echo api-builder        && cd api-builder       && git pull ; cd ../
echo api-framework      && cd api-framework     && git pull ; cd ../
echo openi_android_sdk  && cd openi_android_sdk && git pull ; cd ../
echo api-builder        && cd api-builder       && git pull ; cd ../


DELIM


cat > /home/ubuntu/start_openi.sh <<DELIM
sudo service elasticsearch start
cd /home/ubuntu/repos/api-framework/OPENiapp/
python manage.py runserver 0.0.0.0:8889 &
cd /home/ubuntu/repos/mongrel2/
sh start_mongrel2.sh
cd /home/ubuntu/repos/cloudlet-platform/
node lib/main.js &

DELIM



cat > /home/ubuntu/tmux_openi.sh <<DELIM

SESSION="OPENi"

tmux has-session -t \$SESSION
if [ \$? -eq 0 ]; then
    echo "Session \$SESSION already exists. Attaching."
    sleep 1
    tmux attach -t \$SESSION
    exit 0;
fi

tmux new-session -d -s \$SESSION


tmux rename-window -t \$SESSION:0        'Default'
tmux new-window    -t \$SESSION -a -n    'Mongrel2'
tmux new-window    -t \$SESSION -a -n    'Cloudlet framework'
tmux new-window    -t \$SESSION -a -n    'API framework'
tmux new-window    -t \$SESSION -a -n    'Auth framework'



tmux send-keys -t \$SESSION:1 ' cd /home/ubuntu/repos/mongrel2/                 && sh start_mongrel2.sh'                        Enter
tmux send-keys -t \$SESSION:2 ' cd /home/ubuntu/repos/cloudlet-platform/        && node lib/main.js'                            Enter
tmux send-keys -t \$SESSION:3 ' cd /home/ubuntu/repos/api-framework/OPENiapp/   && python manage.py runserver 0.0.0.0:8889'     Enter
tmux send-keys -t \$SESSION:4 ' cd /home/ubuntu/repos/uaa/proxy                 && supervisor proxy.js '                        Enter


tmux attach -t \$SESSION


DELIM



cat > /home/ubuntu/generate_api_clients.sh <<DELIM
#!/bin/bash
cd /home/ubuntu/repos/openi_android_sdk

bash build-cloudlet-sdk.sh \$1
bash build-graph-api-sdk.sh \$1
bash build-android-sdk.sh \$1
bash build-auth-sdk.sh \$1

cp openi-cloudlet-android-sdk-1.0.0.jar  /home/ubuntu/repos/mongrel2/static/android-sdk/
cp openi-graph-api-android-sdk-1.0.0.jar /home/ubuntu/repos/mongrel2/static/android-sdk/
cp openi-android-sdk-1.0.0.jar           /home/ubuntu/repos/mongrel2/static/android-sdk/
cp openi-auth-android-sdk-1.0.0.jar      /home/vagrant/repos/mongrel2/static/android-sdk/

DELIM


cat > /home/ubuntu/create_sym_links.sh <<DELIM

rm -fr /home/ubuntu/repos/cloudlet-platform/node_modules/DAO/
rm -fr /home/ubuntu/repos/cloudlet-platform/node_modules/cloudlet_api/
rm -fr /home/ubuntu/repos/cloudlet-platform/node_modules/object_api
rm -fr /home/ubuntu/repos/cloudlet-platform/node_modules/swagger-def
rm -fr /home/ubuntu/repos/cloudlet-platform/node_modules/type_api

ln -s /home/ubuntu/repos/dao/          /home/ubuntu/repos/cloudlet-platform/node_modules/DAO
ln -s /home/ubuntu/repos/cloudlet-api/ /home/ubuntu/repos/cloudlet-platform/node_modules/cloudlet_api
ln -s /home/ubuntu/repos/object-api/   /home/ubuntu/repos/cloudlet-platform/node_modules/object_api
ln -s /home/ubuntu/repos/swagger-def/  /home/ubuntu/repos/cloudlet-platform/node_modules/swagger-def
ln -s /home/ubuntu/repos/type-api/     /home/ubuntu/repos/cloudlet-platform/node_modules/type_api

DELIM

printf $'@@ -1,1 +1,1 @@\n-    <Connector port=\"8887\" protocol=\"HTTP/1.1\"\n+    <Connector port=\"8877\" protocol=\"HTTP/1.1\"\n\n' | sudo patch /etc/tomcat7/server.xml -N
sudo rm /var/lib/tomcat7/webapps/ROOT/index.html
sudo touch /var/lib/tomcat7/webapps/ROOT/index.html
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
wget $sec_dep_url/gradle/wrapper/gradle-wrapper.jar
wget $sec_dep_url/gradle/wrapper/gradle-wrapper.properties
cd ../..
wget $sec_dep_url/build.gradle
wget $sec_dep_url/gradle.properties
wget $sec_dep_url/settings.gradle
wget $sec_dep_url/shared_versions.gradle
wget $sec_dep_url/gradlew
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

mkdir repos

sudo sh /etc/init.d/networking restart

