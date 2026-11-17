//! The top bar's colors (`ThemeTopBar`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeTopBar";

/// The colors every editor has.
space: Space = .{},
