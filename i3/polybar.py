#!/usr/bin/env python3
import subprocess
import os


def screens():
    output = [
        l for l in subprocess.check_output(["xrandr"]).decode("utf-8")
        .splitlines()
    ]
    return [l.split()[0] for l in output if " connected " in l]


os.system("killall polybar")
for screen in screens():
    command = "MONITOR=" + screen + " polybar mybar &"
    os.system(command)
