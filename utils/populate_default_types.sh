#!/bin/bash

SSL_CERT=~/repos/mongrel2/certs/5dc1fbe7-d9db-4602-8d19-80c7ef2b1b11.crt

curl --cacert $SSL_CERT -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@context": [
    {
      "@property_name": "images",
      "@openi_type": "attachment",
      "@required": false,
      "@multiple": true,
      "@context_id": "https://openi-ict.eu/images/ids"
    }
  ],
  "@reference": "https://openi-ict.eu/images"
}' \
  https://dev.openi-ict.eu:443/api/v1/types


curl --cacert $SSL_CERT -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@context": [
    {
      "@property_name": "videos",
      "@openi_type": "attachment",
      "@required": false,
      "@multiple": true,
      "@context_id": "https://openi-ict.eu/videos/ids"
    }
  ],
  "@reference": "https://openi-ict.eu/videos"
}' \
  https://dev.openi-ict.eu:443/api/v1/types


curl --cacert $SSL_CERT -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@context": [
    {
      "@property_name": "pdfs",
      "@openi_type": "attachment",
      "@required": false,
      "@multiple": true,
      "@context_id": "https://openi-ict.eu/pdfs/ids"
    }
  ],
  "@reference": "https://openi-ict.eu/pdfs"
}' \
  https://dev.openi-ict.eu:443/api/v1/types



curl --cacert $SSL_CERT -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@context": [
    {
      "@property_name": "audio",
      "@openi_type": "attachment",
      "@required": false,
      "@multiple": true,
      "@context_id": "https://openi-ict.eu/audio/ids"
    }
  ],
  "@reference": "https://openi-ict.eu/audio"
}' \
  https://dev.openi-ict.eu:443/api/v1/types

curl --insecure -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@openi_type": "t_f3bfd0b665a3e32b1d3c9fe1927717d6-511",
  "@data": {
    "username" : "bob",
   "slogan" : ["When you got it, flaunt it.", "What."],
    "avatar" : "a0e34cdf-6424-480d-b8cc-8350a9ce4eb8"
  }
}' \
https://dev.openi-ict.eu:443/api/v1/objects/c_897b0ef002da79321dcb0d681cb473d0