#!/bin/sh

SESSION="OPENi"

tmux has-session -t $SESSION
if [ $? -eq 0 ]; then
    echo "Session $SESSION already exists. Attaching."
    sleep 1
    tmux attach -t $SESSION
    exit 0;
fi

tmux new -d -s $SESSION

tmux rename-window -t $SESSION:0        'Default'
tmux new-window    -t $SESSION -a -n    'Mongrel2'
tmux new-window    -t $SESSION -a -n    'Cloudlet framework'
tmux new-window    -t $SESSION -a -n    'API framework'
tmux new-window    -t $SESSION -a -n    'Auth framework'
tmux new-window    -t $SESSION -a -n    'Auth framework alt-endpoints'



tmux send-keys -t $SESSION:1 ' cd ~/repos/mongrel2/ && sh start_mongrel2.sh'  Enter
tmux send-keys -t $SESSION:2 ' cd ~/repos/cloudlet/ && node main.js'  Enter
tmux send-keys -t $SESSION:3 ' cd ~/repos/api-framework/OPENiapp/ && venv/bin/python manage.py runserver 0.0.0.0:8889' Enter
tmux send-keys -t $SESSION:4 ' cd ~/repos/uaa/proxy && node pass-through-proxy.js ' Enter
tmux send-keys -t $SESSION:5 ' cd ~/repos/uaa/proxy && node auth-alt-proxy.js ' Enter
tmux select-window -t :0


tmux attach -t $SESSION