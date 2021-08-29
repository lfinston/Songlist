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
     public_domain_5.pdf public_domain_5.ps \

replace_control_codes$(EXEEXT): replace_control_codes.o
	g++ -o replace_control_codes$(EXEEXT) replace_control_codes.o

replace_control_codes.o: replace_control_codes.cxx
	g++ -o replace_control_codes.o -c -g replace_control_codes.cxx

.PHONY: pdf

pdf: public_domain_1.pdf public_domain_2.pdf public_domain_3.pdf public_domain_4.pdf public_domain_5.pdf

.PHONY: ps

ps: public_domain_1.ps public_domain_2.ps public_domain_3.ps public_domain_4.ps public_domain_5.ps

.PHONY: dvi

dvi: public_domain_1.dvi public_domain_2.dvi public_domain_3.dvi public_domain_4.dvi public_domain_5.dvi

public_domain_1.pdf: public_domain_1.dvi
	dvipdfmx public_domain_1.dvi

public_domain_1.ps: public_domain_1.dvi
	dvips -o public_domain_1.ps public_domain_1.dvi

public_domain_1.dvi: public_domain_1.tex public_domain.mac chord_symbols.tex songs_a_e.tex replace_control_codes$(EXEEXT)
	rm -f public_domain_1.idx public_domain_1.uix public_domain_1.sdx
	touch public_domain_1.idx
	tex public_domain_1.tex
	replace_control_codes$(EXEEXT) public_domain_1.uix public_domain_1.sdx
	make_index.sh public_domain_1.sdx public_domain_1.idx 
	tex public_domain_1.tex

public_domain_2.pdf: public_domain_2.dvi
	dvipdfmx public_domain_2.dvi

public_domain_2.ps: public_domain_2.dvi
	dvips -o public_domain_2.ps public_domain_2.dvi

public_domain_2.dvi: public_domain_2.tex public_domain.mac chord_symbols.tex songs_f_l.tex replace_control_codes$(EXEEXT)
	rm -f public_domain_2.idx public_domain_2.uix public_domain_2.sdx
	touch public_domain_2.idx
	tex public_domain_2.tex
	replace_control_codes$(EXEEXT) public_domain_2.uix public_domain_2.sdx
	make_index.sh public_domain_2.sdx public_domain_2.idx 
	tex public_domain_2.tex

public_domain_3.pdf: public_domain_3.dvi
	dvipdfmx public_domain_3.dvi

public_domain_3.ps: public_domain_3.dvi
	dvips -o public_domain_3.ps public_domain_3.dvi

public_domain_3.dvi: public_domain_3.tex public_domain.mac chord_symbols.tex songs_m_n.tex \
                     replace_control_codes$(EXEEXT)
	rm -f public_domain_3.idx public_domain_3.uix public_domain_3.sdx
	touch public_domain_3.idx
	tex public_domain_3.tex
	replace_control_codes$(EXEEXT) public_domain_3.uix public_domain_3.sdx
	make_index.sh public_domain_3.sdx public_domain_3.idx 
	tex public_domain_3.tex

public_domain_4.pdf: public_domain_4.dvi
	dvipdfmx public_domain_4.dvi

public_domain_4.ps: public_domain_4.dvi
	dvips -o public_domain_4.ps public_domain_4.dvi

public_domain_4.dvi: public_domain_4.tex public_domain.mac chord_symbols.tex songs_o_s.tex replace_control_codes$(EXEEXT)
	rm -f public_domain_4.idx public_domain_4.uix public_domain_4.sdx
	touch public_domain_4.idx
	tex public_domain_4.tex
	replace_control_codes$(EXEEXT) public_domain_4.uix public_domain_4.sdx
	make_index.sh public_domain_4.sdx public_domain_4.idx 
	tex public_domain_4.tex

public_domain_5.pdf: public_domain_5.dvi
	dvipdfmx public_domain_5.dvi

public_domain_5.ps: public_domain_5.dvi
	dvips -o public_domain_5.ps public_domain_5.dvi

public_domain_5.dvi: public_domain_5.tex public_domain.mac chord_symbols.tex songs_t_z.tex replace_control_codes$(EXEEXT)
	rm -f public_domain_5.idx public_domain_5.uix public_domain_5.sdx
	touch public_domain_5.idx
	tex public_domain_5.tex
	replace_control_codes$(EXEEXT) public_domain_5.uix public_domain_5.sdx
	make_index.sh public_domain_5.sdx public_domain_5.idx 
	tex public_domain_5.tex

.PHONY: full

full: public_domain_full.pdf public_domain_full.ps


.PHONY: fpdf

fpdf: public_domain_full.pdf

public_domain_full.pdf: public_domain_full.dvi
	dvipdfmx public_domain_full.dvi

public_domain_full.ps: public_domain_full.dvi
	dvips -o public_domain_full.ps public_domain_full.dvi

.PHONY: fdvi

fdvi: public_domain_full.dvi 

public_domain_full.dvi: public_domain_full.tex public_domain.mac chord_symbols.tex songs_a_e.tex songs_f_l.tex \
                        songs_m_n.tex songs_o_s.tex songs_t_z.tex replace_control_codes$(EXEEXT)
	rm -f public_domain_full.idx public_domain_full.uix public_domain_full.sdx
	touch public_domain_full.idx
	tex public_domain_full.tex
	replace_control_codes$(EXEEXT) public_domain_full.uix public_domain_full.sdx
	make_index.sh public_domain_full.sdx public_domain_full.idx 
	tex public_domain_full.tex



.PHONY: clean

clean:  
	rm -f *.dvi *.ps *.pdf *.log *.toc *.idx *.uix *.sdx
