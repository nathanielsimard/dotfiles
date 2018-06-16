#!/usr/bin/env python3
import subprocess
import os


def screens():
    output = [
        l for l in subprocess.check_output(["xrandr"]).decode("utf-8")
        .splitlines()
    ]
    return [l.split()[0] for l in output if " connected " in l]


o = os.system("killall polybar")
for screen in screens():
    scale = "1"
    try:
        scale = os.environ["GTK_SCALE"]
    except:
        pass
    height = 20
    dpi = 96
    if scale == "2":
        height *= 2
        dpi *= 2
    command = "MONITOR=" + screen + " HEIGHT=" + str(height) + " DPI=" + str(dpi) + " polybar mybar &"
    os.system(command)
