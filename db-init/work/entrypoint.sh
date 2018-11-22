#!/bin/bash

set -euo pipefail
DB_URL=http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@${COUCHDB_HOST}:${COUCHDB_PORT}/fdic_institutions2 
DB_TEST=http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@${COUCHDB_HOST}:${COUCHDB_PORT}/tests_empty


echo "Verify database on URL ${DB_URL}"
STATUS=$(curl -s -o /dev/null -w '%{http_code}' ${DB_URL})
if [ $STATUS -eq 200 ]; then
    echo "Got 200! Database already exist!!!! Skipping"
    #curl -X DELETE ${DB_URL}
    exit 0
fi

echo "Create database on URL ${DB_URL}"
curl -X PUT ${DB_URL}
echo "Put sample data"
curl -X POST -H "Content-Type: application/json" "${DB_URL}/_bulk_docs" -d '@/work/sample-data.json' 
echo "Create name-view"
curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "name-view": {
      "map": "function(doc){ if(doc.NAME){ emit(doc.NAME, doc); }}"
    }
  },
  "language": "javascript"
}' ${DB_URL}/_design/name

echo "Create asset-view"
curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "asset-view": {
      "map": "function(doc){ if(doc.ASSET){ emit(parseInt(doc.ASSET.replace(\/,\/g, \"\")), doc); }}"
    }
  },
  "language": "javascript"
}' ${DB_URL}/_design/asset

echo "Create name-asset-view"
curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "name-asset-view": {
      "map": "function(doc){ if(doc.NAME && doc.ASSET){ emit(doc.NAME, doc.ASSET); }}"
    }
  },
  "language": "javascript"
}' ${DB_URL}/_design/name-asset

echo "Create fed-rssd-view"
curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "fed-rssd-view": {
      "map": "function(doc){ if(doc.FED_RSSD){ emit(doc.FED_RSSD); }}"
    }
  },
  "language": "javascript"
}'  ${DB_URL}/_design/fed-rssd

echo "Create database on URL ${DB_TEST}"
curl -X PUT ${DB_TEST}


echo "Process completed"