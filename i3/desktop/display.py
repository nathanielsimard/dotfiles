import subprocess
import os


def screens():
    output = [
        l for l in subprocess.check_output(["xrandr"]).decode("utf-8")
        .splitlines()
    ]
    return [l.split()[0] for l in output if " connected " in l]


def lidIsClosed():
    o = os.system("grep -q closed /proc/acpi/button/lid/*/state")
    lid_is_closed = o == 0
    return lid_is_closed


def getScreenLayoutName():
    file_name = ""
    for screen in screens():
        file_name += screen
    file_name += "LidIsClosed-" + str(lidIsClosed())
    file_name += ".sh"
    return file_name


def lock_screen():
    command = "i3lock -i ~/Picture/trees_green_fog_forest_shroud_top_view_118416_3840x2160.png"
    os.system(command)