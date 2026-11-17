//! Colors of widgets in a state (`ThemeWidgetStateColors`): animated, keyed, driven,
//! overridden or changed values, and message severities. null: Blender's default.

const Color = @import("kosm").Color;

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeWidgetStateColors";

/// Color for error items. Blender's default: `#991616ff`.
@"error": ?Color = null,
/// Color for warning items. Blender's default: `#ac8737ff`.
warning: ?Color = null,
/// Color for informational items. Blender's default: `#28487dff`.
info: ?Color = null,
/// Color for successful items. Blender's default: `#188625ff`.
success: ?Color = null,
/// Animated. Blender's default: `#53992e`.
inner_anim: ?Color = null,
/// Animated Selected. Blender's default: `#38a600`.
inner_anim_sel: ?Color = null,
/// Keyframe. Blender's default: `#b3ae36`.
inner_key: ?Color = null,
/// Keyframe Selected. Blender's default: `#b29700`.
inner_key_sel: ?Color = null,
/// Driven. Blender's default: `#9000cc`.
inner_driven: ?Color = null,
/// Driven Selected. Blender's default: `#9900e6`.
inner_driven_sel: ?Color = null,
/// Overridden. Blender's default: `#00c3c3`.
inner_overridden: ?Color = null,
/// Overridden Selected. Blender's default: `#118f8f`.
inner_overridden_sel: ?Color = null,
/// Changed. Blender's default: `#cc7529`.
inner_changed: ?Color = null,
/// Changed Selected. Blender's default: `#d26400`.
inner_changed_sel: ?Color = null,
