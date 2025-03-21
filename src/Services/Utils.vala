/*
* Copyright (c) 2025 Stella
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
*
*/

/* CONTENT

random_theme(skip_theme)
random_title()
random_emote(skip_emote)
random_note(skip_theme)

*/

namespace jorts.Utils {

    /*************************************************/
    // We cannot use numbers in CSS, so we have to translate a number into a string
    public string zoom_to_class(int64 zoom) {
        switch (zoom) {
            case 20: return "antsized";
            case 40: return "muchsmaller";
            case 60: return "smaller";
            case 80: return "small";
            case 100: return "normal_zoom";
            case 120: return "big";
            case 140: return "bigger";
            case 160: return "muchbigger";
            case 180: return "muchmuchbigger";
            case 200: return "huge";
            case 220: return "superhuge";
            case 240: return "megahuge";
            case 260: return "ultrahuge";
            case 280: return "massive";
            case 300: return "urmom";
            default: return "normal_zoom";
        }
    }


    /*************************************************/
    // Spits out a random theme for a new note
    // If there is the name of a string to skip, just skip it.
    // Having an gee.arraylist defined from the start only causes issues
    public string random_theme (string? skip_theme) {
        Gee.ArrayList<string> themes = new Gee.ArrayList<string> ();
        themes.add_all_array (jorts.Constants.THEMES);

        if (skip_theme != null) {
            themes.remove(skip_theme);
        }

        var random_in_range = Random.int_range (0,(themes.size - 1));
        return themes[random_in_range];
    }


    /*************************************************/
    // Spits out a cute or funny random title for a new sticky note
    ///TRANSLATORS: It does not need to match source 1:1 - avoid anything that could be rude or cold sounding 
    public string random_title () {
        string[] alltitles = {
            _("All my very best friends"),
            _("My super good secret recipe"),
            _("My todo list"),
            _("Super secret to not tell anyone"),
            _("My grocery list"),
            _("Random shower thoughts"),
            _("My fav fanfics"),
            _("My fav dinosaurs"),
            _("My evil mastermind plan"),
            _("What made me smile today"),
            _("Hello world!"),
            _("New sticky, new me"),
            _("Hidden pirate treasure"),
            _("To not forget, ever"),
            _("Dear Diary,"),
            _("Hi im a square"),
            _("Have a nice day! :)"),
            _("My meds schedule"),
            _("Household chores"),
            _("Ode to my cat"),
            _("My dogs favourite toys"),
            _("How cool my birds are"),
            _("Suspects in the Last Cookie affair"),
            _("Words my parrots know"),
            _("Cool and funny compliments to give out"),
            _("Ok, listen here,"),
            _("My dream Pokemon team"),
            _("My little notes"),
            _("Surprise gift list"),
            _("Brainstorming notes"),
            _("To bring to the party"),
            _("My amazing mixtape"),
            _("Napkin scribblys"),
            _("My fav songs to sing along"),
            _("When to water which plant"),
            _("Top 10 anime betrayals"),
            _("Amazing ascii art!")
        };
        return alltitles[Random.int_range (0,(alltitles.length - 1))];
    }

    /*************************************************/
    // Spits out a cute or funny random title for a new sticky note
    public string random_emote (string? skip_emote) {

        Gee.ArrayList<string> allemotes = new Gee.ArrayList<string> ();
        allemotes.add_all_array (jorts.Constants.EMOTES);

        if (skip_emote != null) {
            allemotes.remove(skip_emote);
        }
    
        var random_in_range = Random.int_range (0,(allemotes.size - 1));
        return allemotes[random_in_range];
    }


    /*************************************************/
    // Spits out a fresh new note
    public noteData random_note (string? skip_theme) {
        debug("Generating random note... Skip:" + skip_theme);
        var randtitle = jorts.Utils.random_title();
        string randtheme = jorts.Utils.random_theme (skip_theme);
        noteData randnote = new noteData( randtitle, randtheme, "", jorts.Constants.DEFAULT_ZOOM);
        return randnote; 
    }
}