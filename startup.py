# Written whole by kosm on every apply. Loads the theme preset kosm writes when Blender starts,
# then again whenever an apply changes it, so the theme survives restarts and follows applies.

import os

import bpy

PRESET = {kosm.preset}
# Seconds between checks of the preset, or None to load it only at start.
INTERVAL = {kosm.interval}

_loaded = None


def _modified():
    try:
        return os.stat(PRESET).st_mtime_ns
    except FileNotFoundError:
        return None


def _load_if_changed():
    global _loaded
    modified = _modified()
    if modified is not None and modified != _loaded:
        _loaded = modified
        try:
            bpy.ops.script.execute_preset(filepath=PRESET, menu_idname="USERPREF_MT_interface_theme_presets")
            _redraw()
        except Exception as error:
            print(f"kosm: could not load the theme preset {PRESET}: {error}")
    return INTERVAL


def _redraw():
    window_manager = bpy.context.window_manager
    if window_manager is None:
        return
    for window in window_manager.windows:
        for area in window.screen.areas:
            area.tag_redraw()


def register():
    bpy.app.timers.register(_load_if_changed, first_interval=0, persistent=True)


def unregister():
    if bpy.app.timers.is_registered(_load_if_changed):
        bpy.app.timers.unregister(_load_if_changed)
