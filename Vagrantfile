# -*- mode: ruby -*-
# vi: set ft=ruby :



VAGRANTFILE_API_VERSION = "2"
OPENI_REPO_PATH         = "/Users/dmccarthy/work/openi/wp4"
OSP_USERNAME            = "dmccarthy"
CPU_ALLOC               = 4
RAM_ALLOC               = 4096
CLIENT_IP_ADDRESS       = "192.168.33.10"



$script = <<SCRIPT

apt-get update -q

apt-get install -y git
apt-get install -qy wget curl
apt-get install -qy g++ curl libssl-dev apache2-utils
apt-get install -y make
apt-get install -y nmap
apt-get install -y vim

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

#usermod -a -G vagrant vagrant
#
sudo mkdir -p /opt/openi/cloudlet_platform/logs/
sudo chown -R vagrant:vagrant /opt/openi/cloudlet_platform/

#Install build tools
sudo npm install -g grunt-cli

#Install CouchDB
sudo apt-get install couchdb -y

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
Host gitlab.openi-ict.eu
StrictHostKeyChecking no
DELIM

sudo service couchdb restart

add-apt-repository -y ppa:fkrull/deadsnakes
apt-get update  -y
apt-get install python2.7  -y

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

	DocumentRoot /home/vagrant/repos/OPENi-Builder
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /home/vagrant/repos/OPENi-Builder>
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


ssh -oStrictHostKeyChecking=no git@gitlab.openi-ict.eu

cd /home/vagrant/repos

git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/cloudletplatform cloudlet_platform
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/cloudlet-api cloudlet_api
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/object-api object_api
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/type-api type_api
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/m2nodehandler
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/dao
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/mongrel2
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/dbc
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/cloudlet-utils cloudlet_utils
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/openidocker
git clone https://OSP_USERNAME@opensourceprojects.eu/git/p/openi/c60b/ad4e/openi-logger openi_logger

git clone https://github.com/romdim/OPENi-Builder.git

git clone https://dmccarthy@opensourceprojects.eu/git/p/openi/c60b/a620/code openi-apis

cd /home/vagrant/repos/cloudlet_platform; npm install
cd /home/vagrant/repos/cloudlet_api; npm install
cd /home/vagrant/repos/object_api; npm install
cd /home/vagrant/repos/type_api; npm install
cd /home/vagrant/repos/m2nodehandler; npm install
cd /home/vagrant/repos/dao; npm install
cd /home/vagrant/repos/mongrel2; npm install
cd /home/vagrant/repos/dbc; npm install
cd /home/vagrant/repos/openi-cloudlet-utils; npm install
cd /home/vagrant/repos/openi-docker; npm install
cd /home/vagrant/repos/openi-logger; npm install


cd /home/vagrant/repos/openi-apis/OPENiapp/

virtualenv venv
source venv/bin/activate

cd /home/vagrant/repos/openi-apis/

pip install -r requirements.txt

python manage.py syncdb

cd

DELIM


cat > /home/vagrant/start_openi.sh <<DELIM

python /home/vagrant/repos/openi-apis/manage.py runserver 0.0.0.0:8889
sh start_mongrel2.sh
start node.js

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
    apt-get install build-essential linux-headers-`uname -r` dkms
    
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
    
    config.vm.provider :virtualbox do |vb, override|
        override.vm.provision : , :inline => $all_script
        
        # increase default VM RAM
        vb.customize ["modifyvm", :id, "--memory", RAM_ALLOC]
        vb.customize ["modifyvm", :id, "--cpus",   CPU_ALLOC   ]
    end
end
