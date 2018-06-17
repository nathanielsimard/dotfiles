import os

CAPS_LOCK_BINDING_COMMAND = "setxkbmap -option caps:escape"

def keyboard_setup():
    os.system(CAPS_LOCK_BINDING_COMMAND)