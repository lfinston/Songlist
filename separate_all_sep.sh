##! /bin/bash

echo "Entering sep_all_sep.sh"

pdfseparate all_sep.pdf all_sep-%02d.pdf

pdfunite \
all_sep-01.pdf \
all_sep-02.pdf \
all_sep-03.pdf \
all_sep-04.pdf toc_ls.pdf

pdfunite \
all_sep-05.pdf \
all_sep-06.pdf toc_ls_a_h.pdf

pdfunite \
all_sep-07.pdf \
all_sep-08.pdf toc_ls_i_m.pdf

pdfunite \
all_sep-09.pdf \
all_sep-10.pdf toc_ls_p_z.pdf

mv all_sep-11.pdf toc_npt.pdf

pdfunite \
all_sep-12.pdf \
all_sep-13.pdf \
all_sep-14.pdf \
all_sep-15.pdf \
all_sep-16.pdf \
all_sep-17.pdf \
all_sep-18.pdf \
all_sep-19.pdf composers.pdf

pdfunite \
all_sep-20.pdf \
all_sep-21.pdf \
all_sep-22.pdf \
all_sep-23.pdf \
all_sep-24.pdf \
all_sep-25.pdf \
all_sep-26.pdf \
all_sep-27.pdf lyricists.pdf

mv all_sep-28.pdf scanned.pdf

mv all_sep-29.pdf pblcdomn.pdf

rm -f `find . -regex "./all_sep-[0-9]+.*.pdf"`

echo "Exiting sep_all_sep.sh with exit status 0"
exit 0
