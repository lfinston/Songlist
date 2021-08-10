#### Makefile
#### Created by Laurence D. Finston (LDF) Tue 10 Aug 2021 07:44:19 PM CEST

## * Copyright and License.

## This file is part of songlist, a package for keeping track of songs. 
## Copyright (C) 2021 Laurence D. Finston 

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

# ** Variables.

#### Automatic Variables.  For more, see Section 10.5.3, "Automatic Variables"
#### of the Make info manual.
#### LDF 2009.12.29.

#### $@:  Target
#### $<:  First prerequisite
#### $^:  The names of all the prerequisites, with spaces between them.
#### $*:  The stem with which an implicit rule matches

.PHONY: all

all: public_domain.pdf public_domain.ps

.PHONY: pdf

pdf: public_domain.pdf

.PHONY: ps

ps: public_domain.ps

.PHONY: dvi

dvi: public_domain.dvi

.PHONY: dvic # Update contents

dvic:
	tex public_domain.tex
	tex public_domain.tex

public_domain.pdf: public_domain.dvi
	dvipdfmx public_domain.dvi

public_domain.ps: public_domain.dvi
	dvips -o public_domain.ps public_domain.dvi

public_domain.dvi: public_domain.tex
	tex public_domain.tex

.PHONY: clean

clean:  
	rm -f *.dvi *.ps *.pdf *.log 
