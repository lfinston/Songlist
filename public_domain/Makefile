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

all: public_domain_1.pdf public_domain_1.ps public_domain_2.pdf public_domain_2.ps  \
     public_domain_3.pdf public_domain_3.ps public_domain_4.pdf public_domain_4.ps \
     public_domain_5.pdf public_domain_5.ps public_domain_6.pdf public_domain_6.ps \

.PHONY: pdf

pdf: public_domain_1.pdf public_domain_2.pdf public_domain_3.pdf public_domain_4.pdf public_domain_5.pdf \
     public_domain_6.pdf


.PHONY: pdc

pdfc:
	$(MAKE) dvic
	$(MAKE) pdf

.PHONY: ps

ps: public_domain_1.ps public_domain_2.ps public_domain_3.ps public_domain_4.ps public_domain_5.ps public_domain_6.ps

.PHONY: psc

psc:
	$(MAKE) dvic
	$(MAKE) ps

.PHONY: dvi

dvi: public_domain_1.dvi public_domain_2.dvi public_domain_3.dvi public_domain_4.dvi public_domain_5.dvi public_domain_6.dvi

.PHONY: dvic # Update contents

dvic:
	tex public_domain_1.tex
	tex public_domain_1.tex
	tex public_domain_2.tex
	tex public_domain_2.tex
	tex public_domain_3.tex
	tex public_domain_4.tex
	tex public_domain_4.tex
	tex public_domain_4.tex
	tex public_domain_5.tex
	tex public_domain_5.tex
	tex public_domain_6.tex
	tex public_domain_6.tex

public_domain_1.pdf: public_domain_1.dvi
	dvipdfmx public_domain_1.dvi

public_domain_1.ps: public_domain_1.dvi
	dvips -o public_domain_1.ps public_domain_1.dvi

public_domain_1.dvi: public_domain_1.tex
	tex public_domain_1.tex

public_domain_2.pdf: public_domain_2.dvi
	dvipdfmx public_domain_2.dvi

public_domain_2.ps: public_domain_2.dvi
	dvips -o public_domain_2.ps public_domain_2.dvi

public_domain_2.dvi: public_domain_2.tex
	tex public_domain_2.tex

public_domain_3.pdf: public_domain_3.dvi
	dvipdfmx public_domain_3.dvi

public_domain_3.ps: public_domain_3.dvi
	dvips -o public_domain_3.ps public_domain_3.dvi

public_domain_3.dvi: public_domain_3.tex
	tex public_domain_3.tex

public_domain_4.pdf: public_domain_4.dvi
	dvipdfmx public_domain_4.dvi

public_domain_4.ps: public_domain_4.dvi
	dvips -o public_domain_4.ps public_domain_4.dvi

public_domain_4.dvi: public_domain_4.tex
	tex public_domain_4.tex

public_domain_5.pdf: public_domain_5.dvi
	dvipdfmx public_domain_5.dvi

public_domain_5.ps: public_domain_5.dvi
	dvips -o public_domain_5.ps public_domain_5.dvi

public_domain_5.dvi: public_domain_5.tex
	tex public_domain_5.tex

public_domain_6.pdf: public_domain_6.dvi
	dvipdfmx public_domain_6.dvi

public_domain_6.ps: public_domain_6.dvi
	dvips -o public_domain_6.ps public_domain_6.dvi

public_domain_6.dvi: public_domain_6.tex
	tex public_domain_6.tex

.PHONY: clean

clean:  
	rm -f *.dvi *.ps *.pdf *.log *.toc
