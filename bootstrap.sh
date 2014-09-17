#!/usr/bin/env bash
apt-get update -q

sudo apt-get install -y software-properties-common

apt-get install -y git tmux vim
apt-get install -qy wget curl
apt-get install -qy g++ curl libssl-dev apache2-utils
apt-get install -y make
apt-get install -y nmap
apt-get install -y vim
apt-get install -y libssl0.9.8

# Install requirements for Android sdk generation
sudo apt-get install -y openjdk-7-jdk
sudo apt-get install -y maven=3.0.4-2
sudo apt-get install -y libjansi-java

sudo apt-get remove scala-library scala
wget www.scala-lang.org/files/archive/scala-2.10.3.deb
sudo dpkg -i scala-2.10.3.deb
sudo apt-get update
sudo apt-get install -y scala


wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt//0.12.3/sbt.deb
sudo dpkg -i sbt.deb
sudo apt-get update
sudo apt-get install sbt

# Install node.js
cd /tmp ; wget http://www.nodejs.org/dist/v0.10.21/node-v0.10.21.tar.gz; tar -xzvf node-v0.10.21.tar.gz
cd /tmp/node-v0.10.21/ ; ./configure ; make ; make install
cd /tmp

# Install ZMQ
apt-get install -y g++ uuid-dev binutils libtool autoconf automake
cd /tmp ; wget http://download.zeromq.org/zeromq-3.2.4.tar.gz ; tar -xzvf zeromq-3.2.4.tar.gz
cd /tmp/zeromq-3.2.4/ ; ./configure ; make ; make install
ldconfig

cd /home/vagrant

# Install SQLite3
apt-get install -y sqlite3
apt-get install -y libsqlite3-dev

# Install Mongrel2
cd /tmp ;
wget --no-check-certificate https://github.com/zedshaw/mongrel2/releases/download/v1.9.1/mongrel2-v1.9.1.tar.gz ;
tar -xzvf mongrel2-v1.9.1.tar.gz
cd /tmp/mongrel2-v1.9.1/ ;
make clean all
sudo make install

# Install Couchbase
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

# usermod -a -G vagrant vagrant
sudo mkdir -p /opt/openi/cloudlet_platform/logs/
sudo chown -R vagrant:vagrant /opt/openi/cloudlet_platform/


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

cat > /etc/hosts <<DELIM
127.0.0.1 localhost
127.0.1.1 trusty64 dev.openi-ict.eu

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
DELIM

cat > /home/vagrant/.ssh/config <<DELIM
Host github.com
StrictHostKeyChecking no
DELIM

sudo apt-get install -y python-software-properties

sudo add-apt-repository -y ppa:fkrull/deadsnakes
sudo apt-get update  -y
sudo apt-get install python2.7  -y

# Install requirements for API platform
cd /tmp; wget https://www.djangoproject.com/download/1.6/tarball/; tar -xzvf index.html
cd /tmp/Django-1.6; sudo python setup.py install

cd tmp; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
sudo python ez_setup.py

cd tmp; wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py;
sudo python get-pip.py

sudo pip install virtualenv

# Install requirements for api builder
sudo apt-get install -y apache2
sudo apt-get install -y php5 libapache2-mod-php5

sudo rm /etc/apache2/sites-enabled/000-default

sudo sed -i -e 's/80/8888/g' /etc/apache2/ports.conf

cat > /etc/apache2/sites-enabled/builder_apache_conf <<DELIM

<VirtualHost *:8888>
  ServerAdmin webmaster@localhost

  DocumentRoot /home/vagrant/repos/api-builder
  <Directory />
    Options FollowSymLinks
    AllowOverride None
  </Directory>
  <Directory /home/vagrant/repos/api-builder>
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
sudo sh /etc/init.d/networking restart

tmp=`mktemp -q` && {
    apt-get install -q -y --no-upgrade linux-image-generic-lts-raring | \
    tee "$tmp"

    NUM_INST=`awk '$2 == "upgraded," && $4 == "newly" { print $3 }' "$tmp"`
    rm "$tmp"
}

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

if [ ! -d /opt/VBoxGuestAdditions-4.3.16/ ]; then

    # Select fast local mirrors
    sed -i -e 's#http://security.ubuntu.com/ubuntu#mirror://mirrors.ubuntu.com/mirrors.txt#g' /etc/apt/sources.list
    sed -i -e 's#http://us.archive.ubuntu.com/ubuntu/#mirror://mirrors.ubuntu.com/mirrors.txt#g' /etc/apt/sources.list

    apt-get update -q

    # Kernel Headers and dkms are required to build the vbox guest kernel
    # modules.
    apt-get install -q -y linux-headers-generic-lts-raring dkms
    apt-get install -y build-essential linux-headers-`uname -r` dkms

    echo 'Downloading VBox Guest Additions...'
    wget -cq http://dlc.sun.com.edgesuite.net/virtualbox/4.3.16/VBoxGuestAdditions_4.3.16.iso
    echo "d58f678613bd37f5f94bcf324708af63572fc8582833a2558574090231fd080f  VBoxGuestAdditions_4.3.16.iso" | sha256sum --check || exit 1

    mount -o loop,ro /home/vagrant/VBoxGuestAdditions_4.3.16.iso /mnt
    /mnt/VBoxLinuxAdditions.run --nox11
    umount /mnt
fi
