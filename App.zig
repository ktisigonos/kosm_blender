//! Blender's theme: an interface theme preset generated from the theme, which Blender lists
//! under Preferences > Themes. Loading it resets the theme first, so every color left null is
//! Blender's default.

const App = @This();

const std = @import("std");
const kosm = @import("kosm");
const Color = kosm.Color;

/// Blender's user folder, holding one folder per version (`5.2`). Default: `~/.config/blender`.
config: []const u8 = "~/.config/blender",
/// The versions written, as Blender names their folders in `config` (`"5.2"`). null: every
/// version Blender has run, found by the files in its `config` folder, so a version started for
/// the first time gets the theme on the next apply; finding none is an error.
versions: ?[]const []const u8 = null,
/// The preset kosm owns, inside each version's folder; `{name}` is filled as `files` says.
/// Blender lists the preset by its file name.
/// Default: `scripts/presets/interface_theme/{name}.xml`.
preset: []const u8 = "scripts/presets/interface_theme/{name}.xml",
/// How `{name}` in `preset` is filled: `kosm`, or the kosmos' name. Default: the theme's `files`.
files: kosm.Theme.Files = .shared,
/// A startup script inside each version's folder, written whole, that loads the preset when
/// Blender starts and again whenever an apply changes it: Blender keeps its theme in its
/// preferences, not the preset, so without it the preset is picked by hand after every change.
/// null: not written. Default: `scripts/startup/kosm.py`.
startup_script: ?[]const u8 = "scripts/startup/kosm.py",
/// Seconds between the startup script's checks of the preset, so a running Blender follows an
/// apply within that time; each check is one file status call. null: the preset is loaded only
/// when Blender starts. Default 0.25.
reload_interval: ?f64 = 0.25,
/// Corner radius in pixels at a resolution scale of 1, given to every widget's `roundness` and
/// to `user_interface.panel_roundness` that are left null. Panels are at most 10 pixels round,
/// widgets 20; a larger radius is cut to that with a warning. null: Blender's default roundness.
rounding: ?u32 = null,
/// How far shadows reach in pixels, as other apps' shadows do; Blender's menu and panel
/// shadows are this times `shadow_scale`, where `user_interface.menu_shadow_width` is null.
/// null: Blender's default width.
shadow_range: ?u32 = null,
/// How wide Blender's menu and panel shadows are against `shadow_range`: small menus look
/// right with a shorter shadow than windows. The result is cut to Blender's 24 pixels with a
/// warning. Default 0.5.
shadow_scale: f64 = 0.5,
/// Interface-wide colors: panels, editor borders, axes, gizmos, icons.
user_interface: UserInterface = .{},
/// Each kind of widget's colors.
widgets: Widgets = .{},
/// Widgets of animated, keyed, driven, overridden or changed values, and message severities.
widget_state: WidgetStateColors = .{},
/// Keyframes, channels, the playhead and curve handles in every animation editor.
common: Common = .{},
/// Each editor's background, header and text, and the colors of what it shows.
editors: Editors = .{},
/// Sidebars, the asset shelf, animation channels and the scrubbing region.
regions: Regions = .{},

/// Interface-wide colors.
pub const UserInterface = @import("UserInterface.zig");
/// Each kind of widget's colors.
pub const Widgets = @import("Widgets.zig");
/// One kind of widget's colors.
pub const WidgetColors = @import("WidgetColors.zig");
/// Colors of widgets in a state.
pub const WidgetStateColors = @import("WidgetStateColors.zig");
/// Colors every animation editor shares.
pub const Common = @import("Common.zig");
/// Each editor's colors.
pub const Editors = @import("Editors.zig");
/// The generic colors of one editor.
pub const Space = @import("Space.zig");
/// The colors of shared regions.
pub const Regions = @import("Regions.zig");

/// Blender's widget unit in pixels at a resolution scale of 1: a widget's corner radius is its
/// `roundness` times this, a panel's half of it.
pub const widget_unit = 20;
/// Blender's widest menu shadow, in pixels.
pub const max_menu_shadow_width = 24;

/// Every color from the theme. The interface: backgrounds from the background role with its
/// surface steps, text from the foreground role, buttons pressed and sliders filled with the
/// accent, outlines the theme's `line.border`. What editors show: active items the accent,
/// selected ones the secondary role, plain geometry and grids neutral, and each kind of thing
/// Blender colors apart (axes, node and strip kinds, handle and keyframe types, syntax) the
/// palette hue or code color nearest Blender's own, darkened when unselected and mixed toward
/// the background behind text.
pub fn from(theme: kosm.Theme) App {
    const picks: Picks = .{ .theme = theme };
    return .{
        .files = theme.files,
        .user_interface = picks.userInterface(),
        .widgets = picks.widgets(),
        .widget_state = picks.widgetState(),
        .common = .{ .anim = picks.animation(), .curves = picks.curves() },
        .editors = picks.editors(),
        .regions = picks.regions(),
    };
}

/// How far colors drawn behind text (node headers, strips, row highlights) mix toward the
/// background, so foreground text stays readable on them.
const behind_text_mix = 0.5;

