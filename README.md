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

`from(theme)` sets every color Blender has. The interface: backgrounds from the theme's
background role with its surface steps (buttons raised, fields and boxes sunken, menus and
tooltips on the overlay step, menu and list items transparent), text from the foreground role
and highlighted text brighter, pressed buttons and slider fills the accent with readable text
from the theme's `contrast.on`, outlines the theme's `line.border`. Every editor gets the same
background, header and text; the 3D viewport's background is a single color. In what editors
show, active items (the active object, node, marker) are the accent and selected ones the
secondary role; plain geometry, grids and unselected keyframes are neutral; and each kind of
thing Blender colors apart (axes, gizmos, icons, node and strip kinds, handle and keyframe
types, normals, seams) takes the palette hue nearest Blender's own, darker when unselected and
mixed halfway toward the background where text sits on it. The text editor's syntax takes the
theme's code colors, and messages the error, warning and success roles.

`rounding` and `shadow_range` take the shared corner radius and shadow reach in pixels (the
base sets them from its values) and become Blender's roundness of every widget and panel and its
menu shadow width, where those are left null.

The fields follow Blender 5.3's theme. Older versions read the same preset, keeping their
defaults for the few colors 5.3 dropped (editors' titles and header text, the file browser's
selected file).

`kosm doctor` checks that Blender is installed, as the `blender` command.

## Fields

| Field | Default |
|---|---|
| `config` | `~/.config/blender`, Blender's user folder with one folder per version |
| `versions` | null: every version in `config` Blender has run (files in its `config` folder), an error when there is none; a list (`&.{"5.2"}`) writes exactly those |
| `preset` | `scripts/presets/interface_theme/{name}.xml` inside each version's folder; `{name}` is `kosm`, or the kosmos' name with `files = .per_kosmos` |
| `files` | the theme's `files`: `.shared` or `.per_kosmos` |
| `startup_script` | `scripts/startup/kosm.py` inside each version's folder, written whole: loads the preset when Blender starts and again when an apply changes it; null writes nothing, and the preset is picked by hand |
| `reload_interval` | 0.25: seconds between the startup script's checks of the preset (one file status call each); null loads it only at start |
| `rounding` | null: Blender's roundness; pixels of corner radius at a resolution scale of 1, given to every widget's `roundness` (radius = roundness * 20 px) and `user_interface.panel_roundness` (radius = roundness * 10 px) left null; more than Blender draws is cut with a warning |
| `border_size` | null: Blender's outline width; pixels, given to `editors.view_3d.outline_width` (selected objects' outline, 1..5) when it is null; another width is cut with a warning |
| `shadow_range` | null: Blender's shadow width; pixels, times `shadow_scale`, given to `user_interface.menu_shadow_width` when it is null |
| `shadow_scale` | 0.5: menu shadows against `shadow_range`; the width is cut to 24 with a warning |
| `user_interface` | `editor_border`, `editor_outline`, `editor_outline_active`, `widget_text_cursor`, `panel_header`, `panel_title`, `panel_text`, `panel_back`, `panel_sub_back`, `panel_outline`, `panel_active`, `transparent_checker_primary`, `transparent_checker_secondary`, `widget_emboss`, `link`, `axis_x`, `axis_y`, `axis_z`, `axis_w`, `gizmo_hi`, `gizmo_primary`, `gizmo_secondary`, `gizmo_view_align`, `gizmo_a`, `gizmo_b`, `icon_scene`, `icon_collection`, `icon_object`, `icon_object_data`, `icon_modifier`, `icon_shading`, `icon_folder`, `icon_autokey`; `panel_roundness` (0..1), `menu_shadow_width` (pixels, 0..24) |
| `widgets` | one per kind of widget (`regular`, `tool`, `toolbar_item`, `radio`, `text`, `option`, `toggle`, `num`, `numslider`, `box`, `curve`, `menu`, `pulldown`, `menu_back`, `pie_menu`, `tooltip`, `menu_item`, `scroll`, `progress`, `list_item`, `tab`), each `outline`, `outline_sel`, `inner`, `inner_sel`, `item`, `text`, `text_sel` and `roundness` (0..1) |
| `widget_state` | `error`, `warning`, `info`, `success`, and `inner_<state>` with `inner_<state>_sel` for `anim`, `key`, `driven`, `overridden`, `changed` |
| `common` | `anim` (`playhead`, `preview_range`, `scene_strip_range`, `channels`, `channels_sub`, `channel_group`, `channel_group_active`, `channel`, `channel_selected`, `keyframe` and `keyframe_<type>` for `extreme`, `breakdown`, `jitter`, `moving_hold`, `generated`, each with `_selected`, `long_key`, `long_key_selected`) and `curves` (`handle_<type>` and `handle_sel_<type>` for `free`, `auto`, `vect`, `align`, `auto_clamped`; `handle_vertex`, `handle_vertex_select`) |
| `editors` | one per editor (`view_3d`, `graph_editor`, `file_browser`, `nla_editor`, `dopesheet_editor`, `image_editor`, `sequence_editor`, `properties`, `text_editor`, `node_editor`, `outliner`, `info`, `preferences`, `console`, `clip_editor`, `topbar`, `statusbar`, `spreadsheet`), each a `space` (`back`, `text`, `text_hi`, `header`) and every color of that editor under Blender's name (the 3D viewport also `outline_width`, pixels 1..5) (`editors.view_3d.object_active`, `editors.node_editor.shader_node`; completion lists them, each with Blender's default) |
| `regions` | `sidebars_back`, `sidebars_tab_back`, `asset_shelf_back`, `asset_shelf_header_back`, `channels_back`, `channels_text`, `channels_text_selected`, `scrubbing_back`, `scrubbing_text`, `scrubbing_time_marker`, `scrubbing_time_marker_selected` |

Every color left null is Blender's default.
