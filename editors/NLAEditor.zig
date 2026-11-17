//! The nonlinear animation editor's colors (`ThemeNLAEditor`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeNLAEditor";

/// The colors every editor has.
space: Space = .{},
/// Grid. Blender's default: `#2a2a2a`.
grid: ?Color = null,
/// Animation data-block has active action. Blender's default: `#99541366`.
active_action: ?Color = null,
/// Animation data-block does not have active action. Blender's default: `#4d3b174d`.
active_action_unset: ?Color = null,
/// Unselected Action-Clip Strip. Blender's default: `#0d0d0d`.
strips: ?Color = null,
/// Selected Action-Clip Strip. Blender's default: `#ff8c00`.
strips_selected: ?Color = null,
/// Unselected Transition Strip. Blender's default: `#1c2630`.
transition_strips: ?Color = null,
/// Selected Transition Strip. Blender's default: `#2e75db`.
transition_strips_selected: ?Color = null,
/// Unselected Meta Strip (for grouping related strips). Blender's default: `#332642`.
meta_strips: ?Color = null,
/// Selected Meta Strip (for grouping related strips). Blender's default: `#692196`.
meta_strips_selected: ?Color = null,
/// Unselected Sound Strip (for timing speaker sounds). Blender's default: `#2b3d3d`.
sound_strips: ?Color = null,
/// Selected Sound Strip (for timing speaker sounds). Blender's default: `#1f7a7a`.
sound_strips_selected: ?Color = null,
/// Color for strip/action being "tweaked" or edited. Blender's default: `#4df31a`.
tweak: ?Color = null,
/// Warning/error indicator color for strips referencing the strip being tweaked. Blender's default: `#d90000`.
tweak_duplicate: ?Color = null,
/// Color of keyframe border. Blender's default: `#000000ff`.
keyframe_border: ?Color = null,
/// Color of selected keyframe border. Blender's default: `#000000ff`.
keyframe_border_selected: ?Color = null,
