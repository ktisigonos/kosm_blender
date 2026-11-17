//! The info editor's colors (`ThemeInfo`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeInfo";

/// The colors every editor has.
space: Space = .{},
/// Background color of selected line. Blender's default: `#3b5689`.
info_selected: ?Color = null,
/// Text color of selected line. Blender's default: `#ffffff`.
info_selected_text: ?Color = null,
/// Foreground color of Error icon. Blender's default: `#ffffff`.
info_error_text: ?Color = null,
/// Foreground color of Warning icon. Blender's default: `#ffffff`.
info_warning_text: ?Color = null,
/// Foreground color of Info icon. Blender's default: `#ffffff`.
info_info_text: ?Color = null,
/// Background color of Debug icon. Blender's default: `#6b3293ff`.
info_debug: ?Color = null,
/// Foreground color of Debug icon. Blender's default: `#ffffff`.
info_debug_text: ?Color = null,
/// Background color of Property icon. Blender's default: `#236666ff`.
info_property: ?Color = null,
/// Foreground color of Property icon. Blender's default: `#ffffff`.
info_property_text: ?Color = null,
/// Background color of Operator icon. Blender's default: `#235266ff`.
info_operator: ?Color = null,
/// Foreground color of Operator icon. Blender's default: `#ffffff`.
info_operator_text: ?Color = null,
