//! Blender's theme: an interface theme preset generated from the theme, which Blender lists
//! under Preferences > Themes. Loading it resets the theme first, so every color left null is
//! Blender's default.

const App = @This();

const std = @import("std");
const kosm = @import("kosm");

/// The preset kosm owns; the folder names Blender's version, and `{name}` is filled as `files`
/// says. Blender lists the preset by its file name.
/// Default: `~/.config/blender/5.2/scripts/presets/interface_theme/{name}.xml`.
file: []const u8 = "~/.config/blender/5.2/scripts/presets/interface_theme/{name}.xml",
/// How `{name}` in `file` is filled: `kosm`, or the kosmos' name. Default: the theme's `files`.
files: kosm.Theme.Files = .shared,
/// A startup script, written whole, that loads the preset when Blender starts and again
/// whenever an apply changes it: Blender keeps its theme in its preferences, not the preset, so
/// without it the preset is picked by hand after every change. null: not written.
/// Default: `~/.config/blender/5.2/scripts/startup/kosm.py`.
startup_script: ?[]const u8 = "~/.config/blender/5.2/scripts/startup/kosm.py",
/// Seconds between the startup script's checks of the preset, so a running Blender follows an
/// apply within that time; each check is one file status call. null: the preset is loaded only
/// when Blender starts. Default 0.25.
reload_interval: ?f64 = 0.25,
/// Interface-wide colors: panels, editor borders.
user_interface: UserInterface = .{},
/// Each kind of widget's colors.
widgets: Widgets = .{},
/// Each editor's background, header and text.
editors: Editors = .{},
/// Sidebars, the asset shelf, animation channels and the scrubbing region.
regions: Regions = .{},

/// Interface-wide colors.
pub const UserInterface = @import("UserInterface.zig");
/// Each kind of widget's colors.
pub const Widgets = @import("Widgets.zig");
/// One kind of widget's colors.
pub const WidgetColors = @import("WidgetColors.zig");
/// Each editor's generic colors.
pub const Editors = @import("Editors.zig");
/// The generic colors of one editor.
pub const Space = @import("Space.zig");
/// The colors of shared regions.
pub const Regions = @import("Regions.zig");

/// Colors from the theme: backgrounds black (white in light mode) with its surface steps,
/// text white, selections and slider fills cyan with readable text from the theme's
/// `contrast.on`, outlines the theme's `line.border`.
pub fn from(theme: kosm.Theme) App {
    const palette = theme.palette;
    const variations = theme.variations;
    const foreground = if (theme.mode == .dark) palette.white else palette.black;
    const background = if (theme.mode == .dark) palette.black else palette.white;
    const raised = variations.surface.raised.apply(background);
    const sunken = variations.surface.sunken.apply(background);
    const overlay = variations.surface.overlay.apply(background);
    const border = variations.line.border.apply(background);
    const bright = variations.lightness.bright.apply(foreground);
    var clear = background;
    clear.alpha = 0;
    const button: WidgetColors = .{
        .outline = border,
        .outline_sel = palette.cyan,
        .inner = raised,
        .inner_sel = palette.cyan,
        .item = palette.cyan,
        .text = foreground,
        .text_sel = variations.contrast.on.apply(palette.cyan),
    };
    const field = with(button, .{ .inner = sunken });
    const floating = with(button, .{ .inner = overlay });
    const item = with(button, .{ .inner = clear, .outline = clear });
    const space: Space = .{
        .back = background,
        .title = foreground,
        .text = foreground,
        .text_hi = bright,
        .header = raised,
        .header_text = foreground,
        .header_text_hi = bright,
    };
    var editors: Editors = .{};
    inline for (@typeInfo(Editors).@"struct".field_names) |name| @field(editors, name) = space;
    return .{
        .files = theme.files,
        .user_interface = .{
            .editor_border = sunken,
            .editor_outline = border,
            .editor_outline_active = palette.cyan,
            .widget_text_cursor = palette.cyan,
            .panel_header = raised,
            .panel_title = foreground,
            .panel_text = foreground,
            .panel_back = background,
            .panel_sub_back = sunken,
            .panel_outline = border,
            .panel_active = variations.state.hovered.apply(raised),
            .transparent_checker_primary = raised,
            .transparent_checker_secondary = sunken,
        },
        .widgets = .{
            .regular = button,
            .tool = button,
            .toolbar_item = button,
            .radio = button,
            .text = field,
            .option = field,
            .toggle = button,
            .num = field,
            .numslider = field,
            .box = with(button, .{ .inner = sunken }),
            .curve = field,
            .menu = button,
            .pulldown = item,
            .menu_back = floating,
            .pie_menu = floating,
            .tooltip = floating,
            .menu_item = item,
            .scroll = with(button, .{ .inner = sunken, .item = variations.state.hovered.apply(raised) }),
            .progress = field,
            .list_item = item,
            .tab = with(button, .{ .inner = background, .inner_sel = raised, .text_sel = foreground }),
        },
        .editors = editors,
        .regions = .{
            .sidebars_back = raised,
            .sidebars_tab_back = background,
            .asset_shelf_back = background,
            .asset_shelf_header_back = raised,
            .channels_back = raised,
            .channels_text = foreground,
            .channels_text_selected = palette.cyan,
            .scrubbing_back = raised,
            .scrubbing_text = foreground,
        },
    };
}

