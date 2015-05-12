#!/usr/bin/env bash
cd /vagrant/utils/

#git clone https://github.com/peat-platform/swagger-to-peat-types

cd swagger-to-peat-types

#npm install

node main.js -s http://127.0.0.1/api-spec/v1/api_framework -o 127.0.0.1 -f pass1.json -c 'Graph API' --models '["From", "Context", "Time", "Person", "Duration", "PersonModel", "Location", "BaseTags", "BaseFile", "Address"]'


node main.js -s http://127.0.0.1/api-spec/v1/api_framework -o 127.0.0.1 -f pass2.json -c 'Graph API'  -m '{"Address":"t_76ab22940f5d4130f21ab900277ce0b8-1004","BaseFile":"t_51c9cf81214fd0ced68b5943207c2112-791","context":"t_5d48f7cefbbdcd30ed55e77117be9190-19515","Duration":"t_832c3320c7efb11e435ff0d1b6201baa-489","From":"t_46f9fd0b24eaf1021eea4896990ad2d6-680","Location":"t_1f90f0262e4986d6172c24447e2387c6-589","Person":"t_a9ea41b962a9809b9f935b9ca7e6078b-695","Time":"t_ba6c842149f81edbb0abe701f6972eee-609","BaseTag":"t_6d40fa3e59a1dce2f5c42ccb9363dbe5-697"}' --models '["Place", "QuestionOption", "Tag", "Note"]'


node main.js -s http://127.0.0.1/api-spec/v1/api_framework -o 127.0.0.1 -f pass3.json -c 'Graph API'  -m '{"Address":"t_0ef6b52e84d5f321a31109a4f945b80c-1046","BaseFile":"t_51c9cf81214fd0ced68b5943207c2112-791","context":"t_5d48f7cefbbdcd30ed55e77117be9190-19515","Duration":"t_832c3320c7efb11e435ff0d1b6201baa-489","From":"t_46f9fd0b24eaf1021eea4896990ad2d6-680","Location":"t_1f90f0262e4986d6172c24447e2387c6-589","Person":"t_a9ea41b962a9809b9f935b9ca7e6078b-695","Time":"t_ba6c842149f81edbb0abe701f6972eee-609","BaseTag":"t_6d40fa3e59a1dce2f5c42ccb9363dbe5-697", "Place":"t_02229a8f90e599e8a0cc9d3671d5bc0a-966","QuestionOption":"t_7e8ef4de1d42bde3879943dc8cede38d-1095","Tag":"t_7a1c0b2ca7e2b623abb7099bc7e5eacc-1084","Tags":"t_7a1c0b2ca7e2b623abb7099bc7e5eacc-1084","Notes":"t_92ed990ef81de437fff3609a987cc4c4-965"}'


node mergefiles.js