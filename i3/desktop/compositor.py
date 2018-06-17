import os

COMPTON_COMMAND = "compton -b --backend glx --no-fading-openclose"

def start():
    os.system(COMPTON_COMMAND)