/// `colors` with the fields of `changes` replaced.
fn with(colors: WidgetColors, changes: WidgetColors) WidgetColors {
    var result = colors;
    inline for (@typeInfo(WidgetColors).@"struct".field_names) |name| {
        if (@field(changes, name)) |color| @field(result, name) = color;
    }
    return result;
}

/// How presets spell colors. Blender cuts the alpha off colors without one.
const hex8: kosm.ColorFormat = .init("#{}", &.{.hex8});

/// Generates the preset. Blender reads it only when the theme is picked again.
pub fn apply(self: App, output: *kosm.Output) !void {
    const allocator = output.allocator;
    var builder: Builder = .{ .allocator = allocator };
    var user_interface = try builder.attributes(UserInterface, self.user_interface);
    inline for (@typeInfo(Widgets).@"struct".field_names) |name| {
        if (@field(self.widgets, name)) |colors|
            try user_interface.append(allocator, try builder.wrap("wcol_" ++ name, "ThemeWidgetColors", try builder.attributes(WidgetColors, colors)));
    }
    var theme: std.ArrayList(kosm.Value.Entry) = .empty;
    try theme.append(allocator, try builder.wrap("user_interface", "ThemeUserInterface", user_interface));
    try theme.append(allocator, try builder.wrap("regions", "ThemeRegions", try self.regionEntries(&builder)));
    inline for (@typeInfo(Editors).@"struct".field_names) |name| {
        if (@field(self.editors, name)) |space|
            try theme.append(allocator, try builder.wrap(name, @field(Editors.type_names, name), try builder.editorSpace(name, space)));
    }
    try output.generate(.{ .file = try output.namedFile(self.file, self.files), .lang = "xml", .format = .{ .color = hex8 } }, kosm.Value{
        .table = &.{
            .{
                .key = "bpy",
                .value = .{
                    .table = try allocator.dupe(kosm.Value.Entry, &.{
                        .{ .key = "Theme", .value = .{ .table = theme.items } },
                        // Blender's loader fails on a preset without one.
                        .{ .key = "ThemeStyle", .value = .{ .table = &.{} } },
                    }),
                },
            },
        },
    });
    if (self.startup_script) |script| try self.writeStartupScript(output, script);
}

/// The startup script for the preset `file` names, with its path as a Python string literal.
fn writeStartupScript(self: App, output: *kosm.Output, script: []const u8) !void {
    const allocator = output.allocator;
    const preset = try output.namedFile(self.file, self.files);
    const preset_path = if (std.mem.startsWith(u8, preset, "~/")) try std.Io.Dir.path.join(allocator, &.{ output.home, preset[2..] }) else preset;
    const interval = if (self.reload_interval) |seconds| blk: {
        if (!std.math.isFinite(seconds) or seconds <= 0)
            return output.fail(script, "reload_interval must be a positive number of seconds or null, not {d}", .{seconds});
        break :blk try allocator.print("{d}", .{seconds});
    } else "None";
    const values: struct { preset: []const u8, interval: []const u8 } = .{ .preset = try pythonString(allocator, preset_path), .interval = interval };
    try output.template(values, .{ .file = script, .text = @embedFile("startup.py") });
}

