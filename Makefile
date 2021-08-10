#### Makefile
#### Created by Laurence D. Finston 10.2017  

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

ttemp: ttemp.o cmdlnopt.o 
	g++ -o ttemp ttemp.o cmdlnopt.o -L/usr/lib/mysql -L/usr/lib/mysql/plugin \
            -L/usr/lib/x86_64-linux-gnu -lmysqlclient \
            -lpthread -lz -lm -lrt \
           -lssl -lcrypto -ldl -lresolv

ttemp.o: ttemp.cxx cmdlnopt.hxx songdefs.hxx 
	g++ -c -g -I/usr/include/mysql -o ttemp.o ttemp.cxx

.PHONY: clean

clean:  
	rm -f *.o *.dvi *.ps *.pdf *.log toc_ls.tex toc_scores.tex \
              circles.mpx circles.1 circles.2 circles.3 \
              songlist songlist_out.tex ttemp.o ttemp \
              toc_ls_a_h.tex toc_ls_i_o.tex toc_ls_p_z.tex toc_ls.tex toc_npt.tex \
              lyricists.tex composers.tex

.PHONY: all

all: all-no-sep all-sep

.PHONY: f-all

f-all:
	songlist$(EXEEXT)
	$(MAKE) all

sub_filecrds.tex: database/songlist.sql songlist$(EXEEXT)
	songlist$(EXEEXT)

.PHONY: all-sep

all-sep: all_sep.pdf 

#### all_sep.dvi, with separation (no table of contents)

all_sep.dvi: songlist$(EXEEXT) Makefile songlist.mac ./database/songlist.sql toc_ls.tex all.tex all_sep.tex \
             sub_filecrds.tex filecrds.tex
	tex all_sep.tex

all_sep.pdf: all_sep.dvi #sep_all.sh
	dvipdfmx $<

all_sep.ps: all_sep.dvi 
	dvips -q -o $@ $< 2>/dev/null

#sep_all.sh: all_sep.dvi XXX.sh
#	cat XXX.sh | tr "|" "\\" > sep_all.sh 2>/dev/null

# composers.pdf lyricists.pdf pblcdomn.pdf scanned.pdf toc_ls_a_h.pdf \
#    toc_ls_i_o.pdf toc_ls.pdf toc_ls_p_z.pdf toc_npt.pdf toc_p_z_ls.pdf: all_sep.pdf sep_all.sh
# 	./sep_all.sh

.PHONY: all-no-sep

all-no-sep: all_no_sep.ps all_no_sep.pdf 

#### all_no_sep.dvi, no separation (with table of contents)

all_no_sep.dvi: songlist$(EXEEXT) Makefile songlist.mac ./database/songlist.sql toc_ls.tex all.tex all_no_sep.tex \
                sub_filecrds.tex filecrds.tex
	tex all_no_sep.tex & tex all_no_sep.tex

all_no_sep.ps: all_no_sep.dvi
	dvips -q -o $@ $< 2>/dev/null

all_no_sep.pdf: all_no_sep.dvi
	dvipdfmx $<

tocnpt.o: tocnpt.cxx
	g++ -c -g -I/usr/include/mysql -o tocnpt.o tocnpt.cxx

songlist.o: songlist.cxx songdefs.hxx cmdlnopt.hxx 
	g++ -c -g -I/usr/include/mysql -o songlist.o songlist.cxx

songlist$(EXEEXT): songlist.o cmdlnopt.o tocnpt.o
	g++ -o songlist songlist.o cmdlnopt.o tocnpt.o -L/usr/lib/mysql -L/usr/lib/mysql/plugin \
            -L/usr/lib/x86_64-linux-gnu -lmysqlclient \
            -lpthread -lz -lm -lrt \
           -lssl -lcrypto -ldl -lresolv

cmdlnopt.o: cmdlnopt.cxx
	g++ -c -g -o cmdlnopt.o cmdlnopt.cxx

.PHONY: run

# ./songlist

run: ./songlist$(EXEEXT) 
	./songlist$(EXEEXT) 

songlist_out.pdf: songlist_out.ps
	ps2pdf songlist_out.ps

