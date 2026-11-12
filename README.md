# kosm_blender

Blender for kosm: an interface theme preset in the theme's colors, generated into every
Blender version you have run (`~/.config/blender/<version>/scripts/presets/interface_theme/kosm.xml`;
a version is found by the files in its `config` folder, so start a new version once, then
apply). Blender lists it as `kosm`
under Preferences > Themes. Blender keeps its theme in its preferences, not the preset, so the
app also writes a startup script (`scripts/startup/kosm.py`, per version) that loads the preset when Blender
starts and again within `reload_interval` of an apply, recoloring a running Blender. Loading a
preset resets the theme first, so every color the app leaves null is Blender's default. With
the theme's `files = .per_kosmos` the preset is named after the kosmos instead
(`krystallos.dark.xml`), so each kosmos applied keeps its own preset in the list.

`from(theme)` sets backgrounds from the theme's background role with its surface steps
(buttons raised, fields and boxes sunken, menus and tooltips on the overlay step, menu and list
items transparent), text from the foreground role and highlighted text brighter, selections and slider fills the accent
with readable text from the theme's `contrast.on`, and outlines the theme's `line.border`.
Every editor gets the same background, header and text; the 3D viewport's background is a
single color.

## Fields

| Field | Default |
|---|---|
| `config` | `~/.config/blender`, Blender's user folder with one folder per version |
| `versions` | null: every version in `config` Blender has run (files in its `config` folder), an error when there is none; a list (`&.{"5.2"}`) writes exactly those |
| `preset` | `scripts/presets/interface_theme/{name}.xml` inside each version's folder; `{name}` is `kosm`, or the kosmos' name with `files = .per_kosmos` |
| `files` | the theme's `files`: `.shared` or `.per_kosmos` |
| `startup_script` | `scripts/startup/kosm.py` inside each version's folder, written whole: loads the preset when Blender starts and again when an apply changes it; null writes nothing, and the preset is picked by hand |
| `reload_interval` | 0.25: seconds between the startup script's checks of the preset (one file status call each); null loads it only at start |
| `user_interface` | `editor_border`, `editor_outline`, `editor_outline_active`, `widget_text_cursor`, `panel_header`, `panel_title`, `panel_text`, `panel_back`, `panel_sub_back`, `panel_outline`, `panel_active`, `transparent_checker_primary`, `transparent_checker_secondary` |
| `widgets` | one per kind of widget (`regular`, `tool`, `toolbar_item`, `radio`, `text`, `option`, `toggle`, `num`, `numslider`, `box`, `curve`, `menu`, `pulldown`, `menu_back`, `pie_menu`, `tooltip`, `menu_item`, `scroll`, `progress`, `list_item`, `tab`), each `outline`, `outline_sel`, `inner`, `inner_sel`, `item`, `text`, `text_sel` |
| `editors` | one per editor (`view_3d`, `graph_editor`, `file_browser`, `nla_editor`, `dopesheet_editor`, `image_editor`, `sequence_editor`, `properties`, `text_editor`, `node_editor`, `outliner`, `info`, `preferences`, `console`, `clip_editor`, `topbar`, `statusbar`, `spreadsheet`), each `back`, `title`, `text`, `text_hi`, `header`, `header_text`, `header_text_hi` |
| `regions` | `sidebars_back`, `sidebars_tab_back`, `asset_shelf_back`, `asset_shelf_header_back`, `channels_back`, `channels_text`, `channels_text_selected`, `scrubbing_back`, `scrubbing_text` |

Every color left null is Blender's default.
