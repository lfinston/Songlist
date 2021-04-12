%% graphics.mp

%% * Copyright and License.

%% This file is part of songlist, a package for keeping track of songs. 
%% Copyright (C) 2021 Laurence D. Finston 

%% songlist is free software; you can redistribute it and/or modify 
%% it under the terms of the GNU General Public License as published by 
%% the Free Software Foundation; either version 3 of the License, or 
%% (at your option) any later version. 

%% songlist is distributed in the hope that it will be useful, 
%% but WITHOUT ANY WARRANTY; without even the implied warranty of 
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
%% GNU General Public License for more details. 

%% You should have received a copy of the GNU General Public License 
%% along with songlist; if not, write to the Free Software 
%% Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA 

%% Please send bug reports to Laurence.Finston@gmx.de 

input boxes

verbatimtex
\font\large=cmr12
\font\largebx=cmbx12
etex

pickup pencircle scaled 1pt;

picture v[];

v1 = thelabel(btex \largebx Vol.~1 etex, (0, 0));
v2 = thelabel(btex \largebx Vol.~2 etex, (0, 0));



beginfig(1);
boxit.a(v1);
drawboxed(a);
endfig;

beginfig(2);
boxit.a(v1);
draw(v1);
draw bpath a withcolor white;
endfig;

beginfig(3);
boxit.b(v2);
drawboxed(b);
endfig;

beginfig(4);
boxit.b(v2);
draw(v2);
draw bpath b withcolor white;
endfig;

beginfig(5);
circleit.a(v1);
a.dy = 6pt;
a.dx = 4pt;
drawboxed(a);
endfig;

beginfig(6);
circleit.a(v1);
a.dy = 6pt;
a.dx = 4pt;
draw(v1);
draw bpath a withcolor white;
endfig;

beginfig(7);
circleit.b(v2);
b.dy = 6pt;
b.dx = 4pt;
drawboxed(b);
endfig;

beginfig(8);
circleit.b(v2);
b.dy = 6pt;
b.dx = 4pt;
draw(v2);
draw bpath b withcolor white;
endfig;


end;



%% Local Variables:   
%% mode:Text          
%% mode:show-paren    
%% End:               
