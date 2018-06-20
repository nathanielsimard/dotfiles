#!/usr/bin/env python3
import argparse
import display
import layout
import polybar
import rofi
import workspace
import compositor
import keyboard
import wallpaper
import network


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--start-compositor',
        action='store_true',
        default=False,
        help='Start the compositor')
    parser.add_argument(
        '--screen-layout-setup',
        action='store_true',
        default=False,
        help='Apply screen layout settings or start utility')
    parser.add_argument(
        '--screen-layout-utility',
        action='store_true',
        default=False,
        help='Start screen layout utility')
    parser.add_argument(
        '--polybar',
        action='store_true',
        default=False,
        help='Start or restart Polybar')
    parser.add_argument(
        '--applications',
        action='store_true',
        default=False,
        help='Start rofi for searching applications')
    parser.add_argument(
        '--command',
        action='store_true',
        default=False,
        help='Start rofi for running commands')
    parser.add_argument(
        '--add-workspace',
        action='store_true',
        default=False,
        help='Add a workspace')
    parser.add_argument(
        '--move-window-to-new-workspace',
        action='store_true',
        default=False,
        help='Add a workspace')
    parser.add_argument(
        '--lock-screen',
        action='store_true',
        default=False,
        help='Lock the screen')
    parser.add_argument(
        '--keyboard-setup',
        action='store_true',
        default=False,
        help='Apply keyboard settings')
    parser.add_argument(
        '--wallpaper',
        action='store_true',
        default=False,
        help='Apply wallpaper')
    parser.add_argument(
        '--network-setup',
        action='store_true',
        default=False,
        help='Start network applet')

    args = parser.parse_args()
    if args.keyboard_setup:
        keyboard.keyboard_setup()
    if args.start_compositor:
        compositor.start()
    if args.screen_layout_setup:
        layout.setup_screen_layout()
    if args.screen_layout_utility:
        layout.prompt_screen_layout_utility()
    if args.add_workspace:
        workspace.add()
    if args.polybar:
        polybar.start_polybar()
    if args.applications:
        rofi.applications()
    if args.command:
        rofi.command()
    if args.lock_screen:
        display.lock_screen()
    if args.wallpaper:
        wallpaper.apply()
    if args.network_setup:
        network.start_applet()    
    if args.move_window_to_new_workspace:
        workspace.move_window_to_new_workspace()


if __name__ == "__main__":
    main()
