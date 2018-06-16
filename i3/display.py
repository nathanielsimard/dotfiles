#!/usr/bin/env python3
import subprocess
import os

SCREEN_LAYOUT_PATH = "/home/nathaniel/.screenlayout/"


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


def promptScreenLayoutSetting():
    print("Prompt screen layout setting ...")
    tmp_file_name = SCREEN_LAYOUT_PATH + "CHOOSE_ME.sh"
    os.system("touch " + tmp_file_name)
    os.system("chmod +x " + tmp_file_name)
    os.system("arandr")
    if (not os.stat(tmp_file_name).st_size == 0):
        print("Setting good name file ...")
        os.system("mv " + tmp_file_name + " " + screen_layou_full_name)
    else:
        print("Remove tmp file ...")
        os.system("rm " + tmp_file_name)


screen_layout_name = getScreenLayoutName()
screen_layou_full_name = SCREEN_LAYOUT_PATH + screen_layout_name
screen_layout_names = os.listdir(SCREEN_LAYOUT_PATH)

if (screen_layout_name in screen_layout_names):
    print("Execute saved layout setting ...")
    os.system(screen_layou_full_name)
    os.system("~/.config/i3/polybar.py")
else:
    print("Prompt layout setting ...")
    promptScreenLayoutSetting()
