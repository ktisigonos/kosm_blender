//! The text editor's colors (`ThemeTextEditor`), named as Blender names them. null: Blender's default.

const Color = @import("kosm").Color;
const Space = @import("../Space.zig");

/// The type Blender names these colors with, which presets must use.
pub const type_name = "ThemeTextEditor";

/// The colors every editor has.
space: Space = .{},
/// Line Numbers. Blender's default: `#777777`.
line_numbers: ?Color = null,
/// Line Numbers Background. Blender's default: `#1d1d1d`.
line_numbers_background: ?Color = null,
/// Selected Text. Blender's default: `#4d4d4d`.
selected_text: ?Color = null,
/// Cursor. Blender's default: `#71a8ff`.
cursor: ?Color = null,
/// Syntax Built-In. Blender's default: `#e62e67`.
syntax_builtin: ?Color = null,
/// Syntax Symbols. Blender's default: `#ff734d`.
syntax_symbols: ?Color = null,
/// Syntax Special. Blender's default: `#689d06`.
syntax_special: ?Color = null,
/// Syntax Preprocessor. Blender's default: `#9c73e6`.
syntax_preprocessor: ?Color = null,
/// Syntax Reserved. Blender's default: `#c4753b`.
syntax_reserved: ?Color = null,
/// Syntax Comment. Blender's default: `#939393`.
syntax_comment: ?Color = null,
/// Syntax String. Blender's default: `#e6d573`.
syntax_string: ?Color = null,
/// Syntax Numbers. Blender's default: `#48d9e6`.
syntax_numbers: ?Color = null,
