cd ~/repos/openi_rrd/misc && npm install && node rrd_setup.js
sudo cp ~/repos/openi_rrd/graph.d/* /usr/share/ganglia-webfrontend/graph.d/
sudo cp ~/repos/openi_rrd/conf/*    /var/lib/ganglia-web/conf/

sudo service ganglia-monitor restart && sudo service gmetad restart && sudo service apache2 restart
