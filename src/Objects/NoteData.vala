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

// The NoteData object is just packaging to pass off data from and to storage
namespace Jorts {

    public class NoteData : Object {
        public string title;
        public string theme;
        public string content;
        public int zoom;
        public int width;
        public int height;

        public NoteData (
            string? title = null, string? theme = null, string? content = null,
            int? zoom = null, int? width = null, int? height = null)
        {

            // We assign defaults in case theres args missing
            this.title = title ?? Jorts.Utils.random_title ();
            this.theme = theme ?? Jorts.Utils.random_theme ();
            this.content = content ?? "";
            this.zoom = zoom ?? Jorts.Constants.DEFAULT_ZOOM;
            this.width = width ?? Jorts.Constants.DEFAULT_WIDTH;
            this.height = height ?? Jorts.Constants.DEFAULT_HEIGHT;
        }
    }
}
