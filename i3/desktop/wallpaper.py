import os

WALLPAPER_PICTURE_PATH = "~/Picture/trees_green_fog_forest_shroud_top_view_118416_3840x2160.png"
APPLY_WALLPAPER_COMMAND = "feh --bg-scale " + WALLPAPER_PICTURE_PATH

def apply():
    os.system(APPLY_WALLPAPER_COMMAND)
