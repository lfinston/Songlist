/* songlist.cxx  */
/* Created by Laurence D. Finston 10.2017  */

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

#include <stdlib.h>
#include <stdio.h>

#include <string.h>

#include <sys/types.h>

#include <errno.h>
#include <ctype.h>

#include <string>
#include <iomanip>
#include <ios>
#include <iostream>
#include <stdarg.h>
#include <limits.h>
#include <algorithm>
#include <fstream>
#include <iterator>
#include <math.h>
#include <sstream> 
#include <time.h> 
#include <vector> 
#include <map>

#include <mysql.h>

/* #include <deque>   */
/* #include <stack>   */
/* #include <set>     */

#if HAVE_CONFIG_H
#include "config.h"
#endif

#include "songdefs.hxx"
// #include "glblvars.hxx"
#include "cmdlnopt.hxx"

MYSQL_RES *result = 0;
MYSQL_ROW curr_row = 0;
MYSQL *mysql;
  
unsigned int row_ctr = 0; 
unsigned int field_ctr = 0;
long affected_rows = 0;

string datestamp_short;
string datestamp;

/* Function declarations  */

int
get_datestamp(string &datestamp, string &datestamp_short);

int
submit_mysql_query(string query_str);

bool
pair_int_greater_than(pair<int, string> a, pair<int, string> b)
{
   return a.first > b.first;
}

bool
pair_string_less_than(pair<int, string> a, pair<int, string> b)
{
   return compare_strings(a.second, b.second);
}

string
remove_formatting_commands(string s);

/* main definition */

