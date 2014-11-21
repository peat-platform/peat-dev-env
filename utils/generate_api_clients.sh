#!/bin/bash
cd ~/repos/openi_android_sdk

bash build-cloudlet-sdk.sh $1
bash build-graph-api-sdk.sh $1
bash build-android-sdk.sh $1
bash build-auth-sdk.sh $1

cp openi-cloudlet-android-sdk-1.0.0.jar  ~/repos/mongrel2/static/android-sdk/
cp openi-graph-api-android-sdk-1.0.0.jar ~/repos/mongrel2/static/android-sdk/
cp openi-android-sdk-1.0.0.jar           ~/repos/mongrel2/static/android-sdk/
cp openi-auth-android-sdk-1.0.0.jar      ~/repos/mongrel2/static/android-sdk/
cp openi-client-lib.aar                  ~/repos/mongrel2/static/android-sdk/