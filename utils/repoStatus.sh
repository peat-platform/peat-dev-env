#!/usr/bin/env bash

cd /home/vagrant/repos
FOLDER=`pwd`

red='\e[0;31m'
blue='\e[0;34m'
NC='\e[0m'

for dir in `ls -d */ ${pwd}`
do
    cd ${FOLDER}/${dir}

    if [ -d .git ]; then
        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse @{u})
        BASE=$(git merge-base @ @{u})

        if [ ${LOCAL} = ${REMOTE} ]; then
            true
        elif [ ${LOCAL} = ${BASE} ]; then
            echo -e "${red}Need to pull${NC} ${dir}" | sed 's/\///'
#            echo "Do you want to pull the latest changes?"
#            select yn in "Yes" "No"; do
#                case ${yn} in
#                    Yes ) cd /home/vagrant/repos/${dir} && git pull;;
#                    No ) break;;
#                esac
#            done
        elif [ ${REMOTE} = ${BASE} ]; then
            echo -e "${blue}Need to push${NC} ${dir}" | sed 's/\///'
#            echo "Do you want to push your latest changes?"
#            select yn in "Yes" "No"; do
#                case ${yn} in
#                    Yes ) cd /home/vagrant/repos/${dir} && echo `pwd`;;
#                    No ) break;;
#                esac
#            done
        else
            echo -e "${red}Diverged${NC} ${dir}" | sed 's/\///'
        fi
    fi

done