//! The dope sheet's colors (`ThemeDopeSheet`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeDopeSheet";

/// The colors every editor has.
space: Space = .{},
/// Grid. Blender's default: `#161616`.
grid: ?Color = null,
/// Color of keyframe border. Blender's default: `#000000ff`.
keyframe_border: ?Color = null,
/// Color of selected keyframe border. Blender's default: `#000000ff`.
keyframe_border_selected: ?Color = null,
/// Color of summary channel. Blender's default: `#4d272766`.
summary: ?Color = null,
/// Color of lines showing linear interpolation mode. Blender's default: `#94e575cc`.
anim_interpolation_linear: ?Color = null,
/// Color of lines showing constant interpolation mode. Blender's default: `#e59c7bcc`.
anim_interpolation_constant: ?Color = null,
/// Color of lines showing easings & dynamic interpolation mode. Blender's default: `#5dbabeb3`.
anim_interpolation_other: ?Color = null,
/// Simulated Frames. Blender's default: `#721e65ff`.
simulated_frames: ?Color = null,
