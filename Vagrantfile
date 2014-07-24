# -*- mode: ruby -*-
# vi: set ft=ruby :



VAGRANTFILE_API_VERSION = "2"
OPENI_REPO_PATH         = "/Users/dmccarthy/work/openi/wp4_test_install"
CPU_ALLOC               = 4
RAM_ALLOC               = 4096
CLIENT_IP_ADDRESS       = "192.168.33.10"



$script = <<SCRIPT

apt-get update -q

apt-get install -y git tmux vim
apt-get install -qy wget curl
apt-get install -qy g++ curl libssl-dev apache2-utils
apt-get install -y make
apt-get install -y nmap
apt-get install -y vim


#Install requirements for Android sdk generation
sudo apt-get install -y openjdk-7-jdk
sudo apt-get install -y maven=3.0.4-2
sudo apt-get install -y libjansi-java

sudo apt-get remove scala-library scala
wget www.scala-lang.org/files/archive/scala-2.10.3.deb
sudo dpkg -i scala-2.10.3.deb
sudo apt-get update
sudo apt-get install -y scala
#sudo apt-get -f install
#sudo apt-get install scala

wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt//0.12.3/sbt.deb
sudo dpkg -i sbt.deb
sudo apt-get update
sudo apt-get install sbt



#INSTALL node.js
cd /tmp ; wget http://www.nodejs.org/dist/v0.10.21/node-v0.10.21.tar.gz; tar -xzvf node-v0.10.21.tar.gz
cd /tmp/node-v0.10.21/ ; ./configure ; make ; make install
cd /tmp



#INSTALL ZMQ

apt-get install -y g++ uuid-dev binutils libtool autoconf automake
cd /tmp ; wget http://download.zeromq.org/zeromq-3.2.4.tar.gz ; tar -xzvf zeromq-3.2.4.tar.gz
cd /tmp/zeromq-3.2.4/ ; ./configure ; make ; make install
ldconfig

cd /home/vagrant

# INSTALL SQLite3

apt-get install -y sqlite3
apt-get install -y libsqlite3-dev

# INSTALL Mongrel2

cd /tmp ; wget --no-check-certificate https://github.com/zedshaw/mongrel2/tarball/v1.8.0 ; tar -xzvf v1.8.0
cd /tmp/zedshaw-mongrel2-bc721eb/ ; ./configure ; make ; make install

# INSTALL Couchbase
cd /tmp ; wget http://packages.couchbase.com/releases/2.2.0/couchbase-server-enterprise_2.2.0_x86_64.deb
dpkg -i /tmp/couchbase-server-enterprise_2.2.0_x86_64.deb

# usermod -a -G vagrant vagrant
#
sudo mkdir -p /opt/openi/cloudlet_platform/logs/
sudo chown -R vagrant:vagrant /opt/openi/cloudlet_platform/

#Install build tools
sudo npm install -g grunt-cli

#Install CouchDB
apt-get install couchdb -y

cat > /etc/hosts <<DELIM
127.0.0.1	localhost
127.0.1.1	precise64 dev.openi-ict.eu

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
DELIM

sed -i -e 's/bind_address = 127.0.0.1/bind_address = 0.0.0.0/g' /etc/couchdb/default.ini

cat > /home/vagrant/.ssh/config <<DELIM
Host github.com
StrictHostKeyChecking no
DELIM

sudo service couchdb restart

sudo apt-get install -y software-properties-common python-software-properties

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

apt-get install -y apache2
apt-get install -y php5 libapache2-mod-php5

rm /etc/apache2/sites-enabled/000-default

sed -i -e 's/80/8888/g' /etc/apache2/ports.conf

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


/etc/init.d/apache2 restart

cat > /home/vagrant/provision_openi.sh <<DELIM
#!/bin/bash

cd /home/vagrant/repos


git clone https://github.com/OPENi-ict/cloudlet-platform.git
git clone https://github.com/OPENi-ict/cloudlet-api.git
git clone https://github.com/OPENi-ict/object-api.git
git clone https://github.com/OPENi-ict/type-api.git
git clone https://github.com/OPENi-ict/m2nodehandler.git
git clone https://github.com/OPENi-ict/dao.git
git clone https://github.com/OPENi-ict/mongrel2.git
git clone https://github.com/OPENi-ict/dbc.git
git clone https://github.com/OPENi-ict/cloudlet-utils.git

