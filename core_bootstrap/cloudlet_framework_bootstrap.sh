#!/usr/bin/env bash

# Install requirements for Android sdk generation
sudo apt-get install -y openjdk-7-jdk
sudo apt-get install -y maven=3.0.4-2
sudo apt-get install -y libjansi-java

sudo apt-get remove scala-library scala
wget --quiet www.scala-lang.org/files/archive/scala-2.10.3.deb
sudo dpkg -i scala-2.10.3.deb
sudo apt-get update
sudo apt-get install -y scala
rm scala-2.10.3.deb

wget --quiet http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt//0.12.3/sbt.deb
sudo dpkg -i sbt.deb
sudo apt-get update
sudo apt-get install -y sbt
rm sbt.deb


# Install ZMQ
cd /tmp ; wget --quiet http://download.zeromq.org/zeromq-3.2.4.tar.gz ; tar -xzvf zeromq-3.2.4.tar.gz
cd /tmp/zeromq-3.2.4/ ; ./configure ; make ; make install
ldconfig
sudo chown -R vagrant:vagrant /tmp
cd ~

# Install SQLite3
apt-get install -y sqlite3
apt-get install -y libsqlite3-dev

# Install Mongrel2
cd /tmp ;
git clone https://github.com/mongrel2/mongrel2.git
cd /tmp/mongrel2
git checkout release/1.9.2

make clean all
sudo make install
sudo chown -R vagrant:vagrant /tmp
# Install Couchbase
cd /tmp ;


#wget http://latestbuilds.hq.couchbase.com/couchbase-server/sherlock/3133/couchbase-server-enterprise_4.0.0-3133-ubuntu14.04_amd64.deb
wget http://packages.couchbase.com/releases/4.0.0-beta/couchbase-server-enterprise_4.0.0-beta-ubuntu14.04_amd64.deb
sudo dpkg -i couchbase-server-enterprise_4.0.0-beta-ubuntu14.04_amd64.deb
rm /tmp/couchbase-server-enterprise_4.0.0-beta-ubuntu14.04_amd64.deb
sudo chown -R vagrant:vagrant /tmp

/bin/sleep 10
sudo /opt/couchbase/bin/couchbase-cli cluster-init --cluster=127.0.0.1:8091 --user=admin --password=password --cluster-ramsize=2372 --services="data;index;query"
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=objects     --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=types       --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=attachments --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=permissions --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=app_permissions --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password

sudo chown -R vagrant:vagrant /tmp
# Install N1QL DP4
#sudo mkdir /opt/n1ql
#sudo chown -R vagrant:vagrant /opt/n1ql
#cd /opt/n1ql
#wget --quiet http://packages.couchbase.com/releases/couchbase-query/dp4/couchbase-query_dev_preview4_x86_64_linux.tar.gz
#tar -xf couchbase-query_dev_preview4_x86_64_linux.tar.gz
#sudo chown -R vagrant:vagrant /opt/n1ql
#curl -v http://localhost:8093/query/service -d 'statement=CREATE PRIMARY INDEX ON objects;'
#curl -v http://localhost:8093/query/service -d 'statement=CREATE PRIMARY INDEX ON types;'

sudo chown -R vagrant:vagrant /tmp

# Install Elasticsearch & Logstash
sudo wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main"
sudo add-apt-repository "deb http://packages.elasticsearch.org/logstash/1.5/debian stable main"
sudo apt-get update && sudo apt-get install elasticsearch && sudo apt-get install -y logstash
cd /etc/logstash/conf.d && sudo wget --quiet https://gist.githubusercontent.com/philipobrien/c030717feeab0a74b1db/raw/cf859ec4063048868c9384e7cc23ee0d10a4994b/logstash-cloudlet.conf
sudo sed -i 's/start on virtual-filesystems/start on never/g' /etc/init/logstash-web.conf
sudo update-rc.d elasticsearch defaults 95 10

# Install and Configure the Couchbase/Elasticsearch Plugin
sudo /usr/share/elasticsearch/bin/plugin -install transport-couchbase -url http://packages.couchbase.com.s3.amazonaws.com/releases/elastic-search-adapter/2.0.0/elasticsearch-transport-couchbase-2.0.0.zip
sudo /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
sudo /usr/share/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf/master
sudo mkdir /usr/share/elasticsearch/templates
sudo wget --quiet https://raw2.github.com/couchbaselabs/elasticsearch-transport-couchbase/master/src/main/resources/couchbase_template.json -P /usr/share/elasticsearch/templates

