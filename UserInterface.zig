//! The interface-wide colors of `ThemeUserInterface`, named as Blender names them. null: Blender's
//! default.

const Color = @import("kosm").Color;

/// The gap between editors.
editor_border: ?Color = null,
/// Editors' outlines.
editor_outline: ?Color = null,
/// The active editor's outline.
editor_outline_active: ?Color = null,
/// The text cursor in fields.
widget_text_cursor: ?Color = null,
/// Panels' headers.
panel_header: ?Color = null,
/// Panels' titles.
panel_title: ?Color = null,
/// Text in panels.
panel_text: ?Color = null,
/// Panels' background.
panel_back: ?Color = null,
/// Sub-panels' background.
panel_sub_back: ?Color = null,
/// Panels' outlines.
panel_outline: ?Color = null,
/// The panel being dragged or hovered.
panel_active: ?Color = null,
/// The light squares of the checkerboard behind transparency.
transparent_checker_primary: ?Color = null,
/// The dark squares of the checkerboard behind transparency.
transparent_checker_secondary: ?Color = null,
/// The 1-pixel shadow line under widgets.
widget_emboss: ?Color = null,
/// Link widgets.
link: ?Color = null,
/// The X axis.
axis_x: ?Color = null,
/// The Y axis.
axis_y: ?Color = null,
/// The Z axis.
axis_z: ?Color = null,
/// The W axis of quaternion and axis-angle rotations.
axis_w: ?Color = null,
/// A gizmo under the pointer.
gizmo_hi: ?Color = null,
/// Gizmos' primary color.
gizmo_primary: ?Color = null,
/// Gizmos' secondary color.
gizmo_secondary: ?Color = null,
/// The view-aligned gizmo.
gizmo_view_align: ?Color = null,
/// Gizmo color A.
gizmo_a: ?Color = null,
/// Gizmo color B.
gizmo_b: ?Color = null,
/// Scene icons.
icon_scene: ?Color = null,
/// Collection icons.
icon_collection: ?Color = null,
/// Object icons.
icon_object: ?Color = null,
/// Object data icons.
icon_object_data: ?Color = null,
/// Modifier icons.
icon_modifier: ?Color = null,
/// Shading icons.
icon_shading: ?Color = null,
/// Folders in the file browser.
icon_folder: ?Color = null,
/// The auto keying indicator while it is on.
icon_autokey: ?Color = null,
/// How round panels' corners are, 0 (square) to 1: the radius is this times half of Blender's
/// widget unit, 10 pixels at a resolution scale of 1. null: the app's `rounding`, or Blender's
/// default 0.4.
panel_roundness: ?f64 = null,
/// Width of panels' and menus' shadows in pixels, 0 (none) to 24. null: the app's
/// `shadow_range` times its `shadow_scale`, or Blender's default 6.
menu_shadow_width: ?u32 = null,
