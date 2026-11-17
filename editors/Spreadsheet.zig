//! The spreadsheet's colors (`ThemeSpreadsheet`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeSpreadsheet";

/// The colors every editor has.
space: Space = .{},
/// Overlay color on every other row. Blender's default: `#ffffff04`.
row_alternate: ?Color = null,
