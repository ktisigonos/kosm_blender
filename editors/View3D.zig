//! The 3D viewport's colors (`ThemeView3D`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeView3D";

/// The colors every editor has.
space: Space = .{},
/// Grid. Blender's default: `#54545480`.
grid: ?Color = null,
/// Major Grid Lines. Blender's default: `#545454ff`.
grid_major: ?Color = null,
/// Clipping Border. Blender's default: `#3f3f3fff`.
clipping_border_3d: ?Color = null,
/// Wire. Blender's default: `#000000`.
wire: ?Color = null,
/// Color for wireframe when in edit mode, but edge selection is active. Blender's default: `#000000`.
wire_edit: ?Color = null,
/// Grease Pencil wireframe color when in edit mode. Blender's default: `#99999980`.
gp_wire_edit: ?Color = null,
/// Grease Pencil Vertex. Blender's default: `#000000`.
gp_vertex: ?Color = null,
/// Grease Pencil Vertex Select. Blender's default: `#ff8500`.
gp_vertex_select: ?Color = null,
/// Color for indicating Grease Pencil keyframes. Blender's default: `#7a9b14`.
text_grease_pencil: ?Color = null,
/// Object Selected. Blender's default: `#ed5700`.
object_selected: ?Color = null,
/// Active Object. Blender's default: `#ffa028`.
object_active: ?Color = null,
/// Camera. Blender's default: `#000000`.
camera: ?Color = null,
/// Empty. Blender's default: `#000000`.
empty: ?Color = null,
/// Light. Blender's default: `#00000050`.
light: ?Color = null,
/// Speaker. Blender's default: `#000000`.
speaker: ?Color = null,
/// Vertex. Blender's default: `#000000`.
vertex: ?Color = null,
/// Vertex Select. Blender's default: `#ff7a00`.
vertex_select: ?Color = null,
/// Edge Selection. Blender's default: `#ff9900`.
edge_select: ?Color = null,
/// Edge Mode Selection. Blender's default: `#ffd800`.
edge_mode_select: ?Color = null,
/// Face. Blender's default: `#ffffff02`.
face: ?Color = null,
/// Face Selection. Blender's default: `#ffa30033`.
face_select: ?Color = null,
/// Face Mode Selection. Blender's default: `#ffb70033`.
face_mode_select: ?Color = null,
/// Face Orientation Back. Blender's default: `#ff0000b3`.
face_back: ?Color = null,
/// Face Orientation Front. Blender's default: `#0000ff00`.
face_front: ?Color = null,
/// Bevel. Blender's default: `#00a5ff`.
bevel: ?Color = null,
/// Seam. Blender's default: `#db2512`.
seam: ?Color = null,
/// Sharp. Blender's default: `#00ffff`.
sharp: ?Color = null,
/// Crease. Blender's default: `#cc0099`.
crease: ?Color = null,
/// Freestyle. Blender's default: `#7fff7f4d`.
freestyle: ?Color = null,
/// Edge Length Text. Blender's default: `#150806`.
extra_edge_len: ?Color = null,
/// Edge Angle Text. Blender's default: `#4d4d00`.
extra_edge_angle: ?Color = null,
/// Face Angle Text. Blender's default: `#0000cc`.
extra_face_angle: ?Color = null,
/// Face Area Text. Blender's default: `#004d00`.
extra_face_area: ?Color = null,
/// Active Vertex/Edge/Face. Blender's default: `#ffffff33`.
editmesh_active: ?Color = null,
/// Face Normal. Blender's default: `#22dddd`.
normal: ?Color = null,
/// Vertex Normal. Blender's default: `#2361dd`.
vertex_normal: ?Color = null,
/// Custom Normal. Blender's default: `#dd23dd`.
split_normal: ?Color = null,
/// Vertex Group Unreferenced. Blender's default: `#000000`.
vertex_unreferenced: ?Color = null,
/// Face Retopology. Blender's default: `#50c8ff0f`.
face_retopology: ?Color = null,
/// NURBS U Lines. Blender's default: `#909000`.
nurb_uline: ?Color = null,
/// NURBS V Lines. Blender's default: `#803060`.
nurb_vline: ?Color = null,
/// NURBS Active U Lines. Blender's default: `#f0ff40`.
nurb_sel_uline: ?Color = null,
/// NURBS Active V Lines. Blender's default: `#f090a0`.
nurb_sel_vline: ?Color = null,
/// Outline color of selected pose bones. Blender's default: `#50c8ff`.
bone_pose: ?Color = null,
/// Outline color of active pose bones. Blender's default: `#8cffff`.
bone_pose_active: ?Color = null,
/// Default color of the solid shapes of bones. Blender's default: `#b2b2b2`.
bone_solid: ?Color = null,
/// Shade for bones corresponding to a locked weight group during painting. Blender's default: `#ff000080`.
bone_locked_weight: ?Color = null,
/// The color for things before the current frame (for onion skinning, motion paths, etc.). Blender's default: `#f22e23`.
before_current_frame: ?Color = null,
/// The color for things after the current frame (for onion skinning, motion paths, etc.). Blender's default: `#78f244`.
after_current_frame: ?Color = null,
/// Bundle Solid. Blender's default: `#c8c8c8`.
bundle_solid: ?Color = null,
/// Camera Path. Blender's default: `#000000`.
camera_path: ?Color = null,
/// Camera Passepartout. Blender's default: `#000000`.
camera_passepartout: ?Color = null,
/// Skin Root. Blender's default: `#b44d4d`.
skin_root: ?Color = null,
/// View Overlay. Blender's default: `#000000`.
view_overlay: ?Color = null,
/// Transform. Blender's default: `#ffffff`.
transform: ?Color = null,
/// Width in pixels of the outline around selected objects, 1 to 5. null: the app's
/// `border_size`, or Blender's default 1.
outline_width: ?u32 = null,
