//! One kind of widget's colors (`ThemeWidgetColors`), named as Blender names them. null:
//! Blender's default.

const Color = @import("kosm").Color;

/// The widget's outline.
outline: ?Color = null,
/// The outline while selected or pressed.
outline_sel: ?Color = null,
/// The widget's background.
inner: ?Color = null,
/// The background while selected or pressed.
inner_sel: ?Color = null,
/// Inner parts: a slider's fill, a checkbox's check, a scrollbar's handle.
item: ?Color = null,
/// Text.
text: ?Color = null,
/// Text while selected or pressed.
text_sel: ?Color = null,
/// How round the corners are, 0 (square) to 1: the radius is this times Blender's widget unit,
/// 20 pixels at a resolution scale of 1. null: the app's `rounding`, or Blender's default 0.4.
roundness: ?f64 = null,
