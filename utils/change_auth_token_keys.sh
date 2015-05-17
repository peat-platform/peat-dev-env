#!/bin/bash

openssl genrsa -out new_private_key.pem 2048

openssl rsa -in new_private_key.pem -pubout -out new_public_key.pem

new_private_key=`cat new_private_key.pem`
new_public_key=`cat new_public_key.pem`

node update_files_with_keys.js "$new_private_key" "$new_public_key" ~/repos/cloudlet-platform/lib/main.js
node update_files_with_keys.js "$new_private_key" "$new_public_key" ~/repos/user-dashboard/libs/config.js
node update_files_with_keys.js "$new_private_key" "$new_public_key" ~/repos/user-dashboard/app.js
node update_files_with_keys.js "$new_private_key" "$new_public_key" ~/repos/admin-dashboard/libs/config.js
node update_files_with_keys.js "$new_private_key" "$new_public_key" ~/repos/admin-dashboard/app.js
node update_files_with_keys.js "$new_private_key" "$new_public_key" ~/repos/auth-dialogs/bin/default.sh