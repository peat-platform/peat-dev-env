SESSION="OPENi"

tmux has-session -t $SESSION
if [ \\$? -eq 0 ]; then
    echo "Session \\$SESSION already exists. Attaching."
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



tmux send-keys -t $SESSION:1 ' cd /home/vagrant/repos/mongrel2/ && sh start_mongrel2.sh'  Enter
tmux send-keys -t $SESSION:2 ' cd /home/vagrant/repos/cloudlet-platform/  && node lib/main.js'  Enter
tmux send-keys -t $SESSION:3 ' cd /home/vagrant/repos/api-framework/OPENiapp/ && python manage.py runserver 0.0.0.0:8889' Enter
tmux send-keys -t $SESSION:4 ' cd /home/vagrant/repos/uaa/proxy && supervisor proxy.js ' Enter
tmux select-window -t :0


tmux attach -t $SESSION