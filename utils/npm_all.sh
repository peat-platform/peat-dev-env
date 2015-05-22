#!/bin/bash

cd ~/repos

echo cloudlet-platform  && cd ~/repos/cloudlet-platform && npm install --no-bin-links ; cd ../
echo cloudlet-api       && cd ~/repos/cloudlet-api      && npm install --no-bin-links ; cd ../
echo object-api         && cd ~/repos/object-api        && npm install --no-bin-links ; cd ../
echo attachment-api     && cd ~/repos/attachment-api    && npm install --no-bin-links ; cd ../
echo type-api           && cd ~/repos/type-api          && npm install --no-bin-links ; cd ../
echo search-api         && cd ~/repos/search-api        && npm install --no-bin-links ; cd ../
echo admin-dashboard    && cd ~/repos/admin-dashboard   && npm install --no-bin-links ; cd ../
echo user-dashboard     && cd ~/repos/user-dashboard    && npm install --no-bin-links ; cd ../
echo notifications      && cd ~/repos/notifications     && npm install --no-bin-links ; cd ../
echo dao                && cd ~/repos/dao               && npm install --no-bin-links ; cd ../
echo swagger-def        && cd ~/repos/swagger-def       && npm install --no-bin-links ; cd ../
echo permissions-api    && cd ~/repos/permissions-api   && npm install --no-bin-links ; cd ../
echo auth-api           && cd ~/repos/auth-api          && npm install --no-bin-links ; cd ../
echo crud-api           && cd ~/repos/crud-api          && npm install --no-bin-links ; cd ../
echo /peat-aggregator   && cd ~/repos//peat-aggregator  && npm install --no-bin-links ; cd ../
