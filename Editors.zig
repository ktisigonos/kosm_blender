//! Each editor's colors, named as Blender names the editors. A color left null is Blender's
//! default.

/// The 3D viewport.
view_3d: View3D = .{},
/// The graph editor.
graph_editor: GraphEditor = .{},
/// The file browser.
file_browser: FileBrowser = .{},
/// The nonlinear animation editor.
nla_editor: NLAEditor = .{},
/// The dope sheet.
dopesheet_editor: DopeSheet = .{},
/// The image editor.
image_editor: ImageEditor = .{},
/// The video sequencer.
sequence_editor: SequenceEditor = .{},
/// The properties editor.
properties: Properties = .{},
/// The text editor.
text_editor: TextEditor = .{},
/// The node editors.
node_editor: NodeEditor = .{},
/// The outliner.
outliner: Outliner = .{},
/// The info editor.
info: Info = .{},
/// The preferences.
preferences: Preferences = .{},
/// The Python console.
console: Console = .{},
/// The movie clip editor.
clip_editor: ClipEditor = .{},
/// The top bar.
topbar: TopBar = .{},
/// The status bar.
statusbar: StatusBar = .{},
/// The spreadsheet.
spreadsheet: Spreadsheet = .{},

/// The 3D viewport's colors.
pub const View3D = @import("editors/View3D.zig");
/// The graph editor's colors.
pub const GraphEditor = @import("editors/GraphEditor.zig");
/// The file browser's colors.
pub const FileBrowser = @import("editors/FileBrowser.zig");
/// The nonlinear animation editor's colors.
pub const NLAEditor = @import("editors/NLAEditor.zig");
/// The dope sheet's colors.
pub const DopeSheet = @import("editors/DopeSheet.zig");
/// The image editor's colors.
pub const ImageEditor = @import("editors/ImageEditor.zig");
/// The video sequencer's colors.
pub const SequenceEditor = @import("editors/SequenceEditor.zig");
/// The properties editor's colors.
pub const Properties = @import("editors/Properties.zig");
/// The text editor's colors.
pub const TextEditor = @import("editors/TextEditor.zig");
/// The node editors' colors.
pub const NodeEditor = @import("editors/NodeEditor.zig");
/// The outliner's colors.
pub const Outliner = @import("editors/Outliner.zig");
/// The info editor's colors.
pub const Info = @import("editors/Info.zig");
/// The preferences' colors.
pub const Preferences = @import("editors/Preferences.zig");
/// The Python console's colors.
pub const Console = @import("editors/Console.zig");
/// The movie clip editor's colors.
pub const ClipEditor = @import("editors/ClipEditor.zig");
/// The top bar's colors.
pub const TopBar = @import("editors/TopBar.zig");
/// The status bar's colors.
pub const StatusBar = @import("editors/StatusBar.zig");
/// The spreadsheet's colors.
pub const Spreadsheet = @import("editors/Spreadsheet.zig");
