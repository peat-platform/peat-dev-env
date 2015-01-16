#!/bin/bash

SSL_CERT=~/repos/mongrel2/certs/5dc1fbe7-d9db-4602-8d19-80c7ef2b1b11.crt


curl -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{ "dbs": [ "users", "clients", "authorizations", "queries" ] }' \
  http://admin:password@localhost:8092/dbkeys/dbkeys_29f81fe0-3097-4e39-975f-50c4bf8698c7
