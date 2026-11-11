//! The colors of each kind of widget (`wcol_<kind>`), named as Blender names them. null:
//! Blender's default.

const WidgetColors = @import("WidgetColors.zig");

/// Ordinary buttons.
regular: ?WidgetColors = null,
/// Tool buttons.
tool: ?WidgetColors = null,
/// Toolbar buttons.
toolbar_item: ?WidgetColors = null,
/// Radio buttons.
radio: ?WidgetColors = null,
/// Text fields.
text: ?WidgetColors = null,
/// Checkboxes.
option: ?WidgetColors = null,
/// Toggle buttons.
toggle: ?WidgetColors = null,
/// Number fields.
num: ?WidgetColors = null,
/// Number sliders.
numslider: ?WidgetColors = null,
/// Boxes.
box: ?WidgetColors = null,
/// Curve widgets.
curve: ?WidgetColors = null,
/// Menu buttons.
menu: ?WidgetColors = null,
/// Pulldown menus in headers.
pulldown: ?WidgetColors = null,
/// Menu backgrounds.
menu_back: ?WidgetColors = null,
/// Pie menus.
pie_menu: ?WidgetColors = null,
/// Tooltips.
tooltip: ?WidgetColors = null,
/// Menu items.
menu_item: ?WidgetColors = null,
/// Scrollbars.
scroll: ?WidgetColors = null,
/// Progress bars.
progress: ?WidgetColors = null,
/// List items.
list_item: ?WidgetColors = null,
/// Tabs.
tab: ?WidgetColors = null,
