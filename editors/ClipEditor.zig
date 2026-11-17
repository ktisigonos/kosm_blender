//! The movie clip editor's colors (`ThemeClipEditor`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeClipEditor";

/// The colors every editor has.
space: Space = .{},
/// Grid. Blender's default: `#181818ff`.
grid: ?Color = null,
/// Color of marker's outline. Blender's default: `#000000`.
marker_outline: ?Color = null,
/// Color of marker. Blender's default: `#808000`.
marker: ?Color = null,
/// Color of active marker. Blender's default: `#ffffff`.
active_marker: ?Color = null,
/// Color of selected marker. Blender's default: `#ffff00`.
selected_marker: ?Color = null,
/// Color of disabled marker. Blender's default: `#7f0000`.
disabled_marker: ?Color = null,
/// Color of locked marker. Blender's default: `#7f7f7f`.
locked_marker: ?Color = null,
/// Color of path before current frame. Blender's default: `#ff0000`.
path_before: ?Color = null,
/// Color of path after current frame. Blender's default: `#0000ff`.
path_after: ?Color = null,
/// Color of keyframes on a path before current frame. Blender's default: `#ffc4c4`.
path_keyframe_before: ?Color = null,
/// Color of keyframes on a path after current frame. Blender's default: `#c4c4ff`.
path_keyframe_after: ?Color = null,
/// Metadata Background. Blender's default: `#000000`.
metadatabg: ?Color = null,
/// Metadata Text. Blender's default: `#ffffff`.
metadatatext: ?Color = null,
