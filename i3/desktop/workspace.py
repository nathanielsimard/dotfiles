import os

ADD_WORKSPACE_COMMAND = "i3-msg workspace $(($(i3-msg -t get_workspaces | tr , '\n' | grep '\"num\":' | cut -d : -f 2 | sort -rn | head -1) + 1))"

def add():
    os.system(ADD_WORKSPACE_COMMAND)