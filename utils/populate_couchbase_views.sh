#!/bin/bash

SSL_CERT=~/repos/mongrel2/certs/5dc1fbe7-d9db-4602-8d19-80c7ef2b1b11.crt

curl --cacert $SSL_CERT -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "object_by_cloudlet_id": {
            "map": "function (doc, meta) {\n   \n  emit( [doc[\"@cloudlet\"], doc[\"@cloudlet\"]], doc[\"@id\"] );\n  \n  for ( i in doc._permissions){\n    \n    if ( doc._permissions[i][\"read\"] ){\n  \temit( [i, doc[\"@cloudlet\"]], doc[\"@id\"] );\n    }\n  }\n}",
             "reduce":"_count"
         },
         "object_by_type" : {
            "map" : "function (doc, meta) {\n   \n  emit( [doc[\"@cloudlet\"], doc[\"@openi_type\"], doc[\"@cloudlet\"]], [doc[\"@cloudlet\"], doc[\"@id\"]] );\n  \n  for ( i in doc._permissions){\n    \n    if ( doc._permissions[i][\"read\"] ){\n  \temit( [i, doc[\"@openi_type\"], doc[\"@cloudlet\"]], [doc[\"@cloudlet\"], doc[\"@id\"]] );\n    }\n    \n  }\n}",
            "reduce" : "_count"
         },
         "type_usage" : {
            "map" : "function (doc, meta) {\n  emit(doc[\"@openi_type\"], 1);\n}",
            "reduce" : "_count"
         }
      }
   }' \
  http://admin:password@dev.openi-ict.eu:8092/objects/_design/objects_views


curl --cacert $SSL_CERT -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "cloudlet_list": {
            "map": "function (doc, meta) {\n\temit(doc[\"@cloudlet\"], 1);\n}",
            "reduce":"_count"
         }
      }
   }' \
  http://admin:password@dev.openi-ict.eu:8092/objects/_design/cloudlets_views

curl --cacert $SSL_CERT -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "types_list": {
            "map": "function (doc, meta) {\n  emit(doc[\"@id\"], 1);\n}",
            "reduce":"_count"
         }
      }
   }' \
  http://admin:password@dev.openi-ict.eu:8092/types/_design/type_views


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