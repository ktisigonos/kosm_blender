//! The graph editor's colors (`ThemeGraphEditor`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeGraphEditor";

/// The colors every editor has.
space: Space = .{},
/// Grid. Blender's default: `#1a1a1a`.
grid: ?Color = null,
/// Vertex. Blender's default: `#000000`.
vertex: ?Color = null,
/// Vertex Select. Blender's default: `#ff8500`.
vertex_select: ?Color = null,
/// Active Vertex. Blender's default: `#ffffff`.
vertex_active: ?Color = null,
