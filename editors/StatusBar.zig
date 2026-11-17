//! The status bar's colors (`ThemeStatusBar`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeStatusBar";

/// The colors every editor has.
space: Space = .{},
