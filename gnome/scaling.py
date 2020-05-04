#!/bin/python3

import subprocess


def current_scaling_factor():
    scaling = subprocess.check_output(
        ["gsettings", "get", "org.gnome.desktop.interface", "text-scaling-factor"]
    )
    return float(scaling.decode("utf-8").replace("\n", ""))


def set_scaling_factor(scaling=1.4):
    subprocess.check_call(
        [
            "gsettings",
            "set",
            "org.gnome.desktop.interface",
            "text-scaling-factor",
            str(scaling),
        ]
    )


if __name__ == "__main__":
    if current_scaling_factor() == 1.0:
        set_scaling_factor()
    else:
        set_scaling_factor(1.0)
