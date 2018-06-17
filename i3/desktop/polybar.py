import subprocess
import os


def screens():
    output = [
        l for l in subprocess.check_output(["xrandr"]).decode("utf-8")
        .splitlines()
    ]
    return [l.split()[0] for l in output if " connected " in l]


def start_polybar():
    os.system("killall polybar")
    os.system("while pgrep -x polybar >/dev/null; do sleep 1; done")
    for screen in screens():
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
