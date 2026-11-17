//! Colors the animation editors share (`ThemeCommon`). null: Blender's default.

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeCommon";

/// Keyframes, channels and the playhead.
anim: Animation = .{},
/// Curve handles.
curves: Curves = .{},

/// Keyframes, channels and the playhead.
pub const Animation = @import("Animation.zig");
/// Curve handles.
pub const Curves = @import("Curves.zig");
