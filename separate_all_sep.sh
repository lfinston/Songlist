##! /bin/bash

pdfseparate all_sep.pdf all_sep-%02d.pdf

pdfunite all_sep-01.pdf all_sep-04.pdf toc_ls.pdf

pdfunite all_sep-05.pdf all_sep-06.pdf toc_a_h_ls.pdf

pdfunite all_sep-07.pdf all_sep-08.pdf toc_i_o_ls.pdf

pdfunite all_sep-09.pdf all_sep-10.pdf toc_p_z_ls.pdf

mv all_sep-11.pdf toc_npt.pdf

pdfunite all_sep-12.pdf all_sep-19.pdf composers.pdf

pdfunite all_sep-20.pdf all_sep-27.pdf lyricists.pdf

mv all_sep-28.pdf scanned.pdf

mv all_sep-29.pdf pblcdomn.pdf

rm `find . -regex "./all_sep-[0-9]+.*.pdf"`

exit 0
