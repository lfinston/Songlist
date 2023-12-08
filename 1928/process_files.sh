# /bin/bash

#### process_files.sh
#### Created by Laurence D. Finston (LDF) Do 7. Dez 15:23:44 CET 2023

eps2eps btnpvrct1.pdf btnpvrct1.eps
eps2eps btnpvrct2.pdf btnpvrct2.eps

exit 0

"btnpvrct1.eps"
"btnpvrct2.eps"
"btnpvrct.pdf"

"letsdoit.pdf"
"letsdoit1.eps;letsdoit2.eps;"

"lvrcbtme.pdf"
"lvrcbtme1.eps;lvrcbtme2.eps;"

"makwhoop.pdf"
"makwhoop1.eps;makwhoop2.eps;"

"shfnttwy.pdf"
"shfnttwy1.eps;shfnttwy2.eps;"

"whensmil.pdf"
"whensmil1.eps;whensmil2.eps;"

"ytkadvnt.pdf"
"ytkadvnt1.eps;ytkadvnt2.eps;ytkadvnt3.eps;"

eps2eps letsdoit1.pdf letsdoit1.eps
eps2eps letsdoit2.pdf letsdoit2.eps

eps2eps lvrcbtme1.pdf lvrcbtme1.eps
eps2eps lvrcbtme2.pdf lvrcbtme2.eps

eps2eps makwhoop1.pdf makwhoop1.eps
eps2eps makwhoop2.pdf makwhoop2.eps

eps2eps shfnttwy1.pdf shfnttwy1.eps
eps2eps shfnttwy2.pdf shfnttwy2.eps

eps2eps whensmil1.pdf whensmil1.eps
eps2eps whensmil2.pdf whensmil2.eps

eps2eps ytkadvnt1.pdf ytkadvnt1.eps
eps2eps ytkadvnt2.pdf ytkadvnt2.eps
eps2eps ytkadvnt3.pdf ytkadvnt3.eps

exit 0


pdfseparate letsdoit.pdf letsdoit%d.pdf
pdfseparate lvrcbtme.pdf lvrcbtme%d.pdf
pdfseparate makwhoop.pdf makwhoop%d.pdf
pdfseparate shfnttwy.pdf shfnttwy%d.pdf
pdfseparate whensmil.pdf whensmil%d.pdf
pdfseparate ytkadvnt.pdf ytkadvnt%d.pdf

exit 0
