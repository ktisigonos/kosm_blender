//! The colors every editor has (`ThemeSpaceGeneric`), named as Blender names them. null:
//! Blender's default.

const Color = @import("kosm").Color;

/// The editor's background; the 3D viewport's single color.
back: ?Color = null,
/// Region titles.
title: ?Color = null,
/// Text.
text: ?Color = null,
/// Highlighted text.
text_hi: ?Color = null,
/// The header.
header: ?Color = null,
/// Text in the header.
header_text: ?Color = null,
/// Highlighted text in the header.
header_text_hi: ?Color = null,
