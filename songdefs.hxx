/* songdefs.hxx  */
/* Created by Laurence D. Finston 20.10.2017  */

/* * Copyright and License.*/

/* This file is part of songlist, a package for keeping track of songs. */
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

bool compare_authors(const Song&, const Song&);

bool compare_strings(string, string);

int process_tocs_and_npt(void);

class Song
{
    friend int main(int arg, char **argv);

    friend void get_songs(vector<Song> &);
    
    friend bool compare_titles(const Song&, const Song&);

    friend bool compare_authors(const Song&, const Song&);

    friend int process_tocs_and_npt(void);

    int song_ctr;
    string title;
    string words;
    string music;
    string words_and_music;
    bool lead_sheet;
    bool partial_lead_sheet;
    bool no_page_turns;
    bool no_page_turns_with_two_songbooks;
    bool arrangement_orchestra;
    bool arrangement_solo_guitar;
    unsigned short recordings;
    string opera;
    string operetta;
    string musical;
    string revue;
    string film;
    bool sort_by_production;
    int year;
    string copyright;
    string notes;
    bool mark_blue;
    bool is_production;

    vector<string> title_vector;
    
 public:
   
    /* default constructor  */
    
    Song(void) 
    {
         title = "";
	 words = "";
	 music = "";
	 words_and_music = "";
    	 lead_sheet = false;
	 partial_lead_sheet = false;
	 no_page_turns = false;
	 no_page_turns_with_two_songbooks = false;
	 opera = "";
	 operetta = "";
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
	 
         return;
    }

/* copy constructor  */
    
    Song(const Song &s) 
    {
      title = s.title;
      words = s.words;
      music = s.music;
      words_and_music = s.words_and_music;
      lead_sheet = s.lead_sheet;
      partial_lead_sheet = s.partial_lead_sheet;
      no_page_turns = s.no_page_turns;
      no_page_turns_with_two_songbooks = s.no_page_turns_with_two_songbooks;
      opera = s.opera;
      operetta = s.operetta;
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
      title_vector = s.title_vector;

      return;
    }

    void show(string s = "");

    void clear(void);
    
};  /* End of |class Song| definition  */

typedef Song Production;



/* Local Variables:   */
/* mode:C             */
/* mode:show-paren    */
/* End:               */
