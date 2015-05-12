#!/usr/bin/env bash


sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=users          --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=clients        --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password
sudo /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 --bucket=dbkeys         --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password


sudo apt-get install -y redis-server

sudo mkdir /opt/n1ql
sudo chown -R $USER:$GROUP /opt/n1ql
cd /opt/n1ql
sudo chown -R $USER:$GROUP /opt/n1ql

