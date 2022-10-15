dconf write /org/gnome/desktop/wm/preferences/focus-mode "'click'"

# keybindings
dconf reset /org/gnome/desktop/wm/keybindings

# Move workspace
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-left "['<Alt>h']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-right "['<Alt>l']"

# Move window
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-left "['<Shift><Alt>h']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-right "['<Shift><Alt>l']"

# Move monitor
dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-left "['<Shift><Super>h']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-right "['<Shift><Super>l']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-up "['<Shift><Super>k']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-down "['<Shift><Super>j']"

# Window command
dconf write /org/gnome/desktop/wm/keybindings/toggle-maximized "['<Super>k']"
dconf write /org/gnome/desktop/wm/keybindings/minimize "['<Super>j']"
dconf write /org/gnome/desktop/wm/keybindings/close "['<Super>q']"
dconf write /org/gnome/mutter/keybindings/toggle-tiled-right "['<Super>l']"
dconf write /org/gnome/mutter/keybindings/toggle-tiled-left "['<Super>h']"

dconf write /org/gnome/mutter/keybindings/switch-application "['']"
dconf write /org/gnome/mutter/keybindings/switch-application-backward "['']"
dconf write /org/gnome/mutter/keybindings/switch-windows-directly "['<Alt><Tab>']"
dconf write /org/gnome/mutter/keybindings/switch-windows-directly-backward "['<Shift><Alt><Tab>']"