/* ** (2) |main| definition  */
int
main(int argc, char **argv)
{
/* *** (3)   */

   bool DEBUG = false; /* |true|  */

   int status;

   int prev_ctr;
   int curr_ctr;
   int next_ctr;

   vector<pair<int, string> > ctr_composer_vector;
   vector<pair<int, string> > ctr_lyricist_vector;

   stringstream temp_strm;

   ofstream composers_file;
   ofstream lyricists_file;
   ofstream scanned_file;
   ofstream public_domain_file;

   cerr << "This is `songlist'." << endl;
   
   if (DEBUG)
     cerr << "Entering `main'." << endl;

/* ***** (5) Process command-line options.  */

   errno = 0;
   status = process_command_line_options(argc, argv);

   if (status != 0)
   {
       cerr << "ERROR!  In `main':  `process_command_line_options' failed, returning " 
            << status << ":" << endl
            << strerror(errno)
            << endl
            << "Exiting `songlist' unsuccessfully with exit status 1."
            << endl;

       exit(1);

   }
   else if (DEBUG)
   {
       cerr << "In `main':  `process_command_line_options' succeeded, returning 0." 
            << endl;

   }
 
/* ** (2) Initialize  |mysql|  */

   mysql = mysql_init(0);

   if (mysql != 0)
     {
       if (DEBUG) 
	 cerr << "mysql_init succeeded." << endl;
     }
   else
     {
       cerr << "ERROR!  In `main': `mysql_init failed'." << endl
	    << "Exiting `songlist' unsuccessfully with exit status 1."
	    << endl;

       exit(1);
     }

   unsigned int mysql_timeout = 120;
  
   // mysql_options(mysql, MYSQL_OPT_RECONNECT, 0);

   mysql_options(mysql, MYSQL_OPT_CONNECT_TIMEOUT, &mysql_timeout); 
  
   if (!mysql_real_connect(mysql,"localhost","songlist",0,"Songs",0,NULL,0))
     {
       fprintf(stderr, "Failed to connect to database: Error: %s\n",
	       mysql_error(mysql));
     }

   errno = 0;

   affected_rows = 0L;

   status = get_datestamp(datestamp, datestamp_short);

   if (DEBUG) 
     cerr << "datestamp == \"" << datestamp << "\"" << endl
	  << "datestamp_short == \"" << datestamp_short << "\"" 
	  << endl;

   status = process_tocs_and_npt();

   if (status != 0)
     {
       cerr << "ERROR!  In `main':  `process_tocs_and_npt' failed, returning "
	    << status << "." << endl
	    <<  "Exiting `songlist' unsuccessfully with exit status 1."
            << endl;

       mysql_close(mysql);
       mysql_library_end();

       exit(1);
       
     }
   
   else if (DEBUG)
     {
       cerr << "In `main':  `process_tocs_and_npt' succeeded, returning 0."
            << endl;
     }
   
/* *** (3)  Print out list of songs, ordered by composer  */

     composers_file.open("composers.tex");

     composers_file << "%% composers.tex" << endl                                              
                    << "%% Generated by `songlist' " << datestamp << endl << endl        
                    << "\\ifseparate" << endl
                    << "\\pageno=1" << endl
                    << "\\fi" << endl
                    << "\\pagecnt=\\pageno" << endl
                    << "\\parskip=.75\\baselineskip" << endl
                    << "\\medium" << endl
                    << "\\headline={\\hfil \\ifnum\\pageno>\\pagecnt{\\mediumbx Songs by Composer}\\fi" << endl
                    << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl
                    << "\\hldest{xyz}{}{composers}" << endl 
                    << "\\centerline{{\\largebx Songs by Composer}}" << endl
                    << "\\vskip.75\\baselineskip" << endl
                    << "\\doublecolumns" << endl << endl;

     if (DEBUG)
     {
         cerr << "In `main':  `song_vector.size()' == " << song_vector.size()
              << endl;
     }

     stable_sort(song_vector.begin(), song_vector.end(), compare_composers);

     

     if (DEBUG)
     { 
        if (song_vector.size() > 0)
           cerr << "Showing `song_vector'." << endl;
     } 

     string previous_composer = "";

     bool first_time = true;

     int ctr = 1;

     vector<Song>::iterator next;

     next = song_vector.begin();
     ++next;

     string curr_composer;
     string next_composer;

     for (vector<Song>::iterator iter = song_vector.begin();
          iter != song_vector.end();
          ++iter, ++next)
     {
            if (iter->is_production || iter->is_cross_reference)
            {
                continue;
            }

            curr_composer = "";
            next_composer = "";

            if (iter->music_reverse != "")
               curr_composer = iter->music_reverse;
            else if (iter->words_and_music_reverse != "")
               curr_composer = iter->words_and_music_reverse;

#if 0 
            cerr << "curr_composer == " << curr_composer << endl
                 << "title         == " << iter->title << endl;
#endif 

            if (curr_composer == "")
            {  
                cerr << "WARNING!  Composer(s) not listed:" << endl 
                     << "   Title: " << iter->title << endl;
                previous_composer = "";

                continue;
            }

            if (next != song_vector.end())
            {
 
               if (next->music_reverse != "")
                  next_composer = next->music_reverse;
               else if (next->words_and_music_reverse != "")
                  next_composer = next->words_and_music_reverse;
               if (DEBUG)
               {
                  cerr << "`next_composer' == " << next_composer << endl; 
               } 
            }

            if (DEBUG)
               cerr << "Composer(s):  " << curr_composer << endl 
                    << "   Title:  " << iter->title << endl;
            
            if (curr_composer != previous_composer)
            {
               if (!first_time)
               { 
                  composers_file << "}\\vskip\\parskip" << endl;
               }
               
               composers_file << "\\vbox{\\hbox{{\\mediumbx " << curr_composer << "}}" 
                              << endl; 
            }

            composers_file << "\\hbox{\\hskip1.5em ";

            if (   (next != song_vector.end() && (next_composer == curr_composer || ctr > 1))
                || (next == song_vector.end() && ctr > 1))
            {
                 composers_file << "\\hbox to \\twozerosdimen{";
                 if (ctr < 10)
                    composers_file << "\\hfil ";

                 composers_file << ctr << "}. ";
            }

            if (next != song_vector.end() && next_composer != curr_composer)
            {
               ctr_composer_vector.push_back(make_pair(ctr, curr_composer));

               ctr = 1;  
            }
            else if (next == song_vector.end())
            {
               ctr_composer_vector.push_back(make_pair(ctr, curr_composer));
            }
            else
               ctr++;

            composers_file << iter->title << "}" << endl;

            previous_composer = curr_composer;

#if 0
            iter->show("Song:");
#endif
            first_time = false;
               
     }  /* for  */

     composers_file << "}\\singlecolumn" << endl << "\\vfil\\eject" << endl << endl
                    << "\\begingroup" << endl
                    << "\\baselineskip=0pt" << endl
                    << "\\parskip=4pt" << endl
                    << "\\composerskip=2pt" << endl
                    << "\\lyricistskip=2pt" << endl
                    << "\\pagecnt=\\pageno" << endl
                    << "\\global\\headline={\\hfil\\ifnum\\pageno>\\pagecnt{\\mediumbx Composers by Number of Songs}\\fi" << endl 
                    << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl 
                    << "\\Section{composers by number}{Composers By Number of Songs}" << endl 
                    << "\\hldest{xyz}{}{composers by number}" << endl 
                    << "\\centerline{{\\largebx Composers by Number of Songs}}" << endl
                    << "\\vskip.75\\baselineskip" << endl                                
                    << "\\doublecolumns"
                    << endl << endl;

/* *** (3)  */

     sort(ctr_composer_vector.begin(), ctr_composer_vector.end(), pair_string_less_than);
     stable_sort(ctr_composer_vector.begin(), ctr_composer_vector.end(), pair_int_greater_than);

#if 0 
     cerr << "`ctr_composer_vector.size()' == " << ctr_composer_vector.size() << endl
          << "`ctr_composer_vector':" << endl;

     cerr << "ctr_composer_vector.back().first == " << ctr_composer_vector.back().first << endl
          << "ctr_composer_vector.back().second == "
          << ctr_composer_vector.back().second << endl;
#endif 

     curr_ctr = 0;
     prev_ctr = 0;
     next_ctr = ctr_composer_vector.begin()->first;

     for (vector<pair<int, string> >::iterator iter = ctr_composer_vector.begin();
          iter != ctr_composer_vector.end();
          ++iter)
     {
        prev_ctr = curr_ctr;
        curr_ctr = next_ctr;

        if ((iter + 1) != ctr_composer_vector.end())
           next_ctr = (iter + 1)->first;

        if (curr_ctr != prev_ctr)
        {
            if (prev_ctr > 0)
               composers_file << "\\vskip6pt" << endl;

            composers_file << "\\leavevmode\\hbox to \\twozerosbolddimen{\\hss{\\mediumbx " << curr_ctr << "}}\\hskip.5em " 
                           << iter->second << "\\hfil\\break" << endl;

        }
        else
           composers_file << "\\hbox{}\\hskip\\twozerosbolddimen\\hskip.5em " << iter->second << "\\hfil\\break"
                          << endl;

     }

#if 0 
     cerr << endl;
#endif 

     composers_file << endl << "\\singlecolumn" 
                    << "\\endgroup" << endl
                    << "\\vfil\\eject" << endl
                    << "\\ifseparate" << endl
                    << "\\else" << endl
                    << "\\pagecnt=\\pageno" << endl
                    << "\\fi" << endl
                    << "\\endinput" << endl << endl;

     composers_file.close();

/* *** (3)  Print out list of songs, ordered by lyricist  */

     sort(song_vector.begin(), song_vector.end(), compare_titles);

     stable_sort(song_vector.begin(), song_vector.end(), compare_lyricists);

     lyricists_file.open("lyricists.tex");

     lyricists_file << "%% lyricists.tex" << endl                                              
                    << "%% Generated by `songlist' " << datestamp << endl << endl        
                    << "\\ifseparate" << endl
                    << "\\pageno=1" << endl
                    << "\\fi" << endl
                    << "\\pagecnt=\\pageno" << endl
                    << "\\parskip=.75\\baselineskip" << endl
                    << "\\medium" << endl
                    << "\\headline={\\hfil\\ifnum\\pageno>\\pagecnt{\\mediumbx Songs by Lyricist}\\fi"
                    << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl 
                    << "\\hldest{xyz}{}{lyricists}" << endl 
                    << "\\centerline{{\\largebx Songs by Lyricist}}" << endl 
                    << "\\vskip.75\\baselineskip" << endl
                    << "\\doublecolumns" << endl << endl;

     if (DEBUG)
     {
         cerr << "In `main':  `song_vector.size()' == " << song_vector.size()
              << endl;
     }

     if (DEBUG)
     { 
        if (song_vector.size() > 0)
           cerr << "Showing `song_vector'." << endl;
     } 

     string previous_lyricist = "";
     string curr_lyricist = "";
     string next_lyricist = "";

     first_time = true;

     ctr = 1;

     next = song_vector.begin();
     ++next;

     for (vector<Song>::iterator iter = song_vector.begin();
          iter != song_vector.end();
          ++iter, ++next)
     {
            if (iter->is_production || iter->is_cross_reference)
            {
                continue;
            }

            curr_lyricist = "";
            next_lyricist = "";

            if (iter->words_reverse != "")
               curr_lyricist = iter->words_reverse;
            else if (iter->words_and_music_reverse != "")
               curr_lyricist = iter->words_and_music_reverse;

            if (curr_lyricist == "")
            {  
                cerr << "WARNING!  Lyricist(s) not listed:" << endl 
                     << "   Title: " << iter->title << endl;
                previous_lyricist = "";

                continue;
            }

            if (next != song_vector.end())
            {
 
               if (next->words_reverse != "")
                  next_lyricist = next->words_reverse;
               else if (next->words_and_music_reverse != "")
                  next_lyricist = next->words_and_music_reverse;

               if (DEBUG)
               {
                  cerr << "`next_lyricist' == " << next_lyricist << endl;
               } 
            }

            if (DEBUG)
               cerr << "Lyricist(s):  " << curr_lyricist << endl 
                    << "   Title:  " << iter->title << endl;
            
            if (curr_lyricist != previous_lyricist)
            {
               if (!first_time)
               { 
                  lyricists_file << "}\\vskip\\parskip" << endl;
               }
               
               lyricists_file << "\\vbox{\\hbox{{\\mediumbx " << curr_lyricist << "}}" 
                              << endl; 
            }

            lyricists_file << "\\hbox{\\hskip1.5em ";

            if (   (next != song_vector.end() && (next_lyricist == curr_lyricist || ctr > 1))
                || (next == song_vector.end() && ctr > 1))
            {
                 lyricists_file << "\\hbox to \\twozerosdimen{";
                 if (ctr < 10)
                    lyricists_file << "\\hfil ";

                 lyricists_file << ctr << "}. ";
            }

            if (next != song_vector.end() && next_lyricist != curr_lyricist)
            {
               ctr_lyricist_vector.push_back(make_pair(ctr, curr_lyricist));

               ctr = 1;  
            }
            else if (next == song_vector.end())
            {
               ctr_lyricist_vector.push_back(make_pair(ctr, curr_lyricist));
            }
            else
               ctr++;

            lyricists_file << iter->title << "}" << endl;

            previous_lyricist = curr_lyricist;

#if 0
            iter->show("Song:");
#endif
            first_time = false;
               
     }  /* for  */

     lyricists_file << "}\\singlecolumn" << endl << "\\vfil\\eject" << endl << endl
                    << "\\begingroup" << endl
                    << "\\baselineskip=0pt" << endl
                    << "\\parskip=4pt" << endl
                    << "\\composerskip=2pt" << endl
                    << "\\lyricistskip=2pt" << endl
                    << "\\pagecnt=\\pageno" << endl
                    << "\\global\\headline={\\hfil \\ifnum\\pageno>\\pagecnt{\\mediumbx Lyricists by Number of Songs}\\fi\\hfil" << endl 
                    << "\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl 
                    << "\\Section{lyricists by number}{Lyricists By Number of Songs}" << endl 
                    << "\\hldest{xyz}{}{lyricists by number}" << endl 
                    << "\\centerline{{\\largebx Lyricists by Number of Songs}}" << endl
                    << "\\vskip.75\\baselineskip" << endl                                
                    << "\\doublecolumns"
                    << endl << endl;

/* *** (3)  */

     sort(ctr_lyricist_vector.begin(), ctr_lyricist_vector.end(), pair_string_less_than);
     stable_sort(ctr_lyricist_vector.begin(), ctr_lyricist_vector.end(), pair_int_greater_than);

#if 0 
     cerr << "`ctr_lyricist_vector.size()' == " << ctr_lyricist_vector.size() << endl
          << "`ctr_lyricist_vector':" << endl;
#endif 

     curr_ctr = 0;
     prev_ctr = 0;
     next_ctr = ctr_lyricist_vector.begin()->first;

     for (vector<pair<int, string> >::iterator iter = ctr_lyricist_vector.begin();
          iter != ctr_lyricist_vector.end();
          ++iter)
     {
        prev_ctr = curr_ctr;
        curr_ctr = next_ctr;

        if ((iter + 1) != ctr_lyricist_vector.end())
           next_ctr = (iter + 1)->first;

        if (curr_ctr != prev_ctr)
        {
            if (prev_ctr > 0)
               lyricists_file << "\\vskip6pt" << endl;

            lyricists_file << "\\leavevmode\\hbox to \\twozerosbolddimen{\\hss{\\mediumbx " 
                           << curr_ctr << "}}\\hskip.5em ";

        }
        else
           lyricists_file << "\\hbox{}\\hskip\\twozerosbolddimen\\hskip.5em ";

        /* Bug fix:  If there was no comma in |iter->second|, e.g., if it was
           "None" or "Unknown", the vertical spacing between the corresponding line
           and the following line was too small.  In this case, an empty \vbox with the
           depth of `\commabox' (defined in `songlist.mac') is inserted at the beginning
           of the line using `\vtop'.
           LDF 2021.06.14.  */

        if (iter->second.find(",") == string::npos)
           lyricists_file << "\\vtop to \\dp\\commabox{\\vfil}";

        lyricists_file << iter->second << "\\hfil\\break"
                       << endl;

     }  /* |for|  */

/* *** (3) */

#if 0 
     cerr << endl;
#endif 

     lyricists_file << endl << "\\singlecolumn" << endl 
                    << "\\endgroup" << endl
                    << "\\vfil\\eject" << endl
                    << "\\ifseparate" << endl
                    << "\\else" << endl
                    << "\\pagecnt=\\pageno" << endl
                    << "\\fi" << endl
                    << "\\endinput" << endl << endl;

     lyricists_file.close();

/* *** (3)  Print out scanned files.  */

/* !!START HERE Laurence D. Finston (LDF) Wed 26 May 2021 08:32:13 PM CEST */ 

     scanned_file.open("scanned.tex");

     scanned_file << "%% scanned.tex" << endl                                              
                  << "%% Generated by `songlist' " << datestamp << endl << endl        
                  << "\\ifseparate" << endl
                  << "\\pageno=1" << endl
                  << "\\fi" << endl
                  << "\\pagecnt=\\pageno" << endl
                  << "\\parskip=.75\\baselineskip" << endl
                  << "\\advance\\hsize by -.75cm" << endl 
                  << "\\medium" << endl
                  << "\\headline={\\hfil \\ifnum\\pageno>\\pagecnt{\\mediumbx Scanned Lead Sheets}\\fi" << endl 
                  << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl
                  << "\\hldest{xyz}{}{scanned}" << endl 
                  << "\\centerline{{\\largebx Scanned Lead Sheets}}" << endl
                  << "\\vskip.75\\baselineskip" << endl
                  << "\\begingroup" << endl
                  << "\\dimen0=\\vsize" << endl
                  << "\\advance\\dimen0 by -2\\baselineskip" << endl
                  << "\\vbox to 0pt{\\vbox to \\vsize{\\vskip\\dimen0" << endl 
                  << "\\line{${}^{\\dag}$ \\Blue{Public domain}\\hfil}\\vss}\\vss}" << endl
                  << "\\endgroup" << endl
                  << "\\songctr=1" << endl
                  << "\\doublecolumns" << endl 
                  << "\\obeylines" << endl;

     if (DEBUG)
     {
         cerr << "In `main':  `song_vector.size()' == " << song_vector.size()
              << endl;
     }

     char prev_title_char;
 
     sort(song_vector.begin(), song_vector.end(), compare_titles);

     for (vector<Song>::iterator iter = song_vector.begin();
          iter != song_vector.end();
          ++iter, ++next)
     {
         if (iter->scanned == true)
         {
#if 0 
             cerr << iter->title << " ... "
                  << endl 
                  << "iter->title[0] == " << iter->title[0] << endl 
                  << "prev_title_char == " << prev_title_char << endl;
#endif 

             if (iter->scanned_filename.size() > 0)
             {

#if 0 
                cerr << iter->scanned_filename << endl;

                if (tolower(prev_title_char) == 's' && tolower(iter->title[0]) == 't')
                { 
                   cerr << endl 
                        << "iter->title[0] == " << iter->title[0] << endl 
                        << "prev_title_char == " << prev_title_char << endl;
 

                   scanned_file << "%%" << endl 
                                << "%% !! The following line of TeX code causes `scanned.tex' to be split at this point," << endl 
                                << "%% i.e., between \"S\" and \"T\"" << endl 
                                << "%% If the number of scanned lead sheets changes, it may be possible to remove" << endl 
                                << "%% the code that causes this from the function `main' in `songlist.cxx'." << endl 
                                << "%% LDF 2021.05.30." << endl 
                                << "\\singlecolumn\\vfil\\eject\\doublecolumns" << endl
                                << "%% End of code for \"manual\" splitting." << endl
                                << "%%" << endl;
                }
#endif 
                scanned_file << "\\SCANNED{" << iter->title;
                
                if (iter->public_domain == true)
                   scanned_file << "${}^{\\dag}$";

                scanned_file << "}{"
                             << iter->scanned_filename << "}" 
                             << "{" << iter->public_domain << "}" << endl;

                prev_title_char = iter->title[0];
             }
             else
                cerr << "WARNING!  `iter->scanned_filename' is empty." << endl;
         }            

     }  /* |for|  */

     scanned_file << endl << "\\singlecolumn" << endl 
                  << "\\vfil\\eject" << endl
                  << "\\ifseparate" << endl
                  << "\\else" << endl
                  << "\\pagecnt=\\pageno" << endl
                  << "\\fi" << endl
                  << "\\advance\\hsize by .75cm" << endl 
                  << "\\endinput" << endl << endl;

     scanned_file.close();

/* *** (3)  Print out public domain songs.  */

     public_domain_file.open("pblcdomn.tex");

     public_domain_file << "%% pblcdomn.tex" << endl                                              
                        << "%% Generated by `songlist' " << datestamp << endl << endl        
                        << "\\ifseparate" << endl
                        << "\\pageno=1" << endl
                        << "\\fi" << endl
                        << "\\pagecnt=\\pageno" << endl
                        << "\\begingroup" << endl
                        << "\\advance\\baselineskip by 2pt" << endl
                        << "\\parskip=0pt" << endl
                        << "\\medium" << endl
                        << "\\headline={\\hfil \\ifnum\\pageno>\\pagecnt{\\mediumbx Public Domain Songs}\\fi" << endl
                        << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl
                        << "\\hldest{xyz}{}{public domain}" << endl 
                        << "\\centerline{{\\largebx Public Domain Songs}}" << endl
                        << "\\vskip.75\\baselineskip" << endl
                        << "\\setbox0=\\hbox{{\\medium 0000}}" << endl
                        << "\\dimen0=\\wd0" << endl
                        << "\\setbox0=\\hbox{{\\mediumtt xxxxxxxx.xxx}}" << endl
                        << "\\dimen1=\\wd0" << endl
                        << "\\advance\\dimen1 by 5em" << endl
                        << "\\songctr=1" << endl
                        << "%\\doublecolumns" << endl
                        << "\\obeylines" << endl;
     if (DEBUG)
     {
         cerr << "In `main':  `song_vector.size()' == " << song_vector.size()
              << endl;
     }

#if 0 
     /* This is currently not necessary, because `song_vector' is sorted above.
        This line is left in here in case something changes that would make
        resorting necessary.  LDF 2021.05.24.  */

     sort(song_vector.begin(), song_vector.end(), compare_titles);
#endif 

#if 0 
     cerr << endl << "Public Domain songs:" << endl << endl;
#endif 


     for (vector<Song>::iterator iter = song_vector.begin();
          iter != song_vector.end();
          ++iter, ++next)
     {
         if (iter->public_domain == true)
         {
#if 0 
             cerr << iter->title;
#endif 
             public_domain_file << "\\M " << "\\hbox to .5\\hsize{" << iter->title;

             if (iter->year > 0 || (iter->scanned && iter->scanned_filename.size() > 0))
                public_domain_file << "\\leaderfill ";
              
             if (iter->year > 0)
                public_domain_file << iter->year;
             else
                public_domain_file << "\\hbox to \\dimen0{\\leaderfill}";

             public_domain_file << "}";

             if (iter->scanned && iter->scanned_filename.size() > 0)
                public_domain_file << "\\hbox to \\dimen1{\\leaderfill\\HLP{" 
                                   << iter->scanned_filename << "}}";

             public_domain_file << endl;

#if 0 
             cerr << endl;
#endif 

         }            

     }  /* |for|  */

     public_domain_file << "\\endgroup" << endl 
                        << "%\\singlecolumn" << endl 
                        << "\\vfil\\eject" << endl
                        << "\\ifseparate" << endl
                        << "\\else" << endl
                        << "\\pagecnt=\\pageno" << endl
                        << "\\fi" << endl
                        << "\\endinput" << endl << endl;

     public_domain_file.close();

/* *** (3)  */

   /* Close connection to database.  */

   mysql_close(mysql);
   mysql_library_end();

   /* Exit  */

   cerr << "Exiting `songlist' successfully with exit status 0." << endl;
   
   exit(0);

/* *** (3)  */

}  /* End of |main| definition  */

