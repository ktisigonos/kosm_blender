//! The file browser's colors (`ThemeFileBrowser`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeFileBrowser";

/// The colors every editor has.
space: Space = .{},
/// Overlay color on every other row. Blender's default: `#ffffff04`.
row_alternate: ?Color = null,