songlist_out.ps: songlist_out.dvi 
	dvips -o songlist_out.ps songlist_out.dvi

# | grep "Overfull"	

songlist_out.dvi: songlist_out.tex songlist.mac songlist$(EXEEXT) Makefile
	tex songlist_out.tex 


songlist_out.tex: songlist input.txt
	./songlist 
# --banjo --accordeon --zither

.PHONY: eall

eall: explanations.ps explanations.pdf

.PHONY: edvi

edvi: explanations.dvi

.PHONY: eps

eps: explanations.ps

.PHONY: epdf

epdf: explanations.pdf

explanations.dvi: explanations.tex
	tex explanations.tex

explanations.ps: explanations.dvi
	dvips -o explanations.ps explanations.dvi

explanations.pdf: explanations.dvi
	dvipdfmx explanations.dvi

.PHONY: dvi

dvi:  toc_ls.dvi toc_ls_a_h.dvi toc_ls_i_o.dvi toc_ls_p_z.dvi toc_npt.dvi composers.dvi lyricists.dvi \
         scanned.dvi pblcdomn.dvi

.PHONY: ps

ps:  toc_ls.ps toc_ls_a_h.ps toc_ls_i_o.ps toc_ls_p_z.ps toc_npt.ps composers.ps lyricists.ps \
         scanned.ps pblcdomn.ps

.PHONY: pdf

pdf:  toc_ls.pdf toc_ls_a_h.pdf toc_ls_i_o.pdf toc_ls_p_z.pdf toc_npt.pdf composers.pdf lyricists.pdf \
         scanned.pdf pblcdomn.pdf

toc_ls.tex toc_ls_a_h.tex toc_ls_i_o.tex toc_ls_p_z.tex toc_npt.tex composers.tex \
   lyricists.tex scanned.tex pblcdomn.tex : songlist$(EXEEXT) database/songlist.sql
	make run

toc_scores.pdf: toc_scores.ps
	ps2pdf toc_scores.ps

toc_scores.ps: toc_scores.dvi
	dvips -o toc_scores.ps toc_scores.dvi

toc_scores.dvi: toc_scores.tex songlist$(EXEEXT) Makefile
	tex $<

toc_scores.tex: songlist
	make run
.PHONY: run-c

run-c: circles.ps

circles.ps: circles.dvi
	dvips -o circles.ps circles.dvi

circles.dvi: circles.tex redcircle.eps greencircle.eps bluecircle.eps
	tex circles.tex

redcircle.eps greencircle.eps bluecircle.eps whitecircle.eps: circles.mp
	mpost circles.mp
	mv circles.1 redcircle.eps
	mv circles.2 greencircle.eps
	mv circles.3 bluecircle.eps
	mv circles.4 whitecircle.eps

.PHONY: run-t

run-t: ttemp.ps

ttemp.ps: ttemp.dvi
	dvips -o ttemp.ps ttemp.dvi

ttemp.dvi: ttemp.tex songlist.mac songlist$(EXEEXT) Makefile
	tex ttemp.tex


.PHONY: graph

graph: graphics.ps

graphics.ps: graphics.dvi
	dvips -o graphics.ps graphics.dvi

graphics.dvi: graphics.tex graphics_1.eps graphics_2.eps graphics_3.eps graphics_4.eps \
              graphics_5.eps graphics_6.eps graphics_7.eps graphics_8.eps
	tex graphics.tex

graphics_1.eps graphics_2.eps graphics_3.eps graphics_4.eps \
               graphics_5.eps graphics_6.eps graphics_7.eps graphics_8.eps graphics.mp:
	mpost graphics.mp
	-mv graphics.1 graphics_1.eps
	-mv graphics.2 graphics_2.eps
	-mv graphics.3 graphics_3.eps
	-mv graphics.4 graphics_4.eps
	-mv graphics.5 graphics_5.eps
	-mv graphics.6 graphics_6.eps
	-mv graphics.7 graphics_7.eps
	-mv graphics.8 graphics_8.eps

.PHONY: dump

dump:
	mysqlpump Songs > dump.sql