/* |Song::show| definition */ 

void 
Song::show(string s)
{
  if (s == "")
     cerr << "Song:" << endl;
  else                 
     cerr << s << endl;
 
  cerr << "title:                            " << title << endl
       << "subtitle:                         " << subtitle << endl
       << "words:                            " << words << endl
       << "words_reverse:                    " << words_reverse << endl
       << "music:                            " << music << endl
       << "music_reverse:                    " << music_reverse << endl
       << "words_and_music:                  " << words_and_music << endl
       << "words_and_music_reverse:          " << words_and_music_reverse << endl
       << "lead_sheet:                       " << lead_sheet << endl
       << "partial_lead_sheet:               " << partial_lead_sheet << endl
       << "no_page_turns:                    " << no_page_turns << endl
       << "no_page_turns_with_two_songbooks: " << no_page_turns_with_two_songbooks << endl
       << "arrangement_solo_guitar:          " << arrangement_solo_guitar << endl
       << "recordings:                       " << recordings << endl
       << "year:                             " << year << endl
       << "copyright:                        " << copyright << endl
       << "musical:                          " << musical << endl
       << "opera:                            " << opera << endl
       << "operetta:                         " << operetta << endl
       << "song_cycle:                       " << song_cycle << endl
       << "revue:                            " << revue << endl
       << "film:                             " << film << endl
       << "notes:                            " << notes << endl      
       << "mark_blue:                        " << mark_blue << endl
       << "sort_by_production:               " << sort_by_production << endl      
       << "is_production:                    " << is_production << endl
       << "scanned:                          " << scanned << endl
       << "scanned_filename:                 " << scanned_filename << endl
       << "public_domain:                    " << public_domain << endl
       << "language:                         " << language << endl
       << "is_cross_reference:               " << is_cross_reference << endl
       << "target:                           " << target << endl
       << "production:                       " << production << endl
       << "production_subtitle:              " << production_subtitle << endl
       << "do_filecard:                      " << do_filecard << endl
       << "filecard_title:                   " << filecard_title << endl
       << "number_filecards:                 " << number_filecards << endl
       << "source:                           " << source << endl
       << "eps_filenames:                    " << eps_filenames << endl;

 
  if (production_song_vector.size() > 0)
     cerr << "production_song_vector is not empty." << endl;
  else        
     cerr << "production_song_vector is empty." << endl;

  cerr << endl;

  return;

}  /* End of |Show::show| definition.  */

