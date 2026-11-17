//! The properties editor's colors (`ThemeProperties`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeProperties";

/// The colors every editor has.
space: Space = .{},
/// Search Match. Blender's default: `#4772b3`.
match: ?Color = null,