/// `text` as a double-quoted Python string literal: backslashes, quotes and control characters
/// escaped, other bytes (UTF-8 included) as they are.
fn pythonString(allocator: std.mem.Allocator, text: []const u8) ![]const u8 {
    var literal: std.Io.Writer.Allocating = .init(allocator);
    errdefer literal.deinit();
    const writer = &literal.writer;
    try writer.writeByte('"');
    for (text) |byte| switch (byte) {
        '\\', '"' => try writer.print("\\{c}", .{byte}),
        0...0x1f, 0x7f => try writer.print("\\x{x:0>2}", .{byte}),
        else => try writer.writeByte(byte),
    };
    try writer.writeByte('"');
    return literal.toOwnedSlice();
}

/// Each region with a set color, under its `ThemeRegions*` type.
fn regionEntries(self: App, builder: *Builder) !std.ArrayList(kosm.Value.Entry) {
    const regions = [_]struct { []const u8, []const u8, []const []const u8 }{
        .{ "sidebars", "ThemeRegionsSidebars", &.{ "back", "tab_back" } },
        .{ "asset_shelf", "ThemeRegionsAssetShelf", &.{ "back", "header_back" } },
        .{ "channels", "ThemeRegionsChannels", &.{ "back", "text", "text_selected" } },
        .{ "scrubbing", "ThemeRegionsScrubbing", &.{ "back", "text" } },
    };
    var list: std.ArrayList(kosm.Value.Entry) = .empty;
    inline for (regions) |region| {
        var colors: std.ArrayList(kosm.Value.Entry) = .empty;
        inline for (region[2]) |color| {
            if (@field(self.regions, region[0] ++ "_" ++ color)) |value| try colors.append(builder.allocator, .{ .key = "@" ++ color, .value = .{ .color = value } });
        }
        if (colors.items.len != 0) try list.append(builder.allocator, try builder.wrap(region[0], region[1], colors));
    }
    return list;
}

/// Builds the nesting Blender's presets use: a property element holding one element named by
/// its type, whose attributes are the colors.
const Builder = struct {
    allocator: std.mem.Allocator,

    /// The set fields of `colors` as `@name` attributes.
    fn attributes(builder: Builder, comptime Colors: type, colors: Colors) !std.ArrayList(kosm.Value.Entry) {
        var list: std.ArrayList(kosm.Value.Entry) = .empty;
        inline for (@typeInfo(Colors).@"struct".field_names) |name| {
            if (@field(colors, name)) |color| try list.append(builder.allocator, .{ .key = "@" ++ name, .value = .{ .color = color } });
        }
        return list;
    }

    /// `<property><Type ...contents...></Type></property>`.
    fn wrap(builder: Builder, property: []const u8, type_name: []const u8, contents: std.ArrayList(kosm.Value.Entry)) !kosm.Value.Entry {
        const typed = try builder.allocator.dupe(kosm.Value.Entry, &.{.{ .key = type_name, .value = .{ .table = contents.items } }});
        return .{ .key = property, .value = .{ .table = typed } };
    }

    /// An editor's `space`. The 3D viewport's is a gradient whose single color is `back`.
    fn editorSpace(builder: Builder, comptime editor: []const u8, space: Space) !std.ArrayList(kosm.Value.Entry) {
        var colors = try builder.attributes(Space, space);
        const is_viewport = comptime std.mem.eql(u8, editor, "view_3d");
        if (is_viewport) {
            var generic: std.ArrayList(kosm.Value.Entry) = .empty;
            for (colors.items) |entry| {
                if (!std.mem.eql(u8, entry.key, "@back")) try generic.append(builder.allocator, entry);
            }
            colors = generic;
            if (space.back) |back| {
                var gradient: std.ArrayList(kosm.Value.Entry) = .empty;
                try gradient.appendSlice(builder.allocator, &.{
                    .{ .key = "@background_type", .value = .{ .string = "SINGLE_COLOR" } },
                    .{ .key = "@high_gradient", .value = .{ .color = back } },
                    .{ .key = "@gradient", .value = .{ .color = back } },
                });
                try colors.append(builder.allocator, try builder.wrap("gradients", "ThemeGradientColors", gradient));
            }
        }
        var list: std.ArrayList(kosm.Value.Entry) = .empty;
        try list.append(builder.allocator, try builder.wrap("space", if (is_viewport) "ThemeSpaceGradient" else "ThemeSpaceGeneric", colors));
        return list;
    }
};