/* |Song::clear| definition */ 

void 
Song::clear(void)
{
    song_ctr = 0;
    title = "";
    subtitle = "";
    words = "";
    words_reverse = "";
    music = "";
    music_reverse = "";
    words_and_music = "";
    words_and_music_reverse = "";
    lead_sheet = 0;
    partial_lead_sheet = 0;
    no_page_turns = 0;
    no_page_turns_with_two_songbooks = 0;
    arrangement_orchestra = 0;
    arrangement_solo_guitar = 0;
    recordings = 0;
    musical = "";
    opera = "";
    operetta = "";
    song_cycle = "";
    revue = "";
    film = "";
    sort_by_production = 0;
    year = 0;
    copyright = "";
    mark_blue = 0;
    notes = "";
    is_production = false;
    scanned = false;
    scanned_filename = "";
    public_domain = false;
    language = "";
    is_cross_reference = false;
    target ="";
    production = "";
    production_subtitle = "";
    do_filecard = false;
    filecard_title = "";
    number_filecards = false;
    source = "";
    eps_filenames = "";
    production_song_vector.clear();
    
    return;

}  /* End of |Song::clear| definition.  */

/* |get_datestamp| definition  */

int
get_datestamp(string &datestamp, string &datestamp_short)
{
    bool DEBUG = false;  /* |true|  */

    char outstr[64];

    memset(outstr, 0, 64);

    time_t t;
    struct tm tmp;

    t = time(NULL);

    if (localtime_r(&t, &tmp) == 0) 
    {
        cerr << "ERROR!  In `get_datestamp':  `localtime_r' failed, returning 0:"
             << endl
             << "Not creating datestamps.  Exiting function return value 1."
             << endl;

        return 1;

    }

    if (strftime(outstr, sizeof(outstr), "%a, %d %b %Y %T %Z", &tmp) == 0) 
    {
        cerr << "ERROR!  In `get_datestamp':  `strftime' failed, returning 0."
             << endl
             << "Not creating datestamps.  Exiting function with return value 1."
             << endl;

        return 1;

    }

    datestamp = outstr;

    memset(outstr, 0, 64);

    if (strftime(outstr, sizeof(outstr), "%Y.%m.%d", &tmp) == 0) 
    {
        cerr << "ERROR!  In `get_datestamp':  `strftime' failed, returning 0."
             << endl
             << "Not creating datestamps.  Exiting function with return value 1."
             << endl;

        return 1;

    }
    
    datestamp_short = outstr;

    if (DEBUG) 
    {
        cerr << "Result strings are:" << endl
             << "`datestamp'       == " << datestamp << endl
             << "`datestamp_short' == " << datestamp_short << endl;

    }  /* |else|  */

    return 0;

}  /* End of |get_datestamp| definition  */

