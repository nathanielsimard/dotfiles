import os
import display


def applications():
    dpi = display.get_screen_dpi()
    os.system("rofi -show drun -dpi " + dpi)


def command():
    dpi = display.get_screen_dpi()
    os.system("rofi -show run -dpi " + dpi)