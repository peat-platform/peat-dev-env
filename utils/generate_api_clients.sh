#!/bin/bash
cd ~/repos/peat_android_sdk

bash build-android-sdk.sh $1

cp peat-client-lib.aar                  ~/repos/mongrel2/static/android-sdk/