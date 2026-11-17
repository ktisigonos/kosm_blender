//! The node editors' colors (`ThemeNodeEditor`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeNodeEditor";

/// The colors every editor has.
space: Space = .{},
/// Grid. Blender's default: `#303030`.
grid: ?Color = null,
/// Node Outline. Blender's default: `#ffffff26`.
node_outline: ?Color = null,
/// Node Selected. Blender's default: `#ed5700`.
node_selected: ?Color = null,
/// Active Node. Blender's default: `#ffffff`.
node_active: ?Color = null,
/// Wires. Blender's default: `#1a1a1aff`.
wire: ?Color = null,
/// Wire Color. Blender's default: `#8d8d8d`.
wire_inner: ?Color = null,
/// Wire Select. Blender's default: `#ffffffb3`.
wire_select: ?Color = null,
/// Node Backdrop. Blender's default: `#303030ff`.
node_backdrop: ?Color = null,
/// Converter Node. Blender's default: `#246283`.
converter_node: ?Color = null,
/// Color Node. Blender's default: `#6e6e23`.
color_node: ?Color = null,
/// Group Node. Blender's default: `#374725`.
group_node: ?Color = null,
/// Group Socket Node. Blender's default: `#1d1d1d`.
group_socket_node: ?Color = null,
/// Frame Node. Blender's default: `#0f0f0fcc`.
frame_node: ?Color = null,
/// Matte Node. Blender's default: `#5a3838`.
matte_node: ?Color = null,
/// Distort Node. Blender's default: `#3e5a5b`.
distor_node: ?Color = null,
/// Input Node. Blender's default: `#82354c`.
input_node: ?Color = null,
/// Output Node. Blender's default: `#3e232a`.
output_node: ?Color = null,
/// Filter Node. Blender's default: `#412b51`.
filter_node: ?Color = null,
/// Vector Node. Blender's default: `#3c3c83`.
vector_node: ?Color = null,
/// Texture Node. Blender's default: `#79461d`.
texture_node: ?Color = null,
/// Shader Node. Blender's default: `#2b652b`.
shader_node: ?Color = null,
/// Script Node. Blender's default: `#203c3c`.
script_node: ?Color = null,
/// Geometry Node. Blender's default: `#1d725e`.
geometry_node: ?Color = null,
/// Attribute Node. Blender's default: `#1d2546`.
attribute_node: ?Color = null,
/// Simulation Zone. Blender's default: `#66416233`.
simulation_zone: ?Color = null,
/// Repeat Zone. Blender's default: `#76512f33`.
repeat_zone: ?Color = null,
/// For Each Geometry Element Zone. Blender's default: `#33527f33`.
foreach_geometry_element_zone: ?Color = null,
/// Closure Zone. Blender's default: `#7d7d3a33`.
closure_zone: ?Color = null,
