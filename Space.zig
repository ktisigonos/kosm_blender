//! The colors every editor has (`ThemeSpaceGeneric`), named as Blender names them. null:
//! Blender's default.

const Color = @import("kosm").Color;

/// The editor's background; the 3D viewport's single color.
back: ?Color = null,
/// Text, in the editor and its header.
text: ?Color = null,
/// Highlighted text, in the editor and its header.
text_hi: ?Color = null,
/// The header.
header: ?Color = null,