int
submit_mysql_query(string query_str)
{
  int status = 0;

  bool DEBUG = false;  /* |true|  */

  if (DEBUG)
  { 
      cerr << "Entering `submit_mysql_query'." << endl;
  } 
  
  mysql_query(mysql, query_str.c_str());

   if (status != 0)
   {
        
     cerr  << "ERROR!  In `submit_mysql_query':"
           << endl 
           << "`mysql_query' failed, returning " << status << ":"
           << endl 
           << "Error:  " << mysql_error(mysql)
           << endl 
           << "Error number:  " << mysql_errno(mysql)
           << endl 
           << "Exiting function unsuccessfully with return value 1." 
           << endl;
        

     return 1;
       
   }  /* |if| (|mysql_query| failed.)  */

   result = mysql_store_result(mysql);        

   if (result == 0)
   {
     if (DEBUG)
       cerr << endl 
            << "`mysql_store_result' returned 0."
            << endl
            << "Exiting function with return value 0." 
            << endl;

     return 0;
          
   }  /* |if| (No result)  */
   
   row_ctr   = mysql_num_rows(result);
   field_ctr = mysql_num_fields(result);

   if (DEBUG)
   {
     cerr << "`row_ctr' == " << row_ctr 
          << endl
          << "`field_ctr' == " << field_ctr 
          << endl;

   }  /* |if (DEBUG)|  */
   
   affected_rows = (long) mysql_affected_rows(mysql);

   if (DEBUG)
   {
     
     cerr << "`affected_rows' == " << affected_rows
          << endl
          << "Exiting function with return value 0."
          << endl;
   }

   return 0;
   
}  /* |submit_mysql_query| definition */

