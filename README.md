# kosm_blender

Blender for kosm: an interface theme preset in the theme's colors, generated to
`~/.config/blender/5.2/scripts/presets/interface_theme/kosm.xml`. Blender lists it as `kosm`
under Preferences > Themes; pick it again after an apply to load the new colors. Loading a
preset resets the theme first, so every color the app leaves null is Blender's default.

`from(theme)` sets backgrounds from black (white in light mode) with its surface steps
(buttons raised, fields and boxes sunken, menus and tooltips on the overlay step, menu and list
items transparent), text white and highlighted text brighter, selections and slider fills cyan
with readable text from the theme's `contrast.on`, and outlines the theme's `line.border`.
Every editor gets the same background, header and text; the 3D viewport's background is a
single color.

## Fields

| Field | Default |
|---|---|
| `file` | `~/.config/blender/5.2/scripts/presets/interface_theme/kosm.xml`; change `5.2` for another Blender version |
| `user_interface` | `editor_border`, `editor_outline`, `editor_outline_active`, `widget_text_cursor`, `panel_header`, `panel_title`, `panel_text`, `panel_back`, `panel_sub_back`, `panel_outline`, `panel_active`, `transparent_checker_primary`, `transparent_checker_secondary` |
| `widgets` | one per kind of widget (`regular`, `tool`, `toolbar_item`, `radio`, `text`, `option`, `toggle`, `num`, `numslider`, `box`, `curve`, `menu`, `pulldown`, `menu_back`, `pie_menu`, `tooltip`, `menu_item`, `scroll`, `progress`, `list_item`, `tab`), each `outline`, `outline_sel`, `inner`, `inner_sel`, `item`, `text`, `text_sel` |
| `editors` | one per editor (`view_3d`, `graph_editor`, `file_browser`, `nla_editor`, `dopesheet_editor`, `image_editor`, `sequence_editor`, `properties`, `text_editor`, `node_editor`, `outliner`, `info`, `preferences`, `console`, `clip_editor`, `topbar`, `statusbar`, `spreadsheet`), each `back`, `title`, `text`, `text_hi`, `header`, `header_text`, `header_text_hi` |
| `regions` | `sidebars_back`, `sidebars_tab_back`, `asset_shelf_back`, `asset_shelf_header_back`, `channels_back`, `channels_text`, `channels_text_selected`, `scrubbing_back`, `scrubbing_text` |

Every color left null is Blender's default.
