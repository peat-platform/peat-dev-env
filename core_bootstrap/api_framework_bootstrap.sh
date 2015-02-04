#!/usr/bin/env bash
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:fkrull/deadsnakes
sudo apt-get update  -y
sudo apt-get install python2.7  -y
sudo apt-get install build-essential python-dev -y

cd tmp; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
sudo python ez_setup.py

cd tmp; wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py;
sudo python get-pip.py

sudo pip install virtualenv

# Install requirements for api builder
sudo apt-get install -y apache2
sudo apt-get install -y php5 libapache2-mod-php5

sudo rm /etc/apache2/sites-enabled/000-default*

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


sudo sh /etc/init.d/apache2 restart
#sudo sh /etc/init.d/networking restart
sudo ifdown --exclude=lo -a && sudo ifup --exclude=lo -a