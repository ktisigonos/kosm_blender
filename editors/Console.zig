//! The Python console's colors (`ThemeConsole`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeConsole";

/// The colors every editor has.
space: Space = .{},
/// Line Output. Blender's default: `#71a8ff`.
line_output: ?Color = null,
/// Line Input. Blender's default: `#f2f2f2`.
line_input: ?Color = null,
/// Line Info. Blender's default: `#95d600`.
line_info: ?Color = null,
/// Line Error. Blender's default: `#ff4d84`.
line_error: ?Color = null,
/// Cursor. Blender's default: `#71a8ff`.
cursor: ?Color = null,
/// Selection. Blender's default: `#ffffff30`.
select: ?Color = null,
