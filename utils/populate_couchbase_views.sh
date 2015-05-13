#!/bin/bash


curl  -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "object_by_cloudlet_id": {
            "map": "function (doc, meta) {\n\n  if (undefined === doc[\"@type\"]){    return   }\n\n  var ts = new Date(doc[\"_date_modified\"]).getTime()\n\n  emit( [doc[\"@cloudlet\"], doc[\"@cloudlet\"], ts], doc[\"@id\"] );\n\n  for ( i in doc._permissions){\n\n    if ( doc._permissions[i][\"read\"] ){\n emit( [i, doc[\"@cloudlet\"], ts], doc[\"@id\"] );\n    }\n  }\n}",
            "reduce":"_count"
         },
         "object_by_type" : {
            "map" : "function (doc, meta) {\n if (undefined === doc[\"@type\"]){\n return \n }\n var ts = new Date(doc[\"_date_modified\"]).getTime() \n emit( [doc[\"@cloudlet\"], doc[\"@type\"], ts, doc[\"@cloudlet\"]], [doc[\"@cloudlet\"], doc[\"@id\"]] ); \n for ( i in doc._permissions){ \n if ( doc._permissions[i][\"read\"] ){ \n emit( [i, doc[\"@type\"], ts, doc[\"@cloudlet\"]], [doc[\"@cloudlet\"], doc[\"@id\"]] );\n }\n}\n}",
            "reduce" : "_count"
         },
         "type_usage" : {
            "map" : "function (doc, meta) {\n if (undefined === doc[\"@type\"]){\n    return \n  }\n emit(doc[\"@type\"], 1);\n}",
            "reduce" : "_count"
         },
         "object_data" : {
            "map" : "function (doc, meta) {\n if (undefined === doc[\"@type\"]){\n    return \n  }\n emit(doc[\"@id\"], doc[\"@type\"]);\n}"
         },
         "object_by_third_party_type" : {
            "map" : "function (doc, meta) {if (undefined === doc[\"@type\"]){ return }\n \n emit( [doc[\"@cloudlet\"], doc[\"@cloudlet\"], doc[\"@type\"]], doc[\"@type\"] );\n \n for ( i in doc._permissions){\n \n if ( doc._permissions[i][\"read\"] ){\n emit( [i, doc[\"@cloudlet\"], doc[\"@type\"]], doc[\"@type\"] );\n }\n }\n }",
            "reduce" : "_count"
         }
      }
}' \
  http://admin:password@localhost:8092/objects/_design/objects_views


curl -X PUT \
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
  http://admin:password@localhost:8092/objects/_design/cloudlets_views

curl  -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "types_list": {
            "map": "function (doc, meta) {\n  emit(doc[\"@id\"], 1);\n}",
            "reduce":"_count"
         },
         "get_ref": {
            "map": "function (doc, meta) {\n\temit(doc[\"@id\"], doc[\"@reference\"]);\n}"
         }
      }
   }' \
  http://admin:password@localhost:8092/types/_design/type_views


  curl  -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
      "views": {
         "subs_by_objectId": {
            "map": "function (doc, meta) {\n  if (meta.id.indexOf(\"+s_\") !== -1) {\n    //var cloudlet = meta.id.split(\"+\")[0]\n    emit(doc.objectid, doc);\n  }\n}"
        }
      }
    }' \
  http://admin:password@localhost:8092/objects/_design/subscription_views


curl -X PUT \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
    "views": {
        "clients_by_cloudlet_id": {
            "map": "function (doc, meta) {\n  emit(doc.cloudlet, doc); \n}",
            "reduce": "_count"
        },
        "list_service_enablers": {
            "map": "function (doc, meta) {\n if (undefined !== doc.isSE || true === doc.isSE ){\n emit(meta.id, doc);\n }\n}",
            "reduce": "_count"
        }
    }
}' \
  http://admin:password@localhost:8092/clients/_design/clients_views

    curl  -X PUT \
    -H "Accept:application/json" \
    -H "Content-Type: application/json" \
    -d '{
        "views": {
           "app_permissions": {
              "map": "function (doc, meta) {\n splitId = meta.id.split(\"_\")\n emit([splitId[0], splitId[1]], doc)\n}",
              "reduce":"_count"
           }
        }
     }' \
    http://admin:password@localhost:8092/app_permissions/_design/permission_views



    curl  -X PUT \
    -H "Accept:application/json" \
    -H "Content-Type: application/json" \
    -d '{
        "views": {
           "list_permissions_for_cloudlet": {
              "map": "function (doc, meta) {\n var userCid = meta.id.split(\"+\")[1]\n var appCid = meta.id.split(\"+\")[0]\n emit([userCid, appCid], {\"third_party\" : appCid, \"perms\" : doc})\n}",
              "reduce":"_count"
           }
        }
     }' \
    http://admin:password@localhost:8092/permissions/_design/permissions_views

  curl -X PUT \
    -H "Accept:application/json" \
    -H "Content-Type: application/json" \
    -d '{
        "views": {
           "get_name": {
              "map": "function (doc, meta) {\n emit(doc.cloudlet, doc.username);\n}"
           }
        }
     }' \
    http://admin:password@localhost:8092/users/_design/user_views
