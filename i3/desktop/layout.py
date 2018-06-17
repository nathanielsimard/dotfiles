import os
import display
import polybar

SCREEN_LAYOUT_PATH = "/home/nathaniel/.screenlayout/"


def prompt_screen_layout_utility():
    screen_layout_name = __get_screen_layout_name()
    screen_layout_full_name = SCREEN_LAYOUT_PATH + screen_layout_name
    __prompt_screen_layout_utility(screen_layout_full_name)


def setup_screen_layout():
    screen_layout_name = __get_screen_layout_name()
    screen_layout_full_name = SCREEN_LAYOUT_PATH + screen_layout_name
    screen_layout_names = os.listdir(SCREEN_LAYOUT_PATH)

    if (screen_layout_name in screen_layout_names):
        print("Execute saved layout setting ...")
        os.system(screen_layout_full_name)
        polybar.start_polybar()
    else:
        print("Prompt layout setting ...")
        __prompt_screen_layout_utility(screen_layout_full_name)


def __prompt_screen_layout_utility(screen_layou_full_name):
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


def __get_screen_layout_name():
    file_name = ""
    for screen in display.screens():
        file_name += screen
    file_name += "LidIsClosed-" + str(display.lid_is_closed())
    file_name += ".sh"
    return file_name
