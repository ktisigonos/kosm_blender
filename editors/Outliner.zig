//! The outliner's colors (`ThemeOutliner`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeOutliner";

/// The colors every editor has.
space: Space = .{},
/// Filter Match. Blender's default: `#337f33`.
match: ?Color = null,
/// Selected Highlight. Blender's default: `#1d314d`.
selected_highlight: ?Color = null,
/// Active Highlight. Blender's default: `#334d80`.
active: ?Color = null,
/// Selected Objects. Blender's default: `#e96a00`.
selected_object: ?Color = null,
/// Active Object. Blender's default: `#ffaf29`.
active_object: ?Color = null,
/// Edited Object. Blender's default: `#00806266`.
edited_object: ?Color = null,
/// Overlay color on every other row. Blender's default: `#ffffff04`.
row_alternate: ?Color = null,
