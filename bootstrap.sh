#!/bin/bash


SCRIPT_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "################################"
echo "##Installing common components##"
echo "################################"
. /vagrant/core_bootstrap/common_bootstrap.sh


echo "################################"
echo "##Installing cloudlet framework components##"
echo "################################"
cd $SCRIPT_ROOT_DIR
. /vagrant/core_bootstrap/cloudlet_framework_bootstrap.sh


echo "################################"
echo "##Installing api framework components##"
echo "################################"
cd $SCRIPT_ROOT_DIR
. /vagrant/core_bootstrap/api_framework_bootstrap.sh


echo "################################"
echo "##Installing security framework components##"
echo "################################"
cd $SCRIPT_ROOT_DIR
. /vagrant/core_bootstrap/security_framework_bootstrap.sh
