//! The generic colors of each editor, named as Blender names the editors. null: Blender's
//! default.

const Space = @import("Space.zig");

/// The 3D viewport.
view_3d: ?Space = null,
/// The graph editor.
graph_editor: ?Space = null,
/// The file browser.
file_browser: ?Space = null,
/// The nonlinear animation editor.
nla_editor: ?Space = null,
/// The dope sheet.
dopesheet_editor: ?Space = null,
/// The image editor.
image_editor: ?Space = null,
/// The video sequencer.
sequence_editor: ?Space = null,
/// The properties editor.
properties: ?Space = null,
/// The text editor.
text_editor: ?Space = null,
/// The node editors.
node_editor: ?Space = null,
/// The outliner.
outliner: ?Space = null,
/// The info editor.
info: ?Space = null,
/// The preferences.
preferences: ?Space = null,
/// The Python console.
console: ?Space = null,
/// The movie clip editor.
clip_editor: ?Space = null,
/// The top bar.
topbar: ?Space = null,
/// The status bar.
statusbar: ?Space = null,
/// The spreadsheet.
spreadsheet: ?Space = null,

/// The type Blender names each editor's theme with, which presets must use.
pub const type_names = .{
    .view_3d = "ThemeView3D",
    .graph_editor = "ThemeGraphEditor",
    .file_browser = "ThemeFileBrowser",
    .nla_editor = "ThemeNLAEditor",
    .dopesheet_editor = "ThemeDopeSheet",
    .image_editor = "ThemeImageEditor",
    .sequence_editor = "ThemeSequenceEditor",
    .properties = "ThemeProperties",
    .text_editor = "ThemeTextEditor",
    .node_editor = "ThemeNodeEditor",
    .outliner = "ThemeOutliner",
    .info = "ThemeInfo",
    .preferences = "ThemePreferences",
    .console = "ThemeConsole",
    .clip_editor = "ThemeClipEditor",
    .topbar = "ThemeTopBar",
    .statusbar = "ThemeStatusBar",
    .spreadsheet = "ThemeSpreadsheet",
};