#TODO: Passwd should be a randomized default - not randomised since we will need to know it!
sudo bash -c "echo couchbase.password: password >> /etc/elasticsearch/elasticsearch.yml"
sudo bash -c "echo couchbase.username: admin >> /etc/elasticsearch/elasticsearch.yml"
sudo bash -c "echo couchbase.maxConcurrentRequests: 1024 >> /etc/elasticsearch/elasticsearch.yml"
sudo service elasticsearch start
sudo service logstash start

# Setup the Elasticsearch indexing parameters
until $(curl --output /dev/null --silent --head --fail http://localhost:9200); do
    printf '.'
    sleep 5
done

curl --retry 10 -XPUT http://localhost:9200/objects/ -d '{"index":{"analysis":{"analyzer":{"default":{"type":"whitespace","tokenizer":"whitespace"}}}}}'

# Setup the replication from Couchbase to Elasticsearch
curl -v -u admin:password http://localhost:8091/pools/default/remoteClusters -d name=elasticsearch -d hostname=localhost:9091 -d username=admin -d password=password
curl -v -X POST -u admin:password http://localhost:8091/controller/createReplication -d fromBucket=objects -d toCluster=elasticsearch -d toBucket=objects -d replicationType=continuous -d type=capi



# usermod -a -G vagrant vagrant
sudo mkdir -p /opt/peat/cloudlet_platform/logs/
sudo mkdir -p /opt/peat/cloudlet_platform/uploads/
sudo chown -R vagrant:vagrant /opt/peat/cloudlet_platform/


sudo chown -R vagrant:vagrant /tmp


# Install Piwik
# TODO: Sort out proper passwords
sudo apt-get update
# sudo mkdir /usr/share/piwik
sudo apt-get -y install unzip php5 php5-mysql php5-gd
cd /usr/share
sudo wget http://builds.piwik.org/latest.zip
sudo unzip latest.zip
sudo chmod a+w /usr/share/piwik/tmp
sudo chmod a+w /usr/share/piwik/config
sudo chown -R vagrant:vagrant /usr/share/piwik


# sudo wget https://debian.piwik.org/repository.gpg -qO piwik-repository.gpg
# sudo cat piwik-repository.gpg | sudo apt-key add -
# sudo rm -rf piwik-repository.gpg
# sudo bash -c 'echo "deb http://debian.piwik.org/ piwik main\ndeb-src http://debian.piwik.org/ piwik main" >> /etc/apt/sources.list.d/piwik.list'
# sudo apt-get update
# sudo apt-get install unzip php5-gd -y
# sudo apt-get install piwik -y
# sudo chown -R $USER:$GROUP /tmp

cd /usr/share/piwik/plugins
sudo git clone https://github.com/peat-platform/openi-app-tracker.git OpeniAppTracker
sudo git clone https://github.com/peat-platform/openi-company-tracker.git OpeniCompanyTracker
sudo git clone https://github.com/peat-platform/openi-location-tracker.git OpeniLocationTracker
sudo git clone https://github.com/peat-platform/openi-object-tracker.git OpeniObjectTracker
sudo chown -R vagrant:vagrant /tmp

sudo sh -c 'echo "Alias /piwik /usr/share/piwik \n<Directory /usr/share/piwik>\n  Order allow,deny\n  Allow from all\n  AllowOverride None\n  Options Indexes FollowSymLinks\n</Directory>" >> /etc/apache2/apache2.conf'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password password'
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server-5.5
if [ ! -f /var/log/databasesetup ];
then
	echo "CREATE USER 'piwik'@'localhost' IDENTIFIED BY 'password'" | mysql -uroot -ppassword
    echo "CREATE DATABASE piwik" | mysql -uroot -ppassword
    echo "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON piwik.* TO 'piwik'@'localhost'" | mysql -uroot -ppassword
    echo "flush privileges" | mysql -uroot -ppassword

    touch /var/log/databasesetup

    if [ -f /vagrant/data/initial.sql ];
    then
        mysql -uroot -ppassword piwik < /vagrant/data/initial.sql
    fi
fi

# mysql -u root -ppassword -e "CREATE DATABASE piwik"
# mysql -u root -ppassword -e "CREATE USER 'piwik'@'localhost' IDENTIFIED BY 'password'"
# mysql -u root -ppassword -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON piwik.* TO 'piwik'@'localhost'"
sudo /etc/init.d/apache2 restart
sudo chown -R vagrant:vagrant /tmp