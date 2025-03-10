/*
* Copyright (c) 2017-2024 Lains
* Copyright (c) 2025 Stella (teamcons on GitHub) and the Ellie_Commons community
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/

/* I just dont wanna clutter my mainwindow, damn.
So the whole settings popover is here, deal with it.

>Grid
->Label notecolor
->GtkBox
-->Lots of ColorPills


*/


public class jorts.SettingsPopover : Gtk.Popover {



    public string selected;
    public signal void theme_changed (string selected);
    public signal void zoom_changed (string zoomkind);

    public Gtk.Button zoom_out_button;
    public Gtk.Button zoom_in_button;
    public Gtk.Button zoom_default_button;

    public const string[] ACCELS_ZOOM_DEFAULT = { "<control>0", "<Control>KP_0", null };
    public const string[] ACCELS_ZOOM_IN = { "<Control>plus", "<Control>equal", "<Control>KP_Add", null };
    public const string[] ACCELS_ZOOM_OUT = { "<Control>minus", "<Control>KP_Subtract", null };
    
    public SettingsPopover (string theme) {

        this.set_position (Gtk.PositionType.TOP);
        this.set_halign (Gtk.Align.END);

        // Everything is in this
        var setting_grid = new Gtk.Grid ();
        setting_grid.set_margin_start (12);
        setting_grid.set_margin_end (12);
        setting_grid.set_margin_top (12);
        setting_grid.set_margin_bottom (12);

        setting_grid.orientation = Gtk.Orientation.VERTICAL;


        //TRANSLATORS: The label is displayed above colored pills the user can click to choose a theme color
        var color_button_label = new Granite.HeaderLabel (_("Sticky Note Colour"));
        color_button_label.add_css_class (Granite.STYLE_CLASS_TITLE_LABEL);
        color_button_label.tooltip_text = _("Choose a colour for this sticky note");
        setting_grid.attach (color_button_label, 0, 0, 1, 1);


        //TRANSLATORS: Shown as a tooltip when people hover a color theme
        var color_button_blueberry = new ColorPill (_("Blueberry"), "blueberry");
        var color_button_lime = new ColorPill (_("Lime"), "lime");
        var color_button_mint = new ColorPill (_("Mint"), "mint");
        var color_button_banana = new ColorPill (_("Banana"), "banana");
        var color_button_strawberry = new ColorPill (_("Strawberry"), "strawberry");
        var color_button_orange = new ColorPill (_("Orange"), "orange");
        var color_button_bubblegum = new ColorPill (_("Bubblegum"), "bubblegum");
        var color_button_grape = new ColorPill (_("Grape"),"grape");
        var color_button_cocoa = new ColorPill (_("Cocoa"), "cocoa");
        var color_button_slate = new ColorPill (_("Slate"),"slate");

        color_button_lime.set_group (color_button_blueberry);
        color_button_mint.set_group (color_button_blueberry);
        color_button_banana.set_group (color_button_blueberry);
        color_button_strawberry.set_group (color_button_blueberry);
        color_button_orange.set_group (color_button_blueberry);
        color_button_bubblegum.set_group (color_button_blueberry);
        color_button_grape.set_group (color_button_blueberry);
        color_button_cocoa.set_group (color_button_blueberry);
        color_button_slate.set_group (color_button_blueberry);

        color_button_blueberry.set_active ((theme == "BLUEBERRY"));
        color_button_lime.set_active ((theme == "LIME"));
        color_button_mint.set_active ((theme == "MINT"));
        color_button_banana.set_active ((theme == "BANANA"));
        color_button_strawberry.set_active ((theme == "STRAWBERRY"));
        color_button_orange.set_active ((theme == "ORANGE"));
        color_button_bubblegum.set_active ((theme == "BUBBLEGUM"));
        color_button_grape.set_active ((theme == "GRAPE"));
        color_button_cocoa.set_active ((theme == "COCOA"));
        color_button_slate.set_active ((theme == "SLATE"));

        // Emit a signal when a button is toggled
        color_button_blueberry.toggled.connect (() => {this.theme_changed("BLUEBERRY");});
        color_button_orange.toggled.connect (() => {this.theme_changed("ORANGE");});
        color_button_mint.toggled.connect (() => {this.theme_changed("MINT");});
        color_button_banana.toggled.connect (() => {this.theme_changed("BANANA");});
        color_button_lime.toggled.connect (() => {this.theme_changed("LIME");});
        color_button_strawberry.toggled.connect (() => {this.theme_changed("STRAWBERRY");});
        color_button_bubblegum.toggled.connect (() => {this.theme_changed("BUBBLEGUM");});
        color_button_grape.toggled.connect (() => {this.theme_changed("GRAPE");});
        color_button_cocoa.toggled.connect (() => {this.theme_changed("COCOA");});
            color_button_slate.toggled.connect (() => {this.theme_changed("SLATE");});

        //TODO: Multiline
        var color_button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        color_button_box.accessible_role = Gtk.AccessibleRole.LIST;
        color_button_box.margin_top = 3;
        color_button_box.margin_bottom = 9;
        color_button_box.halign = Gtk.Align.CENTER;

        color_button_box.append (color_button_blueberry);
        color_button_box.append (color_button_mint);
        color_button_box.append (color_button_lime);
        color_button_box.append (color_button_banana);
        color_button_box.append (color_button_orange);
        color_button_box.append (color_button_strawberry);
        color_button_box.append (color_button_bubblegum);
        color_button_box.append (color_button_grape);
        color_button_box.append (color_button_cocoa);
        color_button_box.append (color_button_slate);

        setting_grid.attach (color_button_box, 0, 1, 1, 1);
        setting_grid.attach (new Gtk.Separator (HORIZONTAL), 0, 2, 1, 1);


        this.zoom_out_button = new Gtk.Button.from_icon_name ("zoom-out-symbolic") {
            tooltip_markup = Granite.markup_accel_tooltip (
                ACCELS_ZOOM_OUT,
                _("Zoom out")
                )
            };
        this.zoom_default_button = new Gtk.Button () {
            tooltip_markup = Granite.markup_accel_tooltip (
                        ACCELS_ZOOM_DEFAULT,
                        _("Default zoom level")
                    )
            };

        this.zoom_in_button = new Gtk.Button.from_icon_name ("zoom-in-symbolic") {
            tooltip_markup = Granite.markup_accel_tooltip (
                        ACCELS_ZOOM_IN,
                        _("Zoom in")
                    )
            };

        // Emit a signal when a button is toggled that will be picked by MainWindow
        this.zoom_out_button.clicked.connect (() => {this.zoom_changed("zoom_out");});
        this.zoom_default_button.clicked.connect (() => {this.zoom_changed("reset");});
        this.zoom_in_button.clicked.connect (() => {this.zoom_changed("zoom_in");});
        
        var font_size_box = new Gtk.Box (HORIZONTAL, 0) {
            homogeneous = true,
            hexpand = true,
            margin_top = 12,
            margin_start = 6,
            margin_end = 6,
            margin_bottom = 6
        };
        font_size_box.append (this.zoom_out_button);
        font_size_box.append (this.zoom_default_button);
        font_size_box.append (this.zoom_in_button);       
        font_size_box.add_css_class (Granite.STYLE_CLASS_LINKED);


        setting_grid.attach (font_size_box, 0, 3, 1, 1);
        setting_grid.show ();
        this.set_child(setting_grid);


    }



    // Called by the Mainwindow when adjusting to new zoomlevel
    // Mainwindow reacts to a signal by the popover
    public void set_zoomlevel (int64 zoom) {

        //TRANSLATORS: ZOOM is replaced by a number. Ex: 100, to display 100%
        var label = _("ZOOM%");
        label = label.replace ("ZOOM", zoom.to_string ());
        this.zoom_default_button.set_label (label);  
    }




}
