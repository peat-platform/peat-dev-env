#!/usr/bin/env bash
cd /vagrant/utils/

git clone https://github.com/peat-platform/swagger-to-peat-types

cd swagger-to-peat-types

npm install

node main.js -s http://127.0.0.1/api-spec/v1/api_framework -o 127.0.0.1 -f pass1.json -c 'Graph API' --models '["From", "Context", "Time", "Person", "Duration", "PersonModel", "Location", "BaseTags", "BaseFile", "Address"]'


node main.js -s http://127.0.0.1/api-spec/v1/api_framework -o 127.0.0.1 -f pass2.json -c 'Graph API'  -m '{"Address":"t_98484d88a3787639e33c2998a0ede77a-1040","BaseFile":"t_fe251c876663126c8cfef50acb74f020-819","context":"t_eb4ddb73d52ca3b5304e0b4b38b556d5-20043","Duration":"t_362a82b7bade9196d79f35cfe4dc1720-505","From":"t_626702ee27cf2fa1295bdc67bbe6de26-704","Location":"t_0ffb4278fe8821f1ece77163c37c0be5-609","Person":"t_987a8188e90f36cc91d6075739464aa7-719","Time":"t_3a03708eea7763d8bbc5065f90c76360-629","BaseTag":"t_9628066c6c67787431583640a92b9f8d-721"}' --models '["Place", "QuestionOption", "Tag", "Note"]'


node main.js -s http://127.0.0.1/api-spec/v1/api_framework -o 127.0.0.1 -f pass3.json -c 'Graph API'  -m '{"Address":"t_98484d88a3787639e33c2998a0ede77a-1040","BaseFile":"t_fe251c876663126c8cfef50acb74f020-819","context":"t_eb4ddb73d52ca3b5304e0b4b38b556d5-20043","Duration":"t_362a82b7bade9196d79f35cfe4dc1720-505","From":"t_626702ee27cf2fa1295bdc67bbe6de26-704","Location":"t_0ffb4278fe8821f1ece77163c37c0be5-609","Person":"t_987a8188e90f36cc91d6075739464aa7-719","Time":"t_3a03708eea7763d8bbc5065f90c76360-629","BaseTag":"t_9628066c6c67787431583640a92b9f8d-721", "Place":"t_33d74fb349991cbed5baf6c3eb6e4783-998","QuestionOption":"t_9dc45ee5bc31663f9ea4fc3b587b1c25-1131","Tag":"t_65044262f0403e70ac339e39e6719fc4-1120","Tags":"t_65044262f0403e70ac339e39e6719fc4-1120","Notes":"t_f03c0606fdc01f0a2bf9bc51d155763f-997"}'


node mergefiles.js