const testing = std.testing;
const adapter = @import("root.zig").xml_adapter;

const Fixture = struct {
    tmp: testing.TmpDir,
    arena: std.heap.ArenaAllocator,
    plan: kosm.Plan,
    diagnostics: kosm.Diagnostics = .{},
    warnings: kosm.Warnings = undefined,
    home_buffer: [std.Io.Dir.max_path_bytes]u8 = undefined,
    output: kosm.Output = undefined,

    fn init(fixture: *Fixture) !void {
        fixture.* = .{ .tmp = testing.tmpDir(.{}), .arena = .init(testing.allocator), .plan = .init(testing.allocator, testing.io) };
        fixture.warnings = .init(fixture.arena.allocator());
        const length = try fixture.tmp.dir.realPath(testing.io, &fixture.home_buffer);
        fixture.output = .{
            .allocator = fixture.arena.allocator(),
            .home = fixture.home_buffer[0..length],
            .adapters = &.{adapter},
            .plan = &fixture.plan,
            .diagnostics = &fixture.diagnostics,
            .warnings = &fixture.warnings,
            .app = "blender",
            .kosmos = "krystallos.dark",
        };
    }

    fn deinit(fixture: *Fixture) void {
        fixture.plan.deinit();
        fixture.arena.deinit();
        fixture.tmp.cleanup();
    }
};

test "set colors nest under their property and type, the viewport's back becomes its single color" {
    var fixture: Fixture = undefined;
    try fixture.init();
    defer fixture.deinit();
    const app: App = .{
        .user_interface = .{ .panel_back = kosm.hex("041c26") },
        .widgets = .{ .regular = .{ .inner = kosm.hex("082e3f") } },
        .editors = .{ .view_3d = .{ .back = kosm.hex("000000"), .text = kosm.hex("a3c5cc") }, .outliner = .{ .back = kosm.hex("041c26") } },
        .regions = .{ .channels_text = kosm.hex("a3c5cc") },
    };
    try app.apply(&fixture.output);
    try testing.expectEqualStrings(
        \\<?xml version="1.0"?>
        \\<bpy>
        \\  <Theme>
        \\    <user_interface>
        \\      <ThemeUserInterface panel_back="#041c26ff">
        \\        <wcol_regular>
        \\          <ThemeWidgetColors inner="#082e3fff"/>
        \\        </wcol_regular>
        \\      </ThemeUserInterface>
        \\    </user_interface>
        \\    <regions>
        \\      <ThemeRegions>
        \\        <channels>
        \\          <ThemeRegionsChannels text="#a3c5ccff"/>
        \\        </channels>
        \\      </ThemeRegions>
        \\    </regions>
        \\    <view_3d>
        \\      <ThemeView3D>
        \\        <space>
        \\          <ThemeSpaceGradient text="#a3c5ccff">
        \\            <gradients>
        \\              <ThemeGradientColors background_type="SINGLE_COLOR" high_gradient="#000000ff" gradient="#000000ff"/>
        \\            </gradients>
        \\          </ThemeSpaceGradient>
        \\        </space>
        \\      </ThemeView3D>
        \\    </view_3d>
        \\    <outliner>
        \\      <ThemeOutliner>
        \\        <space>
        \\          <ThemeSpaceGeneric back="#041c26ff"/>
        \\        </space>
        \\      </ThemeOutliner>
        \\    </outliner>
        \\  </Theme>
        \\  <ThemeStyle/>
        \\</bpy>
        \\
    , fixture.plan.files.items[0].new);
}