/// The colors `from` builds everything of, from one theme. Alphas given as numbers are
/// Blender's own, so washes stay as faint as Blender draws them.
const Picks = struct {
    theme: kosm.Theme,

    fn background(picks: Picks) Color {
        return picks.theme.roles.background;
    }

    fn foreground(picks: Picks) Color {
        return picks.theme.roles.foreground;
    }

    /// The active item: the accent.
    fn active(picks: Picks) Color {
        return picks.theme.roles.accent;
    }

    /// Selected items: the secondary role.
    fn selected(picks: Picks) Color {
        return picks.theme.roles.secondary;
    }

    fn hue(picks: Picks, name: kosm.Palette.Hue) Color {
        return picks.theme.palette.get(name);
    }

    /// Unselected or quieter variants of a color.
    fn dim(picks: Picks, color: Color) Color {
        return picks.theme.variations.lightness.dark.apply(color);
    }

    /// Text and marks that matter less than the foreground.
    fn muted(picks: Picks) Color {
        return picks.theme.variations.emphasis.muted.apply(picks.foreground());
    }

    /// `color` as a background behind foreground text.
    fn behindText(picks: Picks, color: Color) Color {
        return color.mix(picks.background(), behind_text_mix);
    }

    /// A readable color on top of `color`.
    fn on(picks: Picks, color: Color) Color {
        return picks.theme.variations.contrast.on.apply(color);
    }

    /// Plain geometry Blender draws black: wires, vertices, cameras.
    fn black(picks: Picks) Color {
        return picks.theme.palette.black;
    }

    /// Grid lines on an editor's background.
    fn grid(picks: Picks) Color {
        return picks.theme.variations.line.border.apply(picks.background());
    }

    fn raised(picks: Picks) Color {
        return picks.theme.variations.surface.raised.apply(picks.background());
    }

    fn sunken(picks: Picks) Color {
        return picks.theme.variations.surface.sunken.apply(picks.background());
    }

    fn overlay(picks: Picks) Color {
        return picks.theme.variations.surface.overlay.apply(picks.background());
    }

    fn border(picks: Picks) Color {
        return picks.theme.variations.line.border.apply(picks.background());
    }

    fn bright(picks: Picks) Color {
        return picks.theme.variations.lightness.bright.apply(picks.foreground());
    }

    fn userInterface(picks: Picks) UserInterface {
        const variations = picks.theme.variations;
        return .{
            .editor_border = picks.sunken(),
            .editor_outline = picks.border(),
            .editor_outline_active = picks.active(),
            .widget_text_cursor = picks.active(),
            .panel_header = picks.raised(),
            .panel_title = picks.foreground(),
            .panel_text = picks.foreground(),
            .panel_back = picks.background(),
            .panel_sub_back = picks.sunken(),
            .panel_outline = picks.border(),
            .panel_active = variations.state.hovered.apply(picks.raised()),
            .transparent_checker_primary = picks.raised(),
            .transparent_checker_secondary = picks.sunken(),
            .widget_emboss = variations.surface.shadow.apply(picks.background()),
            .link = picks.theme.roles.link,
            .axis_x = picks.hue(.red),
            .axis_y = picks.hue(.lime),
            .axis_z = picks.hue(.blue),
            .axis_w = picks.hue(.yellow),
            .gizmo_hi = picks.bright(),
            .gizmo_primary = picks.hue(.yellow),
            .gizmo_secondary = picks.hue(.cyan),
            .gizmo_view_align = picks.foreground(),
            .gizmo_a = picks.hue(.green),
            .gizmo_b = picks.hue(.red),
            .icon_scene = picks.foreground(),
            .icon_collection = picks.bright(),
            .icon_object = picks.hue(.orange),
            .icon_object_data = picks.hue(.teal),
            .icon_modifier = picks.hue(.blue),
            .icon_shading = picks.hue(.red),
            .icon_folder = picks.hue(.yellow),
            .icon_autokey = picks.theme.roles.@"error",
        };
    }

    fn widgets(picks: Picks) Widgets {
        const variations = picks.theme.variations;
        const accent = picks.theme.roles.accent;
        var clear = picks.background();
        clear.alpha = 0;
        const button: WidgetColors = .{
            .outline = picks.border(),
            .outline_sel = accent,
            .inner = picks.raised(),
            .inner_sel = accent,
            .item = accent,
            .text = picks.foreground(),
            .text_sel = picks.on(accent),
        };
        const field = with(button, .{ .inner = picks.sunken() });
        const floating = with(button, .{ .inner = picks.overlay() });
        const item = with(button, .{ .inner = clear, .outline = clear });
        return .{
            .regular = button,
            .tool = button,
            .toolbar_item = button,
            .radio = button,
            .text = field,
            .option = field,
            .toggle = button,
            .num = field,
            .numslider = field,
            .box = field,
            .curve = field,
            .menu = button,
            .pulldown = item,
            .menu_back = floating,
            .pie_menu = floating,
            .tooltip = floating,
            .menu_item = item,
            .scroll = with(field, .{ .item = variations.state.hovered.apply(picks.raised()) }),
            .progress = field,
            .list_item = item,
            .tab = with(button, .{ .inner = picks.background(), .inner_sel = picks.raised(), .text_sel = picks.foreground() }),
        };
    }

    fn widgetState(picks: Picks) WidgetStateColors {
        const roles = picks.theme.roles;
        return .{
            .@"error" = roles.@"error",
            .warning = roles.warning,
            .info = roles.accent,
            .success = roles.success,
            .inner_anim = picks.behindText(picks.hue(.green)),
            .inner_anim_sel = picks.hue(.green),
            .inner_key = picks.behindText(picks.hue(.yellow)),
            .inner_key_sel = picks.hue(.yellow),
            .inner_driven = picks.behindText(picks.hue(.purple)),
            .inner_driven_sel = picks.hue(.purple),
            .inner_overridden = picks.behindText(picks.hue(.cyan)),
            .inner_overridden_sel = picks.hue(.cyan),
            .inner_changed = picks.behindText(picks.hue(.orange)),
            .inner_changed_sel = picks.hue(.orange),
        };
    }

    fn animation(picks: Picks) Common.Animation {
        const text = picks.foreground();
        const selection = picks.selected();
        const subtle = picks.theme.variations.emphasis.subtle.apply(text);
        return .{
            .playhead = picks.active(),
            .preview_range = withAlpha(picks.hue(.orange), 0.4),
            .scene_strip_range = withAlpha(picks.black(), 0.5),
            .channels = withAlpha(picks.behindText(picks.hue(.blue)), 0.5),
            .channels_sub = withAlpha(picks.dim(picks.behindText(picks.hue(.blue))), 0.5),
            .channel_group = withAlpha(picks.behindText(picks.hue(.green)), 0.2),
            .channel_group_active = withAlpha(picks.behindText(picks.hue(.green)), 0.4),
            .channel = withAlpha(picks.sunken(), 0.6),
            .channel_selected = withAlpha(selection, 0.27),
            .keyframe = text,
            .keyframe_selected = selection,
            .keyframe_extreme = picks.dim(picks.hue(.pink)),
            .keyframe_extreme_selected = picks.hue(.pink),
            .keyframe_breakdown = picks.dim(picks.hue(.sky)),
            .keyframe_breakdown_selected = picks.hue(.sky),
            .keyframe_jitter = picks.dim(picks.hue(.green)),
            .keyframe_jitter_selected = picks.hue(.green),
            .keyframe_moving_hold = picks.muted(),
            .keyframe_moving_hold_selected = picks.dim(selection),
            .keyframe_generated = subtle,
            .keyframe_generated_selected = picks.dim(picks.dim(selection)),
            .long_key = withAlpha(text, 0.12),
            .long_key_selected = withAlpha(selection, 0.6),
        };
    }

    fn curves(picks: Picks) Common.Curves {
        return .{
            .handle_free = picks.dim(picks.hue(.yellow)),
            .handle_sel_free = picks.hue(.yellow),
            .handle_auto = picks.dim(picks.hue(.red)),
            .handle_sel_auto = picks.hue(.red),
            .handle_vect = picks.dim(picks.hue(.blue)),
            .handle_sel_vect = picks.hue(.blue),
            .handle_align = picks.dim(picks.hue(.green)),
            .handle_sel_align = picks.hue(.green),
            .handle_auto_clamped = picks.dim(picks.hue(.pink)),
            .handle_sel_auto_clamped = picks.hue(.pink),
            .handle_vertex = picks.black(),
            .handle_vertex_select = picks.selected(),
        };
    }

    fn regions(picks: Picks) Regions {
        return .{
            .sidebars_back = picks.raised(),
            .sidebars_tab_back = picks.background(),
            .asset_shelf_back = picks.background(),
            .asset_shelf_header_back = picks.raised(),
            .channels_back = picks.raised(),
            .channels_text = picks.foreground(),
            .channels_text_selected = picks.selected(),
            .scrubbing_back = picks.raised(),
            .scrubbing_text = picks.foreground(),
            .scrubbing_time_marker = withAlpha(picks.foreground(), 0.5),
            .scrubbing_time_marker_selected = picks.selected(),
        };
    }

    fn editors(picks: Picks) Editors {
        var result: Editors = .{
            .view_3d = picks.view3D(),
            .graph_editor = picks.graphEditor(),
            .file_browser = .{ .selected_file = picks.behindText(picks.selected()), .row_alternate = picks.rowAlternate() },
            .nla_editor = picks.nlaEditor(),
            .dopesheet_editor = picks.dopeSheet(),
            .image_editor = picks.imageEditor(),
            .sequence_editor = picks.sequenceEditor(),
            .properties = .{ .match = picks.active() },
            .text_editor = picks.textEditor(),
            .node_editor = picks.nodeEditor(),
            .outliner = picks.outliner(),
            .info = picks.info(),
            .preferences = .{ .match = picks.active() },
            .console = picks.console(),
            .clip_editor = picks.clipEditor(),
            .spreadsheet = .{ .row_alternate = picks.rowAlternate() },
        };
        const space: Space = .{
            .back = picks.background(),
            .title = picks.foreground(),
            .text = picks.foreground(),
            .text_hi = picks.bright(),
            .header = picks.raised(),
            .header_text = picks.foreground(),
            .header_text_hi = picks.bright(),
        };
        inline for (@typeInfo(Editors).@"struct".field_names) |name| @field(result, name).space = space;
        return result;
    }

    fn rowAlternate(picks: Picks) Color {
        return withAlpha(picks.foreground(), 0.016);
    }

    fn view3D(picks: Picks) Editors.View3D {
        const plain = picks.black();
        const selection = picks.selected();
        const mode_selected = picks.theme.variations.lightness.light.apply(selection);
        return .{
            .grid = withAlpha(picks.grid(), 0.5),
            .grid_major = picks.grid(),
            .clipping_border_3d = picks.raised(),
            .wire = plain,
            .wire_edit = plain,
            .gp_wire_edit = withAlpha(picks.theme.palette.gray, 0.5),
            .gp_vertex = plain,
            .gp_vertex_select = selection,
            .text_grease_pencil = picks.hue(.lime),
            .object_selected = selection,
            .object_active = picks.active(),
            .camera = plain,
            .empty = plain,
            .light = withAlpha(plain, 0.31),
            .speaker = plain,
            .vertex = plain,
            .vertex_select = selection,
            .edge_select = selection,
            .edge_mode_select = mode_selected,
            .face = withAlpha(picks.foreground(), 0.01),
            .face_select = withAlpha(selection, 0.2),
            .face_mode_select = withAlpha(mode_selected, 0.2),
            .face_back = withAlpha(picks.hue(.red), 0.7),
            .face_front = withAlpha(picks.hue(.blue), 0),
            .bevel = picks.hue(.sky),
            .seam = picks.hue(.red),
            .sharp = picks.hue(.cyan),
            .crease = picks.hue(.magenta),
            .freestyle = withAlpha(picks.hue(.green), 0.3),
            .extra_edge_len = picks.dim(picks.hue(.red)),
            .extra_edge_angle = picks.dim(picks.hue(.yellow)),
            .extra_face_angle = picks.dim(picks.hue(.blue)),
            .extra_face_area = picks.dim(picks.hue(.green)),
            .editmesh_active = withAlpha(picks.active(), 0.2),
            .normal = picks.hue(.cyan),
            .vertex_normal = picks.hue(.blue),
            .split_normal = picks.hue(.magenta),
            .vertex_unreferenced = plain,
            .face_retopology = withAlpha(picks.hue(.sky), 0.06),
            .nurb_uline = picks.dim(picks.hue(.yellow)),
            .nurb_vline = picks.dim(picks.hue(.pink)),
            .nurb_sel_uline = picks.hue(.yellow),
            .nurb_sel_vline = picks.hue(.pink),
            .bone_pose = selection,
            .bone_pose_active = picks.active(),
            .bone_solid = picks.muted(),
            .bone_locked_weight = withAlpha(picks.hue(.red), 0.5),
            .before_current_frame = picks.hue(.red),
            .after_current_frame = picks.hue(.green),
            .bundle_solid = picks.muted(),
            .camera_path = plain,
            .camera_passepartout = plain,
            .skin_root = picks.dim(picks.hue(.red)),
            .view_overlay = plain,
            .transform = picks.foreground(),
        };
    }

    fn graphEditor(picks: Picks) Editors.GraphEditor {
        return .{ .grid = picks.grid(), .vertex = picks.black(), .vertex_select = picks.selected(), .vertex_active = picks.active() };
    }

    fn nlaEditor(picks: Picks) Editors.NLAEditor {
        const selection = picks.selected();
        return .{
            .grid = picks.grid(),
            .active_action = withAlpha(picks.behindText(picks.hue(.orange)), 0.4),
            .active_action_unset = withAlpha(picks.dim(picks.behindText(picks.hue(.orange))), 0.3),
            .strips = picks.sunken(),
            .strips_selected = selection,
            .transition_strips = picks.behindText(picks.hue(.blue)),
            .transition_strips_selected = picks.hue(.blue),
            .meta_strips = picks.behindText(picks.hue(.purple)),
            .meta_strips_selected = picks.hue(.purple),
            .sound_strips = picks.behindText(picks.hue(.teal)),
            .sound_strips_selected = picks.hue(.teal),
            .tweak = picks.hue(.green),
            .tweak_duplicate = picks.theme.roles.@"error",
            .keyframe_border = picks.black(),
            .keyframe_border_selected = picks.black(),
        };
    }

    fn dopeSheet(picks: Picks) Editors.DopeSheet {
        return .{
            .grid = picks.grid(),
            .keyframe_border = picks.black(),
            .keyframe_border_selected = picks.black(),
            .summary = withAlpha(picks.behindText(picks.hue(.red)), 0.4),
            .anim_interpolation_linear = withAlpha(picks.hue(.green), 0.8),
            .anim_interpolation_constant = withAlpha(picks.hue(.orange), 0.8),
            .anim_interpolation_other = withAlpha(picks.hue(.teal), 0.7),
            .simulated_frames = picks.behindText(picks.hue(.magenta)),
        };
    }

    fn imageEditor(picks: Picks) Editors.ImageEditor {
        const selection = picks.selected();
        return .{
            .grid = picks.grid(),
            .vertex = picks.black(),
            .vertex_select = selection,
            .face = withAlpha(picks.foreground(), 0.04),
            .face_select = withAlpha(selection, 0.24),
            .face_mode_select = withAlpha(selection, 0),
            .editmesh_active = withAlpha(picks.active(), 0.25),
            .wire_edit = picks.muted(),
            .edge_select = selection,
            .scope_back = picks.raised(),
            .preview_stitch_face = withAlpha(picks.hue(.yellow), 0.2),
            .preview_stitch_edge = withAlpha(picks.hue(.magenta), 0.2),
            .preview_stitch_vert = withAlpha(picks.hue(.blue), 0.2),
            .preview_stitch_stitchable = picks.theme.roles.success,
            .preview_stitch_unstitchable = picks.theme.roles.@"error",
            .preview_stitch_active = withAlpha(picks.foreground(), 0.14),
            .uv_shadow = picks.theme.palette.gray,
            .metadatabg = picks.background(),
            .metadatatext = picks.foreground(),
        };
    }

    fn sequenceEditor(picks: Picks) Editors.SequenceEditor {
        return .{
            .grid = picks.grid(),
            .movie_strip = picks.behindText(picks.hue(.blue)),
            .movieclip_strip = picks.behindText(picks.hue(.orange)),
            .image_strip = picks.behindText(picks.hue(.magenta)),
            .scene_strip = picks.behindText(picks.theme.palette.gray),
            .audio_strip = picks.behindText(picks.hue(.teal)),
            .effect_strip = picks.behindText(picks.hue(.purple)),
            .transition_strip = picks.behindText(picks.hue(.sky)),
            .color_strip = picks.behindText(picks.hue(.yellow)),
            .meta_strip = picks.behindText(picks.hue(.lime)),
            .mask_strip = picks.behindText(picks.hue(.red)),
            .text_strip = picks.behindText(picks.hue(.pink)),
            .active_strip = picks.active(),
            .selected_strip = picks.selected(),
            .keyframe_border = picks.black(),
            .keyframe_border_selected = picks.black(),
            .preview_back = picks.black(),
            .metadatabg = picks.background(),
            .metadatatext = picks.foreground(),
            .row_alternate = picks.rowAlternate(),
            .text_strip_cursor = picks.active(),
            .selected_text = withAlpha(picks.selected(), 0.3),
        };
    }

    fn textEditor(picks: Picks) Editors.TextEditor {
        const code = picks.theme.code;
        return .{
            .line_numbers = picks.muted(),
            .line_numbers_background = picks.sunken(),
            .selected_text = picks.behindText(picks.selected()),
            .cursor = picks.active(),
            .syntax_builtin = code.keyword,
            .syntax_symbols = code.operator,
            .syntax_special = code.function,
            .syntax_preprocessor = code.type,
            .syntax_reserved = code.constant,
            .syntax_comment = code.comment,
            .syntax_string = code.string,
            .syntax_numbers = code.number,
        };
    }

    fn nodeEditor(picks: Picks) Editors.NodeEditor {
        return .{
            .grid = picks.grid(),
            .node_outline = picks.border(),
            .node_selected = picks.selected(),
            .node_active = picks.active(),
            .wire = picks.black(),
            .wire_inner = picks.muted(),
            .wire_select = withAlpha(picks.selected(), 0.7),
            .node_backdrop = picks.raised(),
            .converter_node = picks.behindText(picks.hue(.sky)),
            .color_node = picks.behindText(picks.hue(.yellow)),
            .group_node = picks.behindText(picks.hue(.lime)),
            .group_socket_node = picks.sunken(),
            .frame_node = withAlpha(picks.sunken(), 0.8),
            .matte_node = picks.behindText(picks.hue(.red)),
            .distor_node = picks.behindText(picks.hue(.cyan)),
            .input_node = picks.behindText(picks.hue(.pink)),
            .output_node = picks.behindText(picks.hue(.magenta)),
            .filter_node = picks.behindText(picks.hue(.purple)),
            .vector_node = picks.behindText(picks.hue(.blue)),
            .texture_node = picks.behindText(picks.hue(.orange)),
            .shader_node = picks.behindText(picks.hue(.green)),
            .script_node = picks.dim(picks.behindText(picks.hue(.teal))),
            .geometry_node = picks.behindText(picks.hue(.teal)),
            .attribute_node = picks.dim(picks.behindText(picks.hue(.blue))),
            .simulation_zone = withAlpha(picks.hue(.magenta), 0.2),
            .repeat_zone = withAlpha(picks.hue(.orange), 0.2),
            .foreach_geometry_element_zone = withAlpha(picks.hue(.blue), 0.2),
            .closure_zone = withAlpha(picks.hue(.yellow), 0.2),
        };
    }

    fn outliner(picks: Picks) Editors.Outliner {
        return .{
            .match = picks.active(),
            .selected_highlight = picks.behindText(picks.selected()),
            .active = picks.behindText(picks.active()),
            .selected_object = picks.selected(),
            .active_object = picks.active(),
            .edited_object = withAlpha(picks.hue(.teal), 0.4),
            .row_alternate = picks.rowAlternate(),
        };
    }

    fn info(picks: Picks) Editors.Info {
        const roles = picks.theme.roles;
        const selected_line = picks.behindText(picks.selected());
        const debug = picks.behindText(picks.hue(.purple));
        const property = picks.behindText(picks.hue(.teal));
        const operator = picks.behindText(picks.hue(.sky));
        return .{
            .info_selected = selected_line,
            .info_selected_text = picks.foreground(),
            .info_error_text = picks.on(roles.@"error"),
            .info_warning_text = picks.on(roles.warning),
            .info_info_text = picks.on(roles.accent),
            .info_debug = debug,
            .info_debug_text = picks.on(debug),
            .info_property = property,
            .info_property_text = picks.on(property),
            .info_operator = operator,
            .info_operator_text = picks.on(operator),
        };
    }

    fn console(picks: Picks) Editors.Console {
        const roles = picks.theme.roles;
        return .{
            .line_output = roles.accent,
            .line_input = picks.foreground(),
            .line_info = roles.success,
            .line_error = roles.@"error",
            .cursor = picks.active(),
            .select = withAlpha(picks.selected(), 0.19),
        };
    }

    fn clipEditor(picks: Picks) Editors.ClipEditor {
        const lighter = picks.theme.variations.lightness.lighter;
        return .{
            .grid = picks.grid(),
            .marker_outline = picks.black(),
            .marker = picks.dim(picks.hue(.yellow)),
            .active_marker = picks.active(),
            .selected_marker = picks.selected(),
            .disabled_marker = picks.dim(picks.hue(.red)),
            .locked_marker = picks.theme.palette.gray,
            .path_before = picks.hue(.red),
            .path_after = picks.hue(.blue),
            .path_keyframe_before = lighter.apply(picks.hue(.red)),
            .path_keyframe_after = lighter.apply(picks.hue(.blue)),
            .metadatabg = picks.background(),
            .metadatatext = picks.foreground(),
        };
    }
};

