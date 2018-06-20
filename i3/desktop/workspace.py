import os
import json


def __get_workspaces():
    workspaces = os.popen("i3-msg -t get_workspaces")
    return json.load(workspaces)


def __find_current_workspace():
    for workspace in __get_workspaces():
        if workspace["focused"]:
            return workspace


def __find_next_workspace_number():
    biggest_num = 0
    for workspace in __get_workspaces():
        current_num = workspace["num"]
        if current_num > biggest_num:
            biggest_num = current_num
    return biggest_num


def add():
    workspace_number = __find_next_workspace_number()
    os.system("i3-msg workspace " + str(workspace_number + 1))


def move_window_to_new_workspace():
    workspace_number = __find_next_workspace_number()
    os.system("i3-msg move to workspace " + str(workspace_number + 1))
    os.system("i3-msg workspace " + str(workspace_number + 1))