test "from sets every color of every widget and editor" {
    const app = from(kosm.Theme.from(.{ .black = kosm.hex("041c26"), .white = kosm.hex("a3c5cc") }, .dark));
    inline for (@typeInfo(Widgets).@"struct".field_names) |name| {
        const colors = @field(app.widgets, name).?;
        inline for (@typeInfo(WidgetColors).@"struct".field_names) |color| try testing.expect(@field(colors, color) != null);
    }
    inline for (@typeInfo(Editors).@"struct".field_names) |name| try testing.expect(@field(app.editors, name) != null);
    try testing.expectEqual(0, app.widgets.menu_item.?.inner.?.alpha);
}

test "the preset is kosm.xml when shared and named after the kosmos per kosmos" {
    inline for (.{ .{ kosm.Theme.Files.shared, "kosm" }, .{ kosm.Theme.Files.per_kosmos, "krystallos.dark" } }) |case| {
        var fixture: Fixture = undefined;
        try fixture.init();
        defer fixture.deinit();
        const app: App = .{ .files = case[0] };
        try app.apply(&fixture.output);
        try testing.expectEqualStrings("~/.config/blender/5.2/scripts/presets/interface_theme/" ++ case[1] ++ ".xml", fixture.plan.files.items[0].display_path);
    }
    var theme = kosm.Theme.from(.{ .black = kosm.hex("041c26"), .white = kosm.hex("a3c5cc") }, .dark);
    theme.files = .per_kosmos;
    try testing.expectEqual(.per_kosmos, from(theme).files);
}

fn plannedFile(fixture: *Fixture, display_path: []const u8) ?[]const u8 {
    for (fixture.plan.files.items) |file| {
        if (std.mem.eql(u8, file.display_path, display_path)) return file.new;
    }
    return null;
}

test "the startup script loads the preset kosm writes by its full path, checking it every interval" {
    var fixture: Fixture = undefined;
    try fixture.init();
    defer fixture.deinit();
    const app: App = .{ .files = .per_kosmos };
    try app.apply(&fixture.output);
    const script = plannedFile(&fixture, "~/.config/blender/5.2/scripts/startup/kosm.py").?;
    const preset_line = try std.mem.concat(fixture.arena.allocator(), u8, &.{ "\nPRESET = \"", fixture.output.home, "/.config/blender/5.2/scripts/presets/interface_theme/krystallos.dark.xml\"\n" });
    try testing.expect(std.mem.indexOf(u8, script, preset_line) != null);
    try testing.expect(std.mem.indexOf(u8, script, "\nINTERVAL = 0.25\n") != null);
    try testing.expect(std.mem.indexOf(u8, script, "kosm.") == null);
}

test "quotes, backslashes and control characters in the preset path are escaped, a null interval loads once" {
    var fixture: Fixture = undefined;
    try fixture.init();
    defer fixture.deinit();
    const app: App = .{ .file = "/tmp/a \"b\"\\c\td/{name}.xml", .reload_interval = null, .startup_script = "/tmp/startup/kosm.py" };
    try app.apply(&fixture.output);
    const script = plannedFile(&fixture, "/tmp/startup/kosm.py").?;
    try testing.expect(std.mem.indexOf(u8, script, "\nPRESET = \"/tmp/a \\\"b\\\"\\\\c\\x09d/kosm.xml\"\n") != null);
    try testing.expect(std.mem.indexOf(u8, script, "\nINTERVAL = None\n") != null);
}

test "a null startup script writes only the preset, and a reload interval of zero is an error" {
    var fixture: Fixture = undefined;
    try fixture.init();
    defer fixture.deinit();
    const without: App = .{ .startup_script = null };
    try without.apply(&fixture.output);
    try testing.expectEqual(1, fixture.plan.files.items.len);
    var failing: Fixture = undefined;
    try failing.init();
    defer failing.deinit();
    const zero: App = .{ .reload_interval = 0 };
    try testing.expectError(error.AppFailed, zero.apply(&failing.output));
    try testing.expect(std.mem.indexOf(u8, failing.diagnostics.message(), "reload_interval must be a positive number of seconds") != null);
}