/// `color` with its alpha replaced by `alpha`, 0..1.
fn withAlpha(color: Color, alpha: f64) Color {
    var result = color;
    result.alpha = alpha;
    return result;
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

/// Generates the preset, and the startup script that loads it, for each version.
pub fn apply(self: App, output: *kosm.Output) !void {
    const allocator = output.allocator;
    const shaped = try self.withShapes(output, self.config);
    const preset = try shaped.presetValue(allocator);
    const interval = try self.intervalLiteral(output);
    for (try self.versionFolders(output)) |folder| {
        const preset_file = try output.namedFile(try std.Io.Dir.path.join(allocator, &.{ folder, self.preset }), self.files);
        try output.generate(.{ .file = preset_file, .lang = "xml", .format = .{ .color = hex8 } }, preset);
        if (self.startup_script) |script| {
            const script_file = try std.Io.Dir.path.join(allocator, &.{ folder, script });
            try writeStartupScript(output, script_file, preset_file, interval);
        }
    }
}

/// The folder of every version written: `versions` inside `config`, or each one Blender has run.
fn versionFolders(self: App, output: *kosm.Output) ![]const []const u8 {
    const allocator = output.allocator;
    if (self.versions) |versions| {
        const folders = try allocator.alloc([]const u8, versions.len);
        for (versions, folders) |version, *folder| folder.* = try std.Io.Dir.path.join(allocator, &.{ self.config, version });
        return folders;
    }
    const pattern = try std.Io.Dir.path.join(allocator, &.{ self.config, "*", "config", "*" });
    var folders: std.ArrayList([]const u8) = .empty;
    // Found files are sorted, so the files of one version are next to each other.
    for (try output.find(.{ .files = pattern })) |file| {
        const folder = std.Io.Dir.path.dirname(std.Io.Dir.path.dirname(file).?).?;
        if (folders.items.len == 0 or !std.mem.eql(u8, folders.items[folders.items.len - 1], folder)) try folders.append(allocator, folder);
    }
    return folders.items;
}

/// `reload_interval` as the startup script spells it: seconds, or `None`.
fn intervalLiteral(self: App, output: *kosm.Output) ![]const u8 {
    const seconds = self.reload_interval orelse return "None";
    if (!std.math.isFinite(seconds) or seconds <= 0)
        return output.fail(self.config, "reload_interval must be a positive number of seconds or null, not {d}", .{seconds});
    return output.allocator.print("{d}", .{seconds});
}

/// The app with `rounding` and `shadow_range` given to every roundness and shadow width left
/// null, each cut to what Blender can draw with a warning on `file`.
fn withShapes(self: App, output: *kosm.Output, file: []const u8) !App {
    var result = self;
    if (self.rounding) |pixels| {
        const widget = try roundness(output, file, "widgets", pixels, widget_unit);
        const panel = try roundness(output, file, "panels", pixels, widget_unit / 2);
        inline for (@typeInfo(Widgets).@"struct".field_names) |name| {
            if (@field(result.widgets, name)) |*colors| {
                if (colors.roundness == null) colors.roundness = widget;
            }
        }
        if (result.user_interface.panel_roundness == null) result.user_interface.panel_roundness = panel;
    }
    if (self.shadow_range) |range| if (result.user_interface.menu_shadow_width == null) {
        if (!std.math.isFinite(self.shadow_scale) or self.shadow_scale < 0)
            return output.fail(file, "shadow_scale must be a number of 0 or more, not {d}", .{self.shadow_scale});
        const width = @round(@as(f64, @floatFromInt(range)) * self.shadow_scale);
        if (width > max_menu_shadow_width)
            try output.warn(file, "Blender's menu shadows are at most {d} pixels wide, not {d}; using {d}", .{ max_menu_shadow_width, width, max_menu_shadow_width });
        result.user_interface.menu_shadow_width = @intFromFloat(@min(width, max_menu_shadow_width));
    };
    return result;
}

/// The roundness giving `pixels` of radius where a roundness of 1 is `full` pixels, cut to 1
/// with a warning naming `what` on `file`.
fn roundness(output: *kosm.Output, file: []const u8, comptime what: []const u8, pixels: u32, comptime full: u32) !f64 {
    if (pixels > full) {
        try output.warn(file, "Blender's " ++ what ++ " are at most {d} pixels round, not {d}; using {d}", .{ full, pixels, full });
        return 1;
    }
    return @as(f64, @floatFromInt(pixels)) / full;
}

/// The preset's contents: the theme under `bpy`, as Blender's preset loader reads it.
fn presetValue(self: App, allocator: std.mem.Allocator) !kosm.Value {
    var builder: Builder = .{ .allocator = allocator };
    var user_interface = try builder.contents(UserInterface, self.user_interface);
    inline for (@typeInfo(Widgets).@"struct".field_names) |name| {
        if (@field(self.widgets, name)) |colors|
            try user_interface.append(allocator, try builder.wrap("wcol_" ++ name, "ThemeWidgetColors", try builder.contents(WidgetColors, colors)));
    }
    try builder.appendChild(&user_interface, "wcol_state", WidgetStateColors, self.widget_state);
    var theme: std.ArrayList(kosm.Value.Entry) = .empty;
    try theme.append(allocator, try builder.wrap("user_interface", "ThemeUserInterface", user_interface));
    try theme.append(allocator, try builder.wrap("regions", "ThemeRegions", try self.regionEntries(&builder)));
    try builder.appendChild(&theme, "common", Common, self.common);
    // Editors sit right under the theme, each as its own property.
    try theme.appendSlice(allocator, (try builder.contents(Editors, self.editors)).items);
    const root = try allocator.dupe(kosm.Value.Entry, &.{
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
    });
    return .{ .table = root };
}

/// The startup script `script`, loading `preset` (both as an app writes them) every `interval`.
fn writeStartupScript(output: *kosm.Output, script: []const u8, preset: []const u8, interval: []const u8) !void {
    const allocator = output.allocator;
    const preset_path = if (std.mem.startsWith(u8, preset, "~/")) try std.Io.Dir.path.join(allocator, &.{ output.home, preset[2..] }) else preset;
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
        .{ "scrubbing", "ThemeRegionsScrubbing", &.{ "back", "text", "time_marker", "time_marker_selected" } },
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
/// its type, whose attributes are the values.
const Builder = struct {
    allocator: std.mem.Allocator,

    /// The set fields of `values` as `@name` attributes, and each field holding more values as
    /// a child property under its `type_name`, left out when nothing in it is set.
    fn contents(builder: Builder, comptime Values: type, values: Values) !std.ArrayList(kosm.Value.Entry) {
        var list: std.ArrayList(kosm.Value.Entry) = .empty;
        const info = @typeInfo(Values).@"struct";
        inline for (info.field_names, info.field_types) |name, Field| {
            const value = @field(values, name);
            switch (@typeInfo(Field)) {
                .optional => |optional| if (value) |set| try list.append(builder.allocator, .{ .key = "@" ++ name, .value = attribute(optional.child, set) }),
                .@"struct" => if (Field == Space)
                    try builder.appendSpace(&list, Values == Editors.View3D, value)
                else
                    try builder.appendChild(&list, name, Field, value),
                else => @compileError("no preset attribute for " ++ @typeName(Field)),
            }
        }
        return list;
    }

    /// `<property><Values.type_name ...></...></property>` on `list` when anything in `values` is set.
    fn appendChild(builder: Builder, list: *std.ArrayList(kosm.Value.Entry), comptime property: []const u8, comptime Values: type, values: Values) !void {
        const inner = try builder.contents(Values, values);
        if (inner.items.len != 0) try list.append(builder.allocator, try builder.wrap(property, Values.type_name, inner));
    }

    /// `<property><Type ...contents...></Type></property>`.
    fn wrap(builder: Builder, property: []const u8, type_name: []const u8, contents_list: std.ArrayList(kosm.Value.Entry)) !kosm.Value.Entry {
        const typed = try builder.allocator.dupe(kosm.Value.Entry, &.{.{ .key = type_name, .value = .{ .table = contents_list.items } }});
        return .{ .key = property, .value = .{ .table = typed } };
    }

    /// An editor's `space` on `list`. The 3D viewport's is a gradient whose single color is `back`.
    fn appendSpace(builder: Builder, list: *std.ArrayList(kosm.Value.Entry), comptime is_viewport: bool, space: Space) !void {
        var colors = try builder.contents(Space, space);
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
        if (colors.items.len != 0) try list.append(builder.allocator, try builder.wrap("space", if (is_viewport) "ThemeSpaceGradient" else "ThemeSpaceGeneric", colors));
    }
};

/// A field's value as a preset attribute.
fn attribute(comptime T: type, value: T) kosm.Value {
    return switch (T) {
        Color => .{ .color = value },
        f64 => .{ .float = value },
        u32 => .{ .integer = value },
        else => @compileError("no preset attribute for " ++ @typeName(T)),
    };
}

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
        try fixture.runBlender("5.2");
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

    /// Leaves what a first start of Blender `version` leaves: a file in its `config` folder.
    fn runBlender(fixture: *Fixture, comptime version: []const u8) !void {
        try fixture.tmp.dir.createDirPath(testing.io, ".config/blender/" ++ version ++ "/config");
        try fixture.tmp.dir.writeFile(testing.io, .{ .sub_path = ".config/blender/" ++ version ++ "/config/bookmarks.txt", .data = "" });
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
        .editors = .{ .view_3d = .{ .space = .{ .back = kosm.hex("000000"), .text = kosm.hex("a3c5cc") } }, .outliner = .{ .space = .{ .back = kosm.hex("041c26") } } },
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

/// Fails naming the first color field of `values`, at any depth, that is null.
fn expectEveryColor(comptime Values: type, values: Values, comptime path: []const u8) !void {
    const info = @typeInfo(Values).@"struct";
    inline for (info.field_names, info.field_types) |name, Field| {
        const value = @field(values, name);
        switch (@typeInfo(Field)) {
            .optional => |optional| if (optional.child == Color) {
                if (value == null) {
                    std.debug.print("{s}.{s} is null\n", .{ path, name });
                    return error.TestExpectedEqual;
                }
            } else if (@typeInfo(optional.child) == .@"struct") try expectEveryColor(optional.child, value orelse return error.TestUnexpectedNull, path ++ "." ++ name),
            .@"struct" => try expectEveryColor(Field, value, path ++ "." ++ name),
            else => {},
        }
    }
}

test "from sets every color Blender has" {
    const app = from(kosm.Theme.from(.{ .palette = .{ .black = kosm.hex("041c26"), .white = kosm.hex("a3c5cc") }, .mode = .dark }));
    try expectEveryColor(UserInterface, app.user_interface, "user_interface");
    try expectEveryColor(Widgets, app.widgets, "widgets");
    try expectEveryColor(WidgetStateColors, app.widget_state, "widget_state");
    try expectEveryColor(Common, app.common, "common");
    try expectEveryColor(Editors, app.editors, "editors");
    try expectEveryColor(Regions, app.regions, "regions");
    try testing.expectEqual(0, app.widgets.menu_item.?.inner.?.alpha);
}

test "active items are the accent, selected ones the secondary role" {
    const theme = kosm.Theme.from(.{ .palette = .{ .black = kosm.hex("041c26"), .white = kosm.hex("a3c5cc") }, .mode = .dark });
    const app = from(theme);
    try testing.expectEqual(theme.roles.accent, app.editors.view_3d.object_active.?);
    try testing.expectEqual(theme.roles.secondary, app.editors.view_3d.object_selected.?);
    try testing.expectEqual(theme.roles.secondary, app.editors.node_editor.node_selected.?);
    try testing.expectEqual(theme.roles.accent, app.editors.outliner.active_object.?);
    try testing.expectEqual(theme.palette.orange, app.user_interface.icon_object.?);
}

test "rounding becomes the roundness of widgets and panels left null, cut to what Blender draws" {
    var fixture: Fixture = undefined;
    try fixture.init();
    defer fixture.deinit();
    var app: App = .{ .rounding = 12, .widgets = .{ .regular = .{ .inner = kosm.hex("082e3f") }, .tool = .{ .roundness = 0.1 } } };
    app.versions = &.{"5.2"};
    app.startup_script = null;
    try app.apply(&fixture.output);
    const preset = fixture.plan.files.items[0].new;
    try testing.expect(std.mem.indexOf(u8, preset, "<ThemeUserInterface panel_roundness=\"1\">") != null);
    try testing.expect(std.mem.indexOf(u8, preset, "<ThemeWidgetColors inner=\"#082e3fff\" roundness=\"0.6\"/>") != null);
    try testing.expect(std.mem.indexOf(u8, preset, "<ThemeWidgetColors roundness=\"0.1\"/>") != null);
    try testing.expectEqual(1, fixture.warnings.items.items.len);
    try testing.expect(std.mem.indexOf(u8, fixture.warnings.items.items[0].message, "panels are at most 10 pixels round, not 12") != null);
}

test "the shadow range times the scale is the menu shadow width, cut to 24" {
    inline for (.{ .{ 10, 0.5, "5" }, .{ 60, 1.0, "24" } }) |case| {
        var fixture: Fixture = undefined;
        try fixture.init();
        defer fixture.deinit();
        const app: App = .{ .shadow_range = case[0], .shadow_scale = case[1], .startup_script = null };
        try app.apply(&fixture.output);
        try testing.expect(std.mem.indexOf(u8, fixture.plan.files.items[0].new, "menu_shadow_width=\"" ++ case[2] ++ "\"") != null);
    }
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
    var theme = kosm.Theme.from(.{ .palette = .{ .black = kosm.hex("041c26"), .white = kosm.hex("a3c5cc") }, .mode = .dark });
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
    const app: App = .{ .config = "/tmp/a \"b\"\\c\td", .versions = &.{"5.2"}, .reload_interval = null };
    try app.apply(&fixture.output);
    const script = plannedFile(&fixture, "/tmp/a \"b\"\\c\td/5.2/scripts/startup/kosm.py").?;
    try testing.expect(std.mem.indexOf(u8, script, "\nPRESET = \"/tmp/a \\\"b\\\"\\\\c\\x09d/5.2/scripts/presets/interface_theme/kosm.xml\"\n") != null);
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

test "every version Blender has run gets the preset and the script, a version never run gets none" {
    var fixture: Fixture = undefined;
    try fixture.init();
    defer fixture.deinit();
    try fixture.runBlender("5.1");
    try fixture.tmp.dir.createDirPath(testing.io, ".config/blender/5.3/config");
    try (App{}).apply(&fixture.output);
    var written: std.ArrayList([]const u8) = .empty;
    for (fixture.plan.files.items) |file| try written.append(fixture.arena.allocator(), file.display_path);
    try testing.expectEqualDeep(@as([]const []const u8, &.{
        "~/.config/blender/5.1/scripts/presets/interface_theme/kosm.xml",
        "~/.config/blender/5.1/scripts/startup/kosm.py",
        "~/.config/blender/5.2/scripts/presets/interface_theme/kosm.xml",
        "~/.config/blender/5.2/scripts/startup/kosm.py",
    }), written.items);
}

test "listed versions are written even before Blender has run them, finding none is an error" {
    var fixture: Fixture = undefined;
    try fixture.init();
    defer fixture.deinit();
    try (App{ .versions = &.{"6.0"}, .startup_script = null }).apply(&fixture.output);
    try testing.expectEqualStrings("~/.config/blender/6.0/scripts/presets/interface_theme/kosm.xml", fixture.plan.files.items[0].display_path);
    var empty: Fixture = undefined;
    try empty.init();
    defer empty.deinit();
    try empty.tmp.dir.deleteTree(testing.io, ".config/blender");
    try testing.expectError(error.NoFile, (App{}).apply(&empty.output));
    try testing.expectEqualStrings("~/.config/blender/*/config/*", empty.diagnostics.file);
}
