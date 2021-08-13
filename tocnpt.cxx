/* tocnpt.cxx  */
/* Created by Laurence D. Finston Fri 12 Mar 2021 11:34:14 PM CET  */

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

#if HAVE_CONFIG_H
#include "config.h"
#endif

#include "songdefs.hxx"
#include "cmdlnopt.hxx"

extern MYSQL_RES *result;
extern MYSQL_ROW curr_row;
extern MYSQL *mysql;
  
extern unsigned int row_ctr; 
extern unsigned int field_ctr;
extern long affected_rows;

extern string datestamp_short;
extern string datestamp;

int get_datestamp(string &datestamp, string &datestamp_short);

int submit_mysql_query(string query_str);

string remove_formatting_commands(string s);

bool compare_productions(const Song& t, const Song& s);

vector<Song> song_vector;

ofstream toc_ls_file;
ofstream toc_ls_a_h_file;
ofstream toc_ls_i_o_file;
ofstream toc_ls_p_z_file;
ofstream toc_npt_file;
ofstream french_file;
ofstream german_file;
ofstream italian_file;
ofstream portugese_file;
ofstream russian_file;
ofstream spanish_file;   
ofstream productions_file;
ofstream sub_filecards_file;
ofstream songs_a_e_file;
ofstream songs_f_l_file;
ofstream songs_m_n_file;
ofstream songs_o_s_file;
ofstream songs_t_z_file;

ofstream *curr_songs_file = 0;

/* * (1) */

/* ``tocs'' stands for ``table(s) of contents''.  */
/* ``npt'' stands for ``no page turns''.          */

