#!/bin/bash

SSL_CERT=~/repos/mongrel2/certs/5dc1fbe7-d9db-4602-8d19-80c7ef2b1b11.crt

curl --cacert $SSL_CERT -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "object_by_cloudlet_id": {
            "map": "function(doc, meta) {\n  var parts = meta.id.split(\"+\");\n  if(parts.length > 1) {\n    emit(parts[0], doc[\"@id\"]);\n  }\n}"
         },
         "object_by_type": {
            "map": "function(doc, meta) {\n  var parts = meta.id.split(\"+\");\n  if( parts.length > 1 ) {\n    emit( parts[0] + \"+\" + doc[\"@openi_type\"], doc[\"@id\"] );\n  }\n}"
         }
      }
   }' \
  http://admin:password@dev.openi-ict.eu:8092/openi/_design/objects_views

curl --cacert $SSL_CERT -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "cloudlet_list": {
            "map": "function(doc, meta) {\n  var parts = meta.id.split(\"+\");\n  if(1 === parts.length) {\n    if(0 === parts[0].indexOf(\"c_\")) {\n      emit(parts[0], doc[\"@id\"]);\n    }\n  }\n}"
         }
      }
   }' \
  http://admin:password@dev.openi-ict.eu:8092/openi/_design/cloudlets_views

curl --cacert $SSL_CERT -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "types_list": {
            "map": "function(doc, meta) {\n  var parts = meta.id.split(\"+\");\n  if (1 === parts.length) {\n    if (0 === parts[0].indexOf(\"t_\")) {\n      emit(parts[0], doc[\"@id\"]);\n    }\n  }\n}"
         },
         "types_usage": {
            "map": "function(doc, meta) {\n  var parts = meta.id.split(\"+\");\n  if (parts.length > 1) {\n    emit(doc[\"@openi_type\"], 1);\n  }\n}",
            "reduce": "_count"
         }
      }
    }' \
  http://admin:password@dev.openi-ict.eu:8092/openi/_design/type_views

  curl --cacert $SSL_CERT -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "subs_by_objectId": {
            "map": "function (doc, meta) {\n  if (meta.id.indexOf(\"+s_\") !== -1) {\n    //var cloudlet = meta.id.split(\"+\")[0]\n    emit(doc.objectid, doc);\n  }\n}"
        }
      }
    }' \
  http://admin:password@dev.openi-ict.eu:8092/openi/_design/subscription_views