/* |compare_titles| definition */

bool
compare_titles(const Song& t, const Song& s)
{
      if (t.title == s.title && t.is_production == false && s.is_production == true)
	return true;
      else if (t.title == s.title && t.is_production == true && s.is_production == false)
	return false;
      
      return compare_strings(t.title, s.title);

}  /* |end of compare_titles| definition */

/* * (1) |compare_composers| definition */

bool
compare_composers(const Song& s, const Song& t)
{
   string ss;
   string tt;

   if (s.music_reverse != "")
      ss = s.music_reverse;
   else if (s.words_and_music_reverse != "")
      ss = s.words_and_music_reverse;

   if (t.music_reverse != "")
      tt = t.music_reverse;
   else if (t.words_and_music_reverse != "")
      tt = t.words_and_music_reverse;

   return compare_strings(ss, tt);
 
}  /* |end of compare_composers| definition */

/* * (1) |compare_lyricists| definition */

bool
compare_lyricists(const Song& s, const Song& t)
{
   string ss;
   string tt;

   if (s.words_reverse != "")
      ss = s.words_reverse;
   else if (s.words_and_music_reverse != "")
      ss = s.words_and_music_reverse;

   if (t.words_reverse != "")
      tt = t.words_reverse;
   else if (t.words_and_music_reverse != "")
      tt = t.words_and_music_reverse;

   return compare_strings(ss, tt);
 
}  /* |end of compare_lyricists| definition */

/* * (1) |compare_strings| definition */

bool
compare_strings(string t, string s)
{
  size_t found_t;
  size_t found_s;

  bool found_flag = false;

  s = remove_formatting_commands(s);
  t = remove_formatting_commands(t);

  /* Replace ``42nd'' with ``forty-second''  */

  do
    {
      found_t = t.find("42nd");
      if (found_t != string::npos)
	{
	  found_flag = true;
	  t.replace(found_t, 4, "forty-second");

	}

      found_s = s.find("42nd");
      if (found_s != string::npos)
	{
	  found_flag = true;
	  s.replace(found_s, 4, "forty-second");
	}
    }  
    while (found_t != string::npos || found_s != string::npos);

  /* Replace ``14'' with ``fourteen'' (14 Lieder aus des Knaben Wunderhorn)  */

  do
    {
      found_t = t.find("14");
      if (found_t != string::npos)
	{
	  found_flag = true;
	  t.replace(found_t, 4, "fourteen");

	}

      found_s = s.find("14");
      if (found_s != string::npos)
	{
	  found_flag = true;
	  s.replace(found_s, 4, "fourteen");
	}
    }  
    while (found_t != string::npos || found_s != string::npos);

  char tc[64];
  char sc[64];
  memset(tc, 0, 64);
  memset(sc, 0, 64);
      
#if 0 
  if (found_flag)
    cerr << "t == " << t << endl
	 << "s == " << s << endl << endl;
#endif

  memset(tc, 0, 64);
  memset(sc, 0, 64);
      
  strncpy(tc, t.c_str(), t.length());
  strncpy(sc, s.c_str(), s.length());

#if 0 
  cerr << "tc == " << tc << endl;
  cerr << "sc == " << sc << endl;
#endif
  
  t = "";
  s = "";

  int i = 0;
      
  for (i = 0; i < strlen(tc); ++i)
    {
      t += tolower(tc[i]);
    }

  for (i = 0; i < strlen(sc); ++i)
    {
      s += tolower(sc[i]);
    }

#if 0 
  cerr << "tolower(t[0]) == " << tolower(t[0]) << endl
       << "tolower(s[0]) == " << tolower(s[0]) << endl;
  cerr << "t == " << t << endl;
  cerr << "s == " << s << endl;
#endif 

  bool b = t < s;

  return b;
  
}  /* End of |compare_strings| definition  */

bool
compare_productions(const Song& t, const Song& s)
{
   string tt;
   string ss;

   if (t.opera != "")
     tt = t.opera;
   if (s.opera != "")
     ss = s.opera;

   if (t.operetta != "")
     tt = t.operetta;
   if (s.operetta != "")
     ss = s.operetta;

   if (t.song_cycle != "")
     tt = t.song_cycle;
   if (s.song_cycle != "")
     ss = s.song_cycle;

   if (t.musical != "")
     tt = t.musical;
   if (s.musical != "")
     ss = s.musical;

   if (t.revue != "")
     tt = t.revue;
   if (s.revue != "")
     ss = s.revue;

   if (t.film != "")
     tt = t.film;
   if (s.film != "")
     ss = s.film;

   return compare_strings(tt, ss);


}  /* |end of compare_productions| definition */


/* ** (2) */

string 
remove_formatting_commands(string s)
{
  size_t found_s;

  bool found_flag = false;

  /* erase cedilla accents:  |"\c "|  */

  do
    {
      found_s = s.find("\\c ");
      if (found_s != string::npos)
	{
	  found_flag = true;
	  s.erase(found_s, 3);
	}
    }

  while (found_s != string::npos);

  /* Delete ``\\vbox{''  */

  do
    {
      found_s = s.find("\\vbox{");  /* }  */
      if (found_s != string::npos)
	{
	  found_flag = true;
	  s.erase(found_s, 6);
	}
    }
  while (found_s != string::npos);

  /* Delete ``\\vtop{''  }  */

  do
    {
      found_s = s.find("\\vtop{");  /* }  */
      if (found_s != string::npos)
	{
	  found_flag = true;
	  s.erase(found_s, 6);
	}
    }
  while (found_s != string::npos);

  /* Delete ``\\hbox{''  } */


  do
  {
    found_s = s.find("-.2\\baselineskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 16);
      }
  }
  while (found_s != string::npos);

  do
  {
    found_s = s.find(".375\\baselineskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 17);
      }
  }
  while (found_s != string::npos);

  do
  {
    found_s = s.find("\\hbox{");  /* }  */
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 6);
      }
  }
  while (found_s != string::npos);

  /* Delete ``\\vskip''  */

  do
  {
    found_s = s.find("\\vskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 6);
      }
  }
  while (found_s != string::npos);

  /* Delete ``\\hskip''  */

  do
  {
    found_s = s.find("\\hskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 6);
      }
  }
  while (found_s != string::npos);

  /* Delete ``\\baselineskip''  */

  do
  {
    found_s = s.find("\\baselineskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 13);
      }
  }
  while (found_s != string::npos);

  do
  {
    found_s = s.find("\\vskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 6);
      }
  }
  while (found_s != string::npos);

  do
  {
    found_s = s.find("\\titleskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 13);
      }
  }
  while (found_s != string::npos);

  do
  {
    found_s = s.find("\\copyrightskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 13);
      }
  }
  while (found_s != string::npos);

  do
  {
    found_s = s.find("\\composerskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 13);
      }
  }
  while (found_s != string::npos);

  do
  {
    found_s = s.find("\\lyricistskip");
    if (found_s != string::npos)
      {
        found_flag = true;
        s.erase(found_s, 13);
      }
  }
  while (found_s != string::npos);

  char sc[64];
  memset(sc, 0, 64);
      
  do
    {
      found_s = s.find_first_of("@()\\'`\"{}~-_^");
      if (found_s != string::npos)	  	  
	{
	  found_flag = true;
	  s.erase(found_s, 1);
	}
    } while (found_s != string::npos);

    return s;

}  /* End of |remove_formatting_commands| definition  */


/* *** (3) Default constructor  */

Production::Production(void)
{
       title = "";
       subtitle = "";
       words = "";
       music = "";
       words_and_music = "";
       type = 0;
       ttypename = ""; 
       year = 0;
       copyright = "";
       notes = "";
       public_domain = false;
       language = "english";
       do_filecard = true;
       filecard_title = "";
       number_filecards = false;

   return;
}

/* *** (3) Copy constructor  */

Production::Production(const Production& p)
{
   title            = p.title; 
   subtitle         = p.subtitle; 
   words            = p.words;
   music            = p.music;
   words_and_music  = p.words_and_music;
   type             = p.type;
   ttypename        = p.ttypename;
   year             = p.year;
   copyright        = p.copyright;
   notes            = p.notes;
   public_domain    = p.public_domain;
   language         = p.language;
   do_filecard      = p.do_filecard;
   filecard_title   = p.filecard_title;
   number_filecards = p.number_filecards;
   
   return;
}


/* *** (3) Clear  */

void
Production::clear(void)
{
   title = "";
   subtitle = "";
   words = "";
   music = "";
   words_and_music = "";
   type = 0;
   ttypename = ""; 
   year = 0;
   copyright = "";
   notes = "";
   public_domain = false;
   language = "english";
   do_filecard = true;
   filecard_title = "";
   number_filecards = false;

   return;
}

