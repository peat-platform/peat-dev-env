sudo apt-get install -y librrd-dev

sudo chmod -R 777  /var/lib/ganglia/rrds/
mkdir -p "/var/lib/ganglia/rrds/OPENi_Cluster/localhost/"
cd ~/repos/openi_rrd/misc && npm install && node rrd_setup.js
sudo chown -R nobody:nogroup /var/lib/ganglia/rrds
sudo chmod -R 777  /var/lib/ganglia/rrds/

sudo cp ~/repos/openi_rrd/graph.d/* /usr/share/ganglia-webfrontend/graph.d/
sudo cp ~/repos/openi_rrd/conf/*    /var/lib/ganglia-web/conf/

sudo service ganglia-monitor restart && sudo service gmetad restart && sudo service apache2 restart
