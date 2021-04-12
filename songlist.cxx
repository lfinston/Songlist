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
#include "glblvars.hxx"
#include "cmdlnopt.hxx"

MYSQL_RES *result = 0;
MYSQL_ROW curr_row = 0;
MYSQL *mysql;
  
unsigned int row_ctr = 0; 
unsigned int field_ctr = 0;
long affected_rows = 0;

/* Function declarations  */

int
get_datestamp(string &datestamp, string &datestamp_short);

int
submit_mysql_query(string query_str);

/* main definition */

/* ** (2) |main| definition  */

int
main(int argc, char **argv)
{
/* *** (3)   */

   bool DEBUG = false; /* |true|  */

   int status;

   
   stringstream temp_strm;

   cout << "This is `songlist'." << endl;
   
   if (DEBUG)
     cout << "Entering `main'." << endl;

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
       cout << "In `main':  `process_command_line_options' succeeded, returning 0." 
            << endl;

   }
 
/* ** (2) Initialize  |mysql|  */

   mysql = mysql_init(0);

   if (mysql != 0)
     {
       if (DEBUG) 
	 cout << "mysql_init succeeded." << endl;
     }
   else
     {
       cout << "ERROR!  In `main': `mysql_init failed'." << endl
	    << "Exiting `songlist' unsuccessfully with exit status 1."
	    << endl;

       exit(1);
     }

   unsigned int mysql_timeout = 120;
  
   // mysql_options(mysql, MYSQL_OPT_RECONNECT, 0);
   mysql_options(mysql, MYSQL_OPT_CONNECT_TIMEOUT, &mysql_timeout); 
  
   if (!mysql_real_connect(mysql,"localhost","laurence",0,"Songs",0,NULL,0))
     {
       fprintf(stderr, "Failed to connect to database: Error: %s\n",
	       mysql_error(mysql));
     }

   errno = 0;

   affected_rows = 0L;

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




/* *** (3)  */

   /* Close connection to database.  */

   mysql_close(mysql);
   mysql_library_end();

   /* Exit  */

   cout << "Exiting `songlist' successfully with exit status 0." << endl;
   
   exit(0);

/* *** (3)  */

}  /* End of |main| definition  */

/* |Song::show| definition */ 

void 
Song::show(string s)
{
  if (s == "")
     cout << "Song:" << endl;
  else                 
     cout << s << endl;
 
  cout << "title:                            " << title << endl
       << "words:                            " << words << endl
       << "music:                            " << music << endl
       << "words_and_music:                  " << words_and_music << endl
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
       << "revue:                            " << revue << endl
       << "film:                             " << film << endl
       << "notes:                            " << notes << endl      
       << "mark_blue:                        " << mark_blue << endl
       << "sort_by_production:               " << sort_by_production << endl      
       << "is_production:                    " << is_production << endl;      

  if (title_vector.size() > 0)
    cout << "title_vector:" << endl;
  else
        cout << "title_vector is empty" << endl;
  
  for (vector<string>::iterator iter = title_vector.begin();
       iter != title_vector.end();
       ++iter)
  {
  cout << "title:                            " << *iter << endl;
  }

  cout << endl << endl;
  
  return;

}  /* End of |Show::show| definition.  */

/* |Song::clear| definition */ 

void 
Song::clear(void)
{
    song_ctr = 0;
    title = "";
    words = "";
    music = "";
    words_and_music = "";
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
    revue = "";
    film = "";
    sort_by_production = 0;
    year = 0;
    copyright = "";
    mark_blue = 0;
    notes = "";
    is_production = false;
    title_vector.clear();
    
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
        cout << "Result strings are:" << endl
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

   if (result)
     {
       if (DEBUG)
	 cout << endl 
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
       cout << "`row_ctr' == " << row_ctr 
	    << endl
	    << "`field_ctr' == " << field_ctr 
	    << endl;
                 

     }  /* |if (DEBUG)|  */
   
   affected_rows = (long) mysql_affected_rows(mysql);

   if (DEBUG)
     {
       
       cout << "`affected_rows' == " << affected_rows
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

/* |compare_strings| definition */

/* |compare_authors| definition */

bool
compare_authors(const Song& t, const Song& s)
{
 
  string t_str;
  string s_str;
      
  return compare_strings(t_str, s_str);

}  /* |end of compare_authors| definition */

/* |compare_authors| definition */

bool
compare_strings(string t, string s)
{
  size_t found_t;
  size_t found_s;

  bool found_flag = false;
      
  /* erase cedilla accents:  |"\c "|  */

  do
    {
      found_t = t.find("\\c ");
      if (found_t != string::npos)
	{
	  found_flag = true;
	  t.erase(found_t, 3);
	}

      found_s = s.find("\\c ");
      if (found_s != string::npos)
	{
	  found_flag = true;
	  s.erase(found_s, 3);
	}
    }

  while (found_t != string::npos || found_s != string::npos);

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

  char tc[64];
  char sc[64];
  memset(tc, 0, 64);
  memset(sc, 0, 64);
      
  do
    {
      found_t = t.find_first_of("\\'`\"{}~-_");
      if (found_t != string::npos)
	{
	  found_flag = true;
	  t.erase(found_t, 1);
	}
    }
  while (found_t != string::npos );

  do
    {
      found_s = s.find_first_of("\\'`\"{}~-_");
      if (found_s != string::npos)	  	  
	{
	  found_flag = true;
	  s.erase(found_s, 1);
	}
    } while (found_s != string::npos);

#if 0 
  if (found_flag)
    cout << "t == " << t << endl
	 << "s == " << s << endl << endl;
#endif

  memset(tc, 0, 64);
  memset(sc, 0, 64);
      
  strncpy(tc, t.c_str(), t.length());
  strncpy(sc, s.c_str(), s.length());

#if 0 
  cout << "tc == " << tc << endl;
  cout << "sc == " << sc << endl;
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
  cout << "tolower(t[0]) == " << tolower(t[0]) << endl
       << "tolower(s[0]) == " << tolower(s[0]) << endl;

  cout << "t  == " << t << endl;
  cout << "s  == " << s << endl;
#endif 

  return t < s;
  
}  /* |compare_strings| definition  */


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




