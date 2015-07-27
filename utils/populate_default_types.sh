#!/bin/bash

#SSL_CERT=~/repos/mongrel2/certs/5dc1fbe7-d9db-4602-8d19-80c7ef2b1b11.crt

curl -k -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@context": [
    {
      "@property_name": "images",
      "@type": "attachment",
      "@required": false,
      "@multiple": true,
      "@description": "https://openi-ict.eu/images/ids"
    }
  ],
  "@reference": "https://openi-ict.eu/images"
}' \
  https://dev.peat-platform.org:443/api/v1/types


curl -k -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@context": [
    {
      "@property_name": "videos",
      "@type": "attachment",
      "@required": false,
      "@multiple": true,
      "@description": "https://peat-platform.org/videos/ids"
    }
  ],
  "@reference": "https://peat-platform.org/videos"
}' \
  https://dev.peat-platform.org:443/api/v1/types


curl -k -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@context": [
    {
      "@property_name": "pdfs",
      "@type": "attachment",
      "@required": false,
      "@multiple": true,
      "@description": "https://peat-platform.org/pdfs/ids"
    }
  ],
  "@reference": "https://peat-platform.org/pdfs"
}' \
  https://dev.peat-platform.org:443/api/v1/types



curl -k -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@context": [
    {
      "@property_name": "audio",
      "@type": "attachment",
      "@required": false,
      "@multiple": true,
      "@description": "https://peat-platform.org/audio/ids"
    }
  ],
  "@reference": "https://peat-platform.org/audio"
}' \
  https://dev.peat-platform.org:443/api/v1/types

curl -k -X POST \
  -H "Accept:application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "@context": [
    {
      "@property_name": "client_id",
      "@type": "string",
      "@multiple": false,
      "@required": true,
      "@description": "Unique identifier for Client"
    },
    {
      "@property_name": "peat_type",
      "@type": "string",
      "@multiple": false,
      "@required": true,
      "@description": "OPENi Type Id"
    },
    {
      "@property_name": "notification_type",
      "@type": "string",
      "@multiple": false,
      "@required": true,
      "@description": "Type of notification (GCM, email, SMS, SSE)"
    },
    {
      "@property_name": "data",
      "@type": "string",
      "@multiple": false,
      "@required": false,
      "@description": "Data sent for email or SMS"
    },
    {
      "@property_name": "endpoint",
      "@type": "string",
      "@multiple": false,
      "@required": false,
      "@description": "Email address, Phone number or Android Device ID"
    }
  ],
  "@reference": "PEAT Subscription"
}' \
  https://dev.peat-platform.org:443/api/v1/types
