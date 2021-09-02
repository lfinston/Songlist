/*  cmdlnopt.cxx  */

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

/*  * (1) Command line option processing  */

/*  ** (2) Include files  */

#include <stdlib.h>
#include <stdio.h>
#include <getopt.h> 
#include <limits.h> 
#include <errno.h> 

#include <fstream>
#include <iomanip>
#include <ios>
#include <iostream>
#include <string>
#include <string.h>
#include <time.h>
#include <math.h>
#include <sstream>   
#include <vector>

#if 0
#include <map>
#include <deque>
#endif

#if HAVE_CONFIG_H
#include "config.h"
#endif

#ifndef _XOPEN_SOURCE
#define _XOPEN_SOURCE
#endif 

using namespace std;

// #include "glblvars.hxx"

/*  * (0) Command-Line Options Processing.   */

/*  ** (2) Process Command Line Options  */

int
process_command_line_options(int argc, char* argv[])
{

   bool DEBUG = true;  /* |false|  */

   int status = 0;

   string output_filename;
   string log_filename;
   string err_log_filename;

   ofstream output_file_strm;

   long int trace_value = 0;   

/*  **** (4)  */

   int option_ctr;
   int digit_optind = 0;

   size_t pos;
   char *temp_str = 0;

/*  *** (3) Index constants. */

  const unsigned short HELP_INDEX                           =  0;
  const unsigned short VERSION_INDEX                        =  1;
  const unsigned short OUTPUT_FILENAME_INDEX                =  2;
  const unsigned short LOG_FILENAME_INDEX                   =  3;
  const unsigned short TRACE_INDEX                          =  4;
  const unsigned short TOC_LEAD_SHEETS_INDEX                =  5;
  const unsigned short TOC_SCORES_INDEX                     =  6;
  const unsigned short TOC_GUITAR_SOLO_ARRANGEMENTS_INDEX   =  7;
  const unsigned short FILECARD_DATE_INDEX                  =  8;
							       
/*  **** (4)  */

/*  *** (3) Option struct. */

  static struct option long_options[] = {
    {"help", 0, 0, 0},
    {"version", 0, 0, 0},
    {"output-filename",  1, 0, 0},
    {"log-filename", 1, 0, 0},
    {"trace", 2, 0, 0},
    {"toc-lead-sheets", 2, 0, 0},
    {"toc-scores", 2, 0, 0},
    {"toc-guitar-solo-arrangements", 2, 0, 0},
    {"filecard-date", 2, 0, 0},
    {0, 0, 0, 0}
  };

  int option_index = 0;

  int this_option_optind = optind ? optind : 1;

/*  *** (3) Loop for handling options. */

  while (1) 
  {

/*  **** (4)  */

    option_ctr = getopt_long_only (argc,  
                                   argv, "",
                                   long_options, 
                                   &option_index);
    if (DEBUG)
    {

        cerr << "option_ctr == " << option_ctr << endl
             << "option_index == " << option_index << endl;

        if (optarg)
        {

          cerr << "optarg == " << optarg << endl;


        }  /* |if (optarg)|  */

    }  /* |if (DEBUG)|  */


/*  **** (4)  */

    if (option_ctr == -1)
      {

        if (DEBUG)
        {

           cerr << "No more option arguments." << endl;

        }

        break;
      }

/*  **** (4) Option.   */

    else if (option_ctr == 0)
    {

/*  ***** (5)  */


      if (DEBUG)
        {

          cerr << "option " << long_options[option_index].name;

          if (optarg)
          {
            cerr << " with arg " << optarg;
          }

          cerr << endl;

        }
/*  ***** (5) help.   */

        if (option_index == HELP_INDEX)        
        {

/*  ****** (6)  */

            if (DEBUG) 
            {

               cerr << "`option_index' "
                    << "== `HELP_INDEX'" 
                    << endl;

            }

            /* !! TODO: LDF 2012.01.10.  Add explanatory text.  */

/*  ****** (6)  */

            cout << "Usage:  songlist [OPTION] ..." 
                 << endl;
            exit(0);

        } /* |else if (option_index == HELP_INDEX)|  */


/*  ***** (5) version.   */

        else if (option_index == VERSION_INDEX)        
        {

/*  ****** (6)  */


            if (DEBUG) 
            {

               cerr << "`option_index' "
                    << "== `VERSION_INDEX'" 
                    << endl;

            }



            cout << "songlist 1.0"
                    << endl
                    << "Author:  Laurence D. Finston"
                    << endl 
                    << "Copyright (C) 2021 Laurence D. Finston"
                    << endl;

            exit(0);

        }  /* |else if (option_index == VERSION_INDEX)|  */

/*  ***** (5) output-filename. */

        else if (option_index == OUTPUT_FILENAME_INDEX)
        {

/*  ****** (6)  */


            if (DEBUG) 
            {

               cerr << "`option_index' == "
                    << "`OUTPUT_FILENAME_INDEX'" 
                    << endl;
 
               if (optarg)
                  cerr << "optarg == " << optarg << endl;

            }


            output_filename = optarg;

            output_file_strm.open(output_filename.c_str());


/*  ****** (6)  */

        } /* |else if (option_index == OUTPUT_FILENAME_INDEX)|  */


/*  ***** (5) log-filename.   */

        else if (option_index == LOG_FILENAME_INDEX)
        {

/*  ****** (6)  */


            if (DEBUG) 
            {

               cerr << "`option_index' "
                    << "== `LOG_FILENAME_INDEX'." 
                    << endl;


            } /* |if (DEBUG)|  */


            log_filename = optarg;

/*  ****** (6)  */

        } /* |else if (option_index == LOG_FILENAME_INDEX)|  */


/*  ***** (5) trace.   */

        else if (option_index == TRACE_INDEX)        
        {

/*  ****** (6)  */


            if (DEBUG) 
            {

               cerr << "`option_index' "
                    << "== `TRACE_INDEX'" 
                    << endl;

               if(optarg)
                  cerr << "optarg == " << optarg << endl;
               else
                  cerr << "No argument." << endl;

            }
 
            bool invalid_arg = false;

            if (optarg)
            {

                if (!(isdigit(optarg[0]) || optarg[0] == '-'))
                  invalid_arg = true;

                else
                {
                    for (int i = 1; i < strlen(optarg); ++i)
                    {
                        if (!isdigit(optarg[i]))
                        {
                            invalid_arg = true;
                            break;
                        }
                        
                    }  /* |for|  */

                }  /* |else|  */

            }  /* |if|  */


            if (optarg && !invalid_arg)
            {
                errno = 0;
                trace_value = strtol(optarg, 0, 10);


            }

            if (optarg && (invalid_arg || errno != 0 || trace_value == LONG_MAX  
                || trace_value == LONG_MIN))
            {

                cerr << "WARNING!  In `process_command_line_options':"
                     << endl
                     << "Invalid argument to `trace' option:  " << optarg
                     << endl;


                if (errno != 0)
                {
                    cerr << "errno == " << errno << endl;
                    perror("strtol error");
                }

                cerr << "Setting `trace_value' to 0 and continuing."
                     << endl;


                trace_value = 0;
            
            }  /* |if|  */


            if (!optarg)
                trace_value = 1;


            if (DEBUG)
            {

                cerr << "trace_value == " << trace_value << endl;


            }  /* |if (DEBUG)|  */ 

               
        }  /* |else if (option_index == TRACE_INDEX)|  */


/*  ***** (5) filecard-date.   */

        else if (option_index == FILECARD_DATE_INDEX)        
        {

/*  ****** (6)  */

            string date_str;
            FILE *fp = 0;
            char buffer[16];
            memset(buffer, '\0', 16);

            if (DEBUG) 
            {

               cerr << "`option_index' == `FILECARD_DATE_INDEX'" 
                    << endl;

               if(optarg)
                  cerr << "optarg == " << optarg << endl;
               else
                  cerr << "No argument." << endl;

            }

/* ****** (6) */

            if (optarg)
            {
                date_str = optarg;

                /* Replace periods with dashes.  `date' doesn't recognize */
                /* date strings with periods.  LDF 2021.09.02.            */

                do  
                {
                    pos = date_str.find(".");

                    if (pos != string::npos)
                      date_str.replace(pos, 1, "-");
                }
                while (pos != string::npos);

            }

/* ****** (6) */

            else  /* Use default (1 week)  */
            {
                date_str = "-1 week";
            }

/* ****** (6) */

            date_str.insert(0, "date --date='");

            date_str.append("' +'%Y-%m-%d' 2>/dev/null; echo $?");

            cerr << "date_str == " << date_str << endl;

            errno = 0;
            fp = popen(date_str.c_str(), "r");

            if (fp != 0 && errno == 0)
            {
               status = fread(buffer, 1, 16, fp);

               cerr << "AAA buffer == " << buffer << endl;

            }

/* ****** (6) */

            if (fp == 0 || errno != 0 || buffer[0] == '1')
            {

/* ******* (7) */

                if (fp == 0 || errno != 0)
                {
                    cerr << "`popen' failed";

                    if (fp == 0)
                      cerr << " returning NULL";
 
                    cerr << "." << endl;

                    if (errno != 0)
                      cerr << "Error:  " << strerror(errno) << endl;
                }
                else if (buffer[0] == '1')
                   cerr << "`date' failed, returning 1." << endl;
  
                pclose(fp);
                fp = 0;
           
/* ******* (7) */

                if (date_str != "date --date='-1 week' +'%Y-%m-%d' 2>/dev/null; echo $?")
                {
/* ******** (8) */
                   cerr << "Will try again with default." << endl;

                   date_str = "date --date='-1 week' +'%Y-%m-%d' 2>/dev/null; echo $?";

                   cerr << "date_str == " << date_str << endl;

                   memset(buffer, '\0', 16);
                   errno = 0;
                   fp = popen(date_str.c_str(), "r");


                   if (fp != 0 && errno == 0)
                   {
                       status = fread(buffer, 1, 16, fp);

                       cerr << "buffer == " << buffer << endl;

                   }

                   if (fp == 0 || errno != 0 || buffer[0] == '1')
                   {
/* ********* (9) */

                      if (fp == 0 || errno != 0)
                      {
                         cerr << "`popen' failed" << endl;

                         if (fp == 0)
                            cerr << " returning NULL";
 
                         cerr << "." << endl;

                         if (errno != 0)
                            cerr << "Error:  " << strerror(errno) << endl;
                      }
                      else if (buffer[0] == '1')
                         cerr << "`date' failed, returning 1." << endl;
  
                      
/* ********* (9) */

                   }

/* ******** (8) */

                }  /* |if (date_str != "date --date='-1 week' +'%Y-%m-%d'")|  */

/* ******* (7) */

            }  /* |if (fp == 0 || errno != 0 || buffer[0] == '1')|  */

/* ****** (6) */

            if (fp == 0 || errno != 0 || buffer[0] == '1')
            {

                cerr << "ERROR!  In `process_command_line_options':" << endl;

                if (fp == 0 || errno != 0)
                {
                   cerr << "`popen' failed";

                   if (fp == 0)
                       cerr << " returning NULL";
 
                   cerr << "." << endl;

                   if (errno != 0)
                      cerr << "Error:  " << strerror(errno) << endl;
                }

                if (buffer[0] == '1')
                   cerr << "`date' failed, returning 1." << endl;

                cerr << "Not writing new filecards to file."
                     << endl 
                     << "Will continue."  << endl;

            }  /* |if (fp == 0 || errno != 0 || buffer[0] == '1')|  */

/* ****** (6) */

            else if (DEBUG)
            { 
                cerr << "BBB `popen' and `date' succeeded.  `buffer' == " << buffer << endl;

            }        

            pclose(fp);
            fp = 0;

cerr << "YYY Enter <RETURN> to continue: ";
getchar(); 



        }  /* |else if (option_index == FILECARD_DATE_INDEX)|  */


/*  ***** (5) Invalid option_index value. */

        else 
        {

          cerr << "WARNING!  In `process_command_line_options':"
               << endl 
               << "`option_index' has invalid value: "
               << option_index << endl
               << "Will try to continue." 
               << endl;
        }

/*  ***** (5)  */

      }  /* |else if (option_ctr == 0)|  */


/*  **** (4) Ambiguous option. */

    else if (option_ctr == '?')
    {

        cerr << "WARNING! In `process_command_line_options':"
             << endl
             << "`getopt_long_only' returned ambiguous match.  "
             << "Breaking."
             << endl;

        break;

    }  /* |else if (option_ctr == '?')|  */

/*  **** (4) Invalid option. */

    else
    {

        if (DEBUG) 
        {
           cerr << "`getopt_long_only' returned invalid option."
                << endl;
        }

    }

/*  **** (4) End of while loop. */

    if (DEBUG) 
    {

       cerr << "End of option processing" << endl;

    }

/*  **** (4)  */

    } /* |while|  */
  
/*  *** (3) Non-option command line arguments.   */
        
/*  **** (4)  */

  if (optind < argc)
  {
/*  ***** (5)  */

       if (DEBUG)
       {
          cerr << "non-option ARGV-elements: ";

       }  /* |if (DEBUG)|  */ 

       int j = optind;

/*  ***** (5)  */

       for (int i = 0; j < argc;  ++i, ++j)
       {
/*  ****** (6)  */


           if (DEBUG)
           {
               cerr << "argv[" << j << "] == " << argv[j] << endl
                    << "strlen(argv[j]) == " << strlen(argv[j]) << endl;

           }  /* |if (DEBUG)|  */ 


/*  ****** (6) First non-option argument.   */


           if (i == 0)  
           {
/*  ******* (7)  */

               if (false)
               {

                   cerr << "WARNING!  In `process_command_line_options':"
                        << endl 
                        << "Non-option argument found."
                        << endl;

               }
/*  ******* (7)  */

               else if (false)
               {

                   cerr << "WARNING!  In `process_command_line_options':"
                        << endl;


               }

/*  ******* (7)  */

               else
               {
                   if (DEBUG)
                   {

                       cerr << "In `process_command_line_options':"
                            << endl 
                            << "Non-option argument found."
                            << endl;


   }  /* |if (DEBUG)|  */

               }  /* |else|  */

/*  ******* (7)  */

           }  

/*  ****** (6)  */


       }  /* |for| */ 
   
/*  ***** (5)  */
 
  } /* |if (optind < argc)|  */


/*  ****** (6)  */

/*  ***** (5)  */

/*  **** (4)  */

   return 0;

}  /* End of |process_command_line_options| definition  */

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

