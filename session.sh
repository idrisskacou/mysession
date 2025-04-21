#!/bin/bash

SESSION="mysession"

# Check if session already exists
tmux has-session -t $SESSION 2>/dev/null
if [ $? -eq 0 ]; then
  echo "Session $SESSION already exists. Attaching..."
  tmux attach-session -t $SESSION
  exit 0
fi

#Print the Session
echo "Creating new tmux session: $SESSION"

# Create session with first window
tmux new-session -d -s "$SESSION" -n Terminal_1
tmux send-keys -t "$SESSION:0.0" 'cd ~/Desktop' C-m
tmux split-window -h -t "$SESSION:0"
tmux send-keys -t "$SESSION:0.1" 'top' C-m
tmux select-layout -t "$SESSION:0" tiled

# Window 1: server
tmux new-window -t "$SESSION" -n Terminal_2
tmux send-keys -t "$SESSION:1.0" 'cd ..//..' C-m
tmux split-window -v -t "$SESSION:1"
tmux send-keys -t "$SESSION:1.1" 'echo "Server logs coming here..."' C-m
tmux select-layout -t "$SESSION:1" even-vertical

# Window 2: logs
tmux new-window -t "$SESSION" -n Terminal_3
tmux send-keys -t "$SESSION:2.0" 'cd ~/logs' C-m
tmux split-window -h -t "$SESSION:2"
tmux send-keys -t "$SESSION:2.1" 'cd ~/Desktop' C-m
tmux select-layout -t "$SESSION:2" tiled

# Window 3: misc
tmux new-window -t "$SESSION" -n Terminal_4
tmux send-keys -t "$SESSION:3.0" 'cd ~/Desktop' C-m
tmux split-window -v -t "$SESSION:3"
tmux send-keys -t "$SESSION:3.1" 'cd ~/Desktop' C-m
tmux select-layout -t "$SESSION:3" even-vertical

# Select starting window
tmux select-window -t "$SESSION:0"

# Attach to the session
tmux attach-session -t "$SESSION"

# cmd 
# control + b and d (for detach session )
# tmux new -s [session name here idriss ]
# tmux ls # this will list your session 
# tmux a -t [index of the session]
# control + b and c to create new window
# control + b and n allow you to move between window 
# control + b and w show all window and allow you to move between window