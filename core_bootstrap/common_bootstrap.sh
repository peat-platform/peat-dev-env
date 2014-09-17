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
apt-get install -y g++ uuid-dev binutils libtool autoconf automake maven

su -l -c "curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash && echo 'source ~/.nvm/nvm.sh' >> ~/.bashrc" vagrant
su -l -c "nvm install 0.10 && nvm alias default 0.10 && npm install -g grunt-cli && npm install supervisor -g" vagrant

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


tmp=`mktemp -q` && {
    apt-get install -q -y --no-upgrade linux-image-generic-lts-raring | \
    tee "$tmp"

    NUM_INST=`awk '$2 == "upgraded," && $4 == "newly" { print $3 }' "$tmp"`
    rm "$tmp"
}

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
    wget –-quiet -cq http://dlc.sun.com.edgesuite.net/virtualbox/4.3.16/VBoxGuestAdditions_4.3.16.iso
    echo "d58f678613bd37f5f94bcf324708af63572fc8582833a2558574090231fd080f  VBoxGuestAdditions_4.3.16.iso" | sha256sum --check || exit 1

    mount -o loop,ro /home/vagrant/VBoxGuestAdditions_4.3.16.iso /mnt
    /mnt/VBoxLinuxAdditions.run --nox11
    umount /mnt
    rm ~/VBoxGuestAdditions_4.3.16.iso
fi
