//! The interface-wide colors of `ThemeUserInterface`, named as Blender names them. null: Blender's
//! default.

const Color = @import("kosm").Color;

/// The gap between editors.
editor_border: ?Color = null,
/// Editors' outlines.
editor_outline: ?Color = null,
/// The active editor's outline.
editor_outline_active: ?Color = null,
/// The text cursor in fields.
widget_text_cursor: ?Color = null,
/// Panels' headers.
panel_header: ?Color = null,
/// Panels' titles.
panel_title: ?Color = null,
/// Text in panels.
panel_text: ?Color = null,
/// Panels' background.
panel_back: ?Color = null,
/// Sub-panels' background.
panel_sub_back: ?Color = null,
/// Panels' outlines.
panel_outline: ?Color = null,
/// The panel being dragged or hovered.
panel_active: ?Color = null,
/// The light squares of the checkerboard behind transparency.
transparent_checker_primary: ?Color = null,
/// The dark squares of the checkerboard behind transparency.
transparent_checker_secondary: ?Color = null,
