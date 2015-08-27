#!/bin/bash

cd ~/

git clone https://github.com/peat-platform/peat-android-sdk.git

cd ~/peat-android-sdk;

curl -L -o $HOME/.sbt/launchers/0.13.0/sbt-launch.jar http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.0/sbt-launch.jar

bash setup.sh

cd ~/

mv peat-android-sdk ~/repos/

cd ~/repos