int
process_tocs_and_npt(void)
{
/* ** (2) */

   bool DEBUG = false; /* |true|  */

   int status;
  
   stringstream temp_strm;
   string temp_str; 
   string temp_str_1; 
   string temp_str_2; 
   string temp_str_3; 
  
   Song curr_song;

   Production_Song curr_production;

   vector<Production_Song> production_vector;

   size_t pos;
   size_t pos_1;

   bool song_from_production_flag;
   song_from_production_flag = false;
   
   bool public_domain_flag;
   public_domain_flag = false;

   errno = 0;

   affected_rows = 0L;

   int max_production_str_length = 30;

   temp_strm.str("");

   temp_strm << "select title, "                            //  0 
             <<        "words, "                            //  1
             <<        "words_reverse, "                    //  2
             <<        "music, "                            //  3
             <<        "music_reverse, "                    //  4
             <<        "words_and_music, "                  //  5
             <<        "words_and_music_reverse, "          //  6
             <<        "lead_sheet, "                       //  7
	     <<        "partial_lead_sheet, "               //  8
             <<        "no_page_turns, "                    //  9
	     <<        "no_page_turns_with_two_songbooks, " // 10
             <<        "arrangement_orchestra, "            // 11
	     <<        "arrangement_solo_guitar, "          // 12
             <<        "recordings, "                       // 13
             <<        "opera, "                            // 14
             <<        "operetta, "                         // 15
             <<        "song_cycle, "                       // 16
             <<        "musical, "                          // 17
             <<        "revue, "                            // 18
	     <<        "film, "                             // 19
             <<        "sort_by_production, "               // 20
             <<        "year, "                             // 21
             <<        "copyright, "                        // 22
             <<        "notes, "                            // 23
             <<        "scanned, "                          // 24
             <<        "scanned_filename, "                 // 25
             <<        "public_domain, "                    // 26
             <<        "language, "                         // 27
             <<        "is_cross_reference, "               // 28
             <<        "target, "                           // 29
             <<        "production, "                       // 30
             <<        "do_filecard, "                      // 31
             <<        "filecard_title, "                   // 32
             <<        "source, "                           // 33
             <<        "number_filecards, "                 // 34
             <<        "eps_filenames, "                    // 35
             <<        "subtitle, "                         // 36
             <<        "production_subtitle "               // 37
             <<        "from Songs where music != \"\" or words_and_music != \"\" or is_cross_reference = 1 "
             <<        "order by title asc;";

   if (DEBUG) 
     cerr << "temp_strm.str() == " << temp_strm.str() << endl;

   status = submit_mysql_query(temp_strm.str());

   if (status != 0)
     {
       cerr  << "ERROR!  In `process_tocs_and_npt':"
	     << endl 
	     << "`submit_mysql_query' failed, returning " << status << ":"
	     << endl 
	     << "MySQL error:  " << mysql_error(mysql)
	     << endl 
	     << "MySQL error number:  " << mysql_errno(mysql)
	     << endl 
	     << "Exiting `songlist' unsuccessfully with exit status 1." 
	     << endl;
          
       exit(1);
     }
   else if (DEBUG)
     {
       cerr << "`submit_mysql_query' succeeded, returning 0." << endl;
     }
   
   /*  Process the contents of |curr_row|  */

   curr_row = 0;

   do
     {

       curr_song.clear();

       curr_row = mysql_fetch_row(result);

       if (curr_row == 0)
	 {
	   if (DEBUG) 
	     cerr << "`mysql_fetch_row' returned NULL:" 
		  << endl;

	   if (*mysql_error(mysql))
	     {
	       cerr << "ERROR!  In `process_tocs_and_npt':  `mysql_fetch_row' failed "
		    << "returning NULL." << endl
		    << "Error:  " << mysql_error(mysql) << endl
		    << "Exiting `songlist' unsuccessfully with exit status 1."
		    << endl;

	       /* Close connection to database.  */

	       mysql_library_end();
   
	       exit(1);

	     }
	   else if (DEBUG)
	     {
	       cerr << "No more rows." << endl;
	     }

	   break;

	 }  /* |if (curr_row == 0)|  */

       if (DEBUG)
	 cerr << "`title'                            == " << curr_row[0] << endl;

       curr_song.title.assign(curr_row[0]);

       if (DEBUG)
	 cerr << "curr_song.title == " << curr_song.title << endl;
       
       if (curr_row[1])
	 {
	   if (DEBUG)
	     cerr << "`words'                            == " << curr_row[1] << endl;
	   curr_song.words.assign(curr_row[1]);

	 }
       else
	 {
	   if (DEBUG)
	     cerr << "`words'                            == NULL" << endl;
	 }

       if (curr_row[2])
	 {
	   if (DEBUG)
	     cerr << "`words_reverse'                    == " << curr_row[2] << endl;
	   curr_song.words_reverse.assign(curr_row[2]);

	 }
       else
	 {
	   if (DEBUG)
	     cerr << "`words_reverse'                    == NULL" << endl;
	 }

       if (curr_row[3])
	 {
	   if (DEBUG)
	     cerr << "`music'                            == " << curr_row[3] << endl;
	   curr_song.music.assign(curr_row[3]);
	 }
       else
	 {
	   if (DEBUG)
	     cerr << "`music'                            == NULL" << endl;
	 }


       if (curr_row[4])
	 {
	   if (DEBUG)
	     cerr << "`music_reverse'                    == " << curr_row[4] << endl;
	   curr_song.music_reverse.assign(curr_row[4]);
	 }
       else
	 {
	   if (DEBUG)
	     cerr << "`music_reverse'                    == NULL" << endl;
	 }

       if (curr_row[5])
	 {
	   if (DEBUG)
	     cerr << "`words_and_music'                  == " << curr_row[5] << endl;
	   curr_song.words_and_music.assign(curr_row[5]);
	   curr_song.words.assign(curr_row[5]);
	   curr_song.music.assign(curr_row[5]);
	 }
       else
	 {
	   if (DEBUG)
	     cerr << "`words_and_music'                  == NULL" << endl;
	 }

       if (curr_row[6])
	 {
	   if (DEBUG)
	     cerr << "`words_and_music_reverse'          == " << curr_row[6] << endl;
	   curr_song.words_and_music_reverse.assign(curr_row[6]);
	   curr_song.words_reverse.assign(curr_row[6]);
	   curr_song.music_reverse.assign(curr_row[6]);
	 }
       else
	 {
	   if (DEBUG)
	     cerr << "`words_and_music_reverse'          == NULL" << endl;
	 }

       if (DEBUG)
	 cerr << "`lead_sheet'                       == " << curr_row[7] << endl;
       curr_song.lead_sheet = atoi(curr_row[7]);

       if (DEBUG)
	 cerr << "`partial_lead_sheet'               == " << curr_row[8] << endl;
       curr_song.partial_lead_sheet = atoi(curr_row[8]);

       if (DEBUG)
	 cerr << "`no_page_turns'                    == " << curr_row[9] << endl;
       curr_song.no_page_turns = atoi(curr_row[9]);

       if (DEBUG)
	 cerr << "`no_page_turns_with_two_songbooks' == " << curr_row[10] << endl;
       curr_song.no_page_turns_with_two_songbooks = atoi(curr_row[10]);

       if (DEBUG)
	 cerr << "`arrangement_orchestra'            == " << curr_row[11] << endl;
       curr_song.arrangement_orchestra = atoi(curr_row[11]);

       if (DEBUG)
	 cerr << "`arrangement_solo_guitar'          == " << curr_row[12] << endl;
       curr_song.arrangement_solo_guitar = atoi(curr_row[12]);

       if (DEBUG)
	 cerr << "`recordings'                       == " << curr_row[13] << endl;
       curr_song.recordings = atoi(curr_row[13]);
           
       if (curr_row[14])
       {
         if (DEBUG)
           cerr << "`opera'                            == " << curr_row[14] << endl;
         curr_song.opera.assign(curr_row[14]);           
       }
       else
       {
         if (DEBUG)
           cerr << "`opera'                            == NULL" << endl;
       }

       if (curr_row[15])
       {
         if (DEBUG)
           cerr << "`operetta'                         == " << curr_row[15] << endl;
         curr_song.operetta.assign(curr_row[15]);        
       }
       else
       {   if (DEBUG)
           cerr << "`operetta'                         == NULL" << endl;
       }

       if (curr_row[16])
       {
         if (DEBUG)
           cerr << "`song_cycle'                          == " << curr_row[16] << endl;
         curr_song.song_cycle.assign(curr_row[16]);         
       }
       else
       {   if (DEBUG)
           cerr << "`song_cycle'                          == NULL" << endl;
       }  

       if (curr_row[17])
       {
         if (DEBUG)
           cerr << "AAA `musical'                          == " << curr_row[17] << endl;
         curr_song.musical.assign(curr_row[17]);         
       }
       else
       {   if (DEBUG)
           cerr << "AAA `musical'                          == NULL" << endl;
       }  
       if (curr_row[18])
       {
         if (DEBUG)
           cerr << "`revue'                            == " << curr_row[18] << endl;
         curr_song.revue.assign(curr_row[18]);
       }
       else
       {
         if (DEBUG)
           cerr << "`revue'                            == NULL" << endl;
       }

       if (curr_row[19])
       {
         if (DEBUG)
           cerr << "`film'                             == " << curr_row[19] << endl;
         curr_song.film.assign(curr_row[19]);    
       }
       else
       {
         if (DEBUG)
           cerr << "`film'                             == NULL" << endl;
       }

       if (DEBUG)
         cerr << "`sort_by_production'               == " << curr_row[20] << endl;
       curr_song.sort_by_production = atoi(curr_row[20]);

       status = atoi(curr_row[20]);

       if (status > 0)
       {
         if (DEBUG)
           cerr << "curr_song.sort_by_production = " << curr_song.sort_by_production << endl;
       }

       if (curr_row[21])
       {
         if (DEBUG)
           cerr << "`year'                             == " << curr_row[21] << endl;
         curr_song.year = atoi(curr_row[21]);
       }
       else
       {
         if (DEBUG)
           cerr << "`year'                             == NULL" << endl;
         curr_song.year = 0;
       }


       if (curr_row[22])
       {
         if (DEBUG)
           cerr << "`copyright'                        == " << curr_row[22] << endl;
         curr_song.copyright.assign(curr_row[22]);
       }
       else
       {
         if (DEBUG)
           cerr << "`copyright'                        == NULL" << endl;
       }
       if (curr_row[23])
       {
         if (DEBUG)
           cerr << "`notes'                            == " << curr_row[23] << endl;
         curr_song.notes.assign(curr_row[23]);
       }
       if (curr_row[24])
       {
         if (DEBUG)
           cerr << "`scanned'                            == " << curr_row[24] << endl;
         curr_song.scanned = static_cast<bool>(atoi(curr_row[24]));
       }
       if (curr_row[25])
       {
         if (DEBUG)
           cerr << "`scanned_filename'                   == " 
                << ((curr_row[25] != 0) ? curr_row[25] : "NULL") << endl;
         if (curr_row[25] != 0)
            curr_song.scanned_filename = curr_row[25];
       }
       if (curr_row[26])
       {
         if (DEBUG)
           cerr << "`public_domain'                      == " << curr_row[26] << endl;
         curr_song.public_domain = atoi(curr_row[26]);
       }
       else
       {
         if (DEBUG)
           cerr << "`public_domain'                      == NULL" << endl << endl;
       }
       curr_song.language = curr_row[27];
         if (DEBUG)
           cerr << "`language'                           == " << curr_row[27] << endl;

       curr_song.is_cross_reference                      = atoi(curr_row[28]);
         if (DEBUG)
           cerr << "`is_cross_reference'                 == " << curr_row[28] << endl;

       curr_song.target = curr_row[29];
         if (DEBUG)
           cerr << "`target'                             == " << curr_row[29] << endl;

       curr_song.production = curr_row[30];
         if (DEBUG)
           cerr << "`production'                         == " << curr_row[30] << endl;

       curr_song.do_filecard = atoi(curr_row[31]);
         if (DEBUG)
           cerr << "`do_filecard'                        == " << curr_row[31] << endl;

       curr_song.filecard_title = curr_row[32];
         if (DEBUG)
           cerr << "`filecard_title'                     == " << curr_row[32] << endl;

       if (curr_row[33] != 0 && strlen(curr_row[33]) > 0)
       {
          curr_song.source = curr_row[33];
          if (DEBUG)
              cerr << "`source'                             == " << curr_row[33] << endl;
       }
       else if (DEBUG)
           cerr << "`source' is NULL." << endl;

       curr_song.number_filecards = static_cast<bool>(atoi(curr_row[34]));
         if (DEBUG)
           cerr << "`number_filecards'                      == " << curr_row[34] << endl;

       curr_song.eps_filenames = curr_row[35];
         if (DEBUG)
           cerr << "`eps_filenames'                         == " << curr_row[35] << endl;

       curr_song.subtitle = curr_row[36];
         if (DEBUG)
           cerr << "`subtitle'                              == " << curr_row[36] << endl;

       curr_song.production_subtitle = curr_row[37];
         if (DEBUG)
           cerr << "`production_subtitle'                   == " << curr_row[37] << endl;

       if (DEBUG)
         curr_song.show("curr_song:");

       song_vector.push_back(curr_song);

       curr_song.clear();

       if (DEBUG) 
         cerr << "song_vector.back().title               == " << song_vector.back().title << endl
              << "song_vector.back().subtitle            == " << song_vector.back().subtitle << endl
              << "song_vector.back().production_subtitle == " << song_vector.back().production_subtitle << endl;

   } while (curr_row != 0);

     /* Free |result|  */
     
     if (result)
       {
         mysql_free_result(result);
         result = 0;
       }

/* ** (2)  */

   if (song_vector.size() == 0)
   {
      cerr << "WARNING:  In `process_tocs_and_npt':  `song_vector is empty'.  No songs to show." 
           << endl
           << "Exiting `songlist' successfully with exit status 0."
           << endl;

      /* Close connection to database.  */

      mysql_library_end();

      exit(0);
 
   }
   else if (DEBUG)
     cerr << "`song_vector.size()' == " << song_vector.size() << "."
          << endl << endl;

   /* * Process |song_vector|  */

   sort(song_vector.begin(), song_vector.end(), compare_titles);

   if (DEBUG)
     {
       for (vector<Song>::iterator iter = song_vector.begin();
            iter != song_vector.end();
            ++iter)
         {
           iter->show("Song:");
         }
     }

   /* Query database for productions (i.e., musicals, operas, $\ldots$.  */

   /* Musicals  */
   
   temp_strm.str("");

   temp_strm << "select distinct musical, year, public_domain from Songs where lead_sheet is true and musical is not null "
             << "and sort_by_production is true order by musical;";

   if (DEBUG) 
     cerr << "temp_strm.str() == " << temp_strm.str() << endl;

   status = submit_mysql_query(temp_strm.str());

   if (status != 0)
     {
       cerr  << "ERROR!  In `process_tocs_and_npt':"
             << endl 
             << "`submit_mysql_query' failed, returning " << status << ":"
             << endl 
             << "MySQL error:  " << mysql_error(mysql)
             << endl 
             << "MySQL error number:  " << mysql_errno(mysql)
             << endl 
             << "Exiting `songlist' unsuccessfully with exit status 1." 
             << endl;
          
       exit(1);
     }
   else if (DEBUG)
     {
         cerr << "`submit_mysql_query' succeeded, returning 0." << endl
              << "`row_ctr'   == " << row_ctr << endl
              << "`field_ctr' == " << field_ctr << endl;
     }
   
   /*  Process the contents of |result|  */

   curr_row = 0;

   if (row_ctr > 0)
     {
       do
         {
           curr_production.clear();

           curr_row = mysql_fetch_row(result);

           if (curr_row == 0)
             {
               if (DEBUG) 
                 cerr << "`mysql_fetch_row' returned NULL:" 
                      << endl;

               if (*mysql_error(mysql))
                 {
                   cerr << "ERROR!  In `process_tocs_and_npt':  `mysql_fetch_row' failed "
                        << "returning NULL." << endl
                        << "Error:  " << mysql_error(mysql) << endl
                        << "Exiting `songlist' unsuccessfully with exit status 1."
                        << endl;

                   /* Close connection to database.  */

                   mysql_library_end();
   
                   exit(1);

                 }
               else if (DEBUG)
                 {
                   cerr << "No more rows." << endl;
                 }

               break;

             }  /* |if (curr_row == 0)|  */

           if (DEBUG)
             cerr << "BBB `musical' == " << curr_row[0] << endl;

           curr_production.title.assign(curr_row[0]);
           curr_production.musical.assign(curr_row[0]);
           curr_production.is_production = true;
           if (curr_row[1])
              curr_production.year = atoi(curr_row[1]);
           curr_production.public_domain = static_cast<bool>(atoi(curr_row[2]));

           production_vector.push_back(curr_production);

         } while (curr_row != 0);

     }  /* |if (row_ctr > 0)|  */

   /* Free |result|  */
     
   if (result)
     {
       mysql_free_result(result);
       result = 0;
     }
   
   /* Operas  */

   temp_strm.str("");

   temp_strm << "select distinct opera, year, public_domain from Songs where lead_sheet is true and opera is not null "
             << "and sort_by_production is true order by opera;";

   if (DEBUG) 
     cerr << "temp_strm.str() == " << temp_strm.str() << endl;

   status = submit_mysql_query(temp_strm.str());

   if (status != 0)
     {
       cerr  << "ERROR!"
             << endl 
             << "`submit_mysql_query' failed, returning " << status << ":"
             << endl 
             << "MySQL error:  " << mysql_error(mysql)
             << endl 
             << "MySQL error number:  " << mysql_errno(mysql)
             << endl 
             << "Exiting `songlist' unsuccessfully with exit status 1." 
             << endl;
          
       exit(1);
     }
   else if (DEBUG)
     {
       cerr << "`submit_mysql_query' succeeded, returning 0." << endl
            << "`row_ctr'   == " << row_ctr << endl
            << "`field_ctr' == " << field_ctr << endl;

cerr << "XXX Enter <RETURN> to continue: ";
getchar(); 


     }
   
   /*  Process the contents of |result|  */

   curr_row = 0;

   if (row_ctr > 0)
   {
     do
       {
         curr_production.clear();

         curr_row = mysql_fetch_row(result);

         if (curr_row == 0)
           {
             if (DEBUG) 
               cerr << "`mysql_fetch_row' returned NULL:" 
                    << endl;

             if (*mysql_error(mysql))
               {
                 cerr << "ERROR!  In `process_tocs_and_npt':  `mysql_fetch_row' failed "
                      << "returning NULL." << endl
                      << "Error:  " << mysql_error(mysql) << endl
                      << "Exiting `songlist' unsuccessfully with exit status 1."
                      << endl;

                 /* Close connection to database.  */

                 mysql_library_end();
   
                 exit(1);

               }
             else if (DEBUG)
               {
                 cerr << "No more rows." << endl;
               }

             break;

           }  /* |if (curr_row == 0)|  */

         if (DEBUG)
           cerr << "`opera' == " << curr_row[0] << endl;

         curr_production.title.assign(curr_row[0]);
         curr_production.opera.assign(curr_row[0]);
         curr_production.is_production = true;
         if (curr_row[1])
            curr_production.year = atoi(curr_row[1]);
         curr_production.public_domain = static_cast<bool>(atoi(curr_row[2]));

         production_vector.push_back(curr_production);

       } while (curr_row != 0);

   }  /* |if (row_ctr > 0)|  */

   /* Free |result|  */
     
   if (result)
     {
       mysql_free_result(result);
       result = 0;
     }

   /* Operettas  */
   
   temp_strm.str("");
   

   temp_strm << "select distinct operetta, year, public_domain from Songs where lead_sheet is true and operetta is not null "
             << "and sort_by_production is true order by operetta;";

   if (DEBUG) 
     cerr << "temp_strm.str() == " << temp_strm.str() << endl;
   
   status = submit_mysql_query(temp_strm.str());

   if (status != 0)
     {
       cerr  << "ERROR!"
             << endl 
             << "`submit_mysql_query' failed, returning " << status << ":"
             << endl 
             << "MySQL error:  " << mysql_error(mysql)
             << endl 
             << "MySQL error number:  " << mysql_errno(mysql)
             << endl 
             << "Exiting `songlist' unsuccessfully with exit status 1." 
             << endl;
          
       exit(1);
     }
   else if (DEBUG)
     {
       cerr << "`submit_mysql_query' succeeded, returning 0." << endl
            << "`row_ctr'   == " << row_ctr << endl
            << "`field_ctr' == " << field_ctr << endl;
     }
   
   /*  Process the contents of |result|  */

   curr_row = 0;

   if (row_ctr > 0)
     {
       do
         {
           curr_production.clear();

           curr_row = mysql_fetch_row(result);

           if (curr_row == 0)
             {
               if (DEBUG) 
                 cerr << "`mysql_fetch_row' returned NULL:" 
                      << endl;

               if (*mysql_error(mysql))
                 {
                   cerr << "ERROR!  In `process_tocs_and_npt':  `mysql_fetch_row' failed "
                        << "returning NULL." << endl
                        << "Error:  " << mysql_error(mysql) << endl
                        << "Exiting `songlist' unsuccessfully with exit status 1."
                        << endl;

                   /* Close connection to database.  */

                   mysql_library_end();
   
                   exit(1);

                 }
               else if (DEBUG)
                 {
                   cerr << "No more rows." << endl;
                 }

               break;

             }  /* |if (curr_row == 0)|  */

           if (DEBUG)
             cerr << "`operetta' == " << curr_row[0] << endl;

           curr_production.title.assign(curr_row[0]);
           curr_production.operetta.assign(curr_row[0]);
           curr_production.is_production = true;
           if (curr_row[1])
              curr_production.year = atoi(curr_row[1]);
           curr_production.public_domain = static_cast<bool>(atoi(curr_row[2]));

           production_vector.push_back(curr_production);

         } while (curr_row != 0);

     }  /* |if (row_ctr > 0)|  */

   /* Free |result|  */
     
   if (result)
     {
       mysql_free_result(result);
       result = 0;
     }

   /* Song cycles  */
   
   temp_strm.str("");
   
   temp_strm << "select distinct song_cycle, year, public_domain from Songs where lead_sheet is true and song_cycle is not null "
             << "and sort_by_production is true order by song_cycle;";

   if (DEBUG) 
     cerr << "temp_strm.str() == " << temp_strm.str() << endl;
   
   status = submit_mysql_query(temp_strm.str());

   if (status != 0)
     {
       cerr  << "ERROR!"
             << endl 
             << "`submit_mysql_query' failed, returning " << status << ":"
             << endl 
             << "MySQL error:  " << mysql_error(mysql)
             << endl 
             << "MySQL error number:  " << mysql_errno(mysql)
             << endl 
             << "Exiting `songlist' unsuccessfully with exit status 1." 
             << endl;
          
       exit(1);
     }
   else if (DEBUG)
     {
       cerr << "`submit_mysql_query' succeeded, returning 0." << endl
            << "`row_ctr'   == " << row_ctr << endl
            << "`field_ctr' == " << field_ctr << endl;
     }
   
   /*  Process the contents of |result|  */

   curr_row = 0;

   if (row_ctr > 0)
     {
       do
         {
           curr_production.clear();

           curr_row = mysql_fetch_row(result);

           if (curr_row == 0)
             {
               if (DEBUG) 
                 cerr << "`mysql_fetch_row' returned NULL:" 
                      << endl;

               if (*mysql_error(mysql))
                 {
                   cerr << "ERROR!  In `process_tocs_and_npt':  `mysql_fetch_row' failed "
                        << "returning NULL." << endl
                        << "Error:  " << mysql_error(mysql) << endl
                        << "Exiting `songlist' unsuccessfully with exit status 1."
                        << endl;

                   /* Close connection to database.  */

                   mysql_library_end();
   
                   exit(1);

                 }
               else if (DEBUG)
                 {
                   cerr << "No more rows." << endl;
                 }

               break;

             }  /* |if (curr_row == 0)|  */

           if (DEBUG)
             cerr << "`song_cycle' == " << curr_row[0] << endl;

           curr_production.title.assign(curr_row[0]);
           curr_production.song_cycle.assign(curr_row[0]);
           curr_production.is_production = true;
           if (curr_row[1])
              curr_production.year = atoi(curr_row[1]);
           curr_production.public_domain = static_cast<bool>(atoi(curr_row[2]));

           production_vector.push_back(curr_production);

         } while (curr_row != 0);

     }  /* |if (row_ctr > 0)|  */

   /* Free |result|  */
     
   if (result)
     {
       mysql_free_result(result);
       result = 0;
     }

   /* Revues  */
   
   temp_strm.str("");

   temp_strm << "select distinct revue, year, public_domain from Songs where lead_sheet is true and revue is not null "
             << "and sort_by_production is true order by revue";

   if (DEBUG) 
     cerr << "temp_strm.str() == " << temp_strm.str() << endl;
   
   status = submit_mysql_query(temp_strm.str());

   if (status != 0)
     {
       cerr  << "ERROR!"
             << endl 
             << "`submit_mysql_query' failed, returning " << status << ":"
             << endl 
             << "MySQL error:  " << mysql_error(mysql)
             << endl 
             << "MySQL error number:  " << mysql_errno(mysql)
             << endl 
             << "Exiting `songlist' unsuccessfully with exit status 1." 
             << endl;
          
       exit(1);
     }
   else if (DEBUG)
     {
       cerr << "`submit_mysql_query' succeeded, returning 0." << endl
            << "`row_ctr'   == " << row_ctr << endl
            << "`field_ctr' == " << field_ctr << endl;
     }
   
   /*  Process the contents of |result|  */

   curr_row = 0;

   if (row_ctr > 0)
     {
       do
         {
           curr_production.clear();

           curr_row = mysql_fetch_row(result);

           if (curr_row == 0)
             {
               if (DEBUG) 
                 cerr << "`mysql_fetch_row' returned NULL:" 
                      << endl;

               if (*mysql_error(mysql))
                 {
                   cerr << "ERROR!  In `process_tocs_and_npt':  `mysql_fetch_row' failed "
                        << "returning NULL." << endl
                        << "Error:  " << mysql_error(mysql) << endl
                        << "Exiting `songlist' unsuccessfully with exit status 1."
                        << endl;

                   /* Close connection to database.  */

                   mysql_library_end();
   
                   exit(1);

                 }
               else if (DEBUG)
                 {
                   cerr << "No more rows." << endl;
                 }

               break;

             }  /* |if (curr_row == 0)|  */

           if (DEBUG)
             cerr << "`revue' == " << curr_row[0] << endl;

           curr_production.title.assign(curr_row[0]);
           curr_production.revue.assign(curr_row[0]);
           curr_production.is_production = true;
           if (curr_row[1])
              curr_production.year = atoi(curr_row[1]);
           curr_production.public_domain = static_cast<bool>(atoi(curr_row[2]));

           production_vector.push_back(curr_production);

         } while (curr_row != 0);

     }  /* |if (row_ctr > 0)|  */


   /* Free |result|  */
     
   if (result)
     {
       mysql_free_result(result);
       result = 0;
     }

   /* Films  */
   
   temp_strm.str("");
   
   temp_strm << "select distinct film, year, public_domain from Songs where lead_sheet is true and film is not null "
             << "and sort_by_production is true order by film;";

   if (DEBUG) 
     cerr << "temp_strm.str() == " << temp_strm.str() << endl;

   status = submit_mysql_query(temp_strm.str());

   if (status != 0)
     {
       cerr  << "ERROR!"
             << endl 
             << "`submit_mysql_query' failed, returning " << status << ":"
             << endl 
             << "MySQL error:  " << mysql_error(mysql)
             << endl 
             << "MySQL error number:  " << mysql_errno(mysql)
             << endl 
             << "Exiting `songlist' unsuccessfully with exit status 1." 
             << endl;
          
       exit(1);
     }
   else if (DEBUG)
     {
       cerr << "`submit_mysql_query' succeeded, returning 0." << endl
            << "`row_ctr'   == " << row_ctr << endl
            << "`field_ctr' == " << field_ctr << endl;
     }
   
   /*  Process the contents of |result|  */

   curr_row = 0;

   if (row_ctr > 0)
     {
       do
         {
           curr_production.clear();

           curr_row = mysql_fetch_row(result);

           if (curr_row == 0)
             {
               if (DEBUG) 
                 cerr << "`mysql_fetch_row' returned NULL:" 
                      << endl;

               if (*mysql_error(mysql))
                 {
                   cerr << "ERROR!  In `process_tocs_and_npt':  `mysql_fetch_row' failed "
                        << "returning NULL." << endl
                        << "Error:  " << mysql_error(mysql) << endl
                        << "Exiting `songlist' unsuccessfully with exit status 1."
                        << endl;

                   /* Close connection to database.  */

                   mysql_library_end();
   
                   exit(1);

                 }
               else if (DEBUG)
                 {
                   cerr << "No more rows." << endl;
                 }

               break;

             }  /* |if (curr_row == 0)|  */

           if (DEBUG)
             cerr << "`film' == " << curr_row[0] << endl;
 
           curr_production.title.assign(curr_row[0]);
           curr_production.film.assign(curr_row[0]);
           curr_production.is_production = true;
           if (curr_row[1])
              curr_production.year = atoi(curr_row[1]);
           curr_production.public_domain = static_cast<bool>(atoi(curr_row[2]));

           production_vector.push_back(curr_production);

         } while (curr_row != 0);

     }  /* |if (row_ctr > 0)|  */

   /* Free |result|  */
     
   if (result)
     {
       mysql_free_result(result);
       result = 0;
     }

   /*  */

   sort(production_vector.begin(), production_vector.end(), compare_titles);
   
   if (DEBUG)
   {
       if (production_vector.size() > 0)
         cerr << "production_vector:" << endl;
       else
         cerr << "production_vector is empty." << endl;
       
       for (vector<Production_Song>::iterator iter = production_vector.begin();
            iter != production_vector.end();
            ++iter)
         {
           iter->show("Production_Song:");
         }
   }

   for (vector<Production_Song>::iterator iter = production_vector.begin();
        iter != production_vector.end();
        ++iter)
   {
       if (DEBUG)
         {
           iter->show("Production_Song:");
         }

       temp_strm.str("");

       temp_strm << "select title, scanned, eps_filenames, musical, opera, operetta, "
                 << "song_cycle, revue, film, public_domain, subtitle, production_subtitle "
                 << "from Songs where sort_by_production is true and ";

       if (iter->musical.length() > 0)
         temp_strm << "musical = \"" << iter->musical << "\" ";
       else if (iter->opera.length() > 0)
         temp_strm << "opera = \"" << iter->opera << "\" ";
       else if (iter->operetta.length() > 0)
         temp_strm << "operetta = \"" << iter->operetta << "\" ";
       else if (iter->song_cycle.length() > 0)
         temp_strm << "song_cycle = \"" << iter->song_cycle << "\" ";
       else if (iter->revue .length() > 0)
         temp_strm << "revue = \"" << iter->revue << "\" ";
       else if (iter->film .length() > 0)
         temp_strm << "film = \"" << iter->film << "\" ";

       temp_strm << "order by title;";

       temp_str = temp_strm.str();
      
       pos = 0;

       /* Replace |'\'| with |"\\"|.  Two loops are required.                             */

       /* |'%'| is used as a ``dummy'' character here.  Otherwise, replacing |'\'| with   */
       /* |"\\"| would be tricky and would require the use of iterators.                  */
       /* It's simpler to just use two loops.                                             */
       /* |'%'| is guaranteed to not occur in a title, because it's the comment character */
       /* in TeX.  LDF 2021.08.07.                                                        */

       do
       {
          pos = temp_str.find("\\");

          if (pos != string::npos)
          {
              temp_str.replace(pos, 1, "%");
          }
       } while (pos != string::npos);

       pos = 0;

       do
       {
          pos = temp_str.find("%");

          if (pos != string::npos)
          {
              temp_str.replace(pos, 1, "\\\\");
          }
       } while (pos != string::npos);

       temp_strm.str("");

       if (DEBUG)
          cerr << "temp_str == " << temp_str << endl;

       status = submit_mysql_query(temp_str);

       if (status != 0)
       {
         cerr  << "ERROR!"
               << endl 
               << "`submit_mysql_query' failed, returning " << status << ":"
               << endl 
               << "MySQL error:  " << mysql_error(mysql)
               << endl 
               << "MySQL error number:  " << mysql_errno(mysql)
               << endl 
               << "Query string == `temp_str' == \"" << temp_str << "\"" 
               << endl 
               << "Exiting `songlist' unsuccessfully with exit status 1." 
               << endl;
        
         exit(1);
       }
       else if (DEBUG)
       {
         cerr << "`submit_mysql_query' succeeded, returning 0." << endl
              << "`row_ctr'   == " << row_ctr << endl
              << "`field_ctr' == " << field_ctr << endl;
       }

       temp_str = "";

       /*  Process the contents of |result|  */
       
       curr_row = 0;
 

       if (row_ctr > 0)
         {
          
           do
             {
               curr_song.clear();

               curr_row = mysql_fetch_row(result);

               if (curr_row == 0)
                 {
                   if (DEBUG) 
                     cerr << "`mysql_fetch_row' returned NULL:" 
                          << endl;

                   if (*mysql_error(mysql))
                     {
                       cerr << "ERROR!  In `process_tocs_and_npt':  `mysql_fetch_row' failed "
                            << "returning NULL." << endl
                            << "Error:  " << mysql_error(mysql) << endl
                            << "Exiting `songlist' unsuccessfully with exit status 1."
                            << endl;

                       /* Close connection to database.  */

                       mysql_library_end();
   
                       exit(1);

                     }
                   else if (DEBUG)
                     {
                       cerr << "No more rows." << endl;
                     }

                   break;
                 
                 }  /* |if (curr_row == 0)|  */

               curr_song.title = curr_row[0];

               curr_song.scanned = static_cast<bool>(atoi(curr_row[1]));
               curr_song.eps_filenames = curr_row[2];
               if (curr_row[3])
                  curr_song.musical = curr_row[3];
               if (curr_row[4])
                  curr_song.opera = curr_row[4];
               if (curr_row[5])
                  curr_song.operetta = curr_row[5];
               if (curr_row[6])
                  curr_song.song_cycle = curr_row[6];
               if (curr_row[7])
                  curr_song.revue = curr_row[7];
               if (curr_row[8])
                  curr_song.film = curr_row[8];
               curr_song.public_domain = static_cast<bool>(atoi(curr_row[9]));
               curr_song.subtitle.assign(curr_row[10]);
               curr_song.production_subtitle.assign(curr_row[11]);

               iter->production_song_vector.push_back(curr_song);

               if (DEBUG)
                  cerr << "iter->production_song_vector.size() == " << iter->production_song_vector.size() << endl;

             } while (curr_row != 0);

         }  /* |if (row_ctr > 0)|  */

       /* Free |result|  */
     
       if (result)
         {
           mysql_free_result(result);
           result = 0;
         }
       
       /*  */

       sort(iter->production_song_vector.begin(), iter->production_song_vector.end(), compare_titles);

       if (DEBUG)
       {
          for (vector<Song>::iterator a_iter = iter->production_song_vector.begin();
               a_iter != iter->production_song_vector.end();
               ++a_iter) 
          { 
               a_iter->show("*a_iter:");
          }
       } 

   }  /* |for|  */

   if (DEBUG)
   {
       if (production_vector.size() > 0)
         cerr << "production_vector:" << endl;
       else
         cerr << "production_vector is empty." << endl;
       
       for (vector<Production_Song>::iterator iter = production_vector.begin();
            iter != production_vector.end();
            ++iter)
       {       
           iter->show("Production_Song:");
       }
   } 

   song_vector.insert(song_vector.begin(), production_vector.begin(), production_vector.end());

   sort(song_vector.begin(), song_vector.end(), compare_titles);
   
   /* Open output files.  */
   
   toc_ls_file.open("toc_ls.tex");
   toc_ls_a_h_file.open("toc_ls_a_h.tex");
   toc_ls_i_o_file.open("toc_ls_i_o.tex");
   toc_ls_p_z_file.open("toc_ls_p_z.tex");
   toc_npt_file.open("toc_npt.tex");
   french_file.open("french.tex");    
   german_file.open("german.tex");    
   italian_file.open("italian.tex");   
   portugese_file.open("portugese.tex"); 
   russian_file.open("russian.tex");   
   spanish_file.open("spanish.tex");
   productions_file.open("productions.tex");
   sub_filecards_file.open("sub_filecrds.tex");
   songs_a_e_file.open("./public_domain/songs_a_e.tex");
   songs_f_l_file.open("./public_domain/songs_f_l.tex");
   songs_m_n_file.open("./public_domain/songs_m_n.tex");
   songs_o_s_file.open("./public_domain/songs_o_s.tex");
   songs_t_z_file.open("./public_domain/songs_t_z.tex"); 

   status = get_datestamp(datestamp, datestamp_short);

   if (DEBUG) 
     cerr << "datestamp == \"" << datestamp << "\"" << endl
          << "datestamp_short == \"" << datestamp_short << "\"" 
          << endl;
   
   toc_ls_file << "%% toc_ls.tex" << endl                                              
               << "%% Generated by `songlist' " << datestamp << endl << endl           
               << "\\medium" << endl
               << "\\headline={\\hfil \\ifnum\\pageno>1{\\mediumbx Lead Sheets}\\fi"
               << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl
               << "\\songctr=1" << endl
               << "\\hldest{xyz}{}{lead sheets}" << endl 
               << "\\centerline{{\\largebx Lead Sheets}}" << endl
               << "\\vskip.75\\baselineskip" << endl
               << "\\doublecolumns" << endl
               << "\\obeylines" << endl << endl;

   toc_ls_a_h_file << "%% toc_ls_a_h.tex" << endl                                              
                   << "%% Generated by `songlist' " << datestamp << endl << endl               
                   << "\\ifseparate" << endl
                   << "\\pageno=1" << endl
                   << "\\fi" << endl
                   << "\\pagecnt=\\pageno" << endl
                   << "\\medium" << endl
                   << "\\headline={\\hfil \\ifnum\\pageno>\\pagecnt{\\mediumbx Lead Sheets A--H}\\fi"
                   << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl
                   << "\\songctr=1" << endl
                   << "\\hldest{xyz}{}{lead sheets a-h}" << endl 
                   << "\\centerline{{\\largebx Lead Sheets A--H}}" << endl
                   << "\\vskip.75\\baselineskip" << endl
                   << "\\doublecolumns" << endl
                   << "\\obeylines" << endl << endl;

   toc_ls_i_o_file << "%% toc_ls_i_o.tex" << endl                                              
                   << "%% Generated by `songlist' " << datestamp << endl << endl               
                   << "\\ifseparate" << endl
                   << "\\pageno=1" << endl
                   << "\\fi" << endl
                   << "\\pagecnt=\\pageno" << endl
                   << "\\medium" << endl
                   << "\\headline={\\hfil \\ifnum\\pageno>\\pagecnt{\\mediumbx Lead Sheets I--O}\\fi" << endl
                   << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl
                   << "\\hldest{xyz}{}{lead sheets i-o}" << endl 
                   << "\\centerline{{\\largebx Lead Sheets I--O}}" << endl
                   << "\\vskip.75\\baselineskip" << endl
                   << "\\doublecolumns" << endl
                   << "\\obeylines" << endl << endl;                                                        

   toc_ls_p_z_file << "%% toc_ls_p_z.tex" << endl                                           
                   << "%% Generated by `songlist' " << datestamp << endl << endl               
                   << "\\ifseparate" << endl
                   << "\\pageno=1" << endl
                   << "\\fi" << endl
                   << "\\pagecnt=\\pageno" << endl
                   << "\\medium" << endl
                   << "\\headline={\\hfil \\ifnum\\pageno>\\pagecnt{\\mediumbx Lead Sheets P--Z}\\fi" << endl 
                   << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl
                   << "\\hldest{xyz}{}{lead sheets p-z}" << endl 
                   << "\\centerline{{\\largebx Lead Sheets P--Z}}" << endl
                   << "\\vskip.75\\baselineskip" << endl
                   << "\\doublecolumns" << endl
                   << "\\obeylines" << endl << endl;                                                        

   toc_npt_file << "%% toc_npt.tex" << endl 
                << "%% Generated by `songlist' " << datestamp << endl << endl
                << "\\ifseparate" << endl
                << "\\pageno=1" << endl
                << "\\fi" << endl
                << "\\pagecnt=\\pageno" << endl
                << "%\\advance\\hoffset by .5cm" << endl
                << "\\medium" << endl
                << "%\\advance\\baselineskip by .5\\baselineskip" << endl
                << "\\headline={\\hfil \\ifnum\\pageno>\\pagecnt{\\mediumbx No Page Turns}\\fi"
                << "\\hfil\\hbox to 0pt{\\hss{\\tt \\timestamp}\\quad}}" << endl
                << "\\songctr=1" << endl
                << "\\hldest{xyz}{}{no page turns}" << endl 
                << "\\centerline{{\\largebx No Page Turns}}" << endl
                << "\\vskip.75\\baselineskip" << endl << endl;

   french_file << "%% french.tex" << endl
               << "%% Generated by `songlist' " << datestamp << endl << endl
               << "\\medium" << endl
               << "\\songctr=1" << endl
               << "\\hldest{xyz}{}{french}" << endl 
               << "\\vbox{\\centerline{{\\largebx French}}" << endl
               << "\\vskip.75\\baselineskip}" << endl
               << "\\nobreak" << endl
               << "%%\\doublecolumns" << endl
               << "\\begingroup" << endl 
               << "\\parskip=0pt" << endl 
               << "\\obeylines" << endl;

   german_file << "%% german.tex" << endl
               << "%% Generated by `songlist' " << datestamp << endl << endl
               << "\\medium" << endl
               << "\\songctr=1" << endl
               << "\\hldest{xyz}{}{german}" << endl 
               << "\\vbox{\\centerline{{\\largebx German}}" << endl
               << "\\vskip.75\\baselineskip}" << endl
               << "\\nobreak" << endl
               << "%%\\doublecolumns" << endl
               << "\\begingroup" << endl 
               << "\\parskip=0pt" << endl 
               << "\\obeylines" << endl;

   italian_file << "%% italian.tex" << endl
                << "%% Generated by `songlist' " << datestamp << endl << endl
                << "\\medium" << endl
                << "\\songctr=1" << endl
                << "\\hldest{xyz}{}{italian}" << endl 
                << "\\vbox{\\centerline{{\\largebx Italian}}" << endl
                << "\\vskip.75\\baselineskip}" << endl
                << "\\nobreak" << endl
                << "%%\\doublecolumns" << endl
                << "\\begingroup" << endl 
                << "\\parskip=0pt" << endl 
                << "\\obeylines" << endl;

   portugese_file << "%% portugese.tex" << endl
                  << "%% Generated by `songlist' " << datestamp << endl << endl
                  << "\\medium" << endl
                  << "\\songctr=1" << endl
                  << "\\hldest{xyz}{}{portugese}" << endl 
                  << "\\vbox{\\centerline{{\\largebx Portugese}}" << endl
                  << "\\vskip.75\\baselineskip}" << endl
                  << "\\nobreak" << endl
                  << "%%\\doublecolumns" << endl
                  << "\\begingroup" << endl 
                  << "\\parskip=0pt" << endl 
                  << "\\obeylines" << endl;

   russian_file << "%% russian.tex" << endl
                << "%% Generated by `songlist' " << datestamp << endl << endl
                << "\\medium" << endl
                << "\\songctr=1" << endl
                << "\\hldest{xyz}{}{russian}" << endl 
                << "\\vbox{\\centerline{{\\largebx Russian}}" << endl
                << "\\vskip.75\\baselineskip}" << endl
                << "\\nobreak" << endl
                << "%%\\doublecolumns" << endl
                << "\\begingroup" << endl 
                << "\\parskip=0pt" << endl 
                << "\\obeylines" << endl;

   spanish_file << "%% spanish.tex" << endl
                << "%% Generated by `songlist' " << datestamp << endl << endl
                << "\\medium" << endl
                << "\\songctr=1" << endl
                << "\\hldest{xyz}{}{spanish}" << endl 
                << "\\vbox{\\centerline{{\\largebx Spanish}}" << endl
                << "\\vskip.75\\baselineskip}" << endl
                << "\\nobreak" << endl
                << "%%\\doublecolumns" << endl
                << "\\begingroup" << endl 
                << "\\parskip=0pt" << endl 
                << "\\obeylines" << endl;

   productions_file << "%% production.tex" << endl
                    << "%% Generated by `songlist' " << datestamp << endl << endl
                    << "\\ifseparate" << endl
                    << "\\pageno=1" << endl
                    << "\\fi" << endl
                    << "\\temppagecnt=\\pageno" << endl 
                    << "\\headline={\\ifnum\\pageno>\\temppagecnt\\firstmark\\hfil{\\mediumbx Productions}\\hfil%" << endl 
                    << "\\hbox to 0pt{\\hss{\\tt \\timestamp}\\hskip.5cm}\\botmark\\else\\hfil{\\tt \\timestamp}\\quad\\fi}" << endl 
                    << "\\medium" << endl
                    << "\\songctr=1" << endl
                    << "\\doublecolumns" << endl
                    << "\\begingroup" << endl 
                    << "%\\parskip=\\baselineskip" << endl 
                    << "%\\obeylines" << endl;

   sub_filecards_file << "%% sub_filecards.tex" << endl
                      << "%% Generated by `songlist' " << datestamp << endl << endl;

   songs_a_e_file << "%% songs_a_e_file.tex" << endl 
                  << "%% Generated by `songlist' " << datestamp << endl << endl;

   songs_f_l_file << "%% songs_f_l_file.tex" << endl
                  << "%% Generated by `songlist' " << datestamp << endl << endl;

   songs_m_n_file << "%% songs_m_n_file.tex" << endl
                  << "%% Generated by `songlist' " << datestamp << endl << endl;


   songs_o_s_file << "%% songs_o_s_file.tex" << endl
                  << "%% Generated by `songlist' " << datestamp << endl << endl;

   songs_t_z_file << "%% songs_t_z_file.tex" << endl
                  << "%% Generated by `songlist' " << datestamp << endl << endl;

   char temp_char;
   string temp_title;

   if (DEBUG)
     {
       for (vector<Song>::iterator iter = song_vector.begin();
            iter != song_vector.end();
            ++iter)
         iter->show("Song:");
     }

   int filecard_ctr = 0;
   size_t found_s;
   char curr_char = '\0';
   char prev_char= '\0';

   public_domain_flag = false;

   for (vector<Song>::iterator iter = song_vector.begin();
        iter != song_vector.end();
        ++iter)
   {
       if (iter->public_domain)
          public_domain_flag = true;
       else 
          public_domain_flag = false;

       song_from_production_flag = false;

#if 0 
       cerr << "iter->title == " << iter->title << endl;
#endif 
       temp_str = remove_formatting_commands(iter->title);

       found_s = temp_str.find("14");

       if (found_s != string::npos)
       {
          temp_str.replace(found_s, 2, "Fourteen");
       }

       found_s = temp_str.find("42nd");

       if (found_s != string::npos)
       {
          temp_str.replace(found_s, 4, "Forty-Second");
       } 

#if 0 
       cerr << "temp_str == " << temp_str << endl
            << "temp_str[0] == " << temp_str[0] << endl;
#endif 

       if (tolower(temp_str[0]) >= 'a' && tolower(temp_str[0]) <= 'e')
       {
          curr_songs_file = &songs_a_e_file;
       }
       else if (tolower(temp_str[0]) >= 'f' && tolower(temp_str[0]) <= 'l')
       {
          curr_songs_file = &songs_f_l_file;
       }
       else if (tolower(temp_str[0]) >= 'm' && tolower(temp_str[0]) <= 'n')
       {
          curr_songs_file = &songs_m_n_file;
       }
       else if (tolower(temp_str[0]) >= 'o' && tolower(temp_str[0]) <= 's')
       {
          curr_songs_file = &songs_o_s_file;
       }                
       else if (tolower(temp_str[0]) >= 't' && tolower(temp_str[0]) <= 'z')
       {
          curr_songs_file = &songs_t_z_file;
       }

       if (filecard_ctr == 8)
       {
         sub_filecards_file << "\\eject" << endl << endl;
         filecard_ctr = 0;
       }

       temp_title = remove_formatting_commands(iter->title);

       for (int i = 0; i < temp_title.length(); ++i)
       {
         if (isalpha(temp_title[i]))
           {
             temp_char = tolower(temp_title[i]);
             break;
           }
         else if (temp_title[i] == '4')
           {
             temp_char = 'f';
           }
         else
           continue;
       }
       if (DEBUG) 
         iter->show();

#if 0          
       cerr << "iter->title              == " << iter->title << endl;
   
       cerr << "iter->musical   == " << iter->musical << endl;
          
       cerr << "iter->musical.length()   == " << iter->musical.length() << endl;

       cerr << "iter->sort_by_production == " << iter->sort_by_production << endl;

#endif

/* *** (3)  */

       if (!iter->is_production)
       {
          if (iter->language == "french")
          {
              french_file << "\\M " << iter->title << endl;
          }       
          else if (iter->language == "german")
          {
              german_file << "\\M " << iter->title << endl;
          }       
          else if (iter->language == "italian")
          {
              italian_file << "\\M " << iter->title << endl;
          }       
          if (iter->language == "portugese")
          {
              portugese_file << "\\M " << iter->title << endl;
          }       
          if (iter->language == "russian")
          {
              russian_file << "\\M " << iter->title << endl;
          }       
          if (iter->language == "spanish")
          {
              spanish_file << "\\M " << iter->title << endl;
          }       

       }

/* *** (3)  */

       if (iter->do_filecard || iter->is_production)
       {

          curr_char = temp_str[0];
 
          if (curr_char != prev_char)
          {
             sub_filecards_file << "\\FilecardSection{" << curr_char << "}" << endl;
          }

          if (filecard_ctr == 0)
          {  
             sub_filecards_file << "\\A" << endl;
          }
          if (iter->is_production || iter->is_cross_reference)
             sub_filecards_file << "\\vbox to 0pt{\\C";
          else 
             sub_filecards_file << "\\B";

          if (filecard_ctr == 0)
             sub_filecards_file << "{0pt}{0pt}";
          else if (filecard_ctr == 1)
             sub_filecards_file << "{0pt}{.5\\hsize}";
          else if (filecard_ctr == 2)
             sub_filecards_file << "{.25\\vsize}{0pt}";
          else if (filecard_ctr == 3)
             sub_filecards_file << "{.25\\vsize}{.5\\hsize}";
          else if (filecard_ctr == 4)
             sub_filecards_file << "{.5\\vsize}{0pt}";
          else if (filecard_ctr == 5)
             sub_filecards_file << "{.5\\vsize}{.5\\hsize}";
          else if (filecard_ctr == 6)
             sub_filecards_file << "{.75\\vsize}{0pt}";
          else if (filecard_ctr == 7)
             sub_filecards_file << "{.75\\vsize}{.5\\hsize}";

          sub_filecards_file << "{"; 

          if (iter->title == "14 Lieder aus Des Knaben Wunderhorn")
          {
             sub_filecards_file << "\\vtop{\\hbox{14 Lieder aus}\\vskip\\titleskip\\hbox{Des Knaben Wunderhorn}}";
          }
          else if (!iter->filecard_title.empty())
          {
             sub_filecards_file << iter->filecard_title;
          }
          else
          {
             sub_filecards_file << iter->title;
          }

          sub_filecards_file << "}";

          /* !!START HERE:  LDF 2021.08.13.  Add code to acct. for production_subtitle.  */ 

          if (iter->is_production || iter->is_cross_reference)
          {
             sub_filecards_file << "{";

             if (iter->is_production)
             {
                if (!iter->opera.empty())
                   sub_filecards_file << "Opera";
                else if (!iter->operetta.empty())
                   sub_filecards_file << "Operetta";
                else if (!iter->song_cycle.empty())
                   sub_filecards_file << "Song Cycle";
                else if (!iter->musical.empty())
                   sub_filecards_file << "Musical";
                else if (!iter->film.empty())
                {
                   pos = iter->film.find("Film");

                   if (pos == string::npos)
                       sub_filecards_file << "Film";
                }
                else if (!iter->revue.empty())
                   sub_filecards_file << "Revue";
             }

             sub_filecards_file << "}";
          }
          if (iter->is_production)
          {
#if 0
             cerr << "iter->title:  " << iter->title << endl 
                  << "iter->year:  " << iter->year << endl;
#endif 
 
             if (iter->year > 0)
                sub_filecards_file << "{" << iter->year << "}";
             else 
                sub_filecards_file << "{}";
          }

          if (!iter->is_production) 
          {
             if (!iter->words_and_music.empty())
                sub_filecards_file << "{Words and Music:  " << iter->words_and_music << "}{}";
             else if (!(iter->words.empty() && iter->music.empty()))
             {
                if (!iter->words.empty())
                   sub_filecards_file << "{\\hbox to\\wmdimen{Words:  \\hss}" << iter->words << ".}";
                else 
                   sub_filecards_file << "{}" << endl;
                if (!iter->music.empty())
                   sub_filecards_file << "{\\hbox to\\wmdimen{Music:  \\hss}" << iter->music << ".}";
                else 
                   sub_filecards_file << "{}";
             }
             if (!iter->copyright.empty())
                sub_filecards_file << "{" << iter->copyright << "}";
             else if (iter->year >= 1900)
                sub_filecards_file << "{Copyright {\\copyright} " << iter->year << "}";
             else if (iter->year > 0)
                sub_filecards_file << "{Year:  " << iter->year << "}";
             else
                        sub_filecards_file << "{}";

             if (!iter->opera.empty())
             {
                if (iter->opera.length() > max_production_str_length)
                   sub_filecards_file << "{\\vtop{\\hbox{Opera:}\\vskip\\titleskip\\hbox{{\\largebx " 
                                      << iter->opera << "}}}}";
                else
                   sub_filecards_file << "{Opera:  {\\largebx " << iter->opera << "}}";
             }
             else if (!iter->operetta.empty())
             {
                if (iter->operetta.length() > max_production_str_length)
                   sub_filecards_file << "{\\vtop{\\hbox{Operetta:}\\vskip\\titleskip\\hbox{{\\largebx " 
                                      << iter->operetta << "}}}}";
                else
                   sub_filecards_file << "{Operetta:  {\\largebx " << iter->operetta << "}}";
             }
             else if (!iter->song_cycle.empty())
             {
                if (iter->song_cycle.length() > max_production_str_length)
                   sub_filecards_file << "{\\vtop{\\hbox{Song Cycle:}\\vskip\\titleskip\\hbox{{\\largebx " 
                                      << iter->song_cycle << "}}}}";
                else
                   sub_filecards_file << "{Song Cycle:  {\\largebx " << iter->song_cycle << "}}";
             }
             else if (!iter->musical.empty())
             {
                if (iter->musical.length() > max_production_str_length)
                   sub_filecards_file << "{\\vtop{\\hbox{Musical:}\\vskip\\titleskip\\hbox{{\\largebx " 
                                      << iter->musical << "}}}}";
                else
                   sub_filecards_file << "{Musical:  {\\largebx " << iter->musical << "}}";
             }

             else if (!iter->film.empty())
             {
                pos = iter->film.find("(Film)");

                if (pos == string::npos) 
                {
                   if (iter->film.length() > max_production_str_length)
                      sub_filecards_file << "{\\vtop{\\hbox{Film:}\\vskip\\titleskip\\hbox{{\\largebx " 
                                         << iter->film << "}}}}";
                   else
                      sub_filecards_file << "{Film:  {\\largebx " << iter->film << "}}";
                }
                else
                   sub_filecards_file << "{{\\largebx " << iter->film << "}}";
             }
             else if (!iter->revue.empty())
             {
                if (iter->revue.length() > max_production_str_length)
                   sub_filecards_file << "{\\vtop{\\hbox{Revue:  }\\vskip\\titleskip\\hbox{{\\largebx " 
                                      << iter->revue << "}}}}";
                else
                   sub_filecards_file << "{Revue:  {\\largebx " << iter->revue << "}}";
             }
             else
                sub_filecards_file << "{}";

             if (!iter->source.empty())
                sub_filecards_file << "{" << iter->source << "}";
             else
                sub_filecards_file << "{}";

          }  /* |if (!iter->is_production)|  */

          /* number_filecards, Arg. #9 to \B.  */

#if 1 
          if (iter->number_filecards)
             sub_filecards_file << "{1}";
          else 
             sub_filecards_file << "{0}";
#endif 

          sub_filecards_file << endl;

          ++filecard_ctr;
     
          if (isupper(curr_char))           
             prev_char = curr_char;

       }   /* |if (iter->do_filecard || iter->is_production)| */

/* *** (3)  */

       if (iter->is_production && !iter->is_cross_reference)
       {
/* **** (4) */

         if (iter->production_song_vector.size() > 0)
         {         
/* ***** (5) */

              if (iter->public_domain)
                 public_domain_flag = true;

              temp_str = remove_formatting_commands(iter->title);

              if (DEBUG)
              {
                 cerr << "Production:" << endl 
                      << "iter->public_domain == " << iter->public_domain << endl 
                      << "iter->title         == " << iter->title << endl 
                      << "temp_str            == " << temp_str << endl;

                 cerr << "YYY" << endl;
              }

              toc_ls_file << "\\vskip.5\\baselineskip\\vbox{{\\S}" << iter->title << endl;



              if (   (iter->title == "42nd Street" && iter->subtitle == "(Film)")
                  || iter->title == "14 Lieder aus Des Knaben Wunderhorn" 
                  || temp_char <= 'h')
              {
                 toc_ls_a_h_file << "\\vskip.5\\baselineskip\\vbox{{\\R}" << iter->title;

                 toc_ls_a_h_file << endl;
              }
              else if (temp_char <= 'o')
              {
                toc_ls_i_o_file << "\\vskip.5\\baselineskip\\vbox{{\\S}" << iter->title;

                toc_ls_i_o_file << endl;
              }
              else 
              {
                toc_ls_p_z_file << "\\vskip.5\\baselineskip\\vbox{{\\S}" << iter->title;

                toc_ls_p_z_file << endl;
              }

              if (DEBUG)
                 cerr << "iter->production_song_vector.size() == " << iter->production_song_vector.size() 
                      << endl
                      << "DDD" << endl;

              song_from_production_flag = false;

              for (vector<Song>::iterator t_iter = iter->production_song_vector.begin();
                   t_iter != iter->production_song_vector.end();
                   ++t_iter)
              {

                temp_str_2 = remove_formatting_commands(t_iter->title);

                if (DEBUG)
                    cerr << "Song from production:" << endl 
                         << "t_iter->title         == " << t_iter->title << endl 
                         << "temp_str_2              == " << temp_str_2 << endl
                         << "t_iter->scanned       == " << t_iter->scanned << endl
                         << "t_iter->eps_filenames == " << t_iter->eps_filenames << endl
                         << "ZZZ" << endl;

                if (t_iter->scanned == false && t_iter->eps_filenames.length() > 0)
                {
                    cerr << "WARNING! `t_iter->scanned' == `false' and `t_iter->eps_filenames.length()' > 0."
                         << endl
                         << "This shouldn't happen.  Continuing." << endl;

                    t_iter->scanned = true;

                }

                else if (t_iter->scanned == true && t_iter->eps_filenames.length() == 0)
                {
                    cerr << "WARNING! `t_iter->scanned' == `true' and `t_iter->eps_filenames.length()' == 0."
                         << endl
                         << "This shouldn't happen.  Continuing." << endl
                         << "t_iter->title == " << t_iter->title << endl;

                }
               

                if (t_iter->scanned)
                {
                   temp_strm.str("");

                   if (!song_from_production_flag)
                   {
                      if (!t_iter->public_domain)
                      {
                          temp_strm << "\\ifnotpublicdomainonly" << endl;
                      }


                      if (iter->subtitle.length() > 0)
                      {
                          cerr << "iter->title == " << iter->title << endl
                               << "iter->subtitle == " << iter->subtitle << endl;
                          cerr << "LLL Enter <RETURN> to continue: ";
                          getchar(); 
                      }

                      temp_strm << "\\Chapter{" << temp_str;

                      if (iter->title == t_iter->title)
                         temp_strm << "-production";

                      temp_strm << "}{" << iter->title << "}{";

                      if (t_iter->production_subtitle.length() > 0)
                         temp_strm << t_iter->production_subtitle;

                      temp_strm << "}{1}" 
                                << endl
                                << "\\hldest{xyz}{}{" << temp_str;

                      if (iter->title == t_iter->title)
                         temp_strm << "-production";

                      temp_strm << "}" << endl;

                      song_from_production_flag = true;

                   }

                   temp_strm << "\\Section{" << temp_str_2 << "}{" << t_iter->title << "}{"
                             << t_iter->subtitle << "}" << endl
                             << "\\hldest{xyz}{}{" << temp_str_2 << "}" << endl;

                   pos = 0;
                   do
                   {
                       pos_1 = t_iter->eps_filenames.find(";", pos);

                       if (DEBUG)
                           cerr << "pos == " << pos << endl
                                << "pos_1 == " << pos_1 << endl
                                << "t_iter->eps_filenames.length() == " << t_iter->eps_filenames.length() 
                                << endl;

                       if (pos_1 != string::npos)
                       {
                         temp_str_3 = t_iter->eps_filenames.substr(pos, pos_1 - pos);

                         if (DEBUG)
                            cerr << "temp_str_3 == " << temp_str_3 << endl;

                         pos = pos_1 + 1;

                         temp_strm << "\\vbox to \\vsize{\\epsffile{" << temp_str_3 << "}\\vss}" << endl
                                   << "\\eject" << endl;

                       }

                   } while (pos != string::npos && pos < t_iter->eps_filenames.length());

                   if (DEBUG)
                       cerr << "temp_str == " << temp_str << endl
                            << "temp_str_2 == " << temp_str_2 << endl
                            << "temp_strm.str() == " << endl
                            << temp_strm.str() << endl;
  
                   if (curr_songs_file)
                      *curr_songs_file << temp_strm.str();

                   temp_strm.str("");

                }  /* |if (t_iter->scanned)|  */

                sub_filecards_file << "\\leftline{\\hskip\\Chskip\\hskip\\basichskip " << t_iter->title << "}" 
                                   << endl << "\\vskip12pt" << endl;

                toc_ls_file << "\\S\\S {" << t_iter->title;
 
                if (t_iter->subtitle.length() > 0)   
                   toc_ls_file << " " << t_iter->subtitle;

                toc_ls_file << "}" << endl;

                if (   (iter->title == "42nd Street" && iter->subtitle == "(Film)") 
                    || iter->title == "14 Lieder aus Des Knaben Wunderhorn" 
                    || temp_char <= 'h')
                {
                  toc_ls_a_h_file << "\\R\\R {" << t_iter->title << "}" << endl;
                }
                else if (temp_char <= 'o')
                  toc_ls_i_o_file << "\\S\\S {" << t_iter->title << "}" << endl;
                else 
                  toc_ls_p_z_file << "\\S\\S {" << t_iter->title << "}" << endl;

            }    /* |for| (production_song_vector)  */

/* ***** (5) */

            if (song_from_production_flag)
            {
               if (!public_domain_flag)
                  *curr_songs_file << "\\fi" << endl << endl;
               else 
                  *curr_songs_file << endl;
            }

/* ***** (5) */


            temp_strm.str("");

            toc_ls_file << "}" << endl;

            if ((iter->title == "42nd Street" && iter->subtitle == "(Film)")
                || iter->title == "14 Lieder aus Des Knaben Wunderhorn" 
                || temp_char <= 'h')
              toc_ls_a_h_file << "}" << endl;
            else if (temp_char <= 'o')
              toc_ls_i_o_file << "}" << endl;
            else 
              toc_ls_p_z_file << "}" << endl;
         
/* ***** (5) */

          }  /* |if|  */

/* **** (4) */


       }  /* |if|  */
       
       song_from_production_flag = false;

/* *** (3) */

       if (iter->is_cross_reference)
       {
          sub_filecards_file << "\\leftline{\\hskip\\Chskip\\hskip\\basichskip "
                             << "{\\large See {\\largebx " << iter->target << "}}}" << endl;
          if (iter->sort_by_production)
             sub_filecards_file << "\\vskip\\titleskip\\leftline{\\hskip\\Chskip\\hskip\\basichskip{\\large  "
                                << "under {\\largebx " << iter->production << "}}}" << endl;
       }


/* *** (3) */

       if (iter->is_production || iter->is_cross_reference)
          sub_filecards_file << "\\vss}" << endl;          

       if (iter->lead_sheet || iter->is_cross_reference || iter->is_production)
       {

         if (    iter->lead_sheet && iter->scanned && iter->eps_filenames.length() > 0 
             &&  !iter->is_production && !iter->sort_by_production 
             && !iter->is_cross_reference)
         {

            temp_strm.str("");

            temp_str_1 = remove_formatting_commands(iter->title);
            
            if (DEBUG)
                cerr << "iter->public_domain == " << iter->public_domain << endl 
                     << "iter->title         == " << iter->title << endl 
                     << "iter->subtitle      == " << iter->subtitle << endl 
                     << "iter->eps_filenames == " << iter->eps_filenames << endl
                     << "temp_str_1          == " << temp_str_1 << endl;


            if (!iter->public_domain)
               temp_strm << "\\ifnotpublicdomainonly" << endl;
#if 0
            if (iter->subtitle.length() > 0)
            {
                cerr << "iter->subtitle == " << iter->subtitle << endl;
                cerr << "YYY Enter <RETURN> to continue: ";
                getchar(); 
            }
#endif 
            temp_strm << "\\Chapter{" << temp_str_1 << "}{" << iter->title << "}{";
 
            if (iter->subtitle.length() > 0)
               temp_strm << iter->subtitle;

            temp_strm << "}{0}" << endl
                      << "\\hldest{xyz}{}{" << temp_str_1 << "}" << endl; 

            pos = 0;
            do
            {

                pos_1 = iter->eps_filenames.find(";", pos);

                if (DEBUG)
                   cerr << "pos == " << pos << endl
                        << "pos_1 == " << pos_1 << endl
                        << "iter->eps_filenames.length() == " << iter->eps_filenames.length() 
                        << endl;

                if (pos_1 != string::npos)
                {
                  temp_str_1 = iter->eps_filenames.substr(pos, pos_1 - pos);

                  if (DEBUG)
                     cerr << "temp_str_1 == " << temp_str_1 << endl;

                  pos = pos_1 + 1;

                  temp_strm << "\\vbox to \\vsize{\\epsffile{" << temp_str_1 << "}\\vss}" << endl
                            << "\\eject" << endl;

                }

            } while (pos != string::npos && pos < iter->eps_filenames.length());


            if (!iter->public_domain)
               temp_strm << "\\fi" << endl;

            temp_strm << endl;

            if (temp_strm.str().length() > 0)
            {
                if (curr_songs_file)
                   *curr_songs_file << temp_strm.str();

                temp_strm.str("");
            }

         } /* |if|  */

         if (iter->is_cross_reference)
         {
            toc_ls_file << "\\vskip.5\\baselineskip\\vbox{\\S " << iter->title
                        << endl
                        << "\\nobreak" << endl << "\\S (see  ``" << iter->target << "''";

            if (iter->production != "")
               toc_ls_file << "\\nobreak" << endl << "\\S under ``" << iter->production << "''";

            toc_ls_file << ")}" << endl << endl;
         }
         else if (!iter->is_production)
         {
            toc_ls_file << "\\N " << iter->title;
 
            if (iter->subtitle.length() > 0)
               toc_ls_file << " " << iter->subtitle;

            toc_ls_file << endl;
         }
          
         if (iter->musical.length() > 0 && iter->sort_by_production)
           toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->musical << "'')"
                       << endl;
         else if (iter->opera.length() > 0 && iter->sort_by_production)
           toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->opera << "'')"
                       << endl;
         else if (iter->operetta.length() > 0 && iter->sort_by_production)
           toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->operetta << "'')"
                       << endl;
         else if (iter->song_cycle.length() > 0 && iter->sort_by_production)
         {
           if (iter->song_cycle.length() > 20)
           {
              toc_ls_file << "\\nobreak" << endl << "\\S (see under" << endl 
                          << "\\S ``" << iter->song_cycle << "'')" << endl;
           }
           else
           {
              toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->song_cycle << "'')"
                          << endl;
           }

         }
         else if (iter->revue.length() > 0 && iter->sort_by_production)
           toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->revue << "'')"
                       << endl;
         else if (iter->film.length() > 0 && iter->sort_by_production)
           toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->film << "'')"
                       << endl;
         
         toc_ls_file << endl;

         if (   (iter->title == "42nd Street" && iter->subtitle == "(Film)")
             || iter->title == "14 Lieder aus Des Knaben Wunderhorn" 
             || temp_char <= 'h')
         {
             if (iter->is_cross_reference)
             {
                toc_ls_a_h_file << "\\vskip.5\\baselineskip\\vbox{\\S " << iter->title
                            << endl
                            << "\\nobreak" << endl << "\\S (see  ``" << iter->target << "''";

                if (iter->production != "")
                   toc_ls_a_h_file << "\\nobreak" << endl << "\\S under ``" << iter->production << "''";

                toc_ls_a_h_file << ")}" << endl << endl;
             }
             else if (!iter->is_production)
                toc_ls_a_h_file << "\\M " << iter->title << endl;

            if (iter->musical.length() > 0 && iter->sort_by_production)
              toc_ls_a_h_file << "\\nobreak" << endl << "\\R (see under ``" << iter->musical << "'')"
                              << endl;
            else if (iter->opera.length() > 0 && iter->sort_by_production)
              toc_ls_a_h_file << "\\nobreak" << endl << "\\R (see under ``" << iter->opera << "'')"
                              << endl;
            else if (iter->operetta.length() > 0 && iter->sort_by_production)
              toc_ls_a_h_file << "\\nobreak" << endl << "\\R (see under ``" << iter->operetta << "'')"
                              << endl;
            else if (iter->song_cycle.length() > 0 && iter->sort_by_production)
            {
              if (iter->song_cycle.length() > 20)
              {
                 toc_ls_a_h_file << "\\nobreak" << endl << "\\S (see under" << endl 
                             << "\\S ``" << iter->song_cycle << "'')" << endl;
              }
              else
              {
                 toc_ls_a_h_file << "\\nobreak" << endl << "\\S (see under ``" << iter->song_cycle << "'')"
                             << endl;
              }

            }  
            else if (iter->revue.length() > 0 && iter->sort_by_production)
              toc_ls_a_h_file << "\\nobreak" << endl << "\\R (see under ``" << iter->revue << "'')"
                              << endl;
            else if (iter->film.length() > 0 && iter->sort_by_production)
              toc_ls_a_h_file << "\\nobreak" << endl << "\\R (see under ``" << iter->film << "'')"
                              << endl;
         
            toc_ls_a_h_file << endl;
         }
         else if (temp_char <= 'o')
         {
             if (iter->is_cross_reference)
             {
                toc_ls_i_o_file << "\\vskip.5\\baselineskip\\vbox{\\S " << iter->title
                            << endl
                            << "\\nobreak" << endl << "\\S (see  ``" << iter->target << "''";

                if (iter->production != "")
                   toc_ls_i_o_file << "\\nobreak" << endl << "\\S under ``" << iter->production << "''";

                toc_ls_i_o_file << ")}" << endl << endl;
             }
             else if (!iter->is_production)
             {
               toc_ls_i_o_file << "\\N " << iter->title;

               if (iter->subtitle.length() > 0)
                  toc_ls_i_o_file << " " << iter->subtitle;

               toc_ls_i_o_file << endl;

             }

            if (iter->musical.length() > 0 && iter->sort_by_production)
              toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under ``" << iter->musical << "'')"
                              << endl;
            else if (iter->opera.length() > 0 && iter->sort_by_production)
              toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under ``" << iter->opera << "'')"
                              << endl;
            else if (iter->operetta.length() > 0 && iter->sort_by_production)
              toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under ``" << iter->operetta << "'')"
                              << endl;
            else if (iter->song_cycle.length() > 0 && iter->sort_by_production)
            {
              if (iter->song_cycle.length() > 20)
              {
                 toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under" << endl 
                             << "\\S ``" << iter->song_cycle << "'')" << endl;
              }
              else
              {
                 toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under ``" << iter->song_cycle << "'')"
                             << endl;
              }

            }  
            else if (iter->revue.length() > 0 && iter->sort_by_production)
              toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under ``" << iter->revue << "'')"
                              << endl;
            else if (iter->film.length() > 0 && iter->sort_by_production)
              toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under ``" << iter->film << "'')"
                              << endl;
         
            toc_ls_i_o_file << endl;

         }
         else
         {
           if (iter->is_cross_reference)
           {
              toc_ls_p_z_file << "\\vskip.5\\baselineskip\\vbox{\\S " << iter->title
                          << endl
                          << "\\nobreak" << endl << "\\S (see  ``" << iter->target << "''";

              if (iter->production != "")
                 toc_ls_p_z_file << "\\nobreak" << endl << "\\S under ``" << iter->production << "''";

              toc_ls_p_z_file << ")}" << endl << endl;
           }
           else if (!iter->is_production)
           {
             toc_ls_p_z_file << "\\N " << iter->title;

             if (iter->subtitle.length() > 0)
                toc_ls_p_z_file << " " << iter->subtitle;

             toc_ls_p_z_file << endl;
           }
          
           if (iter->musical.length() > 0 && iter->sort_by_production)
             toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->musical << "'')"
                             << endl;
           else if (iter->opera.length() > 0 && iter->sort_by_production)
             toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->opera << "'')"
                             << endl;
           else if (iter->operetta.length() > 0 && iter->sort_by_production)
             toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->operetta << "'')"
                             << endl;
           else if (iter->song_cycle.length() > 0 && iter->sort_by_production)
           {
             if (iter->song_cycle.length() > 20)
             {
                toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under" << endl 
                            << "\\S ``" << iter->song_cycle << "'')" << endl;
             }
             else
             {
                toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->song_cycle << "'')"
                            << endl;
             }

           }  
           else if (iter->revue.length() > 0 && iter->sort_by_production)
             toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->revue << "'')"
                             << endl;
           else if (iter->film.length() > 0 && iter->sort_by_production)
             toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->film << "'')"
                             << endl;
         
           toc_ls_p_z_file << endl;
         }

       }  /* |if|  */

       else if (iter->no_page_turns)
       {
         toc_npt_file << "\\M " << iter->title << endl << endl;
       }

       else if (iter->no_page_turns_with_two_songbooks)
       {
         toc_npt_file << "\\M " << iter->title << " (WTS)" << endl << endl;
       }
       else if (iter->partial_lead_sheet)
       {
         toc_npt_file << "\\M " << iter->title << " (PLS)" << endl << endl;
       }

       
     }  /* |for|  */
 

