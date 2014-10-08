#!/usr/bin/env bash

# Install requirements for Android sdk generation
sudo apt-get install -y openjdk-7-jdk
sudo apt-get install -y maven=3.0.4-2
sudo apt-get install -y libjansi-java

sudo apt-get remove scala-library scala
wget –-quiet www.scala-lang.org/files/archive/scala-2.10.3.deb
sudo dpkg -i scala-2.10.3.deb
sudo apt-get update
sudo apt-get install -y scala
rm scala-2.10.3.deb

wget –-quiet http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt//0.12.3/sbt.deb
sudo dpkg -i sbt.deb
sudo apt-get update
sudo apt-get install sbt
rm sbt.deb


# Install ZMQ
cd /tmp ; wget --quiet http://download.zeromq.org/zeromq-3.2.4.tar.gz ; tar -xzvf zeromq-3.2.4.tar.gz
cd /tmp/zeromq-3.2.4/ ; ./configure ; make ; make install
ldconfig

cd ~

# Install SQLite3
apt-get install -y sqlite3
apt-get install -y libsqlite3-dev

# Install Mongrel2
cd /tmp ;
wget –-quiet --no-check-certificate https://github.com/zedshaw/mongrel2/releases/download/v1.9.1/mongrel2-v1.9.1.tar.gz ;
tar -xzvf mongrel2-v1.9.1.tar.gz
cd /tmp/mongrel2-v1.9.1/ ;
make clean all
sudo make install

# Install Couchbase
cd /tmp ;
wget --quiet http://packages.couchbase.com/releases/3.0.0/couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb
sudo dpkg -i couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb
rm /tmp/couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb
/bin/sleep 10
sudo /opt/couchbase/bin/couchbase-cli cluster-init --cluster=127.0.0.1:8091 --user=admin --password=password --cluster-ramsize=2372
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=openi --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=attachments --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=permissions --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password


# Install Elasticsearch
wget --quiet https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.0.deb
sudo dpkg -i elasticsearch-1.3.0.deb

# Install and Configure the Couchbase/Elasticsearch Plugin
sudo /usr/share/elasticsearch/bin/plugin -install transport-couchbase -url http://packages.couchbase.com.s3.amazonaws.com/releases/elastic-search-adapter/2.0.0/elasticsearch-transport-couchbase-2.0.0.zip
sudo /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
sudo /usr/share/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf/master
sudo mkdir /usr/share/elasticsearch/templates
sudo wget –-quiet https://raw2.github.com/couchbaselabs/elasticsearch-transport-couchbase/master/src/main/resources/couchbase_template.json -P /usr/share/elasticsearch/templates

#TODO: Passwd should be a randomized default - not randomised since we will need to know it!
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

# usermod -a -G vagrant vagrant
sudo mkdir -p /opt/openi/cloudlet_platform/logs/
sudo chown -R vagrant:vagrant /opt/openi/cloudlet_platform/


sudo service elasticsearch start
sudo sh /etc/init.d/networking restart
