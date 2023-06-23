/* replace_control_codes.cxx  */
/* Created by Laurence D. Finston Thu 12 Aug 2021 11:32:15 AM CEST */

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <limits.h>
#include <math.h>
#include <string.h>

#include <sys/types.h>

#include <algorithm>
#include <bitset>
#include <exception>
#include <float.h>
#include <iomanip>
#include <ios>
#include <iostream>
#include <iterator>
#include <limits>
#include <new>
#include <sstream>
#include <stdexcept>
#include <streambuf>
#include <string>
#include <valarray>
#include <vector>
#include <fstream>

using namespace std;

typedef unsigned int i_type;

/* * (1) */

int
main(int argc, char *argv[])
{
/* ** (2) */

   size_t pos = string::npos;
   size_t pos_1 = string::npos;
   size_t pos_2 = string::npos;

   ifstream in_file;
   ofstream out_file;

   char buffer[1024];
   memset(buffer, 0, 1024);

   // cerr << "Entering ttemp." << endl;

   in_file.open(argv[1]);
   out_file.open(argv[2]);

   string s;
   string t;
   string u;

/* ** (2) */

   do 
   {   
/* *** (3) */

      s = "";
      memset(buffer, 0, 1024);
      in_file.getline(buffer, 1024);

//    if (strlen(buffer) > 0)
//       cerr << "buffer = " << buffer << endl;

      s = buffer;

/* *** (3) */

      pos = s.find("14 Lieder");

      if (pos != string::npos)
      {
         // cerr << "Found \"14 Lieder\"." << endl;

         s.replace(pos, 9, "Fourteen Lieder");

         // cerr << "s == " << endl << s << endl; 

      }

/* *** (3) */

      pos = s.find("42nd Street");

      if (pos != string::npos)
      {
         // cerr << "Found \"42nd Street\"." << endl;

         s.replace(pos, 11, "Forty-Second Street");

         // cerr << "s == " << endl << s << endl; 

      }

      /* This only replaces the first accent.  It should be enough for purposes of alphabetizing.  */
      /* It doesn't work to replace all of the accents, because this would affect the text that's  */
      /* printed to the index, which would be incorrect.                                           */
      /* If it turns out to be necessary, code can be added to only replace the accents in         */
      /* the '\setbox0=...' code at the beginning of the '\line'.                                  */
      /* LDF 2021.08.12.                                                                           */

      pos = s.find("{{\\accent ");

      if (pos != string::npos)
      {
         pos_1 = s.find("}}", pos);

         t = s.substr(pos, pos_1 - pos + 2);
         // cerr << "t == \"" << t << "\"" << endl;

         u = t.substr(t.length() - 3, 1);

         pos_2 = t.find("accent \"7F");

         if (pos_2 != string::npos)
            u += 'e';            

         // cerr << "u == \"" << u << "\"" << endl;

         s.replace(pos, t.length(), u);    

         // cerr << "s == " << s << endl;


      }

/* *** (3) */

      out_file << s << endl;

   }
   while (!in_file.eof());
   
/* ** (2) */

   // cerr << "Read to end of file." << endl;

   in_file.close();

/* ** (2) */

   // cerr << "Exiting ttemp successfully with return value 0." << endl;

   return 0;

}

/* * (1) */

/* (setq outline-regexp "/\\* \\**")      */

/* Local Variables:           */
/* mode:CWEB                  */
/* mode:show-paren            */
/* abbrev-mode:t              */
/* End:                       */


