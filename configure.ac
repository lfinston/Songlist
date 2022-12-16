#### configure.ac
#### Created by Laurence D. Finston (LDF) Tue 24 Aug 2021 11:20:20 PM CEST

#### * (1) Copyright and License.

## * Copyright and License.

## This file is part of songlist, a package for keeping track of songs. 
## Copyright (C) 2021, 2022, 2023 Laurence D. Finston 

## songlist is free software; you can redistribute it and/or modify 
## it under the terms of the GNU General Public License as published by 
## the Free Software Foundation; either version 3 of the License, or 
## (at your option) any later version. 

## songlist is distributed in the hope that it will be useful, 
## but WITHOUT ANY WARRANTY; without even the implied warranty of 
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
## GNU General Public License for more details. 

## You should have received a copy of the GNU General Public License 
## along with songlist; if not, write to the Free Software 
## Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA 

## Please send bug reports to Laurence.Finston@gmx.de 


  
.# Process this file with autoconf to produce a configure script.
AC_INIT([Songlist], [1.0], [Laurence.Finston@gmx.de], [Songlist])
AC_CONFIG_SRCDIR([./])
AM_INIT_AUTOMAKE
AC_CONFIG_HEADERS(config.h)
AC_CONFIG_MACRO_DIR([m4])

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_MAKE_SET

# Checks for libraries.
#AC_CHECK_LIB(m, trunc)
AC_CHECK_LIB(mysqlclient, mysql_init)

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([errno.h float.h limits.h stdlib.h unistd.h mysql.h])

# Checks for typedefs, structures, and compiler characteristics.
#AC_C_CONST
#AC_C_INLINE
#AC_TYPE_SIZE_T
#AC_STRUCT_TM
#AC_CHECK_TYPES([unsigned long long, unsigned long, unsigned int])

# Checks for library functions.
#AC_FUNC_MALLOC
#AC_FUNC_STAT
AC_SEARCH_LIBS(trunc, m)
AC_CHECK_FUNCS([floor sqrt trunc])

AC_CONFIG_FILES([Makefile public_domain/Makefile])

# Checks for endianness.
AC_C_BIGENDIAN

AC_ARG_ENABLE([dummy],
AC_HELP_STRING([--enable-debug-compile],
[Enable conditionally compiled debugging output (this is the default).]),
[],[])

AC_ARG_ENABLE([debug-compile], 
[AC_HELP_STRING([--disable-debug-compile],
        [Disable conditionally compiled debugging output.])],
[if test $enableval == "yes"
then
echo "Enabling conditional compilation of debugging output"
AC_DEFINE([DEBUG_COMPILE], [1], 
  [Define to 0 or 1 to disable or enable conditional compilation of debugging output.])
else 
echo "Disabling conditional compilation of debugging output"
AC_DEFINE([DEBUG_COMPILE], [0], 
  [])
fi], 
[echo "Enabling conditional compilation of debugging output"
AC_DEFINE([DEBUG_COMPILE], [1], 
[])	
])

AC_OUTPUT
