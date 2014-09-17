#!/bin/bash
echo "################################"
echo "##Installing common components##"
echo "################################"
. /vagrant/core_bootstrap/common_bootstrap.sh


echo "################################"
echo "##Installing cloudlet framework components##"
echo "################################"
. /vagrant/core_bootstrap/cloudlet_framework_bootstrap.sh


echo "################################"
echo "##Installing api framework components##"
echo "################################"
. /vagrant/core_bootstrap/api_framework_bootstrap.sh


echo "################################"
echo "##Installing security framework components##"
echo "################################"
. /vagrant/core_bootstrap/security_framework_bootstrap.sh
