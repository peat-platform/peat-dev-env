# Cloudlet Platform Vagrant Development Environment Setup Guide

## Introduction

Vagrant (http://www.vagrantup.com/) is free and open-source software for creating and configuring virtual development environments. It can be considered a wrapper around virtualization software such as VirtualBox and configuration management software such as Chef, Salt, Puppet and bash scripts. I've created a Vagrantfile that builds an ubuntu vm with all the applications and tools required to execute the Cloudlet Platform code. Using one of the built in features it allow you to develop your code on the host machine and evaluate/run it on the client vm.

Our Vagrant image has the following tools and applications installed: node, ZeroMQ, couchDB, and Mongrel2. It also has a configurable shared folder that allows you to point to your PEAT repos on the host machine from within the client.


## Preparation

Some people may have difficulty with the ssh forward agent feature, to address this issue add your SSH key to host ssh-agent.*

    key_file=~/.ssh/id_rsa

    # Add if not already added
    [[ -z $(ssh-add -L | grep $key_file) ]] && ssh-add $key_file


Add the following entry into your /etc/hosts file.

    192.168.33.10 dev.peat-platform.org

Install Vagrant

    http://www.vagrantup.com/downloads

## Setup

Clone the peat_dev_env project on the git repo.

    git clone git@github.com:peat-platform/peat-dev-env.git


Modify the parameters at the top of the Vagrant file to suit your system.

    VAGRANTFILE_API_VERSION = "2"
    PEAT_REPO_PATH          = "/Users/xyz/work/peat"
    CPU_ALLOC               = 4
    RAM_ALLOC               = 4096
    CLIENT_IP_ADDRESS       = "192.168.33.10"

Once you are happy with your parameters you execute the following commands to download and provision the vm. Note: the first time that you run vagrant up it provisions the system by downloading and installing a number of applications. This can take up to an hour to execute.

    cd peat_dev_env

    vagrant up

    vagrant halt

    vagrant box update

    vagrant plugin install vagrant-vbguest

    vagrant up


## Post Setup

Once the VM has been built and provisioned execute the following commands to get the Cloudlet platform up and running.

    vagrant ssh

    bash /vagrant/provision.sh

    sh /vagrant/utils/tmux_peat.sh

    sh /vagrant/utils/populate_default_types.sh

    sh /vagrant/utils/populate_couchbase_views.sh

    sh /vagrant/utils/generate_api_clients.sh dev.peat-platform.org

Navigate to `http://dev.peat-platform/api-docs/` on your host system and try out a few of the endpoints.

All the Cloudlet Platforms modules are downloaded to a shared folder `/home/vagrant/repos` on the Virtual Machine and which ever directory you set the PEAT_REPO_PATH variable to on the Host. All edits to module files on the Host are replicated on the VM. To test changes you need to ssh into the VM by firstly changing directory to `peat_dev_env` and then running the `vagrant ssh` command. Once you have SSHed into the VM, navigate to the module that you edited on the Host in e.g. `cd /home/vagrant/repos/object_api`, install the node dependencies with the `npm install` command, and run the build script (includes jshint and unit tests) with the `grunt jenkins`. To run the module in isolation execute the `node lib/local-runner.js` command (The module may have a dependency on others so you may have to start more than one to test it properly).


## Piwik Setup

Details can be found [here in the wiki](https://github.com/peat-platform/peat-dev-env/wiki/Piwik-Setup)

## Links
http://earlyandoften.wordpress.com/2012/09/06/vagrant-cheatsheat/


### Troubleshooting

If you have difficulty running the node applications try deleting their node_modules folder and executing npm install again. One of the dependencies links to a file on the host operating system, deleting the folder from within vagrant and rebuilding it will link to the client operating system.

Note: If using Windows, any paths must use double slashes i.e. `"C:\Users\user1\docs" -> "C:\\Users\\user1\\docs"`