/* *** (3) Show */

void 
Production::show(string s)
{
   if (s.length() == 0)
      s = "Production:";

   cerr << s << endl
        << "title:             " << title << endl
        << "subtitle:          " << subtitle << endl
        << "words:             " << words << endl
        << "music:             " << music << endl
        << "words_and_music:   " << words_and_music << endl
        << "type:              " << type << endl
        << "ttypename:         " << ttypename << endl
        << "year:              " << year << endl
        << "copyright:         " << copyright << endl
        << "notes:             " << notes << endl
        << "public_domain:     " << public_domain << endl
        << "language:          " << language << endl
        << "do_filecard:       " << do_filecard << endl
        << "filecard_title:    " << filecard_title << endl
        << "number_filecards:  " << number_filecards << endl
        << endl;

   return;
}

/* ** (2) */

int
write_to_toc_sub_file(ofstream *toc_file_ptr, vector<Song>::iterator &iter, int two_or_three_digits)
{
/* *** (3) */

    bool DEBUG = false; /* |true|  */

    if (DEBUG)
    { 
       cerr << "Entering `write_to_toc_sub_file'." << endl;

       if (iter->production_subtitle.length() > 0)
       {
          cerr << "iter->production_subtitle == " << iter->production_subtitle << endl;
       }

    }  

    // *toc_file_ptr << endl;

    if (iter->is_cross_reference)
    {
       *toc_file_ptr << "\\vskip.5\\baselineskip\\vbox{" << "\\T " << iter->title;

       if (iter->subtitle.length() > 0)
          *toc_file_ptr << " " << iter->subtitle;
       
       *toc_file_ptr << endl
                       << "\\nobreak" << endl << "\\T (see  ``" << iter->target << "''";

       if (iter->production != "")
          *toc_file_ptr << "\\nobreak" << endl << "\\T under ``" << iter->production;

       if (iter->production_subtitle.length() > 0)
          *toc_file_ptr << " " << iter->production_subtitle;
       
       *toc_file_ptr << "''";

       *toc_file_ptr << ")}" << endl << endl;
    }
    else if (!iter->is_production)
    {
      *toc_file_ptr << "\\N " << iter->title;

      if (iter->subtitle.length() > 0)
         *toc_file_ptr << " " << iter->subtitle;

      *toc_file_ptr << endl;
    }
    
    if (iter->musical.length() > 0 && iter->sort_by_production)
    {
      *toc_file_ptr << "\\nobreak" << endl << "\\T (see under ``" << iter->musical;

      if (iter->production_subtitle.length() > 0)
          *toc_file_ptr << " " << iter->production_subtitle;

      *toc_file_ptr << "'')" << endl;
    }
    else if (iter->opera.length() > 0 && iter->sort_by_production)
    {
      *toc_file_ptr << "\\nobreak" << endl << "\\T (see under ``" << iter->opera;

      if (iter->production_subtitle.length() > 0)
          *toc_file_ptr << " " << iter->production_subtitle;
       
      *toc_file_ptr << "'')" << endl;
    }
    else if (iter->operetta.length() > 0 && iter->sort_by_production)
    {
      *toc_file_ptr << "\\nobreak" << endl << "\\T (see under ``" << iter->operetta;

      if (iter->production_subtitle.length() > 0)
          *toc_file_ptr << " " << iter->production_subtitle;
       
      *toc_file_ptr << "'')" << endl;
    }
    else if (iter->song_cycle.length() > 0 && iter->sort_by_production)
    {
      if (iter->song_cycle.length() > 20)
      {
         *toc_file_ptr << "\\nobreak" << endl << "\\T (see under" << endl 
                     << "\\T ``" << iter->song_cycle;

         if (iter->production_subtitle.length() > 0)
          *toc_file_ptr << " " << iter->production_subtitle;
       
         *toc_file_ptr << "'')" << endl;
      }
      else
      {
         *toc_file_ptr << "\\nobreak" << endl << "\\T (see under ``" << iter->song_cycle;
           
         if (iter->production_subtitle.length() > 0)
           *toc_file_ptr << " " << iter->production_subtitle;
        
         *toc_file_ptr << "'')" << endl;
      }

    }  
    else if (iter->revue.length() > 0 && iter->sort_by_production)
    {
      *toc_file_ptr << "\\nobreak" << endl << "\\T (see under ``" << iter->revue;

      if (iter->production_subtitle.length() > 0)
          *toc_file_ptr << " " << iter->production_subtitle;
       
      *toc_file_ptr << "'')" << endl;
    }
    else if (iter->film.length() > 0 && iter->sort_by_production)
    {
      *toc_file_ptr << "\\nobreak" << endl << "\\T (see under ``" << iter->film;

      if (iter->production_subtitle.length() > 0)
         *toc_file_ptr << " " << iter->production_subtitle;
       
      *toc_file_ptr << "'')" << endl;
    }
    
    *toc_file_ptr << endl;


/* *** (3) */

    if (DEBUG)
    { 
       cerr << "Exiting `write_to_toc_sub_file' successfully with return value 0." 
            << endl;
    }  

   return 0;

}  /* End of |write_to_toc_sub_file| definition.  */

/* ** (2) */

/* * (1) Emacs-Lisp code for use in indirect buffers when using the          */
/*       GNU Emacs editor.  The local variable list is not evaluated when an */
/*   	 indirect buffer is visited, so it's necessary to evaluate the       */
/*   	 following s-expression in order to use the facilities normally      */
/*   	 accessed via the local variables list.                              */
/*   	 \initials{LDF 2004.02.12}.                                          */
/*   	 (progn (cweb-mode) (outline-minor-mode t))                          */

/* (setq outline-regexp "/\\* \\*+") */

/* * Local variables for Emacs.*/
/* Local Variables: */
/* mode:CWEB */
/* eval:(display-time) */
/* eval:(read-abbrev-file) */
/* indent-tabs-mode:nil */
/* eval:(outline-minor-mode) */
/* fill-column:80 */
/* End: */

