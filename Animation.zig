//! Keyframes, channels and the playhead in every animation editor (`ThemeCommonAnim`), named as
//! Blender names them. null: Blender's default.

const Color = @import("kosm").Color;

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeCommonAnim";

/// Playhead. Blender's default: `#4772b3`.
playhead: ?Color = null,
/// Color of preview range overlay. Blender's default: `#a14d0066`.
preview_range: ?Color = null,
/// Color of scene strip range overlay. Blender's default: `#00000080`.
scene_strip_range: ?Color = null,
/// Channels. Blender's default: `#194e8080`.
channels: ?Color = null,
/// Sub-channels. Blender's default: `#0f2c4d80`.
channels_sub: ?Color = null,
/// Channel Group. Blender's default: `#1a332d37`.
channel_group: ?Color = null,
/// Active Channel Group. Blender's default: `#216d5b67`.
channel_group_active: ?Color = null,
/// Channel. Blender's default: `#12121299`.
channel: ?Color = null,
/// Selected Channel. Blender's default: `#60c04044`.
channel_selected: ?Color = null,
/// Color of regular keyframe. Blender's default: `#bfbfbf`.
keyframe: ?Color = null,
/// Color of selected keyframe. Blender's default: `#ffbe33`.
keyframe_selected: ?Color = null,
/// Color of extreme keyframe. Blender's default: `#e8b3cc`.
keyframe_extreme: ?Color = null,
/// Color of selected extreme keyframe. Blender's default: `#f28080`.
keyframe_extreme_selected: ?Color = null,
/// Color of breakdown keyframe. Blender's default: `#b3dbe8`.
keyframe_breakdown: ?Color = null,
/// Color of selected breakdown keyframe. Blender's default: `#54bfed`.
keyframe_breakdown_selected: ?Color = null,
/// Color of jitter keyframe. Blender's default: `#94e575`.
keyframe_jitter: ?Color = null,
/// Color of selected jitter keyframe. Blender's default: `#61c042`.
keyframe_jitter_selected: ?Color = null,
/// Color of moving hold keyframe. Blender's default: `#808080`.
keyframe_moving_hold: ?Color = null,
/// Color of selected moving hold keyframe. Blender's default: `#ffaf23`.
keyframe_moving_hold_selected: ?Color = null,
/// Color of generated keyframe. Blender's default: `#585858`.
keyframe_generated: ?Color = null,
/// Color of selected generated keyframe. Blender's default: `#a28962`.
keyframe_generated_selected: ?Color = null,
/// Long Key. Blender's default: `#ffffff1f`.
long_key: ?Color = null,
/// Long Key Selected. Blender's default: `#ff8c0099`.
long_key_selected: ?Color = null,
