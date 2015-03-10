#!/bin/bash

SCRIPT_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $SCRIPT_ROOT_DIR
. /vagrant/core_provision/cloudlet_framework_provision.sh
cd $SCRIPT_ROOT_DIR
. /vagrant/core_provision/api_framework_provision.sh
cd $SCRIPT_ROOT_DIR
. /vagrant/core_provision/security_framework_provision.sh
cd $SCRIPT_ROOT_DIR
. /vagrant/core_provision/sdk_framework_provision.sh
cd $SCRIPT_ROOT_DIR
. /vagrant/core_provision/monitoring_provision.sh
