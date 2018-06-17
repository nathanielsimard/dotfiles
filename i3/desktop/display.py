import subprocess
import os

DEFAULT_DPI=96

def screens():
    output = [
        l for l in subprocess.check_output(["xrandr"]).decode("utf-8")
        .splitlines()
    ]
    return [l.split()[0] for l in output if " connected " in l]


def lid_is_closed():
    o = os.system("grep -q closed /proc/acpi/button/lid/*/state")
    lid_is_closed = o == 0
    return lid_is_closed


def lock_screen():
    command = "i3lock -i ~/Picture/trees_green_fog_forest_shroud_top_view_118416_3840x2160.png"
    os.system(command)


def get_scaling_factor():
    try:
        return int(os.environ['GTK_SCALE'])
    except:
        return 1


def get_screen_dpi():
    return str(get_scaling_factor() * DEFAULT_DPI)