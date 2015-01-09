useradd ganglia --password OPENiganglia

echo 'ganglia  ALL=(ALL:ALL) ALL' | sudo tee /etc/sudoers.d/ganglia
sudo chmod 0440 /etc/sudoers.d/ganglia

sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y rrdtool librrd-dev
sudo apt-get install -y ganglia-monitor gmetad 

sudo DEBIAN_FRONTEND=noninteractive apt-get -q -y install ganglia-webfrontend 
sudo chmod u+w,a+w /usr/share/ganglia-webfrontend/graph.d
sudo chmod u+w,a+w /var/lib/ganglia-web/conf

echo "<VirtualHost *:9696>
  ServerName localhost
  ServerAdmin webmaster@localhost

  Alias /ganglia /usr/share/ganglia-webfrontend

  DocumentRoot /usr/share/ganglia-webfrontend
  <Directory />
    AllowOverride All
    Order allow,deny
    allow from all
    Deny from none
  </Directory>

  ErrorLog /error.log
  CustomLog /access.log combined

</VirtualHost>" | sudo tee /etc/apache2/sites-enabled/ganglia.conf

echo 'AuthUserFile /usr/share/ganglia-webfrontend/.htpasswd
AuthName "Authorization Required"
AuthType Basic
require user OPENiAdmin' | sudo tee /usr/share/ganglia-webfrontend/.htaccess

echo 'OPENiAdmin:$apr1$USh.zn.E$7YQCqaUbGrdV1ac7Nlf13/' | sudo tee /usr/share/ganglia-webfrontend/.htpasswd

sudo sed -i -e 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

sudo sed -i -e 's/data_source "my cluster".*localhost/data_source "OPENi_Cluster" 60 localhost/g' /etc/ganglia/gmetad.conf

sudo sed -i -e 's/"my cluster"/"OPENi_Cluster"/g' /etc/ganglia/gmond.conf

sudo sed -i -e 's/name = "unspecified"/name = "OPENi_Cluster"/g' /etc/ganglia/gmond.conf

sudo perl -0777 -pe 's/mcast_join = 239\.2\.11\.71/#mcast_join = 239\.2\.11\.71\n  host = localhost/' /etc/ganglia/gmond.conf | sudo tee /etc/ganglia/tmp_gmond.conf
sudo perl -0777 -pe 's/[^#]mcast_join = 239\.2\.11\.71/#mcast_join = 239\.2\.11\.71/' /etc/ganglia/tmp_gmond.conf  | sudo tee /etc/ganglia/gmond.conf

sudo sed -i -e 's/\(NameVirtualHost \*:8888\)/\1\nNameVirtualHost *:9696/g' /etc/apache2/ports.conf

sudo sed -i -e 's/\(Listen 8888\)/\1\nListen 9696/g' /etc/apache2/ports.conf

sudo service ganglia-monitor restart && sudo service gmetad restart && sudo service apache2 restart