/* *** (3)  */

   toc_ls_file << "\\singlecolumn" << endl 
               << "\\vfil\\eject" << endl
               << "\\pagecnt=\\pageno" << endl
               << "\\endinput" << endl << endl;

   toc_ls_a_h_file << "\\singlecolumn" << endl
                   << "\\vfil\\eject" << endl
                   << "\\ifseparate" << endl
                   << "\\else" << endl
                   << "\\pagecnt=\\pageno" << endl
                   << "\\fi" << endl
                   << "\\endinput" << endl << endl;

   toc_ls_i_o_file << "\\singlecolumn" << endl
                   << "\\vfil\\eject" << endl
                   << "\\ifseparate" << endl
                   << "\\else" << endl
                   << "\\pagecnt=\\pageno" << endl
                   << "\\fi" << endl
                   << "\\endinput" << endl << endl;


   toc_ls_p_z_file << "\\singlecolumn" << endl
                   << "\\vfil\\eject" << endl
                   << "\\ifseparate" << endl
                   << "\\else" << endl
                   << "\\pagecnt=\\pageno" << endl
                   << "\\fi" << endl
                   << "\\endinput" << endl << endl;

   songs_a_e_file << "\\endinput" << endl << endl;


   songs_f_l_file << "\\endinput" << endl << endl;


   songs_m_n_file << "\\endinput" << endl << endl;

   songs_o_s_file << "\\endinput" << endl << endl;

   songs_t_z_file << "\\endinput" << endl << endl;

   toc_ls_file.close();
   toc_ls_a_h_file.close();
   toc_ls_i_o_file.close();
   toc_ls_p_z_file.close();
   songs_a_e_file.close();
   songs_f_l_file.close();
   songs_m_n_file.close();
   songs_o_s_file.close();
   songs_t_z_file.close();


   toc_npt_file << "\\vskip2cm" << endl << endl
                << "PLS:  Partial lead sheet\\quad WTS:  No page turns with two songbooks"
                << "\\vfil\\eject" << endl
                << "\\ifseparate" << endl
                << "\\else" << endl
                << "\\pagecnt=\\pageno" << endl
                << "\\fi" << endl
                << "\\endinput" << endl << endl;

   toc_npt_file.close();

   french_file << "%%\\singlecolumn" << endl
               << "%%\\vfil\\eject" << endl
               << "\\endgroup" << endl 
               << "\\endinput" << endl << endl;

   german_file << "%%\\singlecolumn" << endl
               << "%%\\vfil\\eject" << endl
               << "\\endgroup" << endl 
               << "\\endinput" << endl << endl;

   italian_file << "%%\\singlecolumn" << endl
                << "%%\\vfil\\eject" << endl
                << "\\endgroup" << endl 
                << "\\endinput" << endl << endl;

   portugese_file << "%%\\singlecolumn" << endl
                  << "%%\\vfil\\eject" << endl
                  << "\\endgroup" << endl 
                  << "\\endinput" << endl << endl;

   russian_file << "%%\\singlecolumn" << endl
                << "%%\\vfil\\eject" << endl
                << "\\endgroup" << endl 
                << "\\endinput" << endl << endl;

   spanish_file << "%%\\singlecolumn" << endl
                << "%%\\vfil\\eject" << endl
                << "\\endgroup" << endl 
                << "\\endinput" << endl << endl;


   sub_filecards_file << endl << "\\endinput" << endl << endl;

   french_file.close();    
   german_file.close();    
   italian_file.close();   
   portugese_file.close(); 
   russian_file.close();   
   spanish_file.close();   
   sub_filecards_file.close();    

