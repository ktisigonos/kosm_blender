//! The video sequencer's colors (`ThemeSequenceEditor`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeSequenceEditor";

/// The colors every editor has.
space: Space = .{},
/// Grid. Blender's default: `#303030`.
grid: ?Color = null,
/// Movie Strip. Blender's default: `#6282a3`.
movie_strip: ?Color = null,
/// Clip Strip. Blender's default: `#8f6e56`.
movieclip_strip: ?Color = null,
/// Image Strip. Blender's default: `#8c548c`.
image_strip: ?Color = null,
/// Scene Strip. Blender's default: `#999999`.
scene_strip: ?Color = null,
/// Audio Strip. Blender's default: `#568f6d`.
audio_strip: ?Color = null,
/// Effect Strip. Blender's default: `#7b5f80`.
effect_strip: ?Color = null,
/// Transition Strip. Blender's default: `#867acc`.
transition_strip: ?Color = null,
/// Color Strip. Blender's default: `#99995c`.
color_strip: ?Color = null,
/// Meta Strip. Blender's default: `#7b995c`.
meta_strip: ?Color = null,
/// Mask Strip. Blender's default: `#8f5656`.
mask_strip: ?Color = null,
/// Text Strip. Blender's default: `#9f926f`.
text_strip: ?Color = null,
/// Active Strip. Blender's default: `#ffffff`.
active_strip: ?Color = null,
/// Selected Strips. Blender's default: `#ff8f0d`.
selected_strip: ?Color = null,
/// Color of keyframe border. Blender's default: `#000000ff`.
keyframe_border: ?Color = null,
/// Color of selected keyframe border. Blender's default: `#000000ff`.
keyframe_border_selected: ?Color = null,
/// Preview Background. Blender's default: `#000000`.
preview_back: ?Color = null,
/// Metadata Background. Blender's default: `#000000`.
metadatabg: ?Color = null,
/// Metadata Text. Blender's default: `#ffffff`.
metadatatext: ?Color = null,
/// Overlay color on every other row. Blender's default: `#ffffff05`.
row_alternate: ?Color = null,
/// Text strip editing cursor. Blender's default: `#71a8ffff`.
text_strip_cursor: ?Color = null,
/// Text strip editing selection. Blender's default: `#ffffff4d`.
selected_text: ?Color = null,
