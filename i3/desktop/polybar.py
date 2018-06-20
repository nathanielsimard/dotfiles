import subprocess
import display
import os


def start_polybar():
    os.system("killall polybar")
    os.system("while pgrep -x polybar >/dev/null; do sleep 1; done")
    for screen in display.screens():
        print(screen)
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