/* *** (3)  */

   vector<Song> temp_song_vector;

   for (vector<Song>::iterator iter = song_vector.begin();
        iter != song_vector.end();
        ++iter)
   {
       if (iter->is_production)
          continue;

       if (   iter->opera != "" || iter->operetta != "" || iter->song_cycle != "" 
           || iter->musical != "" || iter->revue != "" || iter->film != "")
       {
          temp_song_vector.push_back(*iter);
       }
   }

   sort(temp_song_vector.begin(), temp_song_vector.end(), compare_titles);
   stable_sort(temp_song_vector.begin(), temp_song_vector.end(), compare_productions);
   
   string curr_prod;
   string prev_prod;

   curr_char = prev_char = '\0';
   
   for (vector<Song>::iterator iter = temp_song_vector.begin();
        iter != temp_song_vector.end();
        ++iter)
   {

       if (iter->opera != "")
       {
          curr_prod = iter->opera;

          if (curr_prod != prev_prod)
          {
             if (prev_prod != "")
                productions_file << "}\\vskip.5\\baselineskip" << endl;

#if 0
             cerr << "Opera:     " << iter->opera << endl;
#endif

             temp_str = remove_formatting_commands(iter->opera);
             curr_char = toupper(temp_str[0]);
       
             if (isupper(curr_char) && curr_char != prev_char)
             {
               productions_file << "\\writeptcentry{chapter}{\\hlstart{}{bwidth=0}{production " << char(curr_char) 
                                << "}\\Blue{" << char(curr_char) << "}\\hlend}" << endl;

               productions_file << "\\hldest{xyz}{}{production " << char(curr_char) << "}" << endl;

             }
  
             if (isupper(curr_char))
               productions_file << "\\mark{" << char(curr_char) << "}\\nobreak" << endl;

             productions_file << "\\vbox{\\hbox{{\\bf " << iter->opera << "}";

             if (iter->opera.length() > max_production_str_length)
               productions_file << "}" << endl << "\\hbox{";
             else 
               productions_file << " ";

             productions_file << "(Opera";
             if (iter->year > 0)
                productions_file << " " << iter->year;
             productions_file << ")}" << endl;
 
             if (isupper(curr_char))           
               prev_char = curr_char;


          }
       }
       if (iter->operetta != "")
       {
          curr_prod = iter->operetta;
          if (curr_prod != prev_prod)
          {
             if (prev_prod != "")
                productions_file << "}\\vskip.5\\baselineskip" << endl;

#if 0
             cerr << "Operetta:  " << iter->operetta << endl;
#endif

             temp_str = remove_formatting_commands(iter->operetta);
             curr_char = toupper(temp_str[0]);
    
             if (isupper(curr_char) && curr_char != prev_char)
             {
               productions_file << "\\writeptcentry{chapter}{\\hlstart{}{bwidth=0}{production " << char(curr_char) 
                                << "}\\Blue{" << char(curr_char) << "}\\hlend}" << endl;

               productions_file << "\\hldest{xyz}{}{production " << char(curr_char) << "}" << endl;
             }
  
             if (isupper(curr_char))
               productions_file << "\\mark{" << char(curr_char) << "}\\nobreak" << endl;

             productions_file << "\\vbox{\\hbox{{\\bf " << iter->operetta << "}";
             if (iter->operetta.length() > max_production_str_length)
               productions_file << "}" << endl << "\\hbox{";
             else 
               productions_file << " ";
             productions_file << "(Operetta";

             if (iter->year > 0)
                productions_file << " " << iter->year;

             productions_file << ")}" << endl;

             if (isupper(curr_char))           
               prev_char = curr_char;

          }
       }
       if (iter->song_cycle != "")
       {
          curr_prod = iter->song_cycle;
          if (curr_prod != prev_prod)
          {
             if (prev_prod != "")
                productions_file << "}\\vskip.5\\baselineskip" << endl;

#if 0 
             cerr << "Song cycle:  " << iter->song_cycle << endl;
#endif 

             temp_str = remove_formatting_commands(iter->song_cycle);

             if (temp_str[0] == '4' || (temp_str[0] == '1' && temp_str[1] == '4'))
                curr_char = 'F';
             else
                curr_char = toupper(temp_str[0]);
              
             if (isupper(curr_char) && curr_char != prev_char)
             {
               productions_file << "\\writeptcentry{chapter}{\\hlstart{}{bwidth=0}{production " << char(curr_char) 
                                << "}\\Blue{" << char(curr_char) << "}\\hlend}" << endl;

               productions_file << "\\hldest{xyz}{}{production " << char(curr_char) << "}" << endl;
             }
  
             if (isupper(curr_char))
               productions_file << "\\mark{" << char(curr_char) << "}\\nobreak" << endl;

             productions_file << "\\vbox{\\hbox{{\\bf " << iter->song_cycle << "}";

             if (iter->song_cycle.length() > max_production_str_length)
               productions_file << "}" << endl << "\\hbox{";
             else 
               productions_file << " ";

             productions_file << "(Song Cycle";

             if (iter->year > 0)
                productions_file << " " << iter->year;
             productions_file << ")}" << endl;

             if (isupper(curr_char))           
               prev_char = curr_char;

          }
       }
       if (iter->musical != "")
       {
          curr_prod = iter->musical;
          if (curr_prod != prev_prod)
          {       
             if (prev_prod != "")
                productions_file << "}\\vskip.5\\baselineskip" << endl;
#if 0 
             cerr << "Musical:   " << iter->musical << endl;
#endif 

             temp_str = remove_formatting_commands(iter->musical);

             if (temp_str[0] == '4' || (temp_str[0] == '1' && temp_str[1] == '4'))
                curr_char = 'F';
             else
                curr_char = toupper(temp_str[0]);
 
             if (isupper(curr_char) && curr_char != prev_char)
             {
               productions_file << "\\writeptcentry{chapter}{\\hlstart{}{bwidth=0}{production " << char(curr_char) 
                                << "}\\Blue{" << char(curr_char) << "}\\hlend}" << endl;

               productions_file << "\\hldest{xyz}{}{production " << char(curr_char) << "}" << endl;
             }
  
             if (isupper(curr_char))
               productions_file << "\\mark{" << char(curr_char) << "}\\nobreak" << endl;

             productions_file << "\\vbox{\\hbox{{\\bf " << iter->musical << "}";

             if (iter->musical.length() > max_production_str_length)
               productions_file << "}" << endl << "\\hbox{";
             else 
               productions_file << " ";

             productions_file << "(Musical";

             if (iter->year > 0)
                productions_file << " " << iter->year;
             productions_file << ")}" << endl;

             if (isupper(curr_char))           
               prev_char = curr_char;

          }
       }
       if (iter->revue != "")
       {
          curr_prod = iter->revue;
          if (curr_prod != prev_prod)       
          {
             if (prev_prod != "")
                productions_file << "}\\vskip.5\\baselineskip" << endl;

#if 0 
             cerr << "Revue:     " << iter->revue << endl;
#endif 

             temp_str = remove_formatting_commands(iter->revue);

             curr_char = toupper(temp_str[0]);
       
             if (isupper(curr_char) && curr_char != prev_char)
             {
               productions_file << "\\writeptcentry{chapter}{\\hlstart{}{bwidth=0}{production " << char(curr_char) 
                                << "}\\Blue{" << char(curr_char) << "}\\hlend}" << endl;

               productions_file << "\\hldest{xyz}{}{production " << char(curr_char) << "}" << endl;
             }
    
             if (isupper(curr_char))
               productions_file << "\\mark{" << char(curr_char) << "}\\nobreak" << endl;

             productions_file << "\\vbox{\\hbox{{\\bf " << iter->revue << "}";


             if (iter->revue.length() > max_production_str_length)
               productions_file << "}" << endl << "\\hbox{";
             else 
               productions_file << " ";

             productions_file << "(Revue";

             if (iter->year > 0)
                productions_file << " " << iter->year;
             productions_file << ")}" << endl;

             if (isupper(curr_char))           
               prev_char = curr_char;

          }
       }
       if (iter->film != "")
       {
          curr_prod = iter->film;
          if (curr_prod != prev_prod)       
          {
             if (prev_prod != "")
                productions_file << "}\\vskip.5\\baselineskip" << endl;

#if 0
             cerr << "Film:      " << iter->film << endl;
#endif 
             temp_str = remove_formatting_commands(iter->film);

             if (temp_str[0] == '4' || (temp_str[0] == '1' && temp_str[1] == '4'))
                curr_char = 'F';
             else
                curr_char = toupper(temp_str[0]);
       
             if (isupper(curr_char) && curr_char != prev_char)
             {
                 productions_file << "\\writeptcentry{chapter}{\\hlstart{}{bwidth=0}{production " << char(curr_char) 
                                  << "}\\Blue{" << char(curr_char) << "}\\hlend}" << endl;
                 productions_file << "\\hldest{xyz}{}{production " << char(curr_char) << "}" << endl;
             }

             if (isupper(curr_char))
               productions_file << "\\mark{" << char(curr_char) << "}\\nobreak" << endl;

             productions_file << "\\vbox{\\hbox{{\\bf " << iter->film << "}";

             pos = iter->film.find("(Film)");
             if (pos == string::npos || iter->year > 0)
             {
               if (iter->film.length() > max_production_str_length)
                  productions_file << "}" << endl << "\\hbox{";
               else 
                  productions_file << " ";
               productions_file << "(";
             }
             if (pos == string::npos)
                productions_file << "Film";
             if (pos == string::npos && iter->year > 0)
                productions_file << " ";
             if (iter->year > 0)
                productions_file << iter->year;
             if (pos == string::npos || iter->year > 0)
                productions_file << ")";
             productions_file << "}" << endl;

             if (isupper(curr_char))           
               prev_char = curr_char;

          }
       }
#if 0 
       cerr << "   Title:     " << iter->title << endl;
#endif 

       productions_file << "\\hbox{\\quad " << iter->title << "}" << endl;

       prev_prod = curr_prod;

   }  /* |for|  */
 
   productions_file << "}" << endl;

   productions_file << "%%\\singlecolumn %% DO NOT UNCOMMENT THIS!" << endl
                   << "\\vfil\\eject" << endl
                   << "\\singlecolumn" << endl
                   << "\\endgroup" << endl 
                   << "\\endinput" << endl << endl;

   productions_file.close();   

/* ** (2) */

   return 0;
   
}  /* End of |process_tocs_and_npt| definition  */

/* * (1) Emacs-Lisp code for use in indirect buffers when using the          */
/*       GNU Emacs editor.  The local variable list is not evaluated when an */
/*       indirect buffer is visited, so it's necessary to evaluate the       */
/*       following s-expression in order to use the facilities normally      */
/*       accessed via the local variables list.                              */
/*       \initials{LDF 2004.02.12}.                                          */
/*       (progn (cweb-mode) (outline-minor-mode t))                          */

/* eval:(setq outline-regexp "/\\* \\*+") */


/* * Local variables for Emacs.*/

/* Local Variables: */
/* mode:CWEB */
/* eval:(display-time) */
/* eval:(read-abbrev-file) */
/* indent-tabs-mode:nil */
/* outline-minor-mode:t */
/* eval:(set (make-local-variable 'outline-regexp) "/\\* \\*+") */
/* fill-column:80 */
/* End: */


