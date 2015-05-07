#!/usr/bin/env bash
apt-get update -q

sudo apt-get install -y software-properties-common

apt-get install -y git tmux vim
apt-get install -qy wget curl
apt-get install -qy g++ curl libssl-dev apache2-utils
apt-get install -y make
apt-get install -y nmap
apt-get install -y apache2
apt-get install -y vim
apt-get install -y libssl0.9.8
apt-get install -y g++ uuid-dev binutils libtool autoconf automake maven
apt-get install -y linux-headers-3.13.0-40-generic

su -l -c "curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash && echo 'source ~/.nvm/nvm.sh' >> ~/.bashrc" vagrant
su -l -c "nvm install 0.10 && nvm alias default 0.10 && npm install npm -g && npm install -g grunt-cli && npm install supervisor -g" vagrant

#cp -Rf core_bootstrap/static/* /

cat > /etc/hosts <<DELIM
127.0.0.1 localhost
127.0.1.1 trusty64 dev.peat-platform.org

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

ssh-keygen -A

apt-get install ufw
ufw disable
ufw default deny incoming
ufw default deny outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 3306/tcp
ufw allow 8888/tcp

ufw allow out to any port 25
ufw allow out to any port 53
ufw allow out to any port 80
ufw allow out to any port 443

ufw allow out to any port 9418


apt-get install -y fail2ban