#!/bin/sh

SESSION="PEAT"

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
tmux new-window    -t $SESSION -a -n    'Auth Dialogs'
tmux new-window    -t $SESSION -a -n    'Admin Dashboard'
tmux new-window    -t $SESSION -a -n    'User Dashboard'



tmux send-keys -t $SESSION:1 ' cd ~/repos/mongrel2/ && sh start_mongrel2.sh'  Enter
tmux send-keys -t $SESSION:2 ' cd ~/repos/cloudlet-platform/ && node lib/main.js'  Enter
tmux send-keys -t $SESSION:3 ' cd ~/repos/api-framework/OPENiapp/ && venv/bin/python manage.py runserver 0.0.0.0:8889' Enter
tmux send-keys -t $SESSION:4 ' cd ~/repos/auth-dialogs/ && sh   bin/default.sh'  Enter
tmux send-keys -t $SESSION:5 ' cd ~/repos/admin-dashboard/    && sh bin/default.sh'  Enter
tmux send-keys -t $SESSION:6 ' cd ~/repos/user-dashboard/     && node bin/www'  Enter

tmux select-window -t :0


tmux attach -t $SESSION
