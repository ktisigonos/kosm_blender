//! The colors of regions editors share (`ThemeRegions`), as `<region>_<color>`. null:
//! Blender's default.

const Color = @import("kosm").Color;

/// Sidebars' background.
sidebars_back: ?Color = null,
/// The background of sidebars' tabs.
sidebars_tab_back: ?Color = null,
/// The asset shelf's background.
asset_shelf_back: ?Color = null,
/// The asset shelf header's background.
asset_shelf_header_back: ?Color = null,
/// Animation channels' background.
channels_back: ?Color = null,
/// Animation channels' text.
channels_text: ?Color = null,
/// Selected animation channels' text.
channels_text_selected: ?Color = null,
/// The time scrubbing region's background.
scrubbing_back: ?Color = null,
/// The time scrubbing region's text.
scrubbing_text: ?Color = null,
