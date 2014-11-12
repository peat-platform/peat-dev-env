#!/bin/sh
#sudo add-apt-repository -y ppa:cwchien/gradle
#sudo apt-get -y update
#sudo apt-get install -y gradle=1.10

sudo dpkg --add-architecture i386
sudo apt-get -y update
sudo apt-get install -y libncurses5:i386 libstdc++6:i386 zlib1g:i386
apt-get install -y sun-java6-jdk

cd /tmp

wget http://dl.google.com/android/android-sdk_r23.0.2-linux.tgz

tar -xvf android-sdk_r23.0.2-linux.tgz

mkdir /opt

mv android-sdk-linux /opt/android-sdk-linux

/opt/android-sdk-linux/tools/android list sdk --all

echo yes | /opt/android-sdk-linux/tools/android update sdk -u -t tools,platform-tools,build-tools-21.1.1,extra-android-support,extra-android-m2repository,android-19

echo JAVA_HOME=/usr/lib/jvm/default-java/ >> /etc/environment

export JAVA_HOME=/usr/lib/jvm/default-java/