git clone https://github.com/OPENi-ict/openi-logger.git

git clone https://github.com/OPENi-ict/cloudlet-store

git clone https://github.com/OPENi-ict/api-builder.git

git clone https://github.com/OPENi-ict/api-framework.git

git clone https://github.com/OPENi-ict/openi_android_sdk


cd /home/vagrant/repos/cloudlet-platform; npm install --no-bin-links
cd /home/vagrant/repos/cloudlet-api;      npm install --no-bin-links
cd /home/vagrant/repos/object-api;        npm install --no-bin-links
cd /home/vagrant/repos/type-api;          npm install --no-bin-links
cd /home/vagrant/repos/m2nodehandler;     npm install --no-bin-links
cd /home/vagrant/repos/dao;               npm install --no-bin-links
cd /home/vagrant/repos/mongrel2;          npm install --no-bin-links
cd /home/vagrant/repos/dbc;               npm install --no-bin-links
cd /home/vagrant/repos/cloudlet-utils;    npm install --no-bin-links
cd /home/vagrant/repos/openi-logger;      npm install --no-bin-links
cd /home/vagrant/repos/cloudlet-store;    npm install --no-bin-links



cd /home/vagrant/repos/api-framework/OPENiapp/

virtualenv venv

source /home/vagrant/repos/api-framework/OPENiapp/venv/bin/activate

cd /home/vagrant/repos/api-framework/OPENiapp/

sudo pip install -r requirements.txt

python manage.py syncdb

cd

DELIM


cat > /home/vagrant/start_openi.sh <<DELIM

cd /home/vagrant/repos/api-framework/OPENiapp/
python manage.py runserver 0.0.0.0:8889 &
cd /home/vagrant/repos/mongrel2/
sh start_mongrel2.sh
cd /home/vagrant/repos/cloudlet-platform/
node lib/main.js &

DELIM


sudo sh /etc/init.d/networking restart

tmp=`mktemp -q` && {
    apt-get install -q -y --no-upgrade linux-image-generic-lts-raring | \
    tee "$tmp"

    NUM_INST=`awk '$2 == "upgraded," && $4 == "newly" { print $3 }' "$tmp"`
    rm "$tmp"
}

SCRIPT


$all_script = <<VBOX_SCRIPT + $script

if [ ! -d /opt/VBoxGuestAdditions-4.3.6/ ]; then
    # Update remote package metadata.  'apt-get update' is idempotent.
    apt-get update -q

    # Kernel Headers and dkms are required to build the vbox guest kernel
    # modules.
    apt-get install -q -y linux-headers-generic-lts-raring dkms
    apt-get install -y build-essential linux-headers-`uname -r` dkms

    echo 'Downloading VBox Guest Additions...'
    wget -cq http://dlc.sun.com.edgesuite.net/virtualbox/4.3.6/VBoxGuestAdditions_4.3.6.iso
    echo "95648fcdb5d028e64145a2fe2f2f28c946d219da366389295a61fed296ca79f0  VBoxGuestAdditions_4.3.6.iso" | sha256sum --check || exit 1

    mount -o loop,ro /home/vagrant/VBoxGuestAdditions_4.3.6.iso /mnt
    /mnt/VBoxLinuxAdditions.run --nox11
    umount /mnt
    fi
VBOX_SCRIPT


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box     = "presice64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

end


Vagrant::VERSION >= "1.1.0" and Vagrant.configure("2") do |config|

    config.vm.synced_folder OPENI_REPO_PATH, "/home/vagrant/repos", :nfs => false, :nfs_version => 3

    config.vm.network :private_network, ip: CLIENT_IP_ADDRESS

    config.ssh.forward_agent     = true

    config.ssh.forward_x11       = true

    config.vm.provider :virtualbox do |vb, override|
        override.vm.provision :shell, :inline => $all_script

        # increase default VM RAM
        vb.customize ["modifyvm", :id, "--memory", RAM_ALLOC]
        vb.customize ["modifyvm", :id, "--cpus",   CPU_ALLOC   ]
    end
end
