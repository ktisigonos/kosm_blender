//! The image editor's colors (`ThemeImageEditor`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeImageEditor";

/// The colors every editor has.
space: Space = .{},
/// Grid. Blender's default: `#303030ff`.
grid: ?Color = null,
/// Vertex. Blender's default: `#000000`.
vertex: ?Color = null,
/// Vertex Select. Blender's default: `#ff8500`.
vertex_select: ?Color = null,
/// Face. Blender's default: `#ffffff0a`.
face: ?Color = null,
/// Face Selection. Blender's default: `#ff85003c`.
face_select: ?Color = null,
/// Face Mode Selection. Blender's default: `#00000000`.
face_mode_select: ?Color = null,
/// Active Vertex/Edge/Face. Blender's default: `#ffffff40`.
editmesh_active: ?Color = null,
/// Wire Edit. Blender's default: `#c0c0c0`.
wire_edit: ?Color = null,
/// Edge Select. Blender's default: `#ff8500`.
edge_select: ?Color = null,
/// Scope Region Background. Blender's default: `#727272ff`.
scope_back: ?Color = null,
/// Stitch Preview Face. Blender's default: `#7f7f0033`.
preview_stitch_face: ?Color = null,
/// Stitch Preview Edge. Blender's default: `#ff00ff33`.
preview_stitch_edge: ?Color = null,
/// Stitch Preview Vertex. Blender's default: `#0000ff33`.
preview_stitch_vert: ?Color = null,
/// Stitch Preview Stitchable. Blender's default: `#00ff00ff`.
preview_stitch_stitchable: ?Color = null,
/// Stitch Preview Unstitchable. Blender's default: `#ff0000ff`.
preview_stitch_unstitchable: ?Color = null,
/// Stitch Preview Active Island. Blender's default: `#e1d2c323`.
preview_stitch_active: ?Color = null,
/// Texture Paint/Modifier UVs. Blender's default: `#707070ff`.
uv_shadow: ?Color = null,
/// Metadata Background. Blender's default: `#000000`.
metadatabg: ?Color = null,
/// Metadata Text. Blender's default: `#ffffff`.
metadatatext: ?Color = null,
