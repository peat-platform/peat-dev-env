# -*- mode: ruby -*-
# vi: set ft=ruby :



VAGRANTFILE_API_VERSION = "2"
OPENI_REPO_PATH         = "C:\\Users\\dconway\\TSSG\\tmp"
SSH_KEYS                = "C:\\Users\\dconway\\.ssh"
CPU_ALLOC               = 4
RAM_ALLOC               = 4096
CLIENT_IP_ADDRESS       = "192.168.56.10"


$script = <<SCRIPT

apt-get update -q

apt-get install -y git tmux vim
apt-get install -qy wget curl
apt-get install -qy g++ curl libssl-dev apache2-utils
apt-get install -y make

#INSTALL node.js
add-apt-repository ppa:chris-lea/node.js
apt-get update -q
apt-get install -qy python-software-properties python g++ make nodejs



#INSTALL ZMQ

apt-get install -y g++ uuid-dev binutils libtool autoconf automake
cd /tmp ; wget http://download.zeromq.org/zeromq-3.2.4.tar.gz ; tar -xzvf zeromq-3.2.4.tar.gz
cd /tmp/zeromq-3.2.4/ ; ./configure ; make ; make install
ldconfig

# INSTALL SQLite3

apt-get install -y sqlite3
apt-get install -y libsqlite3-dev

# INSTALL Mongrel2

cd /tmp ; wget --no-check-certificate https://github.com/zedshaw/mongrel2/tarball/v1.8.0 ; tar -xzvf v1.8.0
cd /tmp/zedshaw-mongrel2-bc721eb/ ; ./configure ; make ; make install

# INSTALL Couchbase
cd /tmp ; wget http://packages.couchbase.com/releases/2.2.0/couchbase-server-enterprise_2.2.0_x86_64.deb
dpkg -i /tmp/couchbase-server-enterprise_2.2.0_x86_64.deb

# INSTALL CouchDB
apt-get install -y couchdb

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

ssh -oStrictHostKeyChecking=no git@gitlab.openi-ict.eu

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
git clone https://github.com/OPENi-ict/openi-docker.git
git clone https://github.com/OPENi-ict/openi-logger.git

cat > /home/vagrant/repos/build_all.sh <<DELIM

cd /home/vagrant/repos/cloudlet-platform; npm install --no-bin-links
cd /home/vagrant/repos/cloudlet-api; npm install --no-bin-links
cd /home/vagrant/repos/object-api; npm install --no-bin-links
cd /home/vagrant/repos/type-api; npm install --no-bin-links
cd /home/vagrant/repos/m2nodehandler; npm install --no-bin-links
cd /home/vagrant/repos/dao; npm install --no-bin-links
cd /home/vagrant/repos/mongrel2; npm install --no-bin-links
cd /home/vagrant/repos/dbc; npm install --no-bin-links
cd /home/vagrant/repos/cloudlet-utils; npm install --no-bin-links
cd /home/vagrant/repos/openi-docker; npm install --no-bin-links
cd /home/vagrant/repos/openi-logger; npm install --no-bin-links

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
    
    config.vm.synced_folder OPENI_REPO_PATH, "/home/vagrant/repos", :nfs => true, :nfs_version => 3

    config.vm.network :private_network, ip: CLIENT_IP_ADDRESS

    config.ssh.forward_agent     = true
    
    config.vm.provider :virtualbox do |vb, override|
        override.vm.provision :shell, :inline => $all_script
        
        # increase default VM RAM
        vb.customize ["modifyvm", :id, "--memory", RAM_ALLOC]
        vb.customize ["modifyvm", :id, "--cpus",   CPU_ALLOC   ]
    end
end