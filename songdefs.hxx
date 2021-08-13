/* songdefs.hxx  */
/* Created by Laurence D. Finston 20.10.2017  */

/* * Copyright and License.*/

/* This file is part of Songlist, a package for keeping track of songs. */
/* Copyright (C) 2021 Laurence D. Finston */

/* songlist is free software; you can redistribute it and/or modify */
/* it under the terms of the GNU General Public License as published by */
/* the Free Software Foundation; either version 3 of the License, or */
/* (at your option) any later version. */

/* songlist is distributed in the hope that it will be useful, */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/* GNU General Public License for more details. */

/* You should have received a copy of the GNU General Public License */
/* along with songlist; if not, write to the Free Software */
/* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA */

/* Please send bug reports to Laurence.Finston@gmx.de */

using namespace std;

class Song;

bool compare_titles(const Song&, const Song&);

bool compare_lyricists(const Song&, const Song&);

bool compare_composers(const Song&, const Song&);

bool compare_strings(string, string);

int process_tocs_and_npt(void);


/* !!START HERE:  LDF 2021.08.13.  Add production_subtitle.  */ 

class Song
{
    friend int main(int arg, char **argv);

    friend void get_songs(vector<Song> &);
    
    friend bool compare_titles(const Song&, const Song&);

    friend bool compare_lyricists(const Song&, const Song&);

    friend bool compare_composers(const Song&, const Song&);

    friend bool compare_productions(const Song& t, const Song& s);

    friend int process_tocs_and_npt(void);

    int song_ctr;
    string title;
    string subtitle;
    string words;
    string words_reverse;
    string music;
    string music_reverse;
    string words_and_music;
    string words_and_music_reverse;
    bool lead_sheet;
    bool partial_lead_sheet;
    bool no_page_turns;
    bool no_page_turns_with_two_songbooks;
    bool arrangement_orchestra;
    bool arrangement_solo_guitar;
    unsigned short recordings;
    string opera;
    string operetta;
    string song_cycle;
    string musical;
    string revue;
    string film;
    bool sort_by_production;
    int year;
    string copyright;
    string notes;
    bool mark_blue;
    bool is_production;
    bool scanned;
    string scanned_filename;
    bool public_domain;
    string language;
    bool is_cross_reference;
    string target;
    string production;
    string production_subtitle;
    bool do_filecard;
    string filecard_title;
    bool number_filecards;
    string source;
    string eps_filenames;

    vector<Song> production_song_vector;
    
 public:
   
    /* default constructor  */
    
    Song(void) 
    {
         title = "";
         subtitle = "";
	 words = "";
	 words_reverse = "";
	 music = "";
	 music_reverse = "";
	 words_and_music = "";
	 words_and_music_reverse = "";
    	 lead_sheet = false;
	 partial_lead_sheet = false;
	 no_page_turns = false;
	 no_page_turns_with_two_songbooks = false;
	 opera = "";
	 operetta = "";
	 song_cycle = "";
	 musical = "";
	 revue = "";
	 film = "";
	 bool sort_by_production = false;
    	 arrangement_solo_guitar = 0;
     	 recordings = 0;
         year = 0;
    	 copyright = "";
	 notes = "";
    	 mark_blue = false;
	 is_production = false;
         scanned = false;
         scanned_filename = "";
         public_domain = false;
         language = "english";
         is_cross_reference = false;
         target = "";
         production = "";
         production_subtitle = "";
         do_filecard = false;
         filecard_title = "";
         number_filecards = false;
         source = "";
         eps_filenames = "";
         return;
    }

/* copy constructor  */
    
    Song(const Song &s) 
    {
      title = s.title;
      subtitle = s.subtitle;
      words = s.words;
      words_reverse = s.words_reverse;
      music = s.music;
      music_reverse = s.music_reverse;
      words_and_music = s.words_and_music;
      words_and_music_reverse = s.words_and_music_reverse;
      lead_sheet = s.lead_sheet;
      partial_lead_sheet = s.partial_lead_sheet;
      no_page_turns = s.no_page_turns;
      no_page_turns_with_two_songbooks = s.no_page_turns_with_two_songbooks;
      opera = s.opera;
      operetta = s.operetta;
      song_cycle = s.song_cycle;
      musical = s.musical;
      revue = s.revue;
      film = s.film;
      sort_by_production = s.sort_by_production;
      arrangement_solo_guitar = s.arrangement_solo_guitar;
      recordings = s.recordings;
      year = s.year;
      copyright = s.copyright;
      notes = s.notes;
      mark_blue = s.mark_blue;
      is_production = s.is_production;
      production_song_vector = s.production_song_vector;
      scanned = s.scanned;
      scanned_filename = s.scanned_filename;
      public_domain = s.public_domain;
      language = s.language;
      is_cross_reference = s.is_cross_reference;
      target = s.target;
      production = s.production;
      production_subtitle = s.production_subtitle;
      do_filecard = s.do_filecard;
      filecard_title = s.filecard_title;
      number_filecards = s.number_filecards;
      source = s.source;
      eps_filenames = s.eps_filenames;

      return;
    }

    void show(string s = "");

    void clear(void);
    
};  /* End of |class Song| definition  */


/* ** (2) class Production */

class Production
{
    private:

       string title;
       string subtitle;
       string words;
       string music;
       string words_and_music;
       int type;
       string ttypename; 
       int year;
       string copyright;
       string notes;
       bool public_domain;
       string language;
       bool do_filecard;
       string filecard_title;
       bool number_filecards;

    public: 
       Production(void);
       Production(const Production&);

       void clear(void);
       void show(string s = "");

};  /* End of |class Production| definition  */


typedef Song Production_Song;

extern vector<Song> song_vector;


/* * (1) Emacs-Lisp code for use in indirect buffers when using the          */
/*       GNU Emacs editor.  The local variable list is not evaluated when an */
/*   	 indirect buffer is visited, so it's necessary to evaluate the       */
/*   	 following s-expression in order to use the facilities normally      */
/*   	 accessed via the local variables list.                              */
/*   	 \initials{LDF 2004.02.12}.                                          */
/*   	 (progn (cweb-mode) (outline-minor-mode t))                          */

/* * Local variables for Emacs.*/
/* Local Variables: */
/* mode:CWEB */
/* eval:(display-time) */
/* eval:(read-abbrev-file) */
/* indent-tabs-mode:nil */
/* eval:(outline-minor-mode) */
/* fill-column:80 */
/* End: */



