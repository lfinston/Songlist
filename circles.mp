%% circles.mp

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

verbatimtex
\font\large=cmr12
etex


pickup pencircle scaled 1pt;

beginfig(1); % "R"
draw fullcircle scaled .75cm;
label(btex {\large R} etex, (0, 0)) withcolor .7white;
endfig;

beginfig(2); % "G"
draw fullcircle scaled .75cm;
label(btex {\large G} etex, (0, 0)) withcolor .7white;
endfig;

beginfig(3); % "B"
draw fullcircle scaled .75cm;
label(btex {\large B} etex, (0, 0)) withcolor .7white;
endfig;

beginfig(4); % "White"
draw fullcircle scaled .75cm;
%label(btex {\large B} etex, (0, 0)) withcolor .7white;
endfig;


end;

%% Local Variables:   
%% mode:Text          
%% mode:show-paren    
%% End:               
