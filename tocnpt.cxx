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

vector<Song> song_vector;

ofstream toc_ls_file;
ofstream toc_ls_a_h_file;
ofstream toc_ls_i_o_file;
ofstream toc_ls_p_z_file;
ofstream toc_npt_file;

/* ``tocs'' stands for ``table(s) of contents''.  */
/* ``npt'' stands for ``no page turns''.          */

int
process_tocs_and_npt(void)
{

  bool DEBUG = false; /* |true|  */

  int status;
  
  stringstream temp_strm;
  
   Song curr_song;

   Production curr_production;

   vector<Production> production_vector;

   errno = 0;

   affected_rows = 0L;

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
             <<        "musical, "                          // 16
             <<        "revue, "                            // 17
	     <<        "film, "                             // 18
             <<        "sort_by_production, "               // 19
             <<        "year, "                             // 20
             <<        "copyright, "                        // 21
             <<        "notes "                             // 22
             << "from Songs order by title asc;";

   if (DEBUG) 
     cout << "temp_strm.str() == " << temp_strm.str() << endl;

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
       cout << "`submit_mysql_query' succeeded, returning 0." << endl;
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
	     cout << "`mysql_fetch_row' returned NULL:" 
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
	       cout << "No more rows." << endl;
	     }

	   break;

	 }  /* |if (curr_row == 0)|  */

       if (DEBUG)
	 cout << "`title'                            == " << curr_row[0] << endl;

       curr_song.title.assign(curr_row[0]);

       if (DEBUG) 
	 cout << "curr_song.title == " << curr_song.title << endl;
       
       if (curr_row[1])
	 {
	   if (DEBUG)
	     cout << "`words'                            == " << curr_row[1] << endl;
	   curr_song.words.assign(curr_row[1]);

	 }
       else
	 {
	   if (DEBUG)
	     cout << "`words'                            == NULL" << endl;
	 }

       if (curr_row[2])
	 {
	   if (DEBUG)
	     cout << "`words_reverse'                    == " << curr_row[2] << endl;
	   curr_song.words_reverse.assign(curr_row[2]);

	 }
       else
	 {
	   if (DEBUG)
	     cout << "`words_reverse'                    == NULL" << endl;
	 }

       if (curr_row[3])
	 {
	   if (DEBUG)
	     cout << "`music'                            == " << curr_row[3] << endl;
	   curr_song.music.assign(curr_row[3]);
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`music'                            == NULL" << endl;
	 }


       if (curr_row[4])
	 {
	   if (DEBUG)
	     cout << "`music_reverse'                    == " << curr_row[4] << endl;
	   curr_song.music_reverse.assign(curr_row[4]);
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`music_reverse'                    == NULL" << endl;
	 }

       if (curr_row[5])
	 {
	   if (DEBUG)
	     cout << "`words_and_music'                  == " << curr_row[5] << endl;
	   curr_song.words_and_music.assign(curr_row[5]);
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`words_and_music'                  == NULL" << endl;
	 }

       if (curr_row[6])
	 {
	   if (DEBUG)
	     cout << "`words_and_music_reverse'          == " << curr_row[6] << endl;
	   curr_song.words_and_music_reverse.assign(curr_row[6]);
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`words_and_music_reverse'          == NULL" << endl;
	 }

       if (DEBUG)
	 cout << "`lead_sheet'                       == " << curr_row[7] << endl;
       curr_song.lead_sheet = atoi(curr_row[7]);

       if (DEBUG)
	 cout << "`partial_lead_sheet'               == " << curr_row[8] << endl;
       curr_song.partial_lead_sheet = atoi(curr_row[8]);

       if (DEBUG)
	 cout << "`no_page_turns'                    == " << curr_row[9] << endl;
       curr_song.no_page_turns = atoi(curr_row[9]);

       if (DEBUG)
	 cout << "`no_page_turns_with_two_songbooks' == " << curr_row[10] << endl;
       curr_song.no_page_turns_with_two_songbooks = atoi(curr_row[10]);

       if (DEBUG)
	 cout << "`arrangement_orchestra'            == " << curr_row[11] << endl;
       curr_song.arrangement_orchestra = atoi(curr_row[11]);

       if (DEBUG)
	 cout << "`arrangement_solo_guitar'          == " << curr_row[12] << endl;
       curr_song.arrangement_solo_guitar = atoi(curr_row[12]);

       if (DEBUG)
	 cout << "`recordings'                       == " << curr_row[13] << endl;
       curr_song.recordings = atoi(curr_row[13]);
	   
       if (curr_row[14])
	 {
	   if (DEBUG)
	     cout << "`opera'                            == " << curr_row[14] << endl;
	   curr_song.opera.assign(curr_row[14]);	   
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`opera'                            == NULL" << endl;
	 }

       if (curr_row[15])
	 {
	   if (DEBUG)
	     cout << "`operetta'                         == " << curr_row[15] << endl;
	   curr_song.operetta.assign(curr_row[15]);	   
	 }
       else
	 {   if (DEBUG)
	     cout << "`operetta'                         == NULL" << endl;
	 }

       if (curr_row[16])
	 {
	   if (DEBUG)
	     cout << "`musical'                          == " << curr_row[16] << endl;
	   curr_song.musical.assign(curr_row[16]);	   
	 }
       else
	 {   if (DEBUG)
	     cout << "`musical'                          == NULL" << endl;
	 }  

       if (curr_row[17])
	 {
	   if (DEBUG)
	     cout << "`revue'                            == " << curr_row[17] << endl;
	   curr_song.revue.assign(curr_row[17]);
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`revue'                            == NULL" << endl;
	 }

       if (curr_row[18])
	 {
	   if (DEBUG)
	     cout << "`film'                             == " << curr_row[18] << endl;
	   curr_song.film.assign(curr_row[18]);	   
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`film'                             == NULL" << endl;
	 }

       if (DEBUG)
	 cout << "`sort_by_production'               == " << curr_row[19] << endl;
       curr_song.sort_by_production = atoi(curr_row[19]);

       status = atoi(curr_row[19]);

       if (status > 0)
	 {
	   if (DEBUG)
	     cout << "curr_song.sort_by_production = " << curr_song.sort_by_production << endl;
	 }

       if (curr_row[20])
	 {
	   if (DEBUG)
	     cout << "`year'                             == " << curr_row[20] << endl;
	   curr_song.year = atoi(curr_row[20]);
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`year'                             == NULL" << endl;
	   curr_song.year = 0;
	 }


       if (curr_row[21])
	 {
	   if (DEBUG)
	     cout << "`copyright'                        == " << curr_row[21] << endl;
	   curr_song.copyright.assign(curr_row[21]);
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`copyright'                        == NULL" << endl;
	 }


       if (curr_row[22])
	 {
	   if (DEBUG)
	     cout << "`notes'                            == " << curr_row[22] << endl;
	   curr_song.notes.assign(curr_row[22]);
	 }
       else
	 {
	   if (DEBUG)
	     cout << "`notes'                            == NULL" << endl << endl;
	 }

       if (DEBUG)
	 curr_song.show("curr_song:");

       song_vector.push_back(curr_song);

       if (DEBUG) 
	 cout << "song_vector.back().title == " << song_vector.back().title << endl;

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
      cerr << "WARNING:  In `process_tocs_and_npt':  `song_vector is empty'.  No songs to show." << endl
	   << "Exiting `songlist' successfully with exit status 0."
           << endl;

      /* Close connection to database.  */

      mysql_library_end();

      exit(0);
 
   }
   else if (DEBUG)
     cout << "`song_vector.size()' == " << song_vector.size() << "."
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

   temp_strm << "select distinct musical from Songs where musical is not null "
             << "and sort_by_production is true and lead_sheet is true order by musical;";

   if (DEBUG) 
     cout << "temp_strm.str() == " << temp_strm.str() << endl;

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
	 cout << "`submit_mysql_query' succeeded, returning 0." << endl;
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
		 cout << "`mysql_fetch_row' returned NULL:" 
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
		   cout << "No more rows." << endl;
		 }

	       break;

	     }  /* |if (curr_row == 0)|  */

	   if (DEBUG)
	     cout << "`musical' == " << curr_row[0] << endl;

	   curr_production.title.assign(curr_row[0]);
	   curr_production.musical.assign(curr_row[0]);
	   curr_production.is_production = true;

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
   
   temp_strm << "select distinct opera from Songs where opera is not null "
             << "and sort_by_production is true and lead_sheet is true order by opera;";

   if (DEBUG) 
     cout << "temp_strm.str() == " << temp_strm.str() << endl;
   
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
       cout << "`submit_mysql_query' succeeded, returning 0." << endl;
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
		 cout << "`mysql_fetch_row' returned NULL:" 
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
		   cout << "No more rows." << endl;
		 }

	       break;

	     }  /* |if (curr_row == 0)|  */

	   if (DEBUG)
	     cout << "`opera' == " << curr_row[0] << endl;

	   curr_production.title.assign(curr_row[0]);
	   curr_production.opera.assign(curr_row[0]);
	   curr_production.is_production = true;

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
   
   temp_strm << "select distinct operetta from Songs where operetta is not null "
             << "and sort_by_production is true and lead_sheet is true order by operetta;";

   if (DEBUG) 
     cout << "temp_strm.str() == " << temp_strm.str() << endl;
   
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
       cout << "`submit_mysql_query' succeeded, returning 0." << endl;
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
		 cout << "`mysql_fetch_row' returned NULL:" 
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
		   cout << "No more rows." << endl;
		 }

	       break;

	     }  /* |if (curr_row == 0)|  */

	   if (DEBUG)
	     cout << "`operetta' == " << curr_row[0] << endl;

	   curr_production.title.assign(curr_row[0]);
	   curr_production.operetta.assign(curr_row[0]);
	   curr_production.is_production = true;

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
   
   temp_strm << "select distinct revue from Songs where revue is not null "
             << "and sort_by_production is true and lead_sheet is true order by revue";

   if (DEBUG) 
     cout << "temp_strm.str() == " << temp_strm.str() << endl;
   
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
       cout << "`submit_mysql_query' succeeded, returning 0." << endl;
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
		 cout << "`mysql_fetch_row' returned NULL:" 
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
		   cout << "No more rows." << endl;
		 }

	       break;

	     }  /* |if (curr_row == 0)|  */

	   if (DEBUG)
	     cout << "`revue' == " << curr_row[0] << endl;

	   curr_production.title.assign(curr_row[0]);
	   curr_production.revue.assign(curr_row[0]);
	   curr_production.is_production = true;

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
   
   temp_strm << "select distinct film from Songs where film is not null "
             << "and sort_by_production is true and lead_sheet is true order by film;";

   if (DEBUG) 
     cout << "temp_strm.str() == " << temp_strm.str() << endl;

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
       cout << "`submit_mysql_query' succeeded, returning 0." << endl;
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
		 cout << "`mysql_fetch_row' returned NULL:" 
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
		   cout << "No more rows." << endl;
		 }

	       break;

	     }  /* |if (curr_row == 0)|  */

	   if (DEBUG)
	     cout << "`film' == " << curr_row[0] << endl;

	   curr_production.title.assign(curr_row[0]);
	   curr_production.film.assign(curr_row[0]);
	   curr_production.is_production = true;

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
	 cout << "production_vector:" << endl;
       else
	 cout << "production_vector is empty." << endl;
       
       for (vector<Production>::iterator iter = production_vector.begin();
	    iter != production_vector.end();
	    ++iter)
	 {
	   iter->show("Production:");
	 }
     }
 
   for (vector<Production>::iterator iter = production_vector.begin();
	iter != production_vector.end();
	++iter)
     {
       if (DEBUG)
	 {
	   iter->show("Production:");
	 }

       temp_strm.str("");

       temp_strm << "select title from Songs where sort_by_production is true "
	         << "and ";

       if (iter->musical.length() > 0)
	 temp_strm << "musical = \"" << iter->musical << "\" ";
       else if (iter->opera.length() > 0)
	 temp_strm << "opera = \"" << iter->opera << "\" ";
       else if (iter->operetta.length() > 0)
	 temp_strm << "operetta = \"" << iter->operetta << "\" ";
       else if (iter->revue .length() > 0)
	 temp_strm << "revue = \"" << iter->revue << "\" ";
       else if (iter->film .length() > 0)
	 temp_strm << "film = \"" << iter->film << "\" ";

       temp_strm << "order by title;";

       if (DEBUG)
	 cout << "temp_strm.str() == " << temp_strm.str() << endl;

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
	   cout << "`submit_mysql_query' succeeded, returning 0." << endl;
	 }

       /*  Process the contents of |result|  */
       
       curr_row = 0;

       if (row_ctr > 0)
	 {
	   do
	     {

	       curr_row = mysql_fetch_row(result);

	       if (curr_row == 0)
		 {
		   if (DEBUG) 
		     cout << "`mysql_fetch_row' returned NULL:" 
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
		       cout << "No more rows." << endl;
		     }

		   break;
		 
		 }  /* |if (curr_row == 0)|  */

	       iter->title_vector.push_back(curr_row[0]);

	     } while (curr_row != 0);

	 }  /* |if (row_ctr > 0)|  */

       /* Free |result|  */
     
       if (result)
	 {
	   mysql_free_result(result);
	   result = 0;
	 }
       
       /*  */

       sort(iter->title_vector.begin(), iter->title_vector.end(), compare_strings);

     }  /* |for|  */

   if (DEBUG)
     {
       if (production_vector.size() > 0)
	 cout << "production_vector:" << endl;
       else
	 cout << "production_vector is empty." << endl;
       
       for (vector<Production>::iterator iter = production_vector.begin();
	    iter != production_vector.end();
	    ++iter)
	 {
	   iter->show("Production:");
	 }
     }

   song_vector.insert(song_vector.begin(), production_vector.begin(), production_vector.end());

   production_vector.clear();
   
   sort(song_vector.begin(), song_vector.end(), compare_titles);
   
   /* Open< output files.  */
   
   toc_ls_file.open("toc_ls.tex");
   toc_ls_a_h_file.open("toc_ls_a_h.tex");
   toc_ls_i_o_file.open("toc_ls_i_o.tex");
   toc_ls_p_z_file.open("toc_ls_p_z.tex");

   toc_npt_file.open("toc_npt.tex");

   toc_ls_file << "%% toc_ls.tex" << endl 					       
	       << "%% Generated by `songlist' " << datestamp << endl << endl	       
	       << "\\input songlist.mac" << endl << endl			       
	       << "\\advance\\hoffset by .5cm" << endl				       
	       << "\\medium" << endl						       
	       << "\\advance\\baselineskip by .5\\baselineskip" << endl 	       
	       << "\\setbox0=\\hbox{000}" << endl				       
	       << "\\dimen0=\\wd0" << endl					       
	       << "\\setbox1=\\hbox{\\hskip\\wd0. }" << endl			       
	       << "\\dimen1=\\wd1" << endl					       
	       << "\\def\\S{\\hskip\\dimen1}" << endl				       
	       << "\\headline={\\hfil \\ifnum\\pageno>1{\\mediumbx Lead Sheets}\\fi"   
	       << "\\hfil{\\tt \\timestamp}\\quad}" << endl			       
	       << "\\newcount\\songctr" << endl					       
	       << "\\songctr=1" << endl						       
	       << "\\centerline{{\\largebx Lead Sheets}}" << endl		       
	       << "\\vskip.75\\baselineskip" << endl				       
	       << "\\def\\N{\\leavevmode\\hbox to \\wd0{\\hfil " << endl 	       
	       << "\\the\\songctr\\global\\advance\\songctr by 1}. }" << endl	       
	       << "\\doublecolumns" << endl					       
	       << "\\obeylines" << endl << endl;

   toc_ls_a_h_file << "%% toc_ls_a_h.tex" << endl 					       
		   << "%% Generated by `songlist' " << datestamp << endl << endl	       
		   << "\\input songlist.mac" << endl << endl			       
		   << "\\advance\\hoffset by .5cm" << endl				       
		   << "\\medium" << endl						       
		   << "\\advance\\baselineskip by .5\\baselineskip" << endl 	       
		   << "\\setbox0=\\hbox{000}" << endl				       
		   << "\\dimen0=\\wd0" << endl					       
		   << "\\setbox1=\\hbox{\\hskip\\wd0. }" << endl			       
		   << "\\dimen1=\\wd1" << endl					       
		   << "\\def\\S{\\hskip\\dimen1}" << endl				       
		   << "\\headline={\\hfil \\ifnum\\pageno>1{\\mediumbx Lead Sheets A--H}\\fi"   
		   << "\\hfil{\\tt \\timestamp}\\quad}" << endl			       
		   << "\\newcount\\songctr" << endl					       
		   << "\\songctr=1" << endl						       
		   << "\\centerline{{\\largebx Lead Sheets A--H}}" << endl		       
		   << "\\vskip.75\\baselineskip" << endl				       
		   << "\\def\\N{\\leavevmode\\hbox to \\wd0{\\hfil " << endl 	       
		   << "\\the\\songctr\\global\\advance\\songctr by 1}. }" << endl	       
		   << "\\doublecolumns" << endl					       
		   << "\\obeylines" 
		   << endl << endl;                                                        

   toc_ls_i_o_file << "%% toc_ls_i_o.tex" << endl 					       
		   << "%% Generated by `songlist' " << datestamp << endl << endl	       
		   << "\\input songlist.mac" << endl << endl			       
		   << "\\advance\\hoffset by .5cm" << endl				       
		   << "\\medium" << endl						       
		   << "\\advance\\baselineskip by .5\\baselineskip" << endl 	       
		   << "\\setbox0=\\hbox{000}" << endl				       
		   << "\\dimen0=\\wd0" << endl					       
		   << "\\setbox1=\\hbox{\\hskip\\wd0. }" << endl			       
		   << "\\dimen1=\\wd1" << endl					       
		   << "\\def\\S{\\hskip\\dimen1}" << endl				       
		   << "\\headline={\\hfil \\ifnum\\pageno>1{\\mediumbx Lead Sheets I--O}\\fi"   
		   << "\\hfil{\\tt \\timestamp}\\quad}" << endl			       
		   << "\\newcount\\songctr" << endl					       
		   << "\\songctr=1" << endl						       
		   << "\\centerline{{\\largebx Lead Sheets I--O}}" << endl		       
		   << "\\vskip.75\\baselineskip" << endl				       
		   << "\\def\\N{\\leavevmode\\hbox to \\wd0{\\hfil " << endl 	       
		   << "\\the\\songctr\\global\\advance\\songctr by 1}. }" << endl	       
		   << "\\doublecolumns" << endl					       
		   << "\\obeylines"
		   << endl << endl;                                                        

      toc_ls_p_z_file << "%% toc_ls_p_z.tex" << endl 					       
		   << "%% Generated by `songlist' " << datestamp << endl << endl	       
		   << "\\input songlist.mac" << endl << endl			       
		   << "\\advance\\hoffset by .5cm" << endl				       
		   << "\\medium" << endl						       
		   << "\\advance\\baselineskip by .5\\baselineskip" << endl 	       
		   << "\\setbox0=\\hbox{000}" << endl				       
		   << "\\dimen0=\\wd0" << endl					       
		   << "\\setbox1=\\hbox{\\hskip\\wd0. }" << endl			       
		   << "\\dimen1=\\wd1" << endl					       
		   << "\\def\\S{\\hskip\\dimen1}" << endl				       
		   << "\\headline={\\hfil \\ifnum\\pageno>1{\\mediumbx Lead Sheets P--Z}\\fi"   
		   << "\\hfil{\\tt \\timestamp}\\quad}" << endl			       
		   << "\\newcount\\songctr" << endl					       
		   << "\\songctr=1" << endl						       
		   << "\\centerline{{\\largebx Lead Sheets P--Z}}" << endl		       
		   << "\\vskip.75\\baselineskip" << endl				       
		   << "\\def\\N{\\leavevmode\\hbox to \\wd0{\\hfil " << endl 	       
		   << "\\the\\songctr\\global\\advance\\songctr by 1}. }" << endl	       
		   << "\\doublecolumns" << endl					       
		   << "\\obeylines"
		   << endl << endl;                                                        

   toc_npt_file << "%% toc_npt.tex" << endl 
		<< "%% Generated by `songlist' " << datestamp << endl << endl
		<< "\\input songlist.mac" << endl << endl
		<< "\\advance\\hoffset by .5cm" << endl
     		<< "\\medium" << endl
		<< "\\advance\\baselineskip by .5\\baselineskip" << endl 
		<< "\\setbox0=\\hbox{00}" << endl
		<< "\\dimen0=\\wd0" << endl
		<< "\\setbox1=\\hbox{\\hskip\\wd0. }" << endl
		<< "\\dimen1=\\wd1" << endl
		<< "\\def\\S{\\hskip\\dimen1}" << endl
		<< "\\headline={\\hfil \\ifnum\\pageno>1{\\mediumbx No Page Turns}\\fi"
	       << "\\hfil{\\tt \\timestamp}\\quad}" << endl
		<< "\\newcount\\songctr" << endl
		<< "\\songctr=1" << endl
		<< "\\centerline{{\\largebx No Page Turns}}" << endl
		<< "\\vskip.75\\baselineskip" << endl
		<< "\\def\\N{\\leavevmode\\hbox to \\wd0{\\hfil " << endl 
		<< "\\the\\songctr\\global\\advance\\songctr by 1}. }" << endl
		<< endl;

   char temp_char;

   if (DEBUG)
     {
       for (vector<Song>::iterator iter = song_vector.begin();
	    iter != song_vector.end();
	    ++iter)
	 iter->show("Song:");
     }
   
   for (vector<Song>::iterator iter = song_vector.begin();
	iter != song_vector.end();
	++iter)
     {

       for (int i = 0; i < iter->title.length(); ++i)
	 {
	   if (isalpha(iter->title[i]))
	     {
	       temp_char = tolower(iter->title[i]);
	       break;
	     }
	   else if (iter->title[i] == '4')
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

       if (iter->is_production && iter->title_vector.size() > 0)
	 {
	   toc_ls_file << "\\hskip\\dimen1 " << iter->title << endl;

	   if (iter->title == "42nd Street")
	     toc_ls_a_h_file << "\\hskip\\dimen1 " << iter->title << endl;
	   else if (temp_char <= 'h')
	     toc_ls_a_h_file << "\\hskip\\dimen1 " << iter->title << endl;
	   else if (temp_char <= 'o')
	     toc_ls_i_o_file << "\\hskip\\dimen1 " << iter->title << endl;
	   else 
	     toc_ls_p_z_file << "\\hskip\\dimen1 " << iter->title << endl;

	   for (vector<string>::iterator t_iter = iter->title_vector.begin();
		t_iter != iter->title_vector.end();
		++t_iter)
	     {
	       toc_ls_file << "\\S\\S " << *t_iter << endl;

	       if (iter->title == "42nd Street")
		 toc_ls_a_h_file << "\\S\\S " << *t_iter << endl;
	       else if (temp_char <= 'h')	       
		 toc_ls_a_h_file << "\\S\\S " << *t_iter << endl;
	       else if (temp_char <= 'o')
		 toc_ls_i_o_file << "\\S\\S " << *t_iter << endl;
	       else 
		 toc_ls_p_z_file << "\\S\\S " << *t_iter << endl;

	     }  /* |for|  */

	   toc_ls_file << endl;

	   if (iter->title == "42nd Street")
	     toc_ls_a_h_file << endl;
	   else if (temp_char <= 'h')	       
	     toc_ls_a_h_file << endl;
	   else if (temp_char <= 'o')
	     toc_ls_i_o_file << endl;
	   else 
	     toc_ls_p_z_file << endl;

	 }  /* |if|  */
       
       else if (iter->lead_sheet)
	 {
	   toc_ls_file << "\\N " << iter->title << endl;

	   if (iter->musical.length() > 0 && iter->sort_by_production)
	     toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->musical << "'')"
			 << endl;
   	   else if (iter->opera.length() > 0 && iter->sort_by_production)
	     toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->opera << "'')"
			 << endl;
           else if (iter->operetta.length() > 0 && iter->sort_by_production)
	     toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->operetta << "'')"
			 << endl;
	   else if (iter->revue.length() > 0 && iter->sort_by_production)
	     toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->revue << "'')"
			 << endl;
	   else if (iter->film.length() > 0 && iter->sort_by_production)
	     toc_ls_file << "\\nobreak" << endl << "\\S (see under ``" << iter->film << "'')"
			 << endl;
	   
           toc_ls_file << endl;

	   if (temp_char <= 'h')
	     {

	       toc_ls_a_h_file << "\\N " << iter->title << endl;

	       if (iter->musical.length() > 0 && iter->sort_by_production)
		 toc_ls_a_h_file << "\\nobreak" << endl << "\\S (see under ``" << iter->musical << "'')"
				 << endl;
	       else if (iter->opera.length() > 0 && iter->sort_by_production)
		 toc_ls_a_h_file << "\\nobreak" << endl << "\\S (see under ``" << iter->opera << "'')"
				 << endl;
	       else if (iter->operetta.length() > 0 && iter->sort_by_production)
		 toc_ls_a_h_file << "\\nobreak" << endl << "\\S (see under ``" << iter->operetta << "'')"
				 << endl;
	       else if (iter->revue.length() > 0 && iter->sort_by_production)
		 toc_ls_a_h_file << "\\nobreak" << endl << "\\S (see under ``" << iter->revue << "'')"
				 << endl;
	       else if (iter->film.length() > 0 && iter->sort_by_production)
		 toc_ls_a_h_file << "\\nobreak" << endl << "\\S (see under ``" << iter->film << "'')"
				 << endl;
	   
	       toc_ls_a_h_file << endl;
	     }
	   else if (temp_char <= 'o')
	     {
	       toc_ls_i_o_file << "\\N " << iter->title << endl;

	       if (iter->musical.length() > 0 && iter->sort_by_production)
		 toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under ``" << iter->musical << "'')"
				 << endl;
	       else if (iter->opera.length() > 0 && iter->sort_by_production)
		 toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under ``" << iter->opera << "'')"
				 << endl;
	       else if (iter->operetta.length() > 0 && iter->sort_by_production)
		 toc_ls_i_o_file << "\\nobreak" << endl << "\\S (see under ``" << iter->operetta << "'')"
				 << endl;
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
	       toc_ls_p_z_file << "\\N " << iter->title << endl;
	       
	       if (iter->musical.length() > 0 && iter->sort_by_production)
		 toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->musical << "'')"
				 << endl;
	       else if (iter->opera.length() > 0 && iter->sort_by_production)
		 toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->opera << "'')"
				 << endl;
	       else if (iter->operetta.length() > 0 && iter->sort_by_production)
		 toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->operetta << "'')"
				 << endl;
	       else if (iter->revue.length() > 0 && iter->sort_by_production)
		 toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->revue << "'')"
				 << endl;
	       else if (iter->film.length() > 0 && iter->sort_by_production)
		 toc_ls_p_z_file << "\\nobreak" << endl << "\\S (see under ``" << iter->film << "'')"
				 << endl;
	   
	       toc_ls_p_z_file << endl;
	     }

	 }  /* |if (iter->lead_sheet)|  */

       else if (iter->no_page_turns)
	 {
	   toc_npt_file << "\\N " << iter->title << endl << endl;
	 }

       else if (iter->no_page_turns_with_two_songbooks)
	 {
	   toc_npt_file << "\\N " << iter->title << " (WTS)" << endl << endl;
	 }
       else if (iter->partial_lead_sheet)
	 {
	   toc_npt_file << "\\N " << iter->title << " (PLS)" << endl << endl;
	 }
       
     }  /* |for|  */

   toc_ls_file << "\\singlecolumn" << endl << endl
	       << endl << "\\bye" << endl;

   toc_ls_a_h_file << "\\singlecolumn" << endl << endl
	       << endl << "\\bye" << endl;

   toc_ls_i_o_file << "\\singlecolumn" << endl << endl
		   << endl << "\\bye" << endl;

   toc_ls_p_z_file << "\\singlecolumn" << endl << endl
	       << endl << "\\bye" << endl;

   toc_ls_file.close();
   toc_ls_a_h_file.close();
   toc_ls_i_o_file.close();
   toc_ls_p_z_file.close();

   toc_npt_file << "\\vskip2cm" << endl << endl
		<< "PLS:  Partial lead sheet\\quad WTS:  No page turns with two songbooks"
		<< endl << endl << "\\bye" << endl;

   toc_npt_file.close();

   return 0;
   
}  /* End of |process_tocs_and_npt| definition  */

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


