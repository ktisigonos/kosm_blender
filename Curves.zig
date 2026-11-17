//! Curve handles in every editor showing curves (`ThemeCommonCurves`), named as Blender names
//! them. null: Blender's default.

const Color = @import("kosm").Color;

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeCommonCurves";

/// Free Handle. Blender's default: `#745900`.
handle_free: ?Color = null,
/// Free Handle Selected. Blender's default: `#ffc300`.
handle_sel_free: ?Color = null,
/// Auto Handle. Blender's default: `#740d00`.
handle_auto: ?Color = null,
/// Auto Handle Selected. Blender's default: `#ff1900`.
handle_sel_auto: ?Color = null,
/// Vector Handle. Blender's default: `#232374`.
handle_vect: ?Color = null,
/// Vector Handle Selected. Blender's default: `#4444ff`.
handle_sel_vect: ?Color = null,
/// Align Handle. Blender's default: `#157000`.
handle_align: ?Color = null,
/// Align Handle Selected. Blender's default: `#72ff57`.
handle_sel_align: ?Color = null,
/// Auto-Clamped Handle. Blender's default: `#803060`.
handle_auto_clamped: ?Color = null,
/// Auto-Clamped Handle Selected. Blender's default: `#f090a0`.
handle_sel_auto_clamped: ?Color = null,
/// Handle Vertex. Blender's default: `#000000`.
handle_vertex: ?Color = null,
/// Handle Vertex Select. Blender's default: `#ff8500`.
handle_vertex_select: ?Color = null,
