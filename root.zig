//! Blender: an interface theme preset in the theme's colors.

const std = @import("std");

/// Blender's theme preset; build one with `from`.
pub const App = @import("App.zig");
/// Colors from the theme.
pub const from = App.from;
/// The adapter the app writes the preset with, so a config needs only this package.
pub const xml_adapter = @import("kosm_xml").adapter;

test {
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(App);
}
