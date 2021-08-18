/* /home/laurence/songlist/database/songlist.sql  */

/* Created by Laurence D. Finston Wed 10 Mar 2021 01:28:59 AM CET  */

/* * Copyright and License.*/

/* This file is part of songlist, a package for keeping track of songs. */
/* Copyright (C) 2021 Laurence D. Finston */

/* songlist is free software; you can redistribute it and/or modify */
/* it under the terms of the GNU General Public License as published by */
/* the Free Software Foundation; either version 3 of the License, or */
/* (at your option) any later version. */

/* songlist is distributed in the hope that it will be useful, */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/* GNU General Public License for more details. */

/* You should have received a copy of the GNU General Public License */
/* along with songlist; if not, write to the Free Software */
/* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA */

/* Please send bug reports to Laurence.Finston@gmx.de */

/* * (1)  Instructions  */

/* !! PLEASE NOTE:  It is not intended that this file be loaded using the  */
/* mysql `source' command (`\.')!                                          */
/* The MySQL statements in this file should be executed individually or    */
/* in groups.  The author uses Emacs and the various Emacs commands        */
/* in "SQL mode".  Of course, `mysql' could be used directly from the      */
/* command line, but this would be much more inconvenient.  There are      */
/* surely other ways of accessing `mysql', but the author is not familiar  */
/* with them.                                                              */

/* !! PLEASE NOTE:  The file `songlist_1.sql' contains `insert' commands         */
/* with the (`ignore' keyword) and `update' commands that set the `Songs:source' */
/* field.  The arguments for the `source' field in `replace' commands in this    */
/* file may be out-of-date.                                                      */
/*                                                                               */
/* When and if this file and `songlist_1.sql' are set up to be read in `mysql'   */
/* using the `source' command (or `\.'), then this file should be read first and */
/* then `songlist_1.sql'.  As of this date, this is not yet the case.            */
/* LDF 2021.04.24.  */

/* * (1)  */

use Songs;

/* * (1) As a user with the privilege of creating users and granting privileges (possibly `root')  */
/*       create user `songlist' and grant privileges on database `Songs' to it.                    */

create user 'songlist'@'localhost';

create user 'taxonomy'@'localhost';

GRANT ALL ON Songs TO 'songlist'@'localhost';

GRANT ALL ON Taxonomy TO 'laurence'@'localhost';

/* ** (2) Create table `Songs'.  */

// drop table Songs;

create table Songs
(
    title varchar(128) unique not null,
    subtitle varchar(128) not null default "",
    words varchar(128) default null,
    music varchar(128) default null,
    words_and_music varchar(128) default null,
    lead_sheet boolean not null default false,
    partial_lead_sheet boolean not null default false,
    no_page_turns boolean not null default false,
    no_page_turns_with_two_songbooks boolean not null default false,
    scanned boolean not null default false,
    scanned_filename varchar(12) default null,
    arrangement_orchestra boolean not null default false,
    arrangement_solo_guitar boolean not null default false,
    recordings tinyint not null default 0,
    opera varchar(64) default null,
    operetta varchar(64) default null,
    song_cycle varchar(256) default null,
    musical varchar(64) default null,
    revue varchar(64) default null,
    film  varchar(64) default null,
    film_reverse varchar(64) default null,
    sort_by_production boolean not null default false,
    production varchar(64) not null default "",
    production_subtitle varchar(128) not null default "",
    year int default null,
    copyright varchar(256) default null,
    notes varchar(512) default null,
    public_domain boolean not null default false,
    language varchar(32) not null default "english",
    is_cross_reference boolean not null default false,
    target varchar(256) not null default "",
    do_filecard boolean not null default true,
    filecard_title varchar(128) not null default "",
    number_filecards boolean not null default false,
    eps_filenames varchar(512) not null default ""
    
);

alter table Songs add column operetta varchar(64) default null after opera;
alter table Songs add column source varchar(128) default null after notes;
alter table Songs add column words_reverse varchar(128) default null after words;
alter table Songs add column music_reverse varchar(128) default null after music;
alter table Songs add column words_and_music_reverse varchar(128) default null after words_and_music;
alter table Songs add column scanned boolean not null default false after no_page_turns_with_two_songbooks;
alter table Songs add column scanned_filename varchar(12) default null after scanned;
alter table Songs add column public_domain boolean not null default false after notes;
alter table Songs add column song_cycle varchar(64) default null after operetta;
alter table Songs add column language varchar(32) not null default "english" after public_domain;
alter table Songs modify column copyright varchar(256) default null;
alter table Songs modify column source varchar(356) default null after notes;
alter table Songs add column is_cross_reference boolean not null default 0 after language;
alter table Songs add column target varchar(128) not null default "" after is_cross_reference;
alter table Songs add column production varchar(64) not null default "" after sort_by_production;
alter table Songs add column do_filecard boolean not null default true after target;
alter table Songs add column filecard_title varchar(128) not null default "" after do_filecard;
alter table Songs add column number_filecards boolean not null default false after filecard_title;
alter table Songs add column eps_filenames varchar(512) not null default "" after number_filecards;
alter table Songs modify column target varchar(256) not null default "";
alter table Songs modify column song_cycle varchar(256) default null;
alter table Songs add column subtitle varchar(128) not null default "" after title;
alter table Songs add column production_subtitle varchar(128) not null default "" after production;

show columns from Songs;

delete from Songs;

select distinct subtitle from Songs where subtitle <> "";


/* ** (2) Composers */

drop table Composers;

create table Composers
(
   name varchar(128) unique not null,
   name_reverse varchar(128) unique not null,
   alternative_name varchar(128) default null,
   alternative_name_reverse varchar(128) default null,
   birth_date date default null,
   death_date date default null,
   notes varchar(356) default null
);

show columns from Composers;

/* ** (2) Lyricists */

drop table Lyricists;

create table Lyricists
(
   name varchar(128) unique not null,
   name_reverse varchar(128) unique not null,
   alternative_name varchar(128) default null,
   alternative_name_reverse varchar(128) default null,
   birth_date date default null,
   death_date date default null,
   notes varchar(356) default null
);

show columns from Lyricists;

/* ** (2) Composers_Songs */

create table Composers_Songs
(
   composer varchar(128) not null default "",
   title varchar(128) not null default ""

);

show columns from Composers_Songs;

/* ** (2) Lyricists_Songs */

create table Lyricists_Songs
(
   lyricist varchar(128) not null default "",

   title varchar(128) not null default ""

);

show columns from Lyricists_Songs;

/* ** (2) Productions */

drop table Productions;

create table Productions
(
    title varchar(128) unique not null,
    words varchar(128) default null,
    music varchar(128) default null,
    words_and_music varchar(128) default null,
    type int not null default 0,
    typename varchar(128) not null default "",
    year int default null,
    copyright varchar(256) default null,
    notes varchar(512) default null,
    public_domain boolean not null default false,
    language varchar(32) not null default "english",
    do_filecard boolean not null default true,
    filecard_title varchar(128) not null default "",
    number_filecards boolean not null default false
);

show columns from Productions;

select distinct opera, operetta, song_cycle, musical, revue, film from Songs where 
opera is not null or operetta is not null or song_cycle is not null
or musical is not null or revue is not null or film is not null\G




/* * (1)  Replace into `Songs'  */

/* ** *************************************************** */

/* A  */

select "$$$ A";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year,
language)
values
("Abends in der Taverna", "Aldo von Pinelli", "Pinelli, Aldo von", "Werner Bochmann", "Bochmann, Werner", true, 1, 1940,
"german");

-- select * from Songs where title = "Abends in der Taverna"\G

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Ain't Misbehavin'", "Andy Razaf", "Razaf, Andy",
"Thomas ``Fats'' Waller and Harry Brooks", "Waller, Thomas ``Fats'' and Brooks, Harry",
true, 1929);

/* ** *************************************************** */

-- delete from Songs where title = "Ain't She Sweet";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright,
source, scanned, scanned_filename, eps_filenames)
values
("Ain't She Sweet?", "Jack Yellen", "Yellen, Jack", "Milton Ager", "Ager, Milton", true,
1927, "\\vbox{\\hbox{Copyright {\\copyright} 1927 (Renewed)}\\vskip\\copyrightskip\\hbox{WB Music Corp.~and Edwin H. Morris \\& Co.}}",
"{\\bf The Looney Tunes Songbook}, p.~57.", true, "aintsswt.pdf", "aintswt1.eps;aintswt2.eps;");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
recordings, arrangement_solo_guitar, film, year, scanned, scanned_filename)
values
("All God's Children", /* '  */
"Gus Kahn", "Kahn, Gus",
"Walter Jurmann and Bronislaw Kaper", "Jurmann, Walter and Kaper, Bronislaw",
true, 1, true, "Day at the Races, A", 1937, true, "allgdsch.pdf");

update Songs set eps_filenames = "allgdsch1.eps;allgdsch2.eps;allgdsch3.eps;" where title = "All God's Children";

/* ** *************************************************** */

-- delete from Songs where title = "All I Do Is Dream Of You";

-- select * from Songs where title = "All I Do Is Dream Of You"\G

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename)
values
("All I Do Is Dream Of You", "Arthur Freed", "Freed, Arthur",
"Nacio Herb Brown", "Brown, Nacio Herb", true, 1934,
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 1930s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 1}, p.~9.}}",
true, "alliddrm.pdf");

update Songs set eps_filenames = "alliddrm.eps;" where title = "All I Do Is Dream Of You";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year)
values
("All the Things You Are", "Oscar Hammerstein II", "Hammerstein II, Oscar",
"Jerome Kern", "Kern, Jerome", true, "Very Warm for May", 1939);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
opera, year, scanned, scanned_filename, public_domain, source, sort_by_production, language)
values
("Alles f@{u}hlt der Liebe Freuden", "Emanuel Schikaneder", "Schikaneder, Emanuel",
"Wolfgang Amadeus Mozart", "Mozart, Wolfgang Amadeus", true,
"Zauberfl@{o}te, Die", 1791, false, "allsfhlt.pdf", true,
"{\\bf Opern-Arien, Tenor}, p.~177.", true, "german");
--

select * from Songs where title  = "Zauberfl@{o}te, Die"\G

select * from Songs where opera = "Zauberfl@{o}te, Die"\G

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year,
source, notes, scanned, scanned_filename)
values
("Alone Again (Naturally)", "Gilbert O'Sullivan (Ray Gilbert)", "O'Sullivan, Gilbert (Ray Gilbert)", true, 
1972, "{\\bf The Best of Gilbert O'Sullivan}, p.~16.",
"Authors real name:  Ray Gilbert.", true, "aloneagn.pdf");

update Songs set eps_filenames = "alnagn01.eps;alnagn02.eps;" where title = "Alone Again (Naturally)";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, language)
values
("Amour est bleu, L'", "Pierre Cour", "Cour, Pierre", "Andr{\\'e} Popp", "Popp, Andr{\\'e}", 
true, 1967, "french");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, notes, year)
values
("Annie's Song", /* '  */
"John Denver", "Denver, John",
"\\hbox{Score for flute, b-flat clarinet, alto sax.~and tenor sax.}\\hbox{Completed 02.2018.}",
1974);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical, sort_by_production,
year, source, scanned, scanned_filename)
values
("Anything You Can Do", "Irving Berlin", "Berlin, Irving", true, "Annie Get Your Gun", true,
1946,
"\\vbox{\\hbox{{\\bf Songs of Irving Berlin, The.}}\\vskip\\sourceskip\\hbox{{\\bf Broadway Songs}, p.~2.}}",
true, "anything.pdf");

update Songs set eps_filenames = "anythin1.eps;anythin2.eps;" where title = "Anything You Can Do";

select eps_filenames from Songs where title = "Anything You Can Do";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings,
year, scanned, scanned_filename, public_domain)
values
("April Showers", "Buddy G.~De Sylva", "De Sylva, Buddy G.", "Louis Silvers", "Silvers, Louis",
true, 1, 1921, true, "aprlshwr.pdf", true);

update Songs set eps_filenames = "aprshw01.eps;aprshw02.eps;aprshw03.eps;aprshw04.eps;" where title = "April Showers";

/* ** *************************************************** */

replace into Songs (title, lead_sheet, words_and_music, words_and_music_reverse, year)
values
("As Time Goes By", true, "Herman Hupfeld", "Hupfeld, Herman", 1931);


/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
opera, sort_by_production, source, scanned, scanned_filename, public_domain, language)
values
("Au fond du temple saint", "Eug{\\`e}ne Cormon and Michel Carr{\\'e}", 
"Cormon, Eug{\\`e}ne and Carr{\\'e}, Michel", "Georges Bizet", "Bizet, Georges", 
false, 1863, "P{\\^e}cheurs de perles, Les", true, "Single edition, Edition Peters, EP 7588.",
false, "aufndsnt.pdf", true, "french");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, source, revue)
values
("Autumn in New York", "Vernon Duke", "Duke, Vernon", true, 1934,
"{\\bf Vernon Duke Songbook, The, Volume 1}, p.~8.", "Walk a Little Faster");

select "$$$ End of A";

/* ** ****************************************************/

/* B  */

select "$$$ B";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename)
values
("Baby Face", "Benny Davis", "Davis, Benny", "Harry Akst", "Akst, Harry", 
true, 1926, "\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 1920s,}}\\vskip\\sourceskip"
"\\hbox{{\\bf Volume 2}, p.~24.}}", true, "babyface.pdf");

update Songs set eps_filenames = "babyfac1.eps;babyfac2.eps;" where title = "Baby Face";

-- select * from Songs where title = "Baby Face"\G

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, recordings)
values
("Baby, It's Cold Outside", "Frank Loesser", "Loesser, Frank", true, 1);

/* ** *************************************************** */

-- delete from Songs where title like("Barcarole (%");

-- select title, subtitle from Songs where title like("Barcarole%");

-- delete from Songs where title like("Barcarole%");

-- select "{\\^o}";

select title, subtitle, eps_filenames from Songs where music = "Jacques Offenbach";

replace into Songs (title, subtitle, words, words_reverse, music, music_reverse, lead_sheet,
opera, year, scanned, scanned_filename, public_domain, source, sort_by_production, language)
values
("Barcarole", "(Belle nuit, {\\^o} nuit d'amour)", "Jules Barbier", "Barbier, Jules", 
"Jacques Offenbach", "Offenbach, Jacques", true,
"Contes d'Hoffmann, Les", 1881, true, "barkrole.pdf", true, 
"\\setbox0=\\hbox{0.  }\\vbox{\\hbox{1.  Einzelausgabe}\\vskip\\sourceskip"
"\\hbox{2.  {\\bf Hoffmanns Erz@{a}hlungen (Les Contes}}\\vskip\\sourceskip"
"\\hbox{\\hskip\\wd0{\\bf d'Hoffmann)}, Klavierauszug, p.~246.}}", 
true, "french");

update Songs set eps_filenames = "barkrl01.eps;barkrl02.eps;barkrl03.eps;barkrl04.eps;" where title = "Barcarole";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, source)
values
("Begin the Beguine", "Cole Porter", "Porter, Cole", true, 1935, 
"Copyright {\\copyright} 1935 (Renewed) Warner Bros.~Inc.", "{\\bf The Best of Cole Porter}, p.~30.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
recordings, no_page_turns, year, language)
values
("Bel Ami", "Hans Fritz Beckmann", "Beckmann, Hans Fritz", "Theo Mackeben", "Mackeben, Theo", 
true, 1, true, 1939, "german");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, 
lead_sheet, year, musical, source, scanned, scanned_filename)
values
("Bewitched", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true,
1941, "Pal Joey", 
"\\vbox{\\hbox{{\\bf Rodgers and Hart,}}\\vskip\\sourceskip\\hbox{{\\bf A Musical Anthology}, p.~234.}}", 
true, "bewitchd.pdf");

update Songs set eps_filenames = "bewitchd1.eps;bewitchd2.eps;" where title = "Bewitched";

/* ** *************************************************** */

replace into Songs (title, filecard_title,
words, words_reverse, music, music_reverse, 
lead_sheet, year)
values
("Between the Devil and the Deep Blue Sea", 
"\\vbox{\\hbox{Between the Devil and the}\\vskip\\titleskip\\hbox{Deep Blue Sea}}", 
"Ted Koehler", "Koehler, Ted", 
"Harold Arlen", "Arlen, Harold", true, 1931);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, musical, 
lead_sheet, sort_by_production, year)
values
("Bill", "P.G.~Wodehouse and Oscar Hammerstein II", "Wodehouse, P.G. and Hammerstein, Oscar II", 
"Jerome Kern", "Kern, Jerome", "Showboat", true, true, 1927);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, 
lead_sheet, year, source, scanned, scanned_filename)
values
("Blue Moon", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true,
1934, "\\vbox{\\hbox{{\\bf Rodgers and Hart,}}\\vskip\\sourceskip\\hbox{{\\bf A Musical Anthology}, p.~264.}}", 
true, "bluemoon.pdf");

update Songs set eps_filenames = "blumoon1.eps;blumoon2.eps;" where title = "Blue Moon";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns, year, source)
values
("Blue Skies", "Irving Berlin", "Berlin, Irving", true, 1926,
"{\\bf Irving Berlin Songs}, p.~16.");

/* ** *************************************************** */

replace into Songs (title, lead_sheet, recordings, year)
values
("Blue Velvet", true, 1, 1951);

/* banjo_chord_melody present */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, scanned, scanned_filename)
values
("Body and Soul", "\\vtop{\\hbox{Edward Heymann, Frank Eyton}\\vskip\\composerskip\\hbox{and Robert Sour}}", 
"\\vbox{\\hbox{Heymann, Edward; Eyton Frank;}\\vskip\\composerskip\\hbox{and Sour, Robert}}", 
"John W.~Green", "Green, John W.", true, 1930, true, "bodysoul.pdf");

update Songs set eps_filenames = "bodysoul1.eps;bodysoul2.eps;" where title = "Body and Soul";

/* ** *************************************************** */

-- select title from Songs where title like("Buen%");

-- select title from Composers_Songs where title like("Buen%");

-- select title from Lyricists_Songs where title like("Buen%");

-- delete from Songs where title = "Buenos Noches Mon Amour";

-- delete from Songs where title like("Buen%");

-- delete from Composers_Songs where title = "Buenos Noches Mon Amour";
-- delete from Lyricists_Songs where title = "Buenos Noches Mon Amour";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, source, language)
values
("Buenas Noches mi Amor", "Marc Fontenoy", "Fontenoy, Marc", "Hubert Giraud", "Giraud, Hubert", 
true, 1957, "{\\bf 40 franz@{o}sische Chansons}, p.~99.", "french");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, source,
scanned, scanned_filename)
values
("Button Up Your Overcoat", "\\vtop{\\hbox{B.G.~DeSylva, Lew Brown}\\vskip\\composerskip\\hbox{and Ray Henderson}}", 
"DeSylva, B.G.; Brown, Lew and Henderson, Ray",
true, 1928, "\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 20s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 1}, p.~44.}}", 
true, "btnpvrct.pdf");

update Songs set eps_filenames = "btnpvrc1.eps;btnpvrc2.eps;" where title = "Button Up Your Overcoat";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, arrangement_solo_guitar, year)
values
("By a Waterfall", "Irving Kahal", "Kahal, Irving", "Sammy Fain", "Fain, Sammy", true, 1, true, 1933);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source,
public_domain, scanned, scanned_filename)
values
("By The Light Of The Silvery Moon", "Ed Madden", "Madden, Ed", "Gus Edwards", "Edwards, Gus", true, 1909,
"{\\bf 100 Years of Popular Music, 1900}, p.~52.", true, true, "bltslvmn.pdf");

update Songs set eps_filenames = "bltslvm1.eps;bltslvm2.eps;" where title = "By the Light of the Silvery Moon";

select "$$$ End of B";

/* C   */

select "$$$ C";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename, musical, sort_by_production)
values
("Cabaret", "Fred Ebb", "Ebb, Fred",
"John Kander", "Kander, John", true, 1966,
"{\\bf Vocal Selections from Cabaret}, p.~30.", true, "cabaret.pdf", "Cabaret", true);

update Songs set eps_filenames = "cabaret1.eps;cabaret2.eps;" where title = "Cabaret";

/* ** *************************************************** */
replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, 
source, scanned, scanned_filename)
values
("Call Me", "Tony Hatch", "Hatch, Tony", true, 1965, 
"\\vbox{\\hbox{Copyright {\\copyright} 1965 Welbeck Music Ltd.}\\vskip\\copyrightskip\\hbox{Copyright Renewed.}}", 
"\\vbox{\\hbox{{\\bf The Big Book of '50s and '60s}}\\vskip\\sourceskip\\hbox{{\\bf Swinging Songs}, p.~30.}}", 
true, "callme.pdf");

update Songs set eps_filenames = "callme1.eps;callme2.eps;" where title = "Call Me";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production, year)
values
("Camelot", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, "Camelot", true, 1960);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, recordings, year, language)
values
("Capri Fischer", "Ralph Maria Siegel", "Siegel, Ralph Maria", "Gerhard Winkler", "Winkler, Gerhard", 
true, 1, 1943, "german");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Caravan", "Irving Mills", "Mills, Irving", "Duke Ellington and Juan Tizol", "Ellington, Duke and Tizol, Juan", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Carioca", "Edward Eliscu and Gus Kahn", "Eliscu, Edward and Kahn, Gus", 
"Vincent Youmans", "Youmans, Vincent", true, 1933);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, scanned, 
scanned_filename, public_domain)
values
("Carolina in the Morning", "Gus Kahn", "Kahn, Gus", "Walter Donaldson", "Donaldson, Walter", 
true, 1922, true, "carolina.pdf", true);

update Songs set eps_filenames = "carolin1.eps;carolin2.eps;carolin3.eps;" where title = "Carolina in the Morning";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Chances Are", "Al Stillman", "Stillman, Al", "Robert Allen", "Allen, Robert", true);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, film, source)
values
("Change Partners", "Irving Berlin", "Berlin, Irving", true, 1938, "Carefree",
"\\vbox{\\hbox{{\\bf Songs of Irving Berlin, The,}}\\vskip\\sourceskip\\hbox{{\\bf Movie Songs}, p.~18.}}");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, film, source)
values
("Cheek to Cheek", "Irving Berlin", "Berlin, Irving", true, 1935, "Top Hat",
"\\vbox{\\hbox{{\\bf Songs of Irving Berlin, The,}}\\vskip\\sourceskip\\hbox{{\\bf Movie Songs}, p.~22.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, language)
values
("Chega de Saudade", "Vin{\\'\\i}cius de Moraes", "Moraes, Vin{\\'\\i}cius de",  
"Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true, "portugese");

/* ** *************************************************** */

delete from Songs where title = "Chicago (That Toddling Town)";

select title from Songs where title like("Chicago%");

replace into Songs (title, subtitle, words_and_music, words_and_music_reverse, lead_sheet, year, 
scanned, scanned_filename, public_domain)
values
("Chicago", "(That Toddling Town)", "Fred Fisher", "Fisher, Fred", true, 1922, true, 
"chicago.pdf", true);

update Songs set eps_filenames = "chicago1.eps;chicago2.eps;" where title = "Chicago";

select * from Songs where title = "Chicago"\G

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, 
source, notes, scanned, scanned_filename)
values
("Claire", "Gilbert O'Sullivan (Ray Gilbert)", "O'Sullivan, Gilbert (Ray Gilbert)", true, 
1972, "{\\bf The Best of Gilbert O'Sullivan}, p.~5.",
"Authors real name:  Ray Gilbert.", true, "claire.pdf");

update Songs set eps_filenames = "claire01.eps;claire02.eps;" where title = "Claire";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Close to You", "Hal David", "David, Hal", "Burt Bacharach", "Bacharach, Burt", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes, year, no_page_turns, language)
values
("Comme d'Habitude", "Gille Thibaut", "Thibaut, Gille", "Jacques Revaux and Cluade Fran{\\c c}ois",
"Revaux, Jacques and Fran{\\c c}ois, Claude",
true,
"English title: ``My Way'', English lyrics: Paul Anka", 1967, true, "french");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Cocktails for Two", "Sam Coslow", "Coslow, Sam", "Arthur Johnston", "Johnston, Arthur", true, 1934);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet,
musical, sort_by_production, year, copyright, source)
values
("Consider Yourself", "Lionel Bart", "Bart, Lionel", true,
"Oliver!", true, 1959, 
"\\vtop{\\hbox{Copyright {\\copyright} 1959 by}"
"\\vskip\\copyrightskip\\hbox{Lakeview Music Publishing Company Limited.}}",
"{\\bf Lionel Bart's Oliver, Vocal Selections}, p.~30.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, film)
values
("Continental, The", "Herb Magidson", "Magidson, Herb", "Con Conrad", "Conrad, Con", true, 1934,
"Gay Divorcee, The");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Coquette", "Gus Kahn", "Kahn, Gus", "John W.~Green and Carmen Lombardo",
"Green, John W.~and Lombardo, Carmen", true);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright,
source, scanned, scanned_filename, language)
values
("Corcovado", "Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true, 1962,
"Copyright {\\copyright} 1962, 1964 (Renewed)",
"{\\bf The Definitive Antonio Carlos Jobim Collection}, p.~144.", true, "corcvado.pdf",
"portugese");

update Songs set eps_filenames = "crcvdo01.eps;crcvdo02.eps;" where title = "Corcovado";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, film, 
no_page_turns_with_two_songbooks)
values
("Cosi Cosa", "Ned Washington", "Washington, Ned", "Walter Jurmann and Bronislaw Kaper",
"Jurmann, Walter and Kaper, Bronislaw",
true, 1935,
"Night at the Opera, A", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
scanned, scanned_filename, public_domain)
values
("Cup of Coffee, a Sandwich and You, A", "Al Dubin and Billy Rose", "Dubin, Al and Rose, Billy",
"Joseph Meyer", "Meyer, Joseph", true, 1925, true, "cpcffyou.pdf", true);

update Songs set eps_filenames = "cupcof01.eps;cupcof02.eps;" where title = "Cup of Coffee, a Sandwich and You, A";

select "$$$ End of C";

/* D */

select "$$$ D";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
scanned, scanned_filename, operetta, sort_by_production, year, public_domain, language)
values
("Da geh ich zu Maxim", "Victor L{\\'e}on und Leo Stein", "L{\\'e}on, Victor und Stein, Leo",
"Franz Leh{\\'a}r", "Leh{\\'a}r, Franz", true, true, "maxim.pdf", "Lustige Witwe, Die",
true, 1905, true, "german");

update Songs set eps_filenames = "maxim01.eps;maxim02.eps;maxim03.eps;" where title = "Da geh ich zu Maxim";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Deep Purple", "Mitchell Parish", "Parish, Mitchell", "Peter DeRose", "DeRose, Peter", true, 1939);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright,
source, scanned, scanned_filename, language)
values
("Desafinado", "Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true, 1959,
"Copyright {\\copyright} 1959, 1967 (Renewed)",
"{\\bf The Music of Antonio Carlos Jobim}, p.~3.", true, "desafndo.pdf", "portugese");

update Songs set eps_filenames = "desafin1.eps;desafin2.eps;desafin3.eps;" where title = "Desafinado";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, musical, scanned, scanned_filename)
values
("Diamonds are a Girl's Best Friend", "Leo Robin", "Robin, Leo", "Jule Styne", "Styne, Jule",
true, 1949, "{\\bf The Library of Jazz Standards}, p.~80.", "Gentlemen Prefer Blondes", true, "diamonds.pdf");

update Songs set eps_filenames = "diamnds1.eps;diamnds2.eps;" where title = "Diamonds are a Girl's Best Friend";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Do You Know the Way to San Jose?", "Hal David", "David, Hal", "Burt Bacharach", "Bacharach, Burt", true, 1967);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, recordings)
values
("Downtown", "Tony Hatch", "Hatch, Tony", true, 1964, 
"\\vbox{\\hbox{Copyright {\\copyright} 1964 Welbeck Music Ltd.,}\\vskip\\copyrightskip\\hbox{London, England}}", 
1);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year, copyright)
values
("Dream a Little Dream of Me", "Gus Kahn", "Kahn, Gus",
"Fabian Andre and Wilbur Schwandt", "Andre, Fabian and Schwandt, Wilbur", true, 1, 1931,
"{\\copyright} 1931 Davis, Coots and Engel");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, year, no_page_turns, source, language)
values
("Du sollst der Kaiser meiner Seele sein",
"Fritz Gr@{u}nbaum und Wilhelm Sterk", "Gr@{u}nbaum, Fritz und Sterk, Wilhelm",
"Robert Stolz", "Stolz, Robert",
1916, true, "{\\bf Das neue Operettenbuch, Buch 1.}", "german");

/* ** *************************************************** */

-- delete from Songs where title = "Durch die Wälder, durch die Auen";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright, 
opera, scanned, scanned_filename, public_domain, language, sort_by_production)
values
("Durch die W@{a}lder, durch die Auen", "Friedrich Kind", "Kind, Friedrich", 
"Carl Maria von Weber", "Weber, Carl Maria von",
true, 1821, "Public Domain", "Freisch@{u}tz, Der", true, "drchwldr.pdf", true, "german", true);

update Songs set eps_filenames = "drchwldr01.eps;drchwldr02.eps;drchwldr03.eps;" where title = "Durch die W@{a}lder, durch die Auen";

/* ** *************************************************** */

/* E   */

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, partial_lead_sheet, year)
values
("East of the Sun (and West of the Moon)", "Brooks Bowman", "Bowman, Brooks", true, true, 1934);

/* East of the Sun has both a lead sheet and a partial lead sheet!  */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Embraceable You", "Ira Gershwin", "Gershwin, Ira", "George Gershwin", "Gershwin, George", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, recordings, language)
values
("Es leuchten die Sterne", "Bruno Balz", "Balz, Bruno", "Leo Leux", "Leux, Leo", 1, "german");

/* ** *************************************************** */

delete from Songs where title = "Este Sue Olhar";

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, language, source, year, scanned, 
scanned_filename)
values
("Este Seu Olhar", "Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true, "portugese", "{\\bf Music of Antonio Carlos Jobim, The}, p.~46.",
1964, true, "estsolhr.pdf");

update Songs set eps_filenames = "estsolhr1.eps;estsolhr2.eps;" where title = "Este Seu Olhar";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Every Time We Say Goodbye", "Cole Porter", "Porter, Cole", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, musical, scanned, scanned_filename)
values
("Everything's Coming Up Roses", "Stephen Sondheim", "Sondheim, Stephen", "Jule Styne", "Styne, Jule",
true, 1959,
"\\vbox{\\hbox{{\\bf Broadway Double Bill, Gypsy and}}\\vskip\\sourceskip\\hbox{{\\bf Funny Girl, Vocal Selections}, p.~5.}}",
"Gypsy", true, "evtcuprs.pdf");

update Songs set eps_filenames = "evtcuprs1.eps;evtcuprs2.eps;" where title = "Everything's Coming Up Roses";

/* ** *************************************************** */

/* F   */

/* ** *************************************************** */

/* !! START HERE:  LDF 2021.08.10.  Adjusting line breaks on filecards.  */ 

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year, source)
values
("Falling in Love With Love", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", 
true, "Boys from Syracuse, The", 1938, "{\\bf The Boys from Syracuse.  Vocal Selection}, p.~3.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, 
source, scanned, scanned_filename, film, language, sort_by_production)
values
("Felicidade, A", "Vin{\\'\\i}cius de Moraes", "Moraes, Vin{\\'\\i}cius de",  
"Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true, 1959,
"{\\bf The Definitive Antonio Carlos Jobim Collection}, p.~65.", true, "felcdade.pdf",
"Orfeu Negro", "portugese", true);

update Songs set eps_filenames = "felici01.eps;felici02.eps;" where title = "Felicidade, A";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, year, language)
values
("Feuilles Mortes, Les", "Jacques Prevert", "Prevert, Jacques", "Joseph Kosma", "Kosma, Joseph", true,
1947, "french");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Fine and Dandy", "Paul James (James Paul Warburg)", "James, Paul (Warburg, James Paul)",
"Kay Swift", "Swift, Kay", true, 1930);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Fine Romance, A", "Dorothy Fields", "Fields, Dorothy", "Jerome Kern", "Kern, Jerome", true);

/* ** *************************************************** */

-- 
delete from Songs where title like("Fly Me to the Moon%");

replace into Songs (title, subtitle, words_and_music, words_and_music_reverse, lead_sheet, year, 
copyright, scanned, scanned_filename, source, eps_filenames)
values
("Fly Me to the Moon", "(In Other Words)", "Bart Howard", "Howard, Bart", true, 1954, 
"Copyright {\\copyright} 1954 (Renewed)", true, "fmttmoon.pdf", 
"\\vbox{\\hbox{{\\bf The Big Book of '50s and '60s}}\\vskip\\sourceskip\\hbox{{\\bf Swinging Songs}, p.~65.}}",
"flymoon1.eps;flymoon2.eps;");


/* ** *************************************************** */

/* Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?) */

/*  It's not possible to get the full title (with subtitle) to print on two lines  */
/*  In both the TOC for lead sheets on the one hand and `composers.tex' and        */
/*  `lyricists.tex' on the other, the way they are programmed now.                 */
/*  in `toc_ls.tex', it works to insert `\par\S ', but this doesn't work           */
/*  in the other files, because the title is in an `\hbox' and \par produces a     */
/*  paragraph symbol.  I find this somewhat strange and I didn't know this would   */
/*  happen.  It makes some sense, because `\par' doesn't make any sense inside of  */
/*  an `\hbox'.                                                                    */

/*  delete from Songs where title = "Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)";  */

/* delete from Songs where title = 
   "\\hbox{Five Foot Two, Eyes Of Blue}\\break\\S (Has Anybody Seen My Girl?)";  */

-- select * from Songs where words = "Sam M.~Lewis and Joe Widow Young";
-- select * from Songs where music = "Ray Henderson";

-- insert ignore into Songs (title, source) values
-- ("Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)", 
-- "{\\bf 100 Years of Popular Music, 1920s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 2}}}");

-- select * from Songs where music = "Ray Henderson"\G

-- select * from Songs where title = "Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)"\G

-- select * from Songs where title = "Five Foot Two, Eyes Of Blue"\G

-- delete from Songs where title = "Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)";

-- update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
-- where title = "Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
notes, scanned, scanned_filename, source, public_domain)
values
("Five Foot Two, Eyes Of Blue",
"Sam M.~Lewis and Joe Young", "Lewis, Sam M.~and Young, Joe",
"Ray Henderson", "Henderson, Ray", true, 1925, "Subtitle:  Has Anybody Seen My Girl?", true,
"fivefoot.pdf", "\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 1920s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 2}}}",
true); 

update Songs set eps_filenames = "fivefoot.eps;" where title = "Five Foot Two, Eyes of Blue";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet,
musical, sort_by_production, year, copyright, source, scanned, scanned_filename)
values
("Food, Glorious Food", "Lionel Bart", "Bart, Lionel", true,
"Oliver!", true, 1959,
"\\vtop{\\hbox{Copyright {\\copyright} 1959 by}"
"\\vskip\\copyrightskip\\hbox{Lakeview Music Publishing Company Limited.}}",
"{\\bf Lionel Bart's Oliver, Vocal Selections}, p.~9.", true, "foodglor.pdf");

update Songs set eps_filenames = "fdglfd01.eps;fdglfd02.eps;fdglfd03.eps;fdglfd04.eps;" where title = "Food, Glorious Food";

/* ** *************************************************** */

replace into Songs (title, filecard_title, words, words_reverse, music, music_reverse, lead_sheet, copyright)
values
("Fools Rush In (Where Angels Fear to Tread)", 
"\\vbox{\\hbox{Fools Rush In}\\vskip\\titleskip\\hbox{(Where Angels Fear to Tread)}}",
"Johnny Mercer", "Mercer, Johnny",
"Rube Bloom", "Bloom, Rube", true,
"{\\copyright} 1940 WB Music Corp.~(Renewed)");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, production_subtitle, 
year, sort_by_production, scanned, scanned_filename, source, eps_filenames)
values
("42nd Street", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, "42nd Street", "(Film)", 1933, 
true, true, "ftscstrt.pdf", 
"\\vbox{\\hbox{{\\bf All the Vocal Selections}}\\vskip\\sourceskip\\hbox{{\\bf from 42nd Street}, p.~12.}}",
"frtscst1.eps;frtscst2.eps;");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, recordings, year, language)
values
("Frauen sind keine Engel", "Hans Fritz Beckmann", "Beckmann, Hans Fritz", "Theo Mackeben", "Mackeben, Theo", 
true, 1, 1944, "german");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, language)
values
("Frenesi", "Alberto Dom{\\'\\i}nguez Borr{\\'a}s", "Dom{\\'\\i}nguez Borr{\\'a}s, Alberto", "spanish");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, source, scanned, scanned_filename)
values
("Frim Fram Sauce, The", "Redd Evans", "Evans, Redd", "Joe Ricardel", "Ricardel, Joe", true, 
1946, "{\\bf Library of Jazz Standards, The}, p.~94.", true, "frimfram.pdf");

update Songs set eps_filenames = "frimfrm1.eps;frimfrm2.eps;" where title = "Frim Fram Sauce, The";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
opera, scanned, scanned_filename, source, sort_by_production, public_domain, year, language)
values
("Furtiva lagrima, Una", "Felice Romani", "Romani, Felice",
"Gaetano Donizetti", "Donizetti, Gaetano", false, "Elisir d’amore, L’", false, "",
"{\\bf Opern-Arien, Tenor}, p.~72.", true, true, 1832, "italian");

/* ** *************************************************** */

/* G   */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright,
source, scanned, scanned_filename, language)
values
("Gar{\\^o}ta de Ipanema", "Vin{\\'\\i}cius de Moraes", "Moraes, Vin{\\'\\i}cius de",  
"Antonio Carlos Jobim", "Jobim, Antonio Carlos", true, 1963, "Copyright {\\copyright} 1963 (Renewed)",
"{\\bf The Definitive Antonio Carlos Jobim Collection}, p.~84.", true, "garota.pdf", "portugese");

update Songs set eps_filenames = "garota1.eps;garota2.eps;" where title = "Gar{\\\^o}ta de Ipanema";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("Georgia on my Mind", "Stuart Gorrell", "Gorrell, Stuart", "Hoagy Carmichael", "Carmichael, Hoagy", true, 1);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, copyright)
values
("Georgy  Girl", "Tom Springfield", "Springfield, Tom", "Jim Dale", "Dale, Jim", true,
"\\hbox{1966 and 1967 Springfield Music Ltd., London.}\\hbox{Chapell \\& Co., Inc., publisher.}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, film)
values
("Gigi", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, "Gigi");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, musical, source, scanned, scanned_filename, sort_by_production)
values
("Girl of the Moment", "Ira Gershwin", "Gershwin, Ira", "Kurt Weill", "Weill, Kurt", 
true, 1941, "Lady in the Dark", "{\\bf Kurt Weill, Broadway and Hollywood}, p.~42.",
true, "girlmmnt.pdf", true);

update Songs set eps_filenames = "girlmmn1.eps;girlmmn2.eps;" where title = "Girl of the Moment";

/* ** *************************************************** */

delete from Songs where title = "Gold Diggers' Song, The (We're in the Money)";

replace into Songs (title, subtitle, filecard_title, words, words_reverse, music, music_reverse, lead_sheet, year, film, source, 
notes, scanned, scanned_filename)
values
("Gold Diggers' Song, The", "(We're in the Money)", 
"\\vtop{\\hbox{Gold Diggers' Song, The}\\vskip\\titleskip\\hbox{(We're in the Money)}}", 
"Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", 
true, 1933, "Gold Diggers of 1933", "{\\bf 42nd Street, All the Vocal Selections from 42nd Street}, p.~36.",
"Included in the Broadway musical version of ``42nd Street'' but was {\\it not\/} in the original 1933 film.",
true, "golddgrs.pdf");

update Songs set eps_filenames = "golddig1.eps;golddig2.eps;" where title = "Gold Diggers' Song, The";

replace into Songs (title, is_cross_reference, target, lead_sheet)
values
("We're in the Money", true,
"\\ifalltex Gold Diggers' Song, The\\hfil\\vskip0pt\\S (We're in the Money)"
"\\else\\vtop{\\largebx{\\hbox{Gold Diggers' Song, The}\\vskip\\titleskip\\hbox{\\hskip-\\basichskip(We're in the Money)}}}\\fi",
true);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet,
no_page_turns, year, copyright, musical, source)
values
("Guys and Dolls", "Frank Loesser", "Loesser, Frank", false, true, 1950,
"\\vbox{\\hbox{{\\copyright} Copyright 1950 Frank Music Corporation USA.}"
"\\hbox{{\\copyright} Copyright renewed 1978 Frank Music Corporation USA.}}",
"Guys and Dolls", "Guys and Dolls, Vocal Selections, p.~18.");

/* H   */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes)
values
("Harbour Lights", "Jimmy Kennedy", "Kennedy, Jimmy", "Hugh Williams", "Williams, Hugh", true,
"Hugh Williams is the pseudonym of exiled Austrian composer Will Grosz.");

/* ** *************************************************** */

--

delete from Songs where title = "Heart (You've Gotta Have Heart)";

replace into Songs (title, subtitle, words_and_music, words_and_music_reverse, lead_sheet, year, musical,
scanned, scanned_filename, source, sort_by_production)
values
("Heart", "(You've Gotta Have Heart)", "Richard Adler and Jerry Ross", "Adler, Richard and Ross, Jerry", true, 1955, "Damn Yankees", 
true, "heart.pdf", "{\\bf Damn Yankees, Vocal Selections}, p.~2.", true);

update Songs set eps_filenames = "heart1.eps;heart2.eps;" where title = "Heart";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, copyright, source, scanned, scanned_filename)
values
("Heart and Soul", "Frank Loesser", "Loesser, Frank", 
"Hoagy Carmichael", "Carmichael, Hoagy", true, 1938, 
"Copyright {\\copyright} 1938 (Renewed 1965) by Famous Music Corporation",
"{\\bf The Hoagy Carmichael Songbook}, p.~28.", true, "hrtnsoul.pdf");

update Songs set eps_filenames = "hrtsoul1.eps;hrtsoul2.eps;" where title = "Heart and Soul";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Heartaches", "John Klenner", "Klenner, John", "Al Hoffmann", "Hoffmann, Al", true, 1931);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, musical)
values
("Heat Wave", "Irving Berlin", "Berlin, Irving", true, 1933, "{\\copyright} 1933 (Renewed)",
"As Thousands Cheer");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, public_domain,
scanned, scanned_filename, source, notes)
values
("Hello! Ma Baby", "Joe E.~Howard and Ida Emerson", "Howard, Joe E.~and Emerson, Ida", true, 1899,
true, true, "hlmababy.pdf",
"\\vbox{\\hbox{{\\bf The Looney Tunes Songbook}, p.~98.}\\vskip\\sourceskip"
"\\hbox{{\\bf 100 Years of Popular Music, 1900}, p.~128.}}",
"Verse missing in {\\bf 100 Years of Popular Music, 1900}.  Title and attribution vary.");

update Songs set eps_filenames = "hlmabab1.eps;hlmabab2.eps;" where title = "Hello! Ma Baby";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, source, musical, scanned, scanned_filename)
values
("Here's That Rainy Day", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true, 1953,
"{\\bf Classic Songs of Johnny Burke}, p.~33.", "Carnival in Flanders", true, "hererain.pdf");

update Songs set eps_filenames = "hererain.eps;" where title = "Here's That Rainy Day";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, year, language)
values
("Heute Nacht oder nie", "Marcellus Schiffer", "Schiffer, Marcellus", "Mischa Spoliansky", "Spoliansky, Mischa",
true, 1932, "german");

/* recordings 1 ? Not found. */

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Hey, Good Lookin'", "Hank Williams", "Williams, Hank", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, film, language)
values
("Homme et une femme, Un", "Pierre Barouh", "Barouh, Pierre", "Francis Lai", "Lai, Francis", 
true, 1966, "Homme et une femme, Un", "french");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Hooray For Hollywood", "Johnny Mercer", "Mercer, Johnny", "Richard A.~Whiting", "Whiting, Richard A.", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("How About You?", "Ralph Freed", "Freed, Ralph", "Burton Lane", "Lane, Burton", true);

/* banjo chords accomp.  */

/* ** *************************************************** */

/* select * from Songs where music = "Walter Donaldson"\G  */

/* delete from Songs where title = "How You Gonna Keep 'Em Down on the Farm?";  */

replace into Songs (title, filecard_title, words, words_reverse, music, music_reverse, lead_sheet,
year, source, public_domain, scanned, scanned_filename, eps_filenames, notes)
values
("How 'Ya Gonna Keep 'Em Down on the Farm?", 
"\\vbox{\\hbox{How 'Ya Gonna Keep 'Em}\\vskip\\titleskip\\hbox{Down on the Farm?}}",
"Sam M.~Lewis and Joe Young", "Lewis, Sam M.~and Young, Joe",
"Walter Donaldson", "Donaldson, Walter", true, 1919, "IMSLP", 
true, true, "howkeepm.pdf", "howkeep1.eps;howkeep2.eps;",
"Subtitle:  (After They've Seen Paree)"); 

update Songs set  =  where title = "How 'Ya Gonna Keep 'Em Down on the Farm?";


/* I   */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source, 
musical, scanned, scanned_filename, sort_by_production)
values
("I Can Cook Too", "Betty Comden and Adolf Green", "Comden, Betty and Green, Adolf", 
"Leonard Bernstein", "Bernstein, Leonard",
true, 1944, "{\\bf Bernstein on Broadway}, p.~33.", "On the Town", true, "icancook.pdf", true);

update Songs set eps_filenames = "icancook1.eps;icancook2.eps;icancook3.eps;icancook4.eps;" where title = "I Can Cook Too";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year, copyright)
values
("I Can Dream, Can't I?", "Irving Kahal", "Kahal, Irving", "Sammy Fain", "Fain, Sammy", true,
"Right This Way", 1937, "{\\copyright} 1937 by Chappell \\& Co. Copyright Renewed");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("I Can't Get Started", "Ira Gershwin", "Gershwin, Ira", "Vernon Duke", "Duke, Vernon", true);

/* ** *************************************************** */value

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("I Could Have Danced All Night", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, 1);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, 
scanned, scanned_filename, eps_filenames, year)
values
("I Cover the Waterfront", "Edward Heyman", "Heyman, Edward", "John W.~Green", "Green, John W.", true, 1,
true, "icvrwtft.pdf", "icvrwtft1.eps;icvrwtft2.eps;icvrwtft3.eps;", 1933);

/* ** *************************************************** */

-- delete from Songs where title =  "I Don't Know Why (I Just Do)";

select * from Songs where title like("I Don't Know Why%")\G



replace into Songs (title, subtitle, words, words_reverse, music, music_reverse, lead_sheet, year,
scanned, scanned_filename, eps_filenames)
values
("I Don't Know Why", "(I Just Do)", "Roy Turk", "Turk, Roy", "Fred E.~Ahlert", "Ahlert, Fred E.", true, 1931,
true, "idntknwy.pdf", "idntknwy1.eps;idntknwy2.eps;");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, source,
scanned, scanned_filename)
values
("I Don't Want to Set the World on Fire", 
"\\vtop{\\hbox{Eddie Seiler, Sol Marcus,}\\vskip2pt\\hbox{Bennie Benjamin}\\vskip2pt\\hbox{and Eddie Durham}}", 
"\\vbox{\\hbox{Seiler, Eddie; Marcus, Sol;}\\vskip\\composerskip\\hbox{Benjamin, Bennie and Durham, Eddie}}", 
true, 1941,
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music,}}\\vskip\\sourceskip\\hbox{{\\bf 1940s, Part One}, p.~75.}}", 
true, "idwtswnf.pdf");

update Songs set eps_filenames = "idwtswnf1.eps;idwtswnf2.eps;" where title = "I Don't Want to Set the World on Fire";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production, source)
values
("I Feel Pretty", "Stephen Sondheim", "Sondheim, Stephen", "Leonard Bernstein", "Bernstein, Leonard", true,  
"West Side Story", true, 
"\\vbox{\\hbox{{\\bf Bernstein on Broadway}, p.~200.}\\vskip\\sourceskip"
"\\hbox{{\\bf West Side Story, Die bekanntesten Melodien},}\\vskip\\sourceskip\\hbox{ p.~64 (Vocal Selections).}}");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical, year, source)
values
("I Get a Kick Out of You", "Cole Porter", "Porter, Cole", true, "Anything Goes",
1934, "{\\bf The Best of Cole Porter}, p.~68.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
opera, sort_by_production, source)
values
("I Got Plenty o' Nuttin'", "Ira Gershwin and DuBose Heyward", "Gershwin, Ira and Heyward, DuBose",
"George Gershwin", "Gershwin, George", false, 1935, "Porgy and Bess", false,
"\\vbox{\\hbox{{\\bf Summertime, The Greatest Songs}}\\vskip\\sourceskip\\hbox{{\\bf of George Gershwin}, p.~17.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, revue, source,
scanned, scanned_filename)
values 
("I Like the Likes of You", "E.Y.~Harburg", "Harburg, E.Y.", "Vernon Duke", "Duke, Vernon",
true, 1934, "Ziegfeld Follies of 1934", "{\\bf Vernon Duke Songbook, The, Volume 1}, p.~28.",
true, "lksofyou.pdf");

update Songs set eps_filenames = "lksofyou1.eps;lksofyou2.eps;" where title = "I Like the Likes of You";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical)
values
("I Married an Angel", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", 
true, "I Married an Angel");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("I Only Have Eyes for You", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", 
true, "Dames");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("I Say a Little Prayer", "Hal David", "David, Hal", "Burt Bacharach", "Bacharach, Burt", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production, year)
values
("I Talk to the Trees", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, "Paint Your Wagon", true,
1951);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, 
lead_sheet, year, musical, source, scanned, scanned_filename, public_domain)
values
("I Wonder Who's Kissing Her Now", 
"Will M.~Hough and Frank R.~Adams", "Hough, Will M.~and Adams, Frank R.",
"Harold Orlob", "Orlob, Harold", true, 1909, "Prince of To-Night, The",
"{\\bf 100 Years of Popular Music, 1900}, p.~144.",
true, "iwndrwho.pdf", true);

update Songs set eps_filenames = "iwonder01.eps;iwonder02.eps;" where title = "I Wonder Who's Kissing Her Now";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright)
values
("If Love Were All", "No@{e}l Coward", "Coward, No@{e}l",  true, 1929, "{\\copyright} 1929 (Renewed).");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production, year)
values
("If I Should Ever Leave You", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true,
"Camelot", true, 1960);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
opera, year, scanned, scanned_filename, public_domain, source, sort_by_production, language)
values
("Il {\\'e}tait une fois", "Jules Barbier", "Barbier, Jules", "Jacques Offenbach", "Offenbach, Jacques", false,
"Contes d'Hoffmann, Les", 1881, false, "iletaifs.pdf", true,
"\\vbox{\\hbox{{\\bf Opern-Arien, Tenor}, p.~182.}"
"\\hbox{{\\bf Hoffmanns Erz@{a}hlungen (Les Contes d'Hoffmann), Klavierauszug}, p.~51.}}",
true, "french");

-- select title from Songs where music = "Jacques Offenbach";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year, copyright)
values
("I'll Be Seeing You", "Irving Kahal", "Kahal, Irving", "Sammy Fain", "Fain, Sammy", true,
"Right This Way", 1938, "{\\copyright} 1938 by Williamson Music Co.~(Renewed).");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, copyright, year)
values
("I'll Close My Eyes", "Billy Reid", "Reid, Billy", true, "{\\copyright} 1945.", 1945);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, source,
scanned, scanned_filename, musical)
values
("I'll Follow My Secret Heart", "No@{e}l Coward", "Coward, No@{e}l",  true, 1934, 
"{\\copyright} 1934 (Renewed).",
"{\\bf Sir No@{e}l Coward, His Words and Music}, p.~65.", true, "illfollw.pdf", "Conversation Piece");

update Songs set eps_filenames = "illfollw1.eps;illfollw2.eps;" where title = "I'll Follow My Secret Heart";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source, 
musical, scanned, scanned_filename, sort_by_production)
values
("(I'll Marry) The Very Next Man", "Sheldon Harnick", "Harnick, Sheldon", "Jerry Bock", "Bock, Jerry",
true, 1959, "{\\bf Fiorello!  Vocal Selections}, p.~8.", "Fiorello!", true, "verynext.pdf", true);

update Songs set eps_filenames = "verynext1.eps;verynext2.eps;verynext3.eps;" where title = "(I'll Marry) The Very Next Man";

replace into Songs (title, is_cross_reference, target, lead_sheet, sort_by_production, production)
values
("Very Next Man, (I'll Marry) The", true, "(I'll Marry) The Very Next Man", true, true, "Fiorello!");

select * from Songs where title = "Very Next Man, (I'll Marry) The"\G

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes)
values
("I'll Never Fall in Love Again", "Hal David", "David, Hal", "Burt Bacharach", "Bacharach, Burt", true,
"Keys:  E$\\flat$ (original) and D.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings,
year, source, film, notes, scanned, scanned_filename)
values
("I'll Remember April", "Patricia Johnston and Don Raye", "Johnston, Patricia and Raye, Don", 
"Gene de Paul", "Paul, Gene de", true, 1, 1941, "{\\bf 150 of the Most Beautiful Songs Ever}, p.~184.",
"Ride 'Em Cowboy", "Abbot and Costello film", true, "illrmapr.pdf");

update Songs set eps_filenames = "illrmbr1.eps;illrmbr2.eps;illrmbr3.eps;" where title = "I'll Remember April";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, source)
values
("I'll See You Again", "No@{e}l Coward", "Coward, No@{e}l",  true, 1929, 
"{\\copyright} 1929 (Renewed).",
"{\\bf Sir No@{e}l Coward, His Words and Music}, p.~34.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("I'll See You in My Dreams", "Gus Kahn", "Kahn, Gus", "Isham Jones", "Jones, Isham", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("I'll String Along With You", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, 1934);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, notes, arrangement_solo_guitar, year)
values
("Illusions", "Friedrich Hollaender", "Hollaender, Friedrich", true, "Score but no lead sheet!", true, 1948);

/* mark_blue  */

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, public_domain,
scanned, scanned_filename, source)
values
("I'm Forever Blowing Bubbles", 
"\\vtop{\\hbox{John Kellette, James Brockman,}\\vskip\\composerskip\\hbox{Nat Vincent and James Kendis}}", 
"\\vbox{\\hbox{Kellette, John; Brockman, James;}\\vskip\\composerskip\\hbox{Vincent, Nat and Kendis, James}}", 
true, 1919, true, true, "imfrvrbb.pdf", 
"\\vbox{\\hbox{{\\bf The Looney Tunes Songbook}, p.~78.}\\vskip\\sourceskip"
"\\hbox{{\\bf 100 Years of Popular Music, 1900}, p.~150.}}");

update Songs set eps_filenames = "imfrvrbb.eps;" where title = "I'm Forever Blowing Bubbles";

select * from Songs where title = "I'm Forever Blowing Bubbles"\G

/* ** *************************************************** */

-- delete from Songs where title like("%I'm Gonna Sit%");

replace into Songs (title, filecard_title, words, words_reverse, music, music_reverse, lead_sheet, year, 
scanned, scanned_filename, source)
values
("\\vtop{\\hbox{I'm Gonna Sit Right Down}\\vskip-.2\\baselineskip\\hbox{and Write Myself a Letter}\\vskip.375\\baselineskip}",
"\\vbox{\\hbox{I'm Gonna Sit Right Down}\\vskip\\titleskip\\hbox{and Write Myself a Letter}}",
"Joe Young", "Young, Joe", "Fred E.~Ahlert", "Ahlert, Fred E.", true, 1935, true, "gonnasit.pdf",
"\\vbox{\\hbox{{\\bf The Big Book of '50s and '60s}}\\vskip\\sourceskip\\hbox{{\\bf Swinging Songs}, p.~89.}}");

update Songs set eps_filenames = "gonnasi1.eps;gonnasi2.eps;" where title like("%I'm Gonna Sit Right Down%");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
recordings, year, film, scanned, scanned_filename)
values
("I'm in the Mood for Love", "Dorothy Fields", "Fields, Dorothy", "Jimmy McHugh", "McHugh, Jimmy", true, 1,
1935, "Every Night at Eight", true, "inmdfrlv.pdf");

update Songs set eps_filenames = "inmdfrlv1.eps;inmdfrlv2.eps;inmdfrlv3.eps;" where title = "I'm in the Mood for Love";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, public_domain,
scanned, scanned_filename, source)
values
("I'm Just Wild About Harry", "Noble Sissle", "Sissle, Noble", "Eubie Blake", "Blake, Eubie", true, 1921,
true, true, "imwldahr.pdf",
"\\vbox{\\hbox{{\\bf The Looney Tunes Songbook}, p.~102.}\\vskip\\sourceskip"
"\\hbox{{\\bf 100 Years of Popular Music, 20s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 2}, p.~132.}}");

update Songs set eps_filenames = "imwldah1.eps;imwldah2.eps;" where title = "I'm Just Wild About Harry";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, notes)
values
("I'm Shooting High", "Ted Koehler and Charles Wilmott", "Koehler, Ted and Wilmott, Charles",
"Jimmy McHugh", "McHugh, Jimmy", true, 1935, "Additional words by Charles Wilmott");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, source, scanned, scanned_filename)
values
("Imagination", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true, 1939,
"{\\bf Classic Songs of Johnny Burke}, p.~44.", true, "imagnntn.pdf");

update Songs set eps_filenames = "imagin01.eps;imagin02.eps;" where title = "Imagination";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("In a Sentimental Mood", "Manny Kurtz, Irving Mills", "Kurtz, Manny and Mills, Irving", "Duke Ellington", "Ellington, Duke", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, scanned, scanned_filename, language)
values
("Incerteza", "Newton F.~Mendon{\\c c}a", "Mendon{\\c c}a, Newton F.", 
"Antonio Carlos Jobim", "Jobim, Antonio Carlos", true, 1966, true, "incertza.pdf", "portugese");

update Songs set eps_filenames = "incertz1.eps;incertz2.eps;" where title = "Incerteza";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright,
source, scanned, scanned_filename, language)
values
("Insensatez", "Vin{\\'\\i}cius de Moraes", "Moraes, Vin{\\'\\i}cius de",  
"Antonio Carlos Jobim", "Jobim, Antonio Carlos", true, 1963, "Copyright {\\copyright} 1963, 1964",
"{\\bf The Definitive Antonio Carlos Jobim Collection}, p.~88.", true, "insenstz.pdf", "portugese");

update Songs set eps_filenames = "insenstz.eps;" where title = "Insensatez";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
year, film, scanned, scanned_filename, source)
values
("Isn't It Romantic?", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true,
1932, "Love Me Tonight", true, "isntrmnt.pdf",
"\\vbox{\\hbox{{\\bf Rodgers and Hart,}}\\vskip\\sourceskip\\hbox{{\\bf A Musical Anthology}, p.~192.}}");

update Songs set eps_filenames = "isntrmn1.eps;isntrmn2.eps;" where title = "Isn't It Romantic?";

/* ** *************************************************** */

-- delete from Songs where title like("%Isn't This a Lovely Day?%");

-- select title from Songs where title like("Isn't This a Lovely Day?%");

replace into Songs (title, filecard_title, words_and_music, words_and_music_reverse, lead_sheet, year, film, source)
values
("\\vtop{\\hbox{Isn't This a Lovely Day?}\\vskip-.2\\baselineskip\\hbox{(To Be Caught in the Rain)}\\vskip.375\\baselineskip}",
"\\vtop{\\hbox{Isn't This a Lovely Day?}\\vskip\\titleskip\\hbox{(To Be Caught in the Rain)}}",
"Irving Berlin", "Berlin, Irving", true, 1935, "Top Hat",
"\\vbox{\\hbox{{\\bf Songs of Irving Berlin, The,}}\\vskip\\sourceskip\\hbox{{\\bf Movie Songs}, p.~45.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
scanned, scanned_filename, eps_filenames, year, film)
values
("It Could Happen to You", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true,
true, "itcdhpty.pdf", "itcdhpty1.eps;itcdhpty2.eps;itcdhpty3.eps;", 1944, "And the Angels Sing");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, 
scanned, scanned_filename, public_domain)
values
("It Had to be You", "Gus Kahn", "Kahn, Gus", "Isham Jones", "Jones, Isham", true, 
1924, true, "ithadbey.pdf", true);

update Songs set eps_filenames = "ithadbey.eps;" where title = "It Had to be You";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, 
lead_sheet, year, source, scanned, scanned_filename, musical)
values
("It Never Entered My Mind", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true,
1940,
"\\vbox{\\hbox{{\\bf Rodgers and Hart,}}\\vskip\\sourceskip\\hbox{{\\bf A Musical Anthology}, p.~152.}}",
true, "itnvrmnd.pdf", "Higher and Higher");

update Songs set eps_filenames = "itnvrmnd1.eps;itnvrmnd2.eps;" where title = "It Never Entered My Mind";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, source,
scanned, scanned_filename, eps_filenames)
values
("It's a Pity to Say `Goodnight'", "Billy Reid", "Reid, Billy", true, 1946,
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music,}}\\vskip\\sourceskip\\hbox{{\\bf 1940s, Part Two}, p.~146.}}",
true, "itsptysg.pdf", "itsptysg1.eps;itsptysg2.eps;itsptysg3.eps;itsptysg4.eps;");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, source)
values
("It's All Right With Me", "Cole Porter", "Porter, Cole", true, 1953,
"{\\bf The Best of Cole Porter}, p.~90.");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet,
year, copyright, source, musical, scanned, scanned_filename)
values
("It's De-Lovely", "Cole Porter", "Porter, Cole", true, 1936, 
"Copyright {\\copyright} 1936 by Chappell \\& Co. (Renewed).", 
"{\\bf The Best of Cole Porter}, p.~95", "Red, Hot and Blue", true, "itsdelve.pdf");

update Songs set eps_filenames = "itsdelv1.eps;itsdelv2.eps;" where title = "It's De-Lovely";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("It's Not For Me to Say", "Al Stillman", "Stillman, Al", "Robert Allen", "Allen, Robert", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
scanned, scanned_filename, source)
values
("I've Got a Feeling I'm Falling", "Billy Rose", "Rose, Billy",
"Thomas ``Fats'' Waller and Harry Link", "Waller, Thomas ``Fats'' and Link, Harry",
true, 1929, true, "ivgtflng.pdf", "{\\bf Ain't Misbehavin', Vocal Selections}, p.~42.");

update Songs set eps_filenames = "ivgtflng1.eps;ivgtflng2.eps;" where title = "I've Got a Feeling I'm Falling";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source)
values
("I've Got a Pocketful of Dreams", "Johnny Burke", "Burke, Johnny", "James V.~Monaco", "Monaco, James V.", true, 1938,
"Classic Songs of Johnny Burke, Hollywood's Songwriter, p.~41");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("I've Got the World on a String", "Ted Koehler", "Koehler, Ted", "Harold Arlen", "Arlen, Harold",
true, 1932);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, source)
values
("I've Got You Under My Skin", "Cole Porter", "Porter, Cole", true, 1936, 
"Copyright {\\copyright} 1936 by Chappell {\\&} Co.~ (Renewed)", "{\\bf The Best of Cole Porter}, p.~86.");

/* J   */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year, language)
values
("Ja und Nein", "Willy Dehmel", "Dehmel, Willy", "Franz Grothe", "Grothe, Franz", true, 1, 1939, "german");

/* ** *************************************************** */

/* Instrumental.  Words added later.  */

/* Presumably copyrighted in Denmark and not in public domain.  */


--

delete from Songs where title like("Jalousie%");

replace into Songs (title, subtitle, words, words_reverse, music, music_reverse, lead_sheet, 
year, copyright, scanned, scanned_filename, language, eps_filenames)  
values
("Jalousie ``Tango Tzigane''", "(Jealousy)", "None", "None", "Jacob Gade", "Gade, Jacob", true,
1925, "{\\copyright} 1925.  Public Domain.", true, "jealousy.pdf", "none",
"jealsy01.eps;jealsy02.eps;jealsy03.eps;jealsy04.eps;jealsy05.eps;");

#words: Vera Bloom (Engl.)

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, scanned, scanned_filename)
values
("Japanese Sandman", "Raymond B.~Egan", "Egan, Raymond B.", "Richard A.~Whiting", "Whiting, Richard A.", 
true, true, "jpnsndmn.pdf");

update Songs set eps_filenames = "jpnsnd01.eps;jpnsnd02.eps;jpnsnd03.eps;jpnsnd04.eps;jpnsnd05.eps;" where title = "Japanese Sandman, The";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("Jeepers Creepers", "Johnny Mercer", "Mercer, Johnny", "Harry Warren", "Warren, Harry", true, 1);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename)
values
("Jitterbug Waltz, The", "None", "None",
"Thomas ``Fats'' Waller", "Waller, Thomas ``Fats''",
true, 1942, "{\\bf Ain't Misbehavin', Vocal Selections}, p.~46.", true, "jttrbwlz.pdf");

update Songs set eps_filenames = "jttrbwlz.eps;" where title = "Jitterbug Waltz, The";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename)
values
("Joint is Jumpin', The", "Andy Razaf and J.C.~Johnson", "Razaf, Andy and Johnson, J.C.",
"Thomas ``Fats'' Waller", "Waller, Thomas ``Fats''",
true, 1938, "{\\bf Ain't Misbehavin', Vocal Selections}, p.~78.",
true, "jntsjmpn.pdf");

update Songs set eps_filenames = "jntsjmp1.eps;jntsjmp2.eps;" where title = "Joint is Jumpin', The";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("June in Janury", "Leo Robin", "Robin, Leo", "Ralph Rainger", "Rainger, Ralph", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source, 
musical, scanned, scanned_filename, sort_by_production)
values
("Just in Time", "Betty Comden and Adolf Green", "Comden, Betty and Green, Adolf", "Jule Styne", "Styne, Jule",
true, 1956, "{\\bf The Comden and Green Songbook}, p.~68.", "Bells are Ringing", true, "justtime.pdf", true);

update Songs set eps_filenames = "justtim1.eps;justtim2.eps;" where title = "Just in Time";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source)
values
("Just Like a Man", "Ogden Nash", "Nash, Ogden", "Vernon Duke", "Duke, Vernon", false, 1946,
"{\\bf Vernon Duke Songbook, The, Volume 1}, p.~32.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source,
scanned, scanned_filename)
values
("Just One More Chance", "Sam Coslow", "Coslow, Sam", "Arthur Johnston", "Johnston, Arthur", true, 1931,
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 1930s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 1}, p.~166.}}",
true, "jstonmcn.pdf");

update Songs set eps_filenames = "jstonmc1.eps;jstonmc2.eps;" where title = "Just One More Chance";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, source,
scanned, scanned_filename)
values
("Just One of Those Things", "Cole Porter", "Porter, Cole", false, 1935, 
"Copyright {\\copyright} 1935 (Renewed) Warner Bros.~Inc.", "{\\bf The Best of Cole Porter}, p.~100.",
true, "jstthngs.pdf");

/* ** *************************************************** */

/* K   */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source,
scanned, scanned_filename, film)
values
("Keep Young and Beautiful", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true,
1933, "\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 30s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 1}, p.~170.}}",
true, "kpygbtfl.pdf",
"Roman Scandals");

update Songs set eps_filenames = "kpygbtf1.eps;kpygbtf2.eps;" where title = "Keep Young and Beautiful";

/* ** (2) *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename)
values
("Keepin' Out of Mischief Now", "Andy Razaf", "Razaf, Andy",
"Thomas ``Fats'' Waller", "Waller, Thomas ``Fats''",
true, 1932, "{\\bf Ain't Misbehavin', Vocal Selections}, p.~85.",
true, "kpnmschf.pdf");

update Songs set eps_filenames = "kpnmsch1.eps;kpnmsch2.eps;" where title = "Keepin' Out of Mischief Now";

/* ** (2) *************************************************** */

/* Knaben Wunderhorn, Des.  Gustav Mahler.

select * from Songs where music = "Gustav Mahler"\G

/* *** (3) *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
song_cycle, year, scanned, scanned_filename, public_domain, source, sort_by_production, language)
values
("Antonius von Padua Fischpredigt, Des", "Anonymous, Gustav Mahler", "Anonymous;  Mahler, Gustav", 
"Gustav Mahler", "Mahler, Gustav", false,
"14 Lieder aus Des Knaben Wunderhorn", 1914, false, "antnpdua.pdf", true, 
"\\vbox{\\hbox{{\\bf 14 Lieder aus Des Knaben Wunderhorn}}\\vskip\\sourceskip\\hbox{{\\bf f@{u}r tiefe Stimme und Klavier}, p.~32.}}", 
true, "german");

/* *** (3)*************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
song_cycle, year, scanned, scanned_filename, public_domain, source, sort_by_production, language)
values
("Irdische Leben, Das", "Anonymous, Gustav Mahler", "Anonymous;  Mahler, Gustav", 
"Gustav Mahler", "Mahler, Gustav", false,
"14 Lieder aus Des Knaben Wunderhorn", 1914, false, "irdleben.pdf", true, 
"{\\bf 14 Lieder aus Des Knaben Wunderhorn f@{u}r tiefe Stimme und Klavier}, p.~25.", 
true, "german");

/* *** (3) *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
song_cycle, year, scanned, scanned_filename, public_domain, source, sort_by_production, language)
values
("Lob des hohen Verstandes", "Anonymous, Gustav Mahler", "Anonymous;  Mahler, Gustav", 
"Gustav Mahler", "Mahler, Gustav", true,
"14 Lieder aus Des Knaben Wunderhorn", 1914, true, "lbvrstnd.pdf", true, 
"{\\bf 14 Lieder aus Des Knaben Wunderhorn f@{u}r tiefe Stimme und Klavier}, p.~61.", 
true, "german");

update Songs set eps_filenames = "lbvrstn1.eps;lbvrstn2.eps;lbvrstn3.eps;lbvrstn4.eps;" where title = "Lob des hohen Verstandes";

/* *** (3) *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
song_cycle, year, scanned, scanned_filename, public_domain, source, sort_by_production, language)
values
("Rheinlegendchen", "Anonymous, Gustav Mahler", "Anonymous;  Mahler, Gustav", 
"Gustav Mahler", "Mahler, Gustav", true,
"14 Lieder aus Des Knaben Wunderhorn", 1914, false, "rhnlgndn.pdf", true, 
"{\\bf 14 Lieder aus Des Knaben Wunderhorn f@{u}r tiefe Stimme und Klavier}, p.~41.", 
true, "german");

/* *** (3) *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
song_cycle, year, scanned, scanned_filename, public_domain, source, sort_by_production, language)
values
("Wer hat das Liedlein erdacht?", "Anonymous, Gustav Mahler", "Anonymous;  Mahler, Gustav", 
"Gustav Mahler", "Mahler, Gustav", true,
"14 Lieder aus Des Knaben Wunderhorn", 1914, true, "liedlein.pdf", true, 
"{\\bf 14 Lieder aus Des Knaben Wunderhorn f@{u}r tiefe Stimme und Klavier}, p.~20.", 
true, "german");

update Songs set eps_filenames = "liedlei1.eps;liedlei2.eps;liedlei3.eps;" where title = "Wer hat das Liedlein erdacht?";

/* *** (3) *************************************************** */

/* ** (2) *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, language)
values
("Komm, Zigany", "Julius Brammer und Alfred Gr@{u}nwald", "Brammer, Julius und Gr@{u}nwald, Alfred",
"Emmerich K{\\'a}lm{\\'a}n", "K{\\'a}lm{\\'a}n, Emmerich", true, 1932, "german");

/* Film-Operetta:  Gr@{a}fin Mariza using melodies by K\\'alman.         */
/* comment: (ungarisch: K{\\'a}lm{\\'a}n Imre;  eigentlich: Imre Koppstein  */
/* Copyright 1957                                                           */

/* L  */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, opera,
scanned, scanned_filename, public_domain, language, sort_by_production)
values
("L{\\`a} ci darem la mano", "Lorenzo Da Ponte", "Da Ponte, Lorenzo", "Wolfgang Amadeus Mozart",
"Mozart, Wolfgang Amadeus", true, 1787, "Don Giovanni", true, "lacidarm.pdf", true, "italian",
true);

update Songs set eps_filenames = "lacidr01.eps;lacidr02.eps;lacidr03.eps;lacidr04.eps;lacidr05.eps;"
where title = "L{\\`a} ci darem la mano";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Lady in Red, The", "Mort Dixon", "Dixon, Mort", "Allie Wrubel", "Wrubel, Allie", true, 1935);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year)
values
("Lady is a Tramp, The", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true, "Babes in Arms", 1937);

/* ** *************************************************** */

/*  !!! Get lyricists!  */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, notes)
values
("Lady of Spain",
"Erell Reaves and Henry Tilsley", "Reaves, Erell and Tilsley, Henry",
"Tolchard Evans", "Evans, Tolchard", true, 1931,
"\"Erell Reaves\" is a pseudonym of Stanley J.~Damerell and Robert Hargreaves");

/* ** *************************************************** */

delete from Songs where title like("Lady's in Love%");

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, film,
scanned, scanned_filename, notes)
values
("Lady's in Love With You, The", "Frank Loesser", "Loesser, Frank", "Burton Lane", "Lane, Burton", true,
1939, "Some Like It Hot", true, "ldysinlv.pdf", "Not the 1959 Billy Wilder film.");

update Songs set eps_filenames = "ldysinlv1.eps;ldysinlv2.eps;" where title = "Lady's in Love With You, The";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, arrangement_solo_guitar, notes,
copyright, film, year)
values
("Laura", "Johnny Mercer", "Mercer, Johnny", "David Raksin", "Raksin, David", true, true,
"Arrangement Andantino.",
"\\vtop{\\hbox{{\\copyright} 1945 EMI Catalogue Partnership}\\vskip\\copyrightskip\\hbox{and EMI Robbins Catalog Inc., USA.}"
"\\vskip\\copyrightskip\\hbox{Worldwide print rights controlled by}"
"\\vskip\\copyrightskip\\hbox{Warner Bros. Publications Inc./IMP Ltd.}}",
"Laura", 1944);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, 
year, source, scanned, scanned_filename)
values
("Lazy River", "\\vtop{\\hbox{Hoagy Carmichael}\\vskip\\composerskip\\hbox{and Sidney Arodin}}",
"Carmichael, Hoagy and Arodin, Sidney", 
true, 1931, "{\\bf The Hoagy Carmichael Songbook}, p.~60.", true, "lazyrivr.pdf");

update Songs set eps_filenames = "lazyrivr1.eps;lazyrivr2.eps;" where title = "Lazy River";

/* ** *************************************************** */

/*  ?? Question mark in film title?  */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("Let's Call the Whole Thing Off", "Ira Gershwin", "Gershwin, Ira", "George Gershwin", "Gershwin, George", true,
"Shall We Dance");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, film, source)
values
("Let's Face the Music and Dance", "Irving Berlin", "Berlin, Irving", true, 1936,
"Follow the Fleet",
"\\vbox{\\hbox{{\\bf Songs of Irving Berlin, The,}}\\vskip\\sourceskip\\hbox{{\\bf Movie Songs}, p.~64.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, notes, year)
values
("Let's Fall in Love", "Ted Koehler", "Koehler, Ted", "Harold Arlen", "Arlen, Harold", true, 
"{\\bf The Harold Arlen Songbook}", 
1933);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
scanned, scanned_filename, 
operetta, notes, sort_by_production, year, public_domain, language)
values
("Lippen schweigen", 
"Victor L{\\'e}on und Leo Stein", "L{\\'e}on, Victor und Stein, Leo",
"Franz Leh{\\'a}r", "Leh{\\'a}r, Franz", true, true, "lipnschw.pdf", "Lustige Witwe, Die",
"English title:  The Merry Widow Waltz", true, 1905, true, "german");

update Songs set eps_filenames = "lpnsch01.eps;lpnsch02.eps;" where title = "Lippen schweigen";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
scanned, scanned_filename, operetta, sort_by_production, year, public_domain, language)
values
("Lied vom dummen Reiter, Das", 
"Victor L{\\'e}on und Leo Stein", "L{\\'e}on, Victor und Stein, Leo",
"Franz Leh{\\'a}r", "Leh{\\'a}r, Franz", true, true, "dummreit.pdf", 
"Lustige Witwe, Die", true, 1905, true, "german");

update Songs set eps_filenames = "dummrt01.eps;dummrt02.eps;dummrt03.eps;" where title = "Lied vom dummen Reiter, Das";

/* ** *************************************************** */

/*  Check words!! */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, language)
values
("Lisboa Antiga", "Jos{\\'e} Galhardo", "Galhardo, Jos{\\'e}", 
"Raul Portela and Amadeu do Vale", "Portela, Raul and Vale, Amadeu do", true, 1937, "portugese");

/* ** *************************************************** */

--

delete from Songs where title like("Listen to My Song%");


-- delete from Composers_Songs where title = "Listen to My Song";
-- delete from Lyricists_Songs where title = "Listen to My Song";

replace into Songs (title, subtitle, words, words_reverse, music, music_reverse, lead_sheet, 
year, musical, source, scanned, scanned_filename, sort_by_production, eps_filenames)
values
("Listen to My Song", "(Johnny's Song)", "Paul Green", "Green, Paul", "Kurt Weill", "Weill, Kurt", 
true, 1936, "Johnny Johnson", "{\\bf Kurt Weill, From Berlin to Broadway}, p.~48.",
true, "listsong.pdf", true, "listsong1.eps;listsong2.eps;");


/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source, 
musical, scanned, scanned_filename, sort_by_production)
values
("Little Tin Box", "Sheldon Harnick", "Harnick, Sheldon", "Jerry Bock", "Bock, Jerry",
true, 1959, "{\\bf Fiorello!  Vocal Selections}, p.~22.", "Fiorello!", true, "lttltnbx.pdf", true);

update Songs set eps_filenames = "lttltnbx1.eps;lttltnbx2.eps;" where title = "Little Tin Box";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Little White Lies", "Walter Donaldson", "Donaldson, Walter", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Liza (All the Clouds'll Roll Away)", "Ira Gershwin and Gus Kahn", "Gershwin, Ira and Kahn, Gus",
"George Gershwin", "Gershwin, George", true,
1929);
/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("Long Ago (and Far Away)", "Ira Gershwin", "Gershwin, Ira", "Jerome Kern", "Kern, Jerome", true, "Cover Girl");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year)
values
("Lost in the Stars", "Maxwell Anderson", "Anderson, Maxwell", "Kurt Weill", "Weill, Kurt", true, "Lost in the Stars",
1949);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, source,
scanned, scanned_filename, eps_filenames, musical)
values
("Love for Sale", "Cole Porter", "Porter, Cole", true, 1930, "{\\bf The Best of Cole Porter}, p.~112.",
true, "lovesale.pdf", "lovesale1.eps;lovesale2.eps;lovesale3.eps;", "New Yorkers, The");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
year, source, scanned, scanned_filename)
values
("Love Letters in the Sand", "Nick Kenny and Charles Kenny", "Kenny, Nick and Kenny, Charles",
"J.~Fred Coots", "Coots, J.~Fred", true, 1931,
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 30s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 1}, p.~196.}}",
true, "lvltrsnd.pdf");

update Songs set eps_filenames = "lvltrsn1.eps;lvltrsn2.eps;" where title = "Love Letters in the Sand";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Love Me or Leave Me", "Gus Kahn", "Kahn, Gus", "Walter Donaldson", "Donaldson, Walter", true, 1928);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
operetta, year, copyright, source, scanned, scanned_filename)
values
("Lover Come Back to Me", "Oscar Hammerstein II", "Hammerstein II, Oscar",
"Sigmund Romberg", "Romberg, Sigmund", true, "New Moon, The", 1928,
"Copyright {\\copyright} 1928 Warner Bros.~Inc. Copyright Renewed",
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 1920s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 1}, p.~152.}}",
true, "lvrcbtme.pdf");

update Songs set eps_filenames = "lvrcmbk1.eps;lvrcmbk2.eps;" where title = "Lover Come Back to Me";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year,
sort_by_production, source, notes, scanned, scanned_filename)
values
("Lullaby of Broadway", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true,
"Gold Diggers of 1935", 1935, false, "\\vbox{\\hbox{{\\bf 42nd Street, All the Vocal Selections from 42nd Street}, p.~39.}"
"\\vskip\\sourceskip\\hbox{{\\bf 100 Years of Popular Music, 1930s, Volume 2}}}",
"Included in the Broadway musical version of ``42nd Street'' but was {\\it not\/} in the original 1933 film.",
true, "lullbrdw.pdf");

update Songs set eps_filenames = "lullbrd1.eps;lullbrd2.eps;" where title = "Lullaby of Broadway";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("Lulu's Back in Town", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, 1);

/* M   */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source,
language, scanned, scanned_filename, eps_filenames)
values
("Mademoiselle de Paris", "Henri Contet", "Contet, Henri", "Paul Durand", "Durand, Paul", 
false, 1948, 
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 1940s,}}\\vskip\\sourceskip\\hbox{{\\bf Part Two}, p.~173.}}",
"french", false, "", "");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, 
sort_by_production, year)
values
("Make Believe", "Oscar Hammerstein II", "Hammerstein II, Oscar", "Jerome Kern", "Kern, Jerome", true,  
"Showboat", true, 1927);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, 
source, scanned, scanned_filename)
values
("Makin' Whoopee!", "Gus Kahn", "Kahn, Gus", "Walter Donaldson", "Donaldson, Walter", true, 1928,
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 1920s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 1}, p.~160}}", 
true, "makwhoop.pdf");

update Songs set eps_filenames = "mkwhoop1.eps;mkwhoop2.eps;" where title = "Makin' Whoopee!";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns_with_two_songbooks, year, language)
values
("Mambo {\\#}5", "D{\\'a}maso P{\\'e}rez Prado", "P{\\'e}rez Prado, D{\\'a}maso", true, 1948, "spanish");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes, film, year, 
language, sort_by_production)
values
("Manh{\\~a} da Carnaval", "Ant{\\^o}nio Maria", "Maria, Ant{\\^o}nio",
"Luiz Bonf{\\'a}", "Bonf{\\'a}, Luiz", true, "Score for Andantino completed 23.02.2018.", "Orfeu Negro",
1959, "portugese", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
copyright, musical, source, scanned, scanned_filename, public_domain)
values
("Manhattan", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true,
1925, 
"\\vtop{\\hbox{Copyright {\\copyright} 1925}\\vskip\\copyrightskip\\hbox{by Edward B.~Marks Music Company.}"
"\\vskip\\copyrightskip\\hbox{Copyright Renewed}}",
"Garrick Gaities", 
"\\vbox{\\hbox{{\\bf Rodgers and Hart,}}\\vskip\\sourceskip\\hbox{{\\bf A Musical Anthology}, p.~106.}}",
true, "manhttan.pdf", true);

update Songs set eps_filenames = "manhattan01.eps;manhattan02.eps;" where title = "Manhattan";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production, year)
values
("Many a New Day", "Oscar Hammerstein II", "Hammerstein II, Oscar", "Richard Rodgers", "Rodgers, Richard", true,
"Oklahoma!", true, 1943);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet,
year, source, scanned, scanned_filename, language)
values
("Mas Que Nada", "Jorge Ben", "Ben, Jorge", true, 1963,
"{\\bf The Bossa Nova Songbook}, p.~114 and {\\bf Big Book of Latin American Songs, 2nd Edition}, p.~163.",
true, "masquend.pdf", "portugese");

update Songs set eps_filenames = "masque01.eps;masque02.eps;" where title = "Mas Que Nada";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, partial_lead_sheet, operetta, year, language)
values
("Mein Herr Marquis", "Karl Haffner, Richard Gen{\\'e}e", "Haffner, Karl und Gen{\\'e}e, Richard", 
"Johann Strau{\\ss} (Sohn)", "Strau{\\ss} (Sohn), Johann", true, "Fledermaus, Die", 1874, "german");
 	
/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
scanned, scanned_filename, source, musical)
values
("Memories of You", "Andy Razaf", "Razaf, Andy", "Eubie Blake", "Blake, Eubie",
true, 1930, true, "memrsofy.pdf", 
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 30s }}\\vskip\\sourceskip\\hbox{{\\bf-- Volume 1}, p.~204.}}",
"Blackbirds of 1930");

update Songs set eps_filenames = "memrsof1.eps;memrsof2.eps;" where title = "Memories of You";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, notes)
values
("Message From the Man in the Moon, A", "Gus Kahn", "Kahn, Gus", "Walter Jurmann and Bronislaw Kaper",
"Jurmann, Walter and Kaper, Bronislaw",
true, "Day at the Races, A", "Cut from film.");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, partial_lead_sheet, year)
values
("Mister Sandman", "Pat Ballard", "Ballard, Pat", true, 1954);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Misty", "Johnny Burke", "Burke, Johnny", "Errol Garner", "Garner, Errol", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, musical, source, scanned, scanned_filename, sort_by_production)
values
("Mon Ami, My Friend", "Paul Green", "Green, Paul", "Kurt Weill", "Weill, Kurt", 
true, 1936, "Johnny Johnson", "{\\bf Kurt Weill, From Berlin to Broadway}, p.~52.",
true, "monamimf.pdf", true);

update Songs set eps_filenames = "monamimf1.eps;monamimf2.eps;monamimf3.eps;" where title = "Mon Ami, My Friend";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, year, copyright, film, source)
values
("Moon River", "Johnny Mercer", "Mercer, Johnny", "Henry Mancini", "Mancini, Henry", true,
1961, 
"\\vtop{\\hbox{Copyright {\\copyright} 1961}\\vskip\\copyrightskip"
"\\hbox{(Renewed 1989) by Famous Music Corporation,}\\vskip\\copyrightskip\\hbox{New York, N.Y.}}",
"Breakfast at Tiffany's", 
"{\\bf Too Marvelous For Words.  The Magic of Johnny Mercer}, p.~180.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, 
year, source, scanned, scanned_filename, sort_by_production)
values
("Moon-Faced, Starry-Eyed", "Langston Hughes", "Hughes, Langston", "Kurt Weill", "Weill, Kurt", true,
"Street Scene", 1946, "{\\bf Kurt Weill, Broadway {\\&} Hollywood}, p.~108.", true, "moonfacd.pdf", true);

select * from Songs where musical = "Street Scene"\G

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright)
values
("Moonglow", "Eddie DeLange", "DeLange, Eddie", "Will Hudson and Irving Mills", "Hudson, Will and Mills, Irving", 
true, 1934, "Copyright {\\copyright} 1934 Mills Music");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, source, scanned, scanned_filename, public_domain)
values
("Moonlight Bay", "Edward Madden", "Madden, Edward", "Percy Wenrich", "Wenrich, Percy", true, 1912,
"{\\bf 100 Years of Popular Music, 1900s}", true, "moonltby.pdf", true);

update Songs set eps_filenames = "mnltbay1.eps;mnltbay2.eps;" where title = "Moonlight Bay";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Moonlight Becomes You", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Moonlight Serenade", "Mitchell Parish", "Parish, Mitchell", "Glenn Miller", "Miller, Glenn", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Mr.~Lucky", "Jay Livingston and Ray Evans", "Livingston, Jay and Evans, Ray", 
"Henry Mancini", "Mancini, Henry", true, 1960);

/* words?  */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, 
copyright, source, scanned, scanned_filename)
values
("Music Goes 'Round and Around, The", "Red Hodgson", "Hodgson, Red",
"Edward Farley and Michael Riley", "Farley, Edward and Riley, Michael", true,
1935, "Copyright {\\copyright} 1935 (Renewed).", "{\\bf Big Book of Big Band Hits, The}, p.~175.",
true, "mscgsrnd.pdf");

update Songs set eps_filenames = "mscgsrnd.eps;" where title = "Music Goes 'Round and Around, The";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("My Baby Just Cares for Me", "Gus Kahn", "Kahn, Gus", "Walter Donaldson", "Donaldson, Walter", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, revue, year)
values
("My Blue Heaven", "George A.~Whiting", "Whiting, George A.", "Walter Donaldson", "Donaldson, Walter", true,
"Ziegfeld Follies 1927", 1927);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
musical, year, scanned, scanned_filename)
values
("My Heart Stood Still", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true, 
"Connecticut Yankee, A", 1927, true, "mhrtstst.pdf");

update Songs set eps_filenames = "myheart01.eps;myheart02.eps;" where title = "My Heart Stood Still";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
scanned, scanned_filename, year, public_domain)
values
("My Melancholy Baby", "George A. Norton", "Norton, George A.", "Ernie Burnett", "Burnett, Ernie", 
true, true, "mymelbby.pdf", 1912, true);

update Songs set eps_filenames = "mymlby01.eps;mymlby02.eps;" where title = "My Melancholy Baby";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
scanned, scanned_filename, year, copyright, source, film)
values
("My Old Flame", "Sam Coslow", "Coslow, Sam", "Arthur Johnston", "Johnston, Arthur", 
true, true, "myoldflm.pdf", 1934, "Copyright {\\copyright} 1934 (Renewed 1961) by Famous Music Corporation",
"{\\bf Big Book of Standards}, p.~212.", "Belle of the Nineties");

update Songs set eps_filenames = "myoldfl1.eps;myoldfl2.eps;" where title = "My Old Flame";

/* N   */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("Nancy with the Laughing Face", "Phil Silvers", "Silvers, Phil", "Jimmy van Heusen", "Heusen, Jimmy van", true, 1);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, copyright, source, scanned, scanned_filename)
values
("Nearness of You, The", "Ned Washington", "Washington, Ned", 
"Hoagy Carmichael", "Carmichael, Hoagy", true, 1937, 
"\\vtop{\\hbox{Copyright {\\copyright} 1937, 1940 (Renewed 1964, 1967)}\\vskip\\copyrightskip\\hbox{by Famous Music Corporation}}",
"{\\bf The Hoagy Carmichael Songbook}, p.~84.", true, "nrnsfyou.pdf");

update Songs set eps_filenames = "nearnss1.eps;nearnss2.eps;" where title = "Nearness of You, The";

/* ** *************************************************** */

-- delete from Songs where title like("Nel blu%");

replace into Songs (title, subtitle, words, words_reverse, music, music_reverse, no_page_turns, year, source, language)
values
("Nel blu dipinto di blu", "(Volare)", "Domenico Modugno and Franco Migliacci", "Modugno, Domenico and Migliacci, Franco", 
"Domenico Modugno", "Modugno, Domenico", true, 1958, "Single edition.", "italian");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year, copyright)
values
("Nevertheless (I'm In Love With You)", "Bert Kalmar", "Kalmar, Bert", "Harry Ruby", "Ruby, Harry", true, 1,
1931,
"Copyright {\\copyright} 1931 DeSylva, Brown and Henderson");


/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
film, source, scanned, scanned_filename)
values
("Nice Work If You Can Get It", "Ira Gershwin", "Gershwin, Ira",
"George Gershwin", "Gershwin, George", true, 1937, "Damsel in Distress, A",
"\\vbox{\\hbox{{\\bf Summertime, The Greatest Songs}}\\vskip\\sourceskip\\hbox{{\\bf of George Gershwin}, p.~99.}"
"\\vskip\\sourceskip\\hbox{{\\bf 100 Years of Popular Music, 1930s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 2}, p.~270.}}",
true, "nicework.pdf");

update Songs set eps_filenames = "nicewrk1.eps;nicewrk2.eps;" where title = "Nice Work If You Can Get It";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, copyright, year, source)
values
("Night and Day", "Cole Porter", "Porter, Cole", true,
"Copyright {\\copyright} 1932 Warner Bros.~Inc.~(Renewed)", 1932, "{\\bf The Best of Cole Porter}, p.~120.");

/* ** *************************************************** */

-- delete from Songs where title = "No Strings";

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, film, source)
values
("No Strings (I'm Fancy Free)", "Irving Berlin", "Berlin, Irving", true, 1935, "Top Hat",
"\\vbox{\\hbox{{\\bf Songs of Irving Berlin, The,}}\\vskip\\sourceskip\\hbox{{\\bf Movie Songs}, p.~78.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, scanned, scanned_filename)
values
("Nobody's Sweetheart", "Gus Kahn and Ernest Erdman", "Kahn, Gus and Erdman, Ernest", 
"Billy Meyers and Elmer Schoebel", "Meyers, Billy and Schoebel, Elmer", 
true, true, "nbswthrt.pdf");

update Songs set eps_filenames = "nbdswt01.eps;nbdswt02.eps;nbdswt03.eps;" where title = "Nobody's Sweetheart";

select "!!! N";

/* O   */

/* ** *************************************************** */

select "!!! O";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright,
source, scanned, scanned_filename, language, film, sort_by_production)
values
("O Nosso Amor (Carnival Samba)", "Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true, 1959,
"Copyright {\\copyright} 1959, 1964 (Renewed)",
"{\\bf The Definitive Antonio Carlos Jobim Collection}, p.~121.", true, "onssamor.pdf",
"portugese", "Orfeu Negro", true);

update Songs set eps_filenames = "onssamor1.eps;onssamor2.eps;onssamor3.eps;" where title = "O Nosso Amor (Carnival Samba)";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source)
values
("Oh! You Crazy Moon", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true, 1939,
"Classic Songs of Johnny Burke, Hollywood's Songwriter, p.~59");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
opera, year, scanned, scanned_filename, public_domain, source, sort_by_production, language)
values
("Oiseaux dans les charmille, Les", "Jules Barbier", "Barbier, Jules", "Jacques Offenbach", "Offenbach, Jacques", true,
"Contes d'Hoffmann, Les", 1881, true, "oiseaux.pdf", true,
"{\\bf Hoffmanns Erz@{a}hlungen (Les Contes d'Hoffmann), Klavierauszug}, p.~120.",
true, "french");

update Songs set eps_filenames = "oiseaux1.eps;oiseaux2.eps;oiseaux3.eps;" where title = "Oiseaux dans les charmille, Les";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("On a Clear Day", "Alan Jay Lerner", "Lerner, Alan Jay", "Burton Lane", "Lane, Burton", true);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("On a Slow Boat to China", "Frank Loesser", "Loesser, Frank", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year,
source, scanned, scanned_filename)
values
("On Green Dolphin Street", "Ned Washington", "Washington, Ned", "Bronislau Kaper", "Kaper, Bronislau",
true, "Green Dolphin Street", 1947, 
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music,}}\\vskip\\sourceskip\\hbox{{\\bf 1940s, Part Two}, p.~186.}}",
true, "grndlphn.pdf");

update Songs set eps_filenames = "grndlphn.eps;" where title = "On Green Dolphin Street";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical,
sort_by_production, year)
values
("On the Street Where You Live", "Alan Jay Lerner", "Lerner, Alan Jay",
"Frederick Loewe", "Loewe, Frederick", true,  "My Fair Lady",
true, 1956);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("On the Sunny Side of the Street", "Dorothy Fields", "Fields, Dorothy",
"Jimmy McHugh", "McHugh, Jimmy", true, 1);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse,
lead_sheet, year, copyright, musical, source, scanned, scanned_filename, sort_by_production)
values
("Once in Love with Amy", "Frank Loesser", "Loesser, Frank", true, 1948,
"Copyright {\\copyright} 1948 (Renewed) Frank Music Corp.",
"Where's Charlie?", "Frank Loesser Songbook, The, p.~175", true, "onclvamy.pdf", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, 
year, scanned, scanned_filename, source)
values
("One", "Edward Kleban", "Kleban, Edward", "Marvin Hamlisch", "Hamlisch, Marvin", false, 
"Chorus Line, A", 1975, false, "one.pdf", "{\\bf Marvin Hamlisch Songbook}, p.~14.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Out of Nowhere", "Edward Heyman", "Heyman, Edward", "John W.~Green", "Green, John W.", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year,
copyright, source, notes, scanned, scanned_filename)
values
("Over the Rainbow", "E.Y.~Harburg", "Harburg, E.Y.", "Harold Arlen", "Arlen, Harold", 
true, "Wizard of Oz, The", 1938, "Copyright {\\copyright} 1938, 1939 (Renewed)",
"{\\bf The Harold Arlen Songbook}, p.~112", "Accidentally wrote out lead sheet twice.", true,
"ovrrnbow.pdf");

update Songs set eps_filenames = "ovrrnb01.eps;ovrrnb02.eps;" where title = "Over the Rainbow";

select "!!! End O";

/* P   */

/* ** *************************************************** */

select "!!! P";

delete from Songs where title = "Para Vigo me voy (Say ``Si, Si'')";

select eps_filenames from Songs where title = "Para Vigo me voy (Say ``Si, Si'')";

replace into Songs (title, subtitle, words, words_reverse, music, music_reverse, lead_sheet, year, language)
values
("Para Vigo me voy", "(Say ``Si, Si'')", "Francia Luban", "Luban, Francia", "Ernesto Lecuona", "Lecuona, Ernesto",
true, 1935, "spanish");

#/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, source)
values
("Paris in New York", "Vernon Duke", "Duke, Vernon", true, 1965,
"{\\bf Vernon Duke Songbook, The, Volume 1}, p.~50.");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Parisian Pierrot", "No@{e}l Coward", "Coward, No@{e}l", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source, 
musical, scanned, scanned_filename, sort_by_production)
values
("Party's Over, The", "Betty Comden and Adolf Green", "Comden, Betty and Green, Adolf", "Jule Styne", "Styne, Jule",
true, 1956, "{\\bf The Comden and Green Songbook}, p.~127.", "Bells are Ringing", true, "prtyover.pdf", true);

update Songs set eps_filenames = "prtyovr1.eps;prtyovr2.eps;" where title = "Party's Over, The";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Pennies from Heaven", "Johnny Burke", "Burke, Johnny", "Arthur Johnston", "Johnston, Arthur", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production, year)
values
("People Will Say We're in Love", "Oscar Hammerstein II", "Hammerstein II, Oscar", "Richard Rodgers", "Rodgers, Richard", true, 
"Oklahoma!", true, 1943);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, language)
values
("Perfidia", "Alberto Dom{\\'\\i}nguez Borr{\\'a}s", 
"Dom{\\'\\i}nguez Borr{\\'a}s, Alberto", 
true, 1939, "spanish");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, film, year, source)
values
("Piccolino, The", "Irving Berlin", "Berlin, Irving", true, "Top Hat", 1935,
"\\vbox{\\hbox{{\\bf Songs of Irving Berlin, The,}}\\vskip\\sourceskip\\hbox{{\\bf Movie Songs}, p.~71.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year)
values
("Pick Yourself Up", "Dorothy Fields", "Fields, Dorothy", "Jerome Kern", "Kern, Jerome", true, "Swing Time", 1936);

/* ** *************************************************** */

delete from Songs where title like("Polowetzer%");

replace into Songs (title, subtitle, filecard_title, words_and_music, words_and_music_reverse, lead_sheet, opera,
production_subtitle, scanned, scanned_filename, language, sort_by_production, public_domain)
values
("Polowetzer T@{a}nze", "(``Stranger in Paradise'')",
"\\vbox{\\hbox{Polowetzer T@{a}nze}\\vskip\\titleskip\\hbox{(``Stranger in Paradise'')}}",
"Alexander Borodin", "Borodin, Alexander", 
true, "Prince Igor", "({\\mediumcy kNQZX iGORX})", true, "polowtnz.pdf", "russian", true, true);

update Songs set eps_filenames = "polow01.eps;polow02.eps;polow03.eps;" where title = "Polowetzer T@{a}nze";

delete from Songs where title = "Strangers in Paradise";


replace into Songs (title, is_cross_reference, target, lead_sheet, sort_by_production, production, production_subtitle)
values
("Stranger in Paradise", true, "Polowetzer T@{a}nze", true, true, "Prince Igor", "({\\mediumcy kNQZX iGORX})");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename, language)
values
("Por Una Cabeza", "Alfredo Le Pera", "Le Pera, Alfredo", "Carlos Gardel", "Gardel, Carlos", true, 1935,
"{\\bf Carlos Gardel, Tangos ${\\rm V}^{\\rm o}$ II}, p.~32.", true, "prunacbz.pdf", "spanish");

update Songs set eps_filenames = "prunacbz.eps;" where title = "Por Una Cabeza";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Prelude to a Kiss", "Irving Gordon and Irving Mills", "Gordon, Irving and Mills, Irving", "Duke Ellington", 
"Ellington, Duke", 
true, 1938);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, 
year, scanned, scanned_filename, public_domain)
values
("Pretty A Girl is Like a Melody, A", "Irving Berlin", "Berlin, Irving", 
true, 1919, true, "pretgirl.pdf", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Prisoner of Love", "Leo Robin", "Robin, Leo", "Russ Columbo and Clarence Gaskill", 
"Columbo, Russ and Gaskill, Clarence",
true, 1931);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year)
values
("Put on a Happy Face", "Lee Adams", "Adams, Lee", 
"Charles Strouse", "Strouse, Charles", true, 1, 1960);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns, year, source)
values
("Puttin' On the Ritz", "Irving Berlin", "Berlin, Irving", true, 1929,
"{\\bf Irving Berlin Songs}, p.~22.");

select title, lead_sheet from Songs where words_and_music = "Irving Berlin";

select "!!! End P";

/* Q   */

/* ** *************************************************** */

select "!!! Q";

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns, year, language)
values
("Quiz{\\'a}s, Quiz{\\'a}s, Quiz{\\'a}s", "Osvaldo Farr{\\'e}s", "Farr{\\'e}s, Osvaldo", true, 1947, "spanish");

select "!!! End Q";

/* R   */

select "!!! R";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, source, scanned, scanned_filename)
values
("Rainy Days and Mondays", "Paul Williams", "Williams, Paul", "Roger Nichols", "Nichols, Roger", true,
1970, "{\\bf Carpenters, Greatest Hits}, p.~8.", true, "raindays.pdf");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright, source)
values
("Rainy Night in Rio, A", "Leo Robin", "Robin, Leo", "Arthur Schwartz", "Schwartz, Arthur", true,
1946, "Copyright {\\copyright} 1946 (Renewed) WB Music Corp.",
"{\\bf The Looney Tunes Songbook}, p.~81");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Red Sails in the Sunset", "Jimmy Kennedy", "Kennedy, Jimmy", "Hugh Williams", "Williams, Hugh", true, 1935);

/* ** *************************************************** */

delete from Songs where title like("Rock-a-Bye%");

replace into Songs (title, subtitle, filecard_title, words, words_reverse, music, music_reverse, lead_sheet, 
year, scanned, scanned_filename, public_domain)
values
("Rock-a-Bye Your Baby", "(With a Dixie Melody)",
"\\vbox{\\hbox{Rock-a-Bye Your Baby}\\vskip\\titleskip\\hbox{(With a Dixie Melody)}}",
"Sam M.~Lewis and Joe Young", "Lewis, Sam M.~and Young, Joe", 
"Jean Schwarz", "Schwarz, Jean", true, 1918, true, "rckbybby.pdf", true);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Room With a View, A", "No@{e}l Coward", "Coward, No@{e}l", true);

/* ** *************************************************** */

-- delete from Songs where words_and_music = "Alexander Warlamoff";

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, copyright, source, language)
values
("Rote Sarafan, Der ({\\mediumcy kRASN{\\char'131}{\\char'112} sARAFAN{\\char'137}})",
"Unknown", "Unknown", "Alexander Jegorowitsch Warlamoff", "Warlamoff, Alexander Jegorowitsch",
true, "Public Domain.",
"{\\bf Das Lied der V@{o}lker, Russische Lieder}, p.~26.", "russian");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year,
source, scanned, scanned_filename, eps_filenames)
values
("'Round Midnight", "Cootie Williams and Thelonius Monk", "Williams, Cootie and Monk, Thelonius", 
true, 1944, 
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music 1940s,}}\\vskip\\sourceskip\\hbox{{\\bf Part Two}, p.~213.}}",
false, "", "");

/* ** *************************************************** */

select "!!! End R";

/* S   */

select "!!! S";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
film, year, scanned, scanned_filename, language, sort_by_production)
values
("Samba de Orfeu", "Ant{\\^o}nio Maria", "Maria, Ant{\\^o}nio",
"Luiz Bonf{\\'a}", "Bonf{\\'a}, Luiz", true, "Orfeu Negro", 1959, true, "sambaorf.pdf", "portugese", true);

update Songs set eps_filenames = "samborf1.eps;samborf2.eps;" where title = "Samba de Orfeu";

/* ** *************************************************** */

-- delete from Songs where title = "Samba de uma nota so";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, scanned, scanned_filename, language)
values
("Samba de Uma Nota So", "Newton Mendon{\\c c}a", "Mendon{\\c c}a, Newton", 
"Antonio Carlos Jobim", "Jobim, Antonio Carlos", true, 1961, true, "smbunant.pdf", "portugese");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, language)
values
("Samba do Avi{\\~a}o", "Antonio Carlos Jobim", "Jobim, Antonio Carlos", true, 1962, "portugese");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns,
year, language, source)
values
("Sch@{o}ner Gigolo, armer Gigolo", "Julius Brammer", "Brammer, Julius",
"Leonello Casucci", "Casucci, Leonello", true, 1929, 
"german", "{\\bf Golden Evergreens, Band II}, p.~10.");

/* ** *************************************************** */

select title from Songs where title like("Se Todos%");

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, language, source, year, scanned, 
scanned_filename)
values
("Se Todos Fossem Iguais a Voc{\\^e}", "Vin{\\'\\i}cius de Moraes", "Moraes, Vin{\\'\\i}cius de",  
"Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true, "portugese", "{\\bf Music of Antonio Carlos Jobim, The}, p.~18.",
1958, true, "stdsfiav.pdf");

select music_reverse, title from Songs where music_reverse like("%Jobim%");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year, 
film)
values
("September in the Rain", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, 1, 
1937, "Melody for Two");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, 
year, source, scanned, scanned_filename, sort_by_production)
values
("September Song", "Maxwell Anderson", "Anderson, Maxwell", "Kurt Weill", "Weill, Kurt", 
true, "Knickerbocker Holiday", 1938, "{\\bf Kurt Weill, From Berlin to Broadway}, p.~40.", 
true, "sptmbsng.pdf", true);

update Songs set eps_filenames = "sptmbsn1.eps;sptmbsn2.eps;" where title = "September Song";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, film, source)
values
("Shadow of Your Smile, The", "Paul Francis Webster", "Webster, Paul Francis", 
"Johnny Mandel", "Mandel, Johnny", true, 1965, "Sandpiper, The", "{\\bf Johnny Mandel Songbook, The}, p.~6.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source,
scanned, scanned_filename)
values
("She's Funny That Way", "Richard A.~Whiting", "Whiting, Richard A.", "Neil Moret", "Moret, Neil", 
true, 1928,
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 20s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 1}, p.~222.}}",
true, "shfnttwy.pdf");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename, public_domain, revue)
values
("Shine On Harvest Moon", "Jack Norworth", "Norworth, Jack", "Nora Bayes", "Bayes, Nora", true,
1908, "{\\bf 100 Years of Popular Music, 1900}, p.~328.", true, "shnhrvmn.pdf", true,
"Ziegfeld Follies (1908)");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, production_subtitle, year,
sort_by_production, source)
values
("Shuffle Off to Buffalo", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true,
"42nd Street", "(Film)", 1933, true, "{\\bf 42nd Street, All the Vocal Selections from 42nd Street}, p.~58.");


/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, language)
values
("Siboney", "Ernesto Lecuona", "Lecuona, Ernesto", true, "spanish");

#/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, language)
values
("Siempre en mi Coraz{\\'o}n", "Ernesto Lecuona", "Lecuona, Ernesto", true, "spanish");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source)
values
("Skylark", "Johnny Mercer", "Mercer, Johnny", "Hoagy Carmichael", "Carmichael, Hoagy", true,
1941,
"\\vbox{\\hbox{{\\bf Too Marvelous For Words.}}\\vskip\\sourceskip\\hbox{{\\bf The Magic of Johnny Mercer}, p.~93.}}");

-- "\\vbox{\\hbox{Copyright {\\copyright} 1941, 1942 George Simon, Inc.}"
-- "\\vskip\\copyrightskip\\hbox{Copyrights Renewed (1969, 1970) "
-- "and Assigned to WB Music Corp.~and Frank Music Corp.",

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns, year, source)
values 
("Sleepwalk", "\\vtop{\\hbox{Santo Farina, John Farina}\\vskip\\composerskip\\hbox{and Ann Farina}}",
"Farina, Santo; Farina, John; and Farina, Ann",
true, 1959,
"\\vbox{\\hbox{{\\bf More of the 1950s.}}\\vskip\\sourceskip\\hbox{{\\bf Hal Leonard Essential Songs}, p.~304}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, musical)
values
("Smoke Gets in Your Eyes", "Otto Harbach", "Harbach, Otto", "Jerome Kern", "Kern, Jerome", true, 1933, "Roberta");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Smoke Rings", "Ned Washington", "Washington, Ned", "H.~Eugene Gifford", "Gifford, H.~Eugene ", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year,
source, scanned, scanned_filename, sort_by_production, eps_filenames)
values
("Some Enchanted Evening", "Oscar Hammerstein II", "Hammerstein II, Oscar", "Richard Rodgers", "Rodgers, Richard", true,
"South Pacific", 1949,
"\\vbox{\\hbox{{\\bf Rodgers and Hammerstein Collection,}}\\vskip\\sourceskip\\hbox{{\\bf The}, p.~325.}}",
true, "smenevng.pdf", true, "smenevng1.eps;smenevng2.eps;");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, scanned, scanned_filename, public_domain)
values
("Somebody Loves Me", "Ballard MacDonald and Buddy DeSylva", 
"MacDonald, Ballard and DeSylva, Buddy", 
"George Gershwin", "Gershwin, George",
true, 1924, true, "smblvsme.pdf", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Someone to Watch Over Me", "Ira Gershwin", "Gershwin, Ira", "George Gershwin", "Gershwin, George", true, 1926);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year)
values
("Somethin' Stupid", "C.~Carson Parks", "Parks, C.~Carson", true, 1966);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
musical, sort_by_production, source, scanned, scanned_filename, eps_filenames)
values
("Something's Coming", "Stephen Sondheim", "Sondheim, Stephen", "Leonard Bernstein", "Bernstein, Leonard",
false, 1957, "West Side Story", true,
"\\vbox{\\hbox{{\\bf West Side Story.  Die bekanntesten}}\\vskip\\sourceskip\\hbox{{\\bf Melodien}, p.~26.}}",
false, "", "");

-- https://en.wikipedia.org/wiki/West_Side_Story

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, language, year, source, scanned,
scanned_filename)
values
("So{\\~n}e que me dejabas", "Ernesto Lecuona", "Lecuona, Ernesto", true, "spanish", 1936,
"{\\bf Songs of Ernesto Lecuona}, p.~98.", true, "snqmdjbs.pdf");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Sophisticated Lady", "Mitchell Parish and Irving Mills",
"Parish, Mitchell and Mills, Irving", 
"Duke Ellington", "Ellington, Duke",
true, 1933);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("South of the Border", "Jimmy Kennedy", "Kennedy, Jimmy", "Michael Carr", "Carr, Michael", true, 1939);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, notes, year)
values
("Spanish Eyes (Moon Over Naples)", "Charles Singleton/Eddie Snyder", "Singleton, Charles/Snyder, Eddie", 
"Bert Kaempfert", "Kaempfert, Bert", true, "Source: Best of Bert Kaempfert", 1964);

/* delete from Songs where title = ""Spanish Eyes (Moon Over Naples";  */

/* select title from Songs\G  */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year)
values
("Speak Low", "Ogden Nash", "Nash, Ogden", "Kurt Weill", "Weill, Kurt", true, "One Touch of Venus", 1943);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, recordings, film, year)
values
("Speak Softly, Love", "Larry Kusik", "Kusik, Larry", "Nino Rota", "Rota, Nino", 1, "Godfather, The", 1972);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, partial_lead_sheet, year)
values
("Stand By Your Man", "Tammy Wynette and Billy Sherrill",
"Wynette, Tammy and Sherrill, Billy", true, 1968);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical, year, sort_by_production)
values
("Standing on the Corner", "Frank Loesser", "Loesser, Frank", true, "Most Happy Fella, The", 1956, true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, 
scanned, scanned_filename, eps_filenames)
values
("Stardust", "Mitchell Parish", "Parish, Mitchell", "Hoagy Carmichael", "Carmichael, Hoagy", true,
1928, true, "stardust.pdf", "stardust1.eps;stardust2.eps;stardust3.eps;stardust4.eps;stardust5.eps;");

/* recording?  */

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, notes)
values
("Stars Fell on Alabama", "Mitchell Parish", "Parish, Mitchell", "Frank Perkins", "Perkins, Frank", 
true, 1934, "Banjo chord melody");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source)
values
("Stella By Starlight", "Ned Washington", "Washington, Ned", "Victor Young", "Young, Victor",
true, 1946, 
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music 1940s,}}\\vskip\\sourceskip\\hbox{{\\bf Part Two}, p.~235.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, notes, year)
values
("Strangers in the Night", "Charles Singleton/Eddie Snyder", "Singleton, Charles/Snyder, Eddie",
"Bert Kaempfert", "Kaempfert, Bert", true, "Source: Best of Bert Kaempfert", 1965);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year)
values
("Sure Thing", "Ira Gershwin", "Gershwin, Ira", "Jerome Kern", "Kern, Jerome", true, "Cover Girl", 1944);

/* ** *************************************************** */

-- select * from Songs where title = "Swinging On A Star"\G

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film,
year, source, scanned, scanned_filename)
values
("Swinging On A Star", "Johnny Burke", "Burke, Johnny",
"Jimmy van Heusen", "Heusen, Jimmy van", true, "Going My Way",
1944, "\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 1940s, Volume 2}, p.~252.}\\vskip\\sourceskip"
"\\hbox{{\\bf Classic Songs of Johnny Burke, Hollywood's Songwriter}, p.~102.}}",
true, "swngstar.pdf");

/* ** *************************************************** */

select "!!! End S";

/* T   */

select "!!! T";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
musical, year, scanned, scanned_filename, eps_filenames)
values
("Taking a Chance on Love", "John La Touche and Ted Fetter", "La Touche, John and Fetter, Ted",
"Vernon Duke", "Duke, Vernon", true,
"Cabin in the Sky", 1940, true, "takechnc.pdf", "takechnc1.eps;takechnc2.ps;");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, year, film)
values
("Tammy", "Ray Evans", "Evans, Ray", "Jay Livingston", "Livingston, Jay", true, 
1957, "Tammy and the Bachelor");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright)
values
("Tangerine", "Johnny Mercer", "Mercer, Johnny", "Victor Schertzinger", "Schertzinger, Victor", true,
1942, "Copyright {\\copyright} 1942 Famous Music Corp., USA");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, 
lead_sheet, scanned, scanned_filename)
values
("Tea for Two", "Irving Caesar", "Caesar, Irving", "Vincent Youmans", "Youmans, Vincent", 
true, true, "teafrtwo.pdf");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename, film)
values
("Temptation", "Arthur Freed", "Freed, Arthur",
"Nacio Herb Brown", "Brown, Nacio Herb", true, 1933,
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 30s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 1}, p.~272.}}", 
true, "temptatn.pdf", "Going Hollywood");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, musical, source)
values
("Ten Cents a Dance", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true, 1930,
"Simple Simon", 
"\\vbox{\\hbox{{\\bf Rodgers and Hart,}}\\vskip\\sourceskip\\hbox{{\\bf A Musical Anthology}, p.~255.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns,
year, source)
values
("Tenderly", "Jack Lawrence", "Lawrence, Jack", "Walter Gross", "Gross, Walter", 
true, 1946, 
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music 1940s,}}\\vskip\\sourceskip\\hbox{{\\bf Vol. 1}, p.~212.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
film, year)
values
("Thanks for the Memory", "Leo Robin", "Robin, Leo", "Ralph Rainger", "Rainger, Ralph", true,
"Big Broadcast of 1938, The", 1938);

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year, 
copyright, scanned, scanned_filename, eps_filenames)
values
("That Old Feeling", "Lew Brown", "Brown, Lew", "Sammy Fain", "Fain, Sammy", true,
"Vogues of 1938", 1937, "Copyright {\\copyright} 1937, Renewed 1965.", 
true, "ttldflng.pdf", "ttldflng1.eps;ttldflng2.eps;");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical, sort_by_production,
year, source)
values
("There's No Business Like Show Business", "Irving Berlin", "Berlin, Irving", true, "Annie Get Your Gun", true,
1946,
"\\vbox{\\hbox{{\\bf Songs of Irving Berlin, The.}}\\vskip\\sourceskip\\hbox{{\\bf Broadway Songs}, p.~102.}}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("These Foolish Things", "Holt Marvell (Eric Maschwitz)", 
"Marvell, Holt (Maschwitz, Eric)", 
"Jack Strachey", "Strachey, Jack", true, 1935);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production, year)
values
("They Call the Wind Maria", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, "Paint Your Wagon",
true, 1951);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
film, sort_by_production, source, scanned, scanned_filename)
values
("They Can't Take That Away From Me", "Ira Gershwin", "Gershwin, Ira",
"George Gershwin", "Gershwin, George", true, 1937, "Shall We Dance", false,
"\\vbox{\\hbox{{\\bf Summertime, The Greatest Songs}}\\vskip\\sourceskip\\hbox{{\\bf of George Gershwin}, p.~127.}}", 
true, "theycant.pdf");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical, sort_by_production,
year, source)
values
("They Say it's Wonderful", "Irving Berlin", "Berlin, Irving", true, "Annie Get Your Gun", true,
1946, "{\\bf Songs of Irving Berlin, The, Ballads}, p.~86.");

select scanned from Songs where title = "They Say it's Wonderful";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename)
values
("Things We Did Last Summer, The", "Sammy Cahn", "Cahn, Sammy", "Jule Styne", "Styne, Jule",
true, 1946, "{\\bf New Sammy Cahn Songbook, The}, p.~80.", true, "thngswdd.pdf");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes)
values
("This Can't be Love", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true,
"\\hbox{}\\hbox{\\hskip-\\noteswd Verse incomplete on lead sheet and score.\\hss}");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, 
lead_sheet, year, musical, source, scanned, scanned_filename)
values
("Thou Swell", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true, 1927,
"Connecticut Yankee, A", 
"\\vbox{\\hbox{{\\bf Rodgers and Hart,}}\\vskip\\sourceskip\\hbox{{\\bf A Musical Anthology}, p.~82}}",
true, "thouswll.pdf");

/* ** *************************************************** */

delete from Songs where title like("Ti Guarder%");

replace into Songs (title, subtitle, words, words_reverse, music, music_reverse, lead_sheet, 
year, film, source, scanned, scanned_filename, language, eps_filenames)
values
("Ti Guarder{\\`e}ro Nel Cuore", "(More)", "Marcello Ciorciolini", "Ciorciolini, Marcello",
"Nino Oliviero and Riz Ortolani", "Oliviero, Nino and Ortolani, Riz", true, 1962, 
"Mondo Cane", "\\vbox{\\hbox{{\\bf The Big Book of '50s {\\&} '60s}}\\vskip\\sourceskip\\hbox{{\\bf Swinging Songs}, p.~136.}}", 
true, "tgrdnlcr.pdf", "italian", "tgrdnlc1.eps;tgrdnlc2.eps;");

replace into Songs (title, is_cross_reference, target, lead_sheet)
values
("More", true, "Ti Guarder{\\`e}ro Nel Cuore (More)", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
scanned, scanned_filename, public_domain, language)
values
("Tico Tico no Fuba", "Aloysio de Oliveira", "Oliveira, Aloysio de",
"Zequinha de Abreu", "Abreu, Zequinha de", true, 1917, true, "ticotico.pdf", true, "portugese");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Tiptoe Through the Tulips With Me", "Al Dubin", "Dubin, Al", "Joe Burke", "Burke, Joe", true, 1929);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename, language)
values
("Tomo y Obligo", "Manuel Romero", "Romero, Manuel", "Carlos Gardel", "Gardel, Carlos", true, 1931,
"{\\bf Carlos Gardel, Tangos ${\\rm V}^{\\rm o}$ I}, p.~17.", true, "tomyoblg.pdf", "spanish");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical,
year, source, scanned, scanned_filename, public_domain)
values
("Toot Toot Tootsie, Goo'bye", "Gus Kahn, Ernie Erdman, Dan Russo and Ted Fiorito",
"\\vbox{\\hbox{Kahn, Gus; Erdman, Ernie;}\\vskip\\composerskip\\hbox{Russo, Dan and Fiorito, Ted}}", 
true, "Bombo", 
1922, "\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 20s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 2}, p.~281.}}",
true, "toottoot.pdf", true);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, film,
year, source, scanned, scanned_filename, sort_by_production)
values
("Top Hat, White Tie and Tails", "Irving Berlin", "Berlin, Irving", true, "Top Hat", 
1935,
"\\vbox{\\hbox{{\\bf Songs of Irving Berlin, The,}}\\vskip\\sourceskip\\hbox{{\\bf Movie Songs}, p.~102.}}",
true, "tphtwttl.pdf", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source)
values
("Top of the World", "John Bettis", "Bettis, John", "Richard Carpenter", "Carpenter, Richard", true,
1972, "{\\bf Carpenters, Greatest Hits}, p.~38.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, copyright, film, source, scanned, scanned_filename)
values
("Two Sleepy People", "Frank Loesser", "Loesser, Frank", 
"Hoagy Carmichael", "Carmichael, Hoagy", true, 1938, 
"Copyright {\\copyright} 1938 (Renewed 1965) by Famous Music Corporation",
"Thanks for the Memory", "{\\bf The Hoagy Carmichael Songbook}, p.~240.", true, "twosleep.pdf");

/* ** *************************************************** */

select "!!! End T";

/*  U  */

select "!!! U";

/* ** *************************************************** */

replace into Songs (title, no_page_turns, language)
values
("{\\'U}ltima Noche, La", true, "spanish");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns, year)
values
("Unforgettable", "Irving Gordon", "Gordon, Irving", true, 1951);

select "!!! End U";

/* ** *************************************************** */

/*  V  */

select "!!! V";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year,
source, scanned, scanned_filename)
values
("Very Thought of You, The", "Ray Noble", "Noble, Ray", true, 1934,
"\\vbox{\\hbox{{\\bf 100 Years of Popular Music,}}\\vskip\\sourceskip\\hbox{{\\bf 1930s, Part Two}, p.~327.}}", 
true, "vrythght.pdf");

/* ** *************************************************** */

select title from Songs where music = "Carlos Gardel";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename, language)
values
("Volver", "Alfredo Le Pera", "Le Pera, Alfredo", "Carlos Gardel", "Gardel, Carlos", true, 1934,
"{\\bf Carlos Gardel, Tangos ${\\rm V}^{\\rm o}$ I}, p.~29.", true, "volver.pdf", "spanish");

select "!!! End V";

/*  W  */

select "!!! W";

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright,
source, scanned, scanned_filename)
values
("Wave", "Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true, 1967,
"Copyright {\\copyright} 1967, 1968 (Renewed)",
"{\\bf The Definitive Antonio Carlos Jobim Collection}, p.~206.", true, "wave.pdf");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("Way You Look Tonight, The", "Dorothy Fields", "Fields, Dorothy", "Jerome Kern", "Kern, Jerome", true,
"Swing Time");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year)
values
("Wedding of the Painted Doll, The", "Arthur Freed", "Freed, Arthur", "Nacio Herb Brown", "Brown, Nacio Herb", true,
"Broadway Melody, The", 1929);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, 
source, scanned, scanned_filename)
values
("We've Only Just Begun", "Paul Williams", "Williams, Paul", "Roger Nichols", "Nichols, Roger", true,
1970, "{\\bf Carpenters, Greatest Hits}, p.~5.", true, "weveonly.pdf");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, source,
scanned, scanned_filename)
values
("What a Wonderful World", "\\vtop{\\hbox{George David Weiss}\\vskip\\composerskip\\hbox{and Bob Thiele}}",
"Weiss, George David and Thiele, Bob", 
true, 1967, "{\\bf 150 of the Most Beautiful Songs Ever}, p.~504.", true, "whtwndfl.pdf");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical,
year, source, scanned, scanned_filename, sort_by_production)
values
("What Good Would the Moon Be?", "Langston Hughes", "Hughes, Langston", "Kurt Weill", "Weill, Kurt",
true, "Street Scene", 1946, "{\\bf Kurt Weill, From Berlin to Broadway}, p.~79.", true, "whatgood.pdf", true);

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical,
year, source, scanned, scanned_filename, sort_by_production)
values
("What Kind of Fool Am I?",
"\\vtop{\\hbox{Leslie Bricusse and}\\vskip\\titleskip\\hbox{Anthony Newley}}",
"Bricusse, Leslie and Newley, Anthony", 
true, "Stop the World---I Want to Get Off", 1961, "{\\bf 150 of the Most Beautiful Songs Ever}, p.~508.",
true, "whatkind.pdf", true);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film,
year, source, scanned, scanned_filename)
values
("When I Fall in Love", "Edward Heyman", "Heyman, Edward", "Victor Young", "Young, Victor",
true, "One Minute to Zero", 1952, 
"{\\bf Nat ``King'' Cole, Unforgettable.  Legendary Performers -- Volume 9}, p.~9.", 
true, "whenlove.pdf");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year,
source, scanned, scanned_filename)
values
("When You're Smiling", "\\vtop{\\hbox{Mark Fisher, Joe Goodwin}\\vskip\\composerskip\\hbox{and Larry Shay}}", 
"Fisher, Mark; Goodwin, Joe and Shay, Larry", 
true, 1928, "\\vbox{\\hbox{{\\bf 100 Years of Popular Music, 1920s,}}\\vskip\\sourceskip\\hbox{{\\bf Volume 2}, p.~299.}}", 
true, "whensmil.pdf");

/* ** *************************************************** */

replace into Songs (title, filecard_title, words, words_reverse, music, music_reverse, partial_lead_sheet,
year, source)
values
("Where Do I Begin? (Theme from Love Story)", 
"\\vbox{\\hbox{Where Do I Begin?}\\vskip\\titleskip\\hbox{(Theme from Love Story)}}", 
"Carl Sigman", "Sigman, Carl", "Francis Lai", "Lai, Francis",
true, 1970, "Single edition.");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet,
musical, sort_by_production, year, copyright, source, scanned, scanned_filename)
values
("Who Will Buy?", "Lionel Bart", "Bart, Lionel", true,
"Oliver!", true, 1959, 
"\\vtop{\\hbox{Copyright {\\copyright} 1959 by}"
"\\vskip\\copyrightskip\\hbox{Lakeview Music Publishing Company Limited.}}",
"{\\bf Lionel Bart's Oliver, Vocal Selections}, p.~97.", true, "whwllbuy.pdf");

update Songs set eps_filenames = "whwllbuy.eps;" where title = "Who Will Buy?";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year,
scanned, scanned_filename, source)
values
("Why Was I Born?", "Oscar Hammerstein II", "Hammerstein II, Oscar",
"Jerome Kern", "Kern, Jerome", true, "Sweet Adeline", 1929, true, "whwsibrn.pdf",
"{\\bf Jerome Kern Collection}, p.~97.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
year, copyright, source, scanned, scanned_filename, language)
values
("Wie lange noch?", "Walter Mehring", "Mehring, Walter", "Kurt Weill", "Weill, Kurt", 
true, 1944, "Copyright {\\copyright} 1981.", "{\\bf Unknown Kurt Weill, The}, p.~23.",
true, "wlngnoch.pdf", "german");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, year,
source, musical)
values
("Willkommen", "Fred Ebb", "Ebb, Fred", "John Kander", "Kander, John", true, 1966,
"{\\bf Vocal Selections from Cabaret}, p.~2.", "Cabaret");

/* ** (2) *************************************************** */

/* Winterreise, Die.  Franz Schubert and Wilhelm Müller.

/* *** (3) *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, song_cycle,
sort_by_production, source, scanned, scanned_filename, language, public_domain)
values
("Gute Nacht", "Wilhelm M@{u}ller", "M@{u}ller, Wilhelm",  
"Franz Schubert", "Schubert, Franz", true, 1827,
"Winterreise, Die", true,
"\\vbox{\\hbox{{\\bf Schubert.  Lieder Band 3, Hohe Stimme}}\\vskip\\sourceskip\\hbox{B@{a}renreiter Urtext, p.~78.}}",
false, "gutencht.pdf", "german", true);

/* *** (3) *************************************************** */

/* ** (2) *************************************************** */

/* ** *************************************************** */

select * from Songs where title = "Bewitched"\G

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet,
year, film, production_subtitle, source, notes, scanned, scanned_filename, sort_by_production)
values
("Woman in Love, A", "Frank Loesser", "Loesser, Frank", true, 1955,
"Guys and Dolls", "(Film)", "Guys and Dolls, Vocal Selections, p.~2.",
"In the 1955 film, not in the original Broadway production.", true, "womninlv.pdf", true);

update Songs set eps_filenames = "womninlv1.eps;womninlv2.eps;" where title = "Woman in Love, A";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, musical, sort_by_production, year)
values
("Wouldn't It Be Loverly?", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, 
"My Fair Lady", true, 1956);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Wrap Your Troubles in Dreams", "Ted Koehler and Billy Moll", "Koehler, Ted and Moll, Billy",
"Harry Barris", "Barris, Harry", true, 1931);

select "!!! End W";

/*  X  */

select "!!! X";

select "!!! End X";

/*  Y  */

select "!!! Y";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year,
source, scanned, scanned_filename)
values
("Yacht Club Swing", "J.C.~Johnson", "Johnson, J.C.",
"Thomas ``Fats'' Waller and Herman Autrey", "Waller, Thomas ``Fats'' and Autrey, Herman",
true, 1938, "{\\bf Ain't Misbehavin', Vocal Selections}, p.~54.", true, "ychtclub.pdf");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright)
values
("You Go to My Head", "Haven Gillespie", "Gillespie, Haven", "J.~Fred Coots", "Coots, J.~Fred", true,
1938, "Copyright {\\copyright} 1938 Remick Music");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
film, production_subtitle, year, sort_by_production, source)
values
("Young and Healthy", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, 
"42nd Street", "(Film)", 1933, true, 
"{\\bf 42nd Street, All the Vocal Selections from 42nd Street}, p.~16.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
film, production_subtitle, year, sort_by_production, source)
values
("You're Getting to Be a Habit With Me", "Al Dubin", "Dubin, Al",
"Harry Warren", "Warren, Harry", true,
"42nd Street", "(Film)", 1933, true,
"{\\bf 42nd Street, All the Vocal Selections from 42nd Street}, p.~24.");

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
scanned, scanned_filename, public_domain, source, year)
values
("You Made Me Love You", "Joe McCarthy", "McCarthy, Joe", "James Monaco", "Monaco, James",
true, true, "youmadem.pdf", true, "{\\bf 100 Years of Popular Music, 1900}, p.~405.", 1913);

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse,
lead_sheet, arrangement_solo_guitar, year, musical, source, scanned, scanned_filename)
values
("You Took Advantage of Me", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard",
true, true, 1928, "Present Arms",
"\\vbox{\\hbox{{\\bf Rodgers and Hart,}}\\vskip\\sourceskip\\hbox{{\\bf A Musical Anthology}, p.~248.}}",
true, "ytkadvnt.pdf");

/* ** *************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year,
scanned, scanned_filename, source)
values
("You're Nobody 'Til Somebody Loves You",
"\\vtop{\\hbox{Russ Morgan, Larry Stock}\\vskip\\composerskip\\hbox{and James Cavanaugh}}",
"\\vbox{\\hbox{Morgan, Russ; Stock, Larry}\\vskip\\composerskip\\hbox{and Cavanaugh, James}}", 
true, 1944, true, "yrnbdytl.pdf",
"\\vbox{\\hbox{{\\bf The Big Book of '50s {\\&} '60s}}\\vskip\\sourceskip\\hbox{{\\bf Swinging Songs}, p.~241.}}");

select * from Songs where title = "You're Nobody 'Til Somebody Loves You"\G

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes, year, film, source)
values
("You've Got That Look", "Friedrich Hollaender", "Hollaender, Friedrich", 
"Frank Loesser", "Loesser, Frank", true, "Too low.  Must transpose!", 1939, "Destry Rides Again",
"{\\bf Marlene Dietrich Sings Friedrich Hollaender}, p.~46.");

/* mark_blue  */
/* words: Frank Loesser (Check!)  */

select "!!! End Y";

/*  Z  */

select "!!! Z";

/* ** *************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, operetta, year, language)
values
("Zwei M@{a}rchenaugen", "Julius Brammer und Alfred Gr@{u}nwald", "Brammer, Julius und Gr@{u}nwald, Alfred",
"Emmerich K{\\'a}lm{\\'a}n", "K{\\'a}lm{\\'a}n, Emmerich", true, "Zirkusprinzessin, Die", 1926, "german");

/* Copyright 1951  */

select "!!! End Z";

/* * (1) *************************************************** */

/* Select  */

select * from Songs order by title asc\G

select music_reverse, words_and_music_reverse, title, words from Songs 
where music_reverse is not null or words_and_music_reverse is not null
order by music_reverse, words_and_music_reverse, title\G

select words_and_music_reverse, title from Songs 
where words_and_music_reverse = "Porter, Cole"
order by title\G

select distinct music_reverse, words_and_music_reverse from Songs
where music_reverse is not null or words_and_music_reverse is not null
order by music_reverse, words_and_music_reverse\G

select title, words, words_reverse, music, music_reverse, words_and_music, words_and_music_reverse, lead_sheet, 
partial_lead_sheet, no_page_turns, 
no_page_turns_with_two_songbooks, arrangement_orchestra, 
arrangement_solo_guitar, recordings, opera, musical, revue, 
film, sort_by_production, year, copyright from Songs order by title asc\G

or opera is not null or operetta is not null or revue is not null
or film is not null) and sort_by_production is true
order by title asc\G

select title, musical, opera, operetta, revue, film, sort_by_production
from Songs\G

select title from Songs where title = "Camelot";

select title from Songs where title = "Stardust";

 or opera not null or operetta not null or film not null

select distinct words, words_reverse, music, music_reverse, words_and_music 
from Songs 
where words is not null or music is not null or words_and_music is not null
order by
words, words_reverse, music, music_reverse, words_and_music\G

select * from Songs where words is null and music is null and words_and_music is null\G

select title from Songs where words = "Langston Hughes"\G

select title from Songs where words_and_music = "Irving Berlin"\G

select title, words_reverse, music_reverse, words_and_music_reverse
from Songs where words_reverse is not null or music_reverse is not null or words_and_music_reverse is not null
order by words_reverse, music_reverse, words_and_music_reverse\G

/* * (1)  */

replace	into Composers_Songs (composer, title) values ("Abreu, Zequinha de", "Tico Tico no Fuba");

replace	into Composers_Songs (composer, title) values ("Ager, Milton", "Ain't She Sweet");

replace into Composers_Songs (composer, title) values ("Ahlert, Fred E.", "I Don't Know Why (I Just Do)");

replace into Composers_Songs (composer, title) values ("Ahlert, Fred E.", "I'm Gonna Sit Right Down and Write Myself a Letter");

replace into Composers_Songs (composer, title) values ("Akst, Harry", "Baby Face");

replace into Composers_Songs (composer, title) values ("Allen, Robert", "It's Not For Me to Say");

replace into Composers_Songs (composer, title) values ("Allen, Robert", "Chances Are");

replace into Composers_Songs (composer, title) values ("Andre, Fabian", "Dream a Little Dream of Me");

replace into Composers_Songs (composer, title) values ("Schwandt, Wilbur", "Dream a Little Dream of Me");

replace into Composers_Songs (composer, title) values ("Arlen, Harold", "Between the Devil and the Deep Blue Sea");

replace into Composers_Songs (composer, title) values ("Arlen, Harold", "Let's Fall in Love");

replace into Composers_Songs (composer, title) values ("Arlen, Harold", "I've Got the World on a String");

replace into Composers_Songs (composer, title) values ("Arlen, Harold", "Over the Rainbow");

replace into Composers_Songs (composer, title) values ("Waller, Thomas ``Fats''", "Yacht Club Swing");

replace into Composers_Songs (composer, title) values ("Autrey, Herman", "Yacht Club Swing");

replace into Composers_Songs (composer, title) values ("Bacharach, Burt", "I'll Never Fall in Love Again");

replace into Composers_Songs (composer, title) values ("Bacharach, Burt", "I Say a Little Prayer");

replace into Composers_Songs (composer, title) values ("Bacharach, Burt", "Do You Know the Way to San Jose?");

replace into Composers_Songs (composer, title) values ("Bacharach, Burt", "Close to You");

replace into Composers_Songs (composer, title) values ("Barris, Harry", "Wrap Your Troubles in Dreams");

replace into Composers_Songs (composer, title) values ("Bernstein, Leonard", "I Can Cook Too");

replace into Composers_Songs (composer, title) values ("Bernstein, Leonard", "I Feel Pretty");

replace into Composers_Songs (composer, title) values ("Bernstein, Leonard", "Something's Coming");

replace into Composers_Songs (composer, title) values ("Bizet, Georges", "Au fond du temple saint");

replace into Composers_Songs (composer, title) values ("Blake, Eubie", "I'm Just Wild About Harry");

replace into Composers_Songs (composer, title) values ("Blake, Eubie", "Memories of You");

replace into Composers_Songs (composer, title) values ("Bloom, Rube", "Fools Rush In (Where Angels Fear to Tread)");

replace into Composers_Songs (composer, title) values ("Bochmann, Werner", "Abends in der Taverna");

replace into Composers_Songs (composer, title) values ("Bock, Jerry", "(I'll Marry) The Very Next Man");

replace into Composers_Songs (composer, title) values ("Bock, Jerry", "Little Tin Box");

replace into Composers_Songs (composer, title) values ("Bonf{\\'a}, Luiz", "Manh{\\~a} da Carnaval");

replace into Composers_Songs (composer, title) values ("Bonf{\\'a}, Luiz", "Samba de Orfeu");

replace into Composers_Songs (composer, title) values ("Brown, Nacio Herb", "All I Do Is Dream Of You");

replace into Composers_Songs (composer, title) values ("Brown, Nacio Herb", "Temptation");

-- delete from Composers_Songs where title = "Wedding of the Painted Doll, The";

replace into Composers_Songs (composer, title) values ("Brown, Nacio Herb", "Wedding of the Painted Doll, The");

replace into Composers_Songs (composer, title) values ("Burke, Joe", "Tiptoe Through the Tulips With Me");

replace into Composers_Songs (composer, title) values ("Burnett, Ernie", "My Melancholy Baby");

replace into Composers_Songs (composer, title) values ("Weber, Carl Maria von", "Durch die W@{a}lder, durch die Auen");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Heart and Soul");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Georgia on my Mind");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Nearness of You, The");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Skylark");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Stardust");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Two Sleepy People");

replace into Composers_Songs (composer, title) values ("Carpenter, Richard", "Top of the World");

replace into Composers_Songs (composer, title) values ("Carr, Michael", "South of the Border");

replace into Composers_Songs (composer, title) values ("Casucci, Leonello", "Sch@{o}ner Gigolo, armer Gigolo");

replace into Composers_Songs (composer, title) values ("Columbo, Russ", "Prisoner of Love");

replace into Composers_Songs (composer, title) values ("Gaskill, Clarence", "Prisoner of Love");

replace into Composers_Songs (composer, title) values ("Conrad, Con", "Continental, The");

replace into Composers_Songs (composer, title) values ("Coots, J.~Fred", "You Go to My Head");

replace into Composers_Songs (composer, title) values ("Coots, J.~Fred", "Love Letters in the Sand");

replace into Composers_Songs (composer, title) values ("Dale, Jim", "Georgy  Girl");

replace into Composers_Songs (composer, title) values ("DeRose, Peter", "Deep Purple");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "Carolina in the Morning");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "Little White Lies");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "Love Me or Leave Me");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "Makin' Whoopee!");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "My Baby Just Cares for Me");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "My Blue Heaven");

-- select * from Composers_Songs where composer = "Donaldson, Walter";

replace into Composers_Songs (composer, title) values ("Donizetti, Gaetano", "Furtiva lagrima, Una");

replace into Composers_Songs (composer, title) values ("Duke, Vernon", "I Can't Get Started");

replace into Composers_Songs (composer, title) values ("Duke, Vernon", "I Like the Likes of You");

replace into Composers_Songs (composer, title) values ("Duke, Vernon", "Just Like a Man");

replace into Composers_Songs (composer, title) values ("Duke, Vernon", "Taking a Chance on Love");

replace into Composers_Songs (composer, title) values ("Durand, Paul", "Mademoiselle de Paris");

replace into Composers_Songs (composer, title) values ("Edwards, Gus", "By The Light Of The Silvery Moon");

replace into Composers_Songs (composer, title) values ("Ellington, Duke", "Prelude to a Kiss");

replace into Composers_Songs (composer, title) values ("Ellington, Duke", "Sophisticated Lady");

replace into Composers_Songs (composer, title) values ("Ellington, Duke", "In a Sentimental Mood");

replace into Composers_Songs (composer, title) values ("Ellington, Duke", "Caravan");

replace into Composers_Songs (composer, title) values ("Tizol, Juan", "Caravan");

replace into Composers_Songs (composer, title) values ("Evans, Tolchard", "Lady of Spain");

replace into Composers_Songs (composer, title) values ("Fain, Sammy", "I Can Dream, Can't I?");

replace into Composers_Songs (composer, title) values ("Fain, Sammy", "I'll Be Seeing You");

replace into Composers_Songs (composer, title) values ("Fain, Sammy", "That Old Feeling");

replace into Composers_Songs (composer, title) values ("Fain, Sammy", "By a Waterfall");

replace into Composers_Songs (composer, title) values ("Farley, Edward", "Music Goes 'Round and Around, The");
replace into Composers_Songs (composer, title) values ("Riley, Michael", "Music Goes 'Round and Around, The");

replace into Composers_Songs (composer, title) values ("Gade, Jacob", "Jalousie ``Tango Tzigane'' (Jealousy)");

-- select * from Composers_Songs where composer = "Gardel, Carlos";

replace into Composers_Songs (composer, title) values ("Gardel, Carlos", "Por Una Cabeza");

replace into Composers_Songs (composer, title) values ("Gardel, Carlos", "Tomo y Obligo");

replace into Composers_Songs (composer, title) values ("Gardel, Carlos", "Volver");

replace into Composers_Songs (composer, title) values ("Garner, Errol", "Misty");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Embraceable You");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "I Got Plenty o' Nuttin'");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Let's Call the Whole Thing Off");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Liza (All the Clouds'll Roll Away)");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Nice Work If You Can Get It");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Somebody Loves Me");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Someone to Watch Over Me");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "They Can't Take That Away From Me");

replace into Composers_Songs (composer, title) values ("Gifford, H.~Eugene", "Smoke Rings");

replace into Composers_Songs (composer, title) values ("Giraud, Hubert", "Buenas Noches mi Amor");

replace into Composers_Songs (composer, title) values ("Green, John W.", "I Cover the Waterfront");

replace into Composers_Songs (composer, title) values ("Green, John W.", "Body and Soul");

replace into Composers_Songs (composer, title) values ("Green, John W.", "Out of Nowhere");

replace into Composers_Songs (composer, title) values ("Green, John W.", "Coquette");

replace into Composers_Songs (composer, title) values ("Lombardo, Carmen", "Coquette");

replace into Composers_Songs (composer, title) values ("Gross, Walter", "Tenderly");

replace into Composers_Songs (composer, title) values ("Grothe, Franz", "Ja und Nein");

replace into Composers_Songs (composer, title) values ("Hamlisch, Marvin", "One");

replace into Composers_Songs (composer, title) values 
("Five Foot Two, Eyes Of Blue\\par\\S (Has Anybody Seen My Girl?)",
"Henderson, Ray");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Here's That Rainy Day");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Moonlight Becomes You");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Nancy with the Laughing Face");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "It Could Happen to You");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Imagination");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Oh! You Crazy Moon");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Swinging On A Star");

replace into Composers_Songs (composer, title) values ("Hoffmann, Al", "Heartaches");

replace into Composers_Songs (composer, title) values ("Hollaender, Friedrich", "You've Got That Look");

replace into Composers_Songs (composer, title) values ("Hudson, Will", "Moonglow");

replace into Composers_Songs (composer, title) values ("Mills, Irving", "Moonglow");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Chega de Saudade");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Felicidade, A");

select title from Songs where music_reverse = "Jobim, Antonio Carlos";

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Gar{\\^o}ta de Ipanema");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Incerteza");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Insensatez");

-- delete from Composers_Songs where title = "Samba de uma nota so";

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Samba de Uma Nota So");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Se Todos Fossem Iguais a Voc{\\^e}");  

replace into Composers_Songs (composer, title) values ("Johnston, Arthur", "Cocktails for Two");

replace into Composers_Songs (composer, title) values ("Johnston, Arthur", "Just One More Chance");

replace into Composers_Songs (composer, title) values ("Johnston, Arthur", "My Old Flame");

replace into Composers_Songs (composer, title) values ("Johnston, Arthur", "Pennies from Heaven");

replace into Composers_Songs (composer, title) values ("Jones, Isham", "I'll See You in My Dreams");

replace into Composers_Songs (composer, title) values ("Jurmann, Walter", "All God's Children");

replace into Composers_Songs (composer, title) values ("Kaper, Bronislaw", "All God's Children");

replace into Composers_Songs (composer, title) values ("Jurmann, Walter", "Cosi Cosa");

replace into Composers_Songs (composer, title) values ("Kaper, Bronislaw", "Cosi Cosa");

replace into Composers_Songs (composer, title) values ("Jurmann, Walter", "Message From the Man in the Moon, A");

replace into Composers_Songs (composer, title) values ("Kaper, Bronislaw", "Message From the Man in the Moon, A");

replace into Composers_Songs (composer, title) values ("K{\\'a}lm{\\'a}n, Emmerich", "Komm, Zigany");

replace into Composers_Songs (composer, title) values ("K{\\'a}lm{\\'a}n, Emmerich", "Zwei M@{a}rchenaugen");

replace into Composers_Songs (composer, title) values ("Kaempfert, Bert", "Strangers in the Night");

replace into Composers_Songs (composer, title) values ("Kaempfert, Bert", "Spanish Eyes (Moon Over Naples)");

replace into Composers_Songs (composer, title) values ("Kander, John", "Cabaret");

replace into Composers_Songs (composer, title) values ("Kander, John", "Willkommen");

replace into Composers_Songs (composer, title) values ("Kaper, Bronislau", "On Green Dolphin Street");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "All the Things You Are");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Bill");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Make Believe");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Way You Look Tonight, The");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Long Ago (and Far Away)");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Fine Romance, A");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Pick Yourself Up");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Smoke Gets in Your Eyes");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Sure Thing");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Why Was I Born?");

replace into Composers_Songs (composer, title) values ("Kosma, Joseph", "Feuilles Mortes, Les");

replace into Composers_Songs (composer, title) values ("Lai, Francis", "Homme et une femme, Un");

replace into Composers_Songs (composer, title) values ("Lai, Francis", "Where Do I Begin? (Theme from Love Story)");

replace into Composers_Songs (composer, title) values ("Lane, Burton", "How About You?");

replace into Composers_Songs (composer, title) values ("Lane, Burton", "Lady's in Love With You, The");

replace into Composers_Songs (composer, title) values ("Lane, Burton", "On a Clear Day");

replace into Composers_Songs (composer, title) values ("Lecuona, Ernesto", "Para Vigo me voy (Say ``Si, Si'')");

replace into Composers_Songs (composer, title) values ("Leh{\\'a}r  Franz", "Lied vom dummen Reiter, Das");

replace into Composers_Songs (composer, title) values ("Leh{\\'a}r  Franz", "Lippen schweigen");

replace into Composers_Songs (composer, title) values ("Leh{\\'a}r, Franz", "Da geh ich zu Maxim");

replace into Composers_Songs (composer, title) values ("Leux, Leo", "Es leuchten die Sterne");

replace into Composers_Songs (composer, title) values ("Livingston, Jay", "Tammy");

replace into Composers_Songs (composer, title) values ("Loewe, Frederick", "They Call the Wind Maria");

replace into Composers_Songs (composer, title) values ("Loewe, Frederick", "I Talk to the Trees");

replace into Composers_Songs (composer, title) values ("Loewe, Frederick", "Wouldn't It Be Loverly?");

replace into Composers_Songs (composer, title) values ("Loewe, Frederick", "If I Should Ever Leave You");

replace into Composers_Songs (composer, title) values ("Loewe, Frederick", "Camelot");

replace into Composers_Songs (composer, title) values ("Loewe, Frederick", "I Could Have Danced All Night");

replace into Composers_Songs (composer, title) values ("Loewe, Frederick", "Gigi");

replace into Composers_Songs (composer, title) values ("Loewe, Frederick", "On the Street Where You Live");

replace into Composers_Songs (composer, title) values ("Mackeben, Theo", "Bel Ami");

replace into Composers_Songs (composer, title) values ("Mackeben, Theo", "Frauen sind keine Engel");

replace into Composers_Songs (composer, title) values ("Mancini, Henry", "Mr.~Lucky");

replace into Composers_Songs (composer, title) values ("Mandel, Johnny", "Shadow of Your Smile, The");

replace into Composers_Songs (composer, title) values ("McHugh, Jimmy", "I'm Shooting High");

replace into Composers_Songs (composer, title) values ("McHugh, Jimmy", "I'm in the Mood for Love");

replace into Composers_Songs (composer, title) values ("McHugh, Jimmy", "On the Sunny Side of the Street");

replace into Composers_Songs (composer, title) values ("Meyers, Billy", "Nobody's Sweetheart");

replace into Composers_Songs (composer, title) values ("Romberg, Sigmund", "Lover Come Back to Me");

replace into Composers_Songs (composer, title) values ("Schoebel, Elmer", "Nobody's Sweetheart");

replace into Composers_Songs (composer, title) values ("Miller, Glenn", "Moonlight Serenade");

replace into Composers_Songs (composer, title) values ("Modugno, Domenico", "Nel blu dipinto di blu (Volare)"); 

replace into Composers_Songs (composer, title) values ("Monaco, James", "You Made Me Love You");

replace into Composers_Songs (composer, title) values ("Monaco, James V.", "I've Got a Pocketful of Dreams");

replace into Composers_Songs (composer, title) values ("Moret, Neil", "She's Funny That Way");

replace into Composers_Songs (composer, title) values ("Mozart, Wolfgang Amadeus", "Alles f@{u}hlt der Liebe Freuden");

replace into Composers_Songs (composer, title) values ("Mozart, Wolfgang Amadeus", "L{\\`a} ci darem la mano");

replace into Composers_Songs (composer, title) values ("Nichols, Roger", "Rainy Days and Mondays");

replace into Composers_Songs (composer, title) values ("Nichols, Roger", "We've Only Just Begun");

replace into Composers_Songs (composer, title) values ("Bayes, Nora", "Shine On Harvest Moon");

-- delete from Composers_Songs where title = "Shine On Harvest Moon";

replace into Composers_Songs (composer, title) values ("Offenbach, Jacques", "Barcarole");

-- select * from Composers_Songs where composer = "Offenbach, Jacques";

-- delete from Composers_Songs where composer = "Offenbach, Jacques";

replace into Composers_Songs (composer, title) values ("Offenbach, Jacques", "Barcarole (Belle nuit, {\\^o} nuit d'amour)");

replace into Composers_Songs (composer, title) values ("Offenbach, Jacques", "Il {\\'e}tait une fois");

replace into Composers_Songs (composer, title) values ("Offenbach, Jacques", "Oiseaux dans les charmille, Les");

replace into Composers_Songs (composer, title) values ("Oliviero, Nino", "Ti Guarder{\\`e}ro Nel Cuore (More)");

replace into Composers_Songs (composer, title) values ("Orlob, Harold", "I Wonder Who's Kissing Her Now");

replace into Composers_Songs (composer, title) values ("Ortolani, Riz", "Ti Guarder{\\`e}ro Nel Cuore (More)");

replace into Composers_Songs (composer, title) values ("Paul, Gene de", "I'll Remember April");

replace into Composers_Songs (composer, title) values ("Perkins, Frank", "Stars Fell on Alabama");

replace into Composers_Songs (composer, title) values ("Popp, Andr{\\'e}", "Amour est bleu, L'");

replace into Composers_Songs (composer, title) values ("Portela, Raul", "Lisboa Antiga");

replace into Composers_Songs (composer, title) values ("Vale, Amadeu do", "Lisboa Antiga");

replace into Composers_Songs (composer, title) values ("Rainger, Ralph", "Thanks for the Memory");

replace into Composers_Songs (composer, title) values ("Rainger, Ralph", "June in Janury");

replace into Composers_Songs (composer, title) values ("Raksin, David", "Laura");

replace into Composers_Songs (composer, title) values ("Revaux, Jacques", "Comme d'Habitude");

replace into Composers_Songs (composer, title) values ("Fran{\\c c}ois, Claude", "Comme d'Habitude");

replace into Composers_Songs (composer, title) values ("Ricardel, Joe", "Frim Fram Sauce, The");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Blue Moon");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Falling in Love With Love");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "I Married an Angel");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Isn't It Romantic?");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "It Never Entered My Mind");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Lady is a Tramp, The");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Manhattan");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Many a New Day");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "My Heart Stood Still");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "People Will Say We're in Love");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Some Enchanted Evening");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Ten Cents a Dance");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "This Can't be Love");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Thou Swell");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "You Took Advantage of Me");

replace into Composers_Songs (composer, title) values ("Rota, Nino", "Speak Softly, Love");

replace into Composers_Songs (composer, title) values ("Ruby, Harry", "Nevertheless (I'm In Love With You)");

replace into Composers_Songs (composer, title) values ("Schertzinger, Victor", "Tangerine");

replace into Composers_Songs (composer, title) values ("Schubert, Franz", "Gute Nacht");

replace into Composers_Songs (composer, title) values ("Schwartz, Arthur", "Rainy Night in Rio, A");

replace into Composers_Songs (composer, title) values ("Schwarz, Jean", "Rock-a-Bye Your Baby (With a Dixie Melody)");

replace into Composers_Songs (composer, title) values ("Silvers, Louis", "April Showers");

replace into Composers_Songs (composer, title) values ("Spoliansky, Mischa", "Heute Nacht oder nie");

replace into Composers_Songs (composer, title) values ("Stolz, Robert", "Du sollst der Kaiser meiner Seele sein");

replace into Composers_Songs (composer, title) values ("Strachey, Jack", "These Foolish Things");

replace into Composers_Songs (composer, title) values ("Strau{\\ss} (Sohn), Johann", "Mein Herr Marquis");

replace into Composers_Songs (composer, title) values ("Strouse, Charles", "Put on a Happy Face");

replace into Composers_Songs (composer, title) values ("Styne, Jule", "Diamonds are a Girl's Best Friend");

replace into Composers_Songs (composer, title) values ("Styne, Jule", "Everything's Coming Up Roses");

replace into Composers_Songs (composer, title) values ("Styne, Jule", "Just in Time");

replace into Composers_Songs (composer, title) values ("Styne, Jule", "Party's Over, The");

replace into Composers_Songs (composer, title) values ("Styne, Jule", "Things We Did Last Summer, The");

replace into Composers_Songs (composer, title) values ("Swift, Kay", "Fine and Dandy");

replace into Composers_Songs (composer, title) values ("Waller, Thomas ``Fats''", "Ain't Misbehavin'");

replace into Composers_Songs (composer, title) values ("Brooks, Harry", "Ain't Misbehavin'");

replace into Composers_Songs (composer, title) values ("Waller, Thomas ``Fats''", "I've Got a Feeling I'm Falling");

replace into Composers_Songs (composer, title) values ("Link, Harry", "I've Got a Feeling I'm Falling");

replace into Composers_Songs (composer, title) values ("Waller, Thomas ``Fats''", "Jitterbug Waltz, The");

replace into Composers_Songs (composer, title) values ("Waller, Thomas ``Fats''", "Joint is Jumpin', The");

replace into Composers_Songs (composer, title) values ("Waller, Thomas ``Fats''", "Keepin' Out of Mischief Now");

replace into Composers_Songs (composer, title) values 
("Warlamoff, Alexander Jegorowitsch", 
"Rote Sarafan, Der ({\\mediumcy kRASN{\\char'131}{\\char'112} sARAFAN{\\char'137}})");

replace into Composers_Songs (composer, title) values ("Warren, Harry", 
   "Gold Diggers' Song, The (We're in the Money)");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "I Only Have Eyes for You");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "I'll String Along With You");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Jeepers Creepers");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Keep Young and Beautiful");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Lullaby of Broadway");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Lulu's Back in Town");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Shuffle Off to Buffalo");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "September in the Rain");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Young and Healthy");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "You're Getting to Be a Habit With Me");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Girl of the Moment");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Listen to My Song (Johnny's Song)");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Lost in the Stars");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Mon Ami, My Friend");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Moon-Faced, Starry-Eyed");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "September Song");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Speak Low");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "What Good Would the Moon Be?");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Wie lange noch?");

replace into Composers_Songs (composer, title) values ("Whiting, Richard A.", "Hooray For Hollywood");

replace into Composers_Songs (composer, title) values ("Whiting, Richard A.", "Japanese Sandman");

replace into Composers_Songs (composer, title) values ("Williams, Hugh", "Harbour Lights");

replace into Composers_Songs (composer, title) values ("Williams, Hugh", "Red Sails in the Sunset");

replace into Composers_Songs (composer, title) values ("Winkler, Gerhard", "Capri Fischer");

replace into Composers_Songs (composer, title) values ("Wrubel, Allie", "Lady in Red, The");

replace into Composers_Songs (composer, title) values ("Youmans, Vincent", "Carioca");

replace into Composers_Songs (composer, title) values ("Youmans, Vincent", "Tea for Two");

replace into Composers_Songs (composer, title) values ("Young, Victor", "Stella By Starlight");

replace into Composers_Songs (composer, title) values ("Young, Victor", "When I Fall in Love");

-- /* * (1)  */

select "$$$ Lyricists_Songs";

replace into Lyricists_Songs (lyricist, title) values ("Adams, Lee", "Put on a Happy Face");

replace into Lyricists_Songs (lyricist, title) values ("Anderson, Maxwell", "Lost in the Stars");

replace into Lyricists_Songs (lyricist, title) values ("Anderson, Maxwell", "September Song");

replace into Lyricists_Songs (lyricist, title) values ("Balz, Bruno", "Es leuchten die Sterne");

-- select * from Lyricists_Songs where lyricist = "Barbier, Jules";

-- delete from Lyricists_Songs where lyricist = "Barbier, Jules";

replace into Lyricists_Songs (lyricist, title) values ("Barbier, Jules", "Barcarole (Belle nuit, {\\^o} nuit d'amour)");

replace into Lyricists_Songs (lyricist, title) values ("Barbier, Jules", "Il {\\'e}tait une fois");

replace into Lyricists_Songs (lyricist, title) values ("Barbier, Jules", "Oiseaux dans les charmille, Les");

replace into Lyricists_Songs (lyricist, title) values ("Barouh, Pierre", "Homme et une femme, Un");

replace into Lyricists_Songs (lyricist, title) values ("Norworth, Jack", "Shine On Harvest Moon");

replace into Lyricists_Songs (lyricist, title) values ("Beckmann, Hans Fritz", "Bel Ami");

replace into Lyricists_Songs (lyricist, title) values ("Beckmann, Hans Fritz", "Frauen sind keine Engel");

replace into Lyricists_Songs (lyricist, title) values ("Bettis, John", "Top of the World");

replace into Lyricists_Songs (lyricist, title) values ("Brammer, Julius", "Sch@{o}ner Gigolo, armer Gigolo");

replace into Lyricists_Songs (lyricist, title) values ("Brammer, Julius", "Zwei M@{a}rchenaugen");

replace into Lyricists_Songs (lyricist, title) values ("Brown, Lew", "That Old Feeling");

replace into Lyricists_Songs (lyricist, title) values ("Gr@{u}nwald, Alfred", "Zwei M@{a}rchenaugen");

replace into Lyricists_Songs (lyricist, title) values ("Brammer, Julius", "Komm, Zigany");

replace into Lyricists_Songs (lyricist, title) values ("Gr@{u}nwald, Alfred", "Komm, Zigany");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Here's That Rainy Day");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Misty");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Moonlight Becomes You");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Oh! You Crazy Moon");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Pennies from Heaven");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "It Could Happen to You");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "I've Got a Pocketful of Dreams");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Imagination");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Swinging On A Star");

replace into Lyricists_Songs (lyricist, title) values ("Caesar, Irving", "Tea for Two");

replace into Lyricists_Songs (lyricist, title) values ("Cahn, Sammy", "Things We Did Last Summer, The");

-- select * from Lyricists_Songs where title = "Things We Did Last Summer, The";

-- select * from Lyricists_Songs where title = "Things We Did Last Summer, The";

-- select * from Composers_Songs where title = "Things We Did Last Summer, The";

-- delete from Composers_Songs where title = "Things We Did Last Summer, The";

-- delete from Lyricists_Songs where title = "Things We Did Last Summer, The";

replace into Lyricists_Songs (lyricist, title) values ("Ciorciolini, Marcello", "Ti Guarder{\\`e}ro Nel Cuore (More)");

-- delete from Lyricists_Songs where lyricist = "Comden, Betty" limit 1;

replace into Lyricists_Songs (lyricist, title) values ("Comden, Betty", "I Can Cook Too");

replace into Lyricists_Songs (lyricist, title) values ("Green, Adolf", "I Can Cook Too");

replace into Lyricists_Songs (lyricist, title) values ("Comden, Betty", "Just in Time");

replace into Lyricists_Songs (lyricist, title) values ("Comden, Betty", "Party's Over, The");

replace into Lyricists_Songs (lyricist, title) values ("Green, Adolf", "Just in Time");

replace into Lyricists_Songs (lyricist, title) values ("Green, Adolf", "Party's Over, The");

replace into Lyricists_Songs (lyricist, title) values ("Contet, Henri", "Mademoiselle de Paris");

replace into Lyricists_Songs (lyricist, title) values ("Cormon, Eug{\\`e}ne", "Au fond du temple saint");

replace into Lyricists_Songs (lyricist, title) values ("Carr{\\'e}, Michel", "Au fond du temple saint");

replace into Lyricists_Songs (lyricist, title) values ("Coslow, Sam", "Cocktails for Two");

replace into Lyricists_Songs (lyricist, title) values ("Coslow, Sam", "Just One More Chance");

replace into Lyricists_Songs (lyricist, title) values ("Coslow, Sam", "My Old Flame");

replace into Lyricists_Songs (lyricist, title) values ("Cour, Pierre", "Amour est bleu, L'");

replace into Lyricists_Songs (lyricist, title) values ("Da Ponte, Lorenzo", "L{\\`a} ci darem la mano");

replace into Lyricists_Songs (lyricist, title) values ("David, Hal", "Close to You");

replace into Lyricists_Songs (lyricist, title) values ("David, Hal", "I'll Never Fall in Love Again");

replace into Lyricists_Songs (lyricist, title) values ("David, Hal", "Do You Know the Way to San Jose?");

replace into Lyricists_Songs (lyricist, title) values ("David, Hal", "I Say a Little Prayer");

replace into Lyricists_Songs (lyricist, title) values ("Davis, Benny", "Baby Face");

replace into Lyricists_Songs (lyricist, title) values ("De Sylva, Buddy G.", "April Showers");

replace into Lyricists_Songs (lyricist, title) values ("Dehmel, Willy", "Ja und Nein");

replace into Lyricists_Songs (lyricist, title) values ("DeLange, Eddie", "Moonglow");

replace into Lyricists_Songs (lyricist, title) values ("Dixon, Mort", "Lady in Red, The");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Gold Diggers' Song, The (We're in the Money)");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "I'll String Along With You");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "I Only Have Eyes for You");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Keep Young and Beautiful");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Lullaby of Broadway");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Lulu's Back in Town");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Tiptoe Through the Tulips With Me");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "September in the Rain");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Shuffle Off to Buffalo");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Young and Healthy");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "You're Getting to Be a Habit With Me");

replace into Lyricists_Songs (lyricist, title) values ("Ebb, Fred", "Cabaret");

replace into Lyricists_Songs (lyricist, title) values ("Ebb, Fred", "Willkommen");

replace into Lyricists_Songs (lyricist, title) values ("Egan, Raymond B.", "Japanese Sandman");

replace into Lyricists_Songs (lyricist, title) values ("Eliscu, Edward", "Carioca");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Carioca");

replace into Lyricists_Songs (lyricist, title) values ("Evans, Ray", "Tammy");

replace into Lyricists_Songs (lyricist, title) values ("Evans, Redd", "Frim Fram Sauce, The");

replace into Lyricists_Songs (lyricist, title) values ("Eyton Frank", "Body and Soul");

replace into Lyricists_Songs (lyricist, title) values ("Heymann, Edward", "Body and Soul");

replace into Lyricists_Songs (lyricist, title) values ("Sour, Robert", "Body and Soul");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "On the Sunny Side of the Street");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "I'm in the Mood for Love");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "Way You Look Tonight, The");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "Fine Romance, A");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "Pick Yourself Up");

replace into Lyricists_Songs (lyricist, title) values ("Fontenoy, Marc", "Buenas Noches mi Amor");

replace into Lyricists_Songs (lyricist, title) values ("Freed, Arthur", "All I Do Is Dream Of You");

replace into Lyricists_Songs (lyricist, title) values ("Freed, Arthur", "Temptation");

replace into Lyricists_Songs (lyricist, title) values ("Freed, Arthur", "Wedding of the Painted Doll, The");

replace into Lyricists_Songs (lyricist, title) values ("Freed, Ralph", "How About You?");

replace into Lyricists_Songs (lyricist, title) values ("Galhardo, Jos{\\'e}", "Lisboa Antiga");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Embraceable You");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Girl of the Moment");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "I Can't Get Started");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "I Got Plenty o' Nuttin'"); 

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Let's Call the Whole Thing Off");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Liza (All the Clouds'll Roll Away)");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Long Ago (and Far Away)");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Nice Work If You Can Get It");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Someone to Watch Over Me");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Sure Thing");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "They Can't Take That Away From Me");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Liza (All the Clouds'll Roll Away)");

replace into Lyricists_Songs (lyricist, title) values ("Gillespie, Haven", "You Go to My Head");

replace into Lyricists_Songs (lyricist, title) values ("Gordon, Irving", "Prelude to a Kiss");

replace into Lyricists_Songs (lyricist, title) values ("Mills, Irving", "Prelude to a Kiss");

replace into Lyricists_Songs (lyricist, title) values ("Gorrell, Stuart", "Georgia on my Mind");

replace into Lyricists_Songs (lyricist, title) values ("Green, Paul", "Listen to My Song (Johnny's Song)");

replace into Lyricists_Songs (lyricist, title) values ("Gr@{u}nbaum, Fritz", "Du sollst der Kaiser meiner Seele sein");

replace into Lyricists_Songs (lyricist, title) values ("Sterk, Wilhelm", "Du sollst der Kaiser meiner Seele sein");

replace into Lyricists_Songs (lyricist, title) values ("Haffner, Karl", "Mein Herr Marquis");

replace into Lyricists_Songs (lyricist, title) values ("Gen{\\'e}e, Richard", "Mein Herr Marquis");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "All the Things You Are");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "Lover Come Back to Me");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "People Will Say We're in Love");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "Many a New Day");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "Make Believe");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "Some Enchanted Evening");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "Why Was I Born?");

replace into Lyricists_Songs (lyricist, title) values ("Harbach, Otto", "Smoke Gets in Your Eyes");

-- delete from Lyricists_Songs where title = "Over the Rainbow";

replace into Lyricists_Songs (lyricist, title) values ("Harburg, E.Y.", "I Like the Likes of You");

replace into Lyricists_Songs (lyricist, title) values ("Harburg, E.Y.", "Over the Rainbow");

replace into Lyricists_Songs (lyricist, title) values ("Harnick, Sheldon", "(I'll Marry) The Very Next Man");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Blue Moon");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Falling in Love With Love");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "I Married an Angel");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Isn't It Romantic?");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "It Never Entered My Mind");

-- select * from Lyricists_Songs where title = "It Never Entered My Mind";

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Lady is a Tramp, The");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Manhattan");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "My Heart Stood Still");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Ten Cents a Dance");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "This Can't be Love");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Thou Swell");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "You Took Advantage of Me");

replace into Lyricists_Songs (lyricist, title) values ("Heyman, Edward", "I Cover the Waterfront");

replace into Lyricists_Songs (lyricist, title) values ("Heyman, Edward", "Out of Nowhere");

replace into Lyricists_Songs (lyricist, title) values ("Heyman, Edward", "When I Fall in Love");

-- delete from Lyricists_Songs where title = "I Wonder Who's Kissing Her Now";

replace into Lyricists_Songs (lyricist, title) values ("Heyward, DuBose", "I Got Plenty o' Nuttin'"); 

-- select * from Lyricists_Songs where lyricist = "Heyward, DuBose";

-- select * from Lyricists_Songs where lyricist = "Gershwin, Ira" order by title;

replace into Lyricists_Songs (lyricist, title) values ("Hough, Will M.", "I Wonder Who's Kissing Her Now");

replace into Lyricists_Songs (lyricist, title) values ("Adams, Frank R.", "I Wonder Who's Kissing Her Now");

replace into Lyricists_Songs (lyricist, title) values ("Hodgson, Red", "Music Goes 'Round and Around, The");

replace into Lyricists_Songs (lyricist, title) values ("Hughes, Langston", "Moon-Faced, Starry-Eyed");

replace into Lyricists_Songs (lyricist, title) values ("Hughes, Langston", "What Good Would the Moon Be?"); 

replace into Lyricists_Songs (lyricist, title) values ("James, Paul (Warburg, James Paul)", "Fine and Dandy");

replace into Lyricists_Songs (lyricist, title) values ("Johnson, J.C.", "Joint is Jumpin', The");

replace into Lyricists_Songs (lyricist, title) values ("Razaf, Andy", "Joint is Jumpin', The");

replace into Lyricists_Songs (lyricist, title) values ("Johnson, J.C.", "Yacht Club Swing");

replace into Lyricists_Songs (lyricist, title) values ("Johnston, Patricia", "I'll Remember April");

replace into Lyricists_Songs (lyricist, title) values ("Raye, Don", "I'll Remember April");

replace into Lyricists_Songs (lyricist, title) values ("Kahal, Irving", "By a Waterfall");

replace into Lyricists_Songs (lyricist, title) values ("Kahal, Irving", "I Can Dream, Can't I?");

replace into Lyricists_Songs (lyricist, title) values ("Kahal, Irving", "I'll Be Seeing You");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Love Me or Leave Me");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Makin' Whoopee!");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Coquette");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "I'll See You in My Dreams");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "My Baby Just Cares for Me");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Message From the Man in the Moon, A");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "All God's Children");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Carolina in the Morning");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Dream a Little Dream of Me");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Nobody's Sweetheart");

replace into Lyricists_Songs (lyricist, title) values ("Erdman, Ernest", "Nobody's Sweetheart");

replace into Lyricists_Songs (lyricist, title) values ("Kalmar, Bert", "Nevertheless (I'm In Love With You)");

replace into Lyricists_Songs (lyricist, title) values ("Kennedy, Jimmy", "Harbour Lights");

replace into Lyricists_Songs (lyricist, title) values ("Kennedy, Jimmy", "Red Sails in the Sunset");

replace into Lyricists_Songs (lyricist, title) values ("Kennedy, Jimmy", "South of the Border");

replace into Lyricists_Songs (lyricist, title) values ("Kenny, Nick", "Love Letters in the Sand");

replace into Lyricists_Songs (lyricist, title) values ("Kenny, Charles", "Love Letters in the Sand");

replace into Lyricists_Songs (lyricist, title) values ("Kind, Friedrich", "Durch die W@{a}lder, durch die Auen");

replace into Lyricists_Songs (lyricist, title) values ("Kleban, Edward", "One");

replace into Lyricists_Songs (lyricist, title) values ("Klenner, John", "Heartaches");

replace into Lyricists_Songs (lyricist, title) values ("Koehler, Ted", "Let's Fall in Love");

replace into Lyricists_Songs (lyricist, title) values ("Koehler, Ted", "I've Got the World on a String");

replace into Lyricists_Songs (lyricist, title) values ("Koehler, Ted", "Between the Devil and the Deep Blue Sea");

replace into Lyricists_Songs (lyricist, title) values ("Koehler, Ted", "Wrap Your Troubles in Dreams");

replace into Lyricists_Songs (lyricist, title) values ("Moll, Billy", "Wrap Your Troubles in Dreams");

replace into Lyricists_Songs (lyricist, title) values ("Koehler, Ted", "I'm Shooting High");

replace into Lyricists_Songs (lyricist, title) values ("Wilmott, Charles", "I'm Shooting High");

replace into Lyricists_Songs (lyricist, title) values ("Kurtz, Manny", "In a Sentimental Mood");

replace into Lyricists_Songs (lyricist, title) values ("Mills, Irving", "In a Sentimental Mood");

replace into Lyricists_Songs (lyricist, title) values ("Kusik, Larry", "Speak Softly, Love");

replace into Lyricists_Songs (lyricist, title) values ("Le Pera, Alfredo", "Por Una Cabeza");

replace into Lyricists_Songs (lyricist, title) values ("Le Pera, Alfredo", "Volver");

replace into Lyricists_Songs (lyricist, title) values ("L{\\'e}on, Victor", "Da geh ich zu Maxim");

replace into Lyricists_Songs (lyricist, title) values ("Stein, Leo", "Da geh ich zu Maxim");

replace into Lyricists_Songs (lyricist, title) values ("L{\\'e}on, Victor", "Lied vom dummen Reiter, Das");

replace into Lyricists_Songs (lyricist, title) values ("Stein, Leo", "Lied vom dummen Reiter, Das");

replace into Lyricists_Songs (lyricist, title) values ("L{\\'e}on, Victor", "Lippen schweigen");

replace into Lyricists_Songs (lyricist, title) values ("Stein, Leo", "Lippen schweigen");

replace into Lyricists_Songs (lyricist, title) values ("La Touche, John", "Taking a Chance on Love");

replace into Lyricists_Songs (lyricist, title) values ("Fetter, Ted", "Taking a Chance on Love");

replace into Lyricists_Songs (lyricist, title) values ("Lerner, Alan Jay", "Camelot");

replace into Lyricists_Songs (lyricist, title) values ("Lerner, Alan Jay", "Gigi");

replace into Lyricists_Songs (lyricist, title) values ("Lerner, Alan Jay", "If I Should Ever Leave You");

replace into Lyricists_Songs (lyricist, title) values ("Lerner, Alan Jay", "Wouldn't It Be Loverly?");

replace into Lyricists_Songs (lyricist, title) values ("Lerner, Alan Jay", "They Call the Wind Maria");

replace into Lyricists_Songs (lyricist, title) values ("Lerner, Alan Jay", "On a Clear Day");

replace into Lyricists_Songs (lyricist, title) values ("Lerner, Alan Jay", "On the Street Where You Live");

replace into Lyricists_Songs (lyricist, title) values ("Lerner, Alan Jay", "I Talk to the Trees");

replace into Lyricists_Songs (lyricist, title) values ("Lerner, Alan Jay", "I Could Have Danced All Night");

replace into Lyricists_Songs (lyricist, title) values ("Lewis, Sam M.", "Rock-a-Bye Your Baby (With a Dixie Melody)");

replace into Lyricists_Songs (lyricist, title) values ("Young, Joe", "Rock-a-Bye Your Baby (With a Dixie Melody)");

replace into Lyricists_Songs (lyricist, title) values ("Lewis, Sam M.", "How 'Ya Gonna Keep 'Em Down on the Farm?");

replace into Lyricists_Songs (lyricist, title) values ("Young, Joe", "How 'Ya Gonna Keep 'Em Down on the Farm?");

-- select * from Songs where music = "Ray Henderson"\G

-- select * from Lyricists_Songs where lyricist = "Young, Joe"\G

-- delete from Lyricists_Songs where lyricist = "Young, Joe"\G

-- select * from Lyricists_Songs where lyricist = "Lewis, Sam M."\G

-- delete from Lyricists_Songs where lyricist = "Lewis, Sam M."\G

replace into Lyricists_Songs (lyricist, title) values ("Lewis, Sam M.", "Five Foot Two, Eyes Of Blue");

replace into Lyricists_Songs (lyricist, title) values ("Young, Joe", "Five Foot Two, Eyes Of Blue");

replace into Lyricists_Songs (lyricist, title) values ("Livingston, Jay", "Mr.~Lucky");

replace into Lyricists_Songs (lyricist, title) values ("Evans, Ray", "Mr.~Lucky");

replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Heart and Soul");

replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Lady's in Love With You, The");

replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Two Sleepy People");

replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "You've Got That Look");

replace into Lyricists_Songs (lyricist, title) values ("Luban, Francia", "Para Vigo me voy (Say ``Si, Si'')");

-- select * from Lyricists_Songs where lyricist = "Luban, Francia";
-- select * from Lyricists_Songs where lyricist = "MacDonald, Ballard";

replace into Lyricists_Songs (lyricist, title) values ("MacDonald, Ballard", "Somebody Loves Me");

replace into Lyricists_Songs (lyricist, title) values ("DeSylva, Buddy", "Somebody Loves Me");

replace into Lyricists_Songs (lyricist, title) values ("Lawrence, Jack", "Tenderly");

replace into Lyricists_Songs (lyricist, title) values ("Madden, Edward", "Moonlight Bay");

replace into Lyricists_Songs (lyricist, title) values ("Magidson, Herb", "Continental, The");

replace into Lyricists_Songs (lyricist, title) values ("Maria, Ant{\\^o}nio", "Manh{\\~a} da Carnaval");

replace into Lyricists_Songs (lyricist, title) values ("Maria, Ant{\\^o}nio", "Samba de Orfeu");

replace into Lyricists_Songs (lyricist, title) 
values ("Marvell, Holt (Maschwitz, Eric)", "These Foolish Things");

replace into Lyricists_Songs (lyricist, title) values ("McCarthy, Joe", "You Made Me Love You");

-- delete from Lyricists_Songs where title = "Incerteza";

replace into Lyricists_Songs (lyricist, title) values ("Madden, Ed", "By The Light Of The Silvery Moon"); 

replace into Lyricists_Songs (lyricist, title) values ("Mehring, Walter", "Wie lange noch?");

replace into Lyricists_Songs (lyricist, title) values ("Mendon{\\c c}a, Newton F.", "Incerteza");

-- delete from Lyricists_Songs where title = "Samba de uma nota so";

replace into Lyricists_Songs (lyricist, title) values ("Mendon{\\c c}a, Newton", "Samba de Uma Nota So");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Jeepers Creepers");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Skylark");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Hooray For Hollywood");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Tangerine");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Laura");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Fools Rush In (Where Angels Fear to Tread)");

replace into Lyricists_Songs (lyricist, title) values ("Migliacci, Franco", "Nel blu dipinto di blu (Volare)"); 

replace into Lyricists_Songs (lyricist, title) values ("Mills, Irving", "Caravan");

replace into Lyricists_Songs (lyricist, title) values ("Modugno, Domenico", "Nel blu dipinto di blu (Volare)"); 

-- /* select * from Lyricists_Songs where title = "Chega de Saudade";  */

replace into Lyricists_Songs (lyricist, title) values ("Moraes, Vin{\\'\\i}cius de", "Chega de Saudade");

replace into Lyricists_Songs (lyricist, title) values ("Moraes, Vin{\\'\\i}cius de", "Felicidade, A");

replace into Lyricists_Songs (lyricist, title) values ("Moraes, Vin{\\'\\i}cius de", "Gar{\\^o}ta de Ipanema");

replace into Lyricists_Songs (lyricist, title) values ("Moraes, Vin{\\'\\i}cius de", "Insensatez");

-- delete from Lyricists_Songs where title = "Se Todos Fossem Iguais A Voc{\\^e}";

replace into Lyricists_Songs (lyricist, title) values ("Moraes, Vin{\\'\\i}cius de", "Se Todos Fossem Iguais a Voc{\\^e}");

replace into Lyricists_Songs (lyricist, title) values ("M@{u}ller, Wilhelm", "Gute Nacht");

replace into Lyricists_Songs (lyricist, title) values ("Nash, Ogden", "Just Like a Man");

replace into Lyricists_Songs (lyricist, title) values ("Nash, Ogden", "Speak Low");

replace into Lyricists_Songs (lyricist, title) values ("None", "Jalousie ``Tango Tzigane'' (Jealousy)");

replace into Lyricists_Songs (lyricist, title) values ("Norton, George A.", "My Melancholy Baby");

replace into Lyricists_Songs (lyricist, title) values ("Oliveira, Aloysio de", "Tico Tico no Fuba");

replace into Lyricists_Songs (lyricist, title) values ("Parish, Mitchell", "Deep Purple");

replace into Lyricists_Songs (lyricist, title) values ("Parish, Mitchell", "Stars Fell on Alabama");

replace into Lyricists_Songs (lyricist, title) values ("Parish, Mitchell", "Stardust");

replace into Lyricists_Songs (lyricist, title) values ("Parish, Mitchell", "Moonlight Serenade");

replace into Lyricists_Songs (lyricist, title) values ("Parish, Mitchell", "Sophisticated Lady");

replace into Lyricists_Songs (lyricist, title) values ("Mills, Irving", "Sophisticated Lady");

replace into Lyricists_Songs (lyricist, title) values ("Pinelli, Aldo von", "Abends in der Taverna");

replace into Lyricists_Songs (lyricist, title) values ("Prevert, Jacques", "Feuilles Mortes, Les");

replace into Lyricists_Songs (lyricist, title) values ("Razaf, Andy", "Ain't Misbehavin'");

replace into Lyricists_Songs (lyricist, title) values ("Razaf, Andy", "Keepin' Out of Mischief Now");

replace into Lyricists_Songs (lyricist, title) values ("Razaf, Andy", "Memories of You");

replace into Lyricists_Songs (lyricist, title) values ("Reaves, Erell", "Lady of Spain");

replace into Lyricists_Songs (lyricist, title) values ("Tilsley, Henry", "Lady of Spain");

replace into Lyricists_Songs (lyricist, title) values ("Robin, Leo", "Diamonds are a Girl's Best Friend");

replace into Lyricists_Songs (lyricist, title) values ("Robin, Leo", "June in Janury");

replace into Lyricists_Songs (lyricist, title) values ("Robin, Leo", "Thanks for the Memory");

replace into Lyricists_Songs (lyricist, title) values ("Robin, Leo", "Rainy Night in Rio, A");

replace into Lyricists_Songs (lyricist, title) values ("Robin, Leo", "Prisoner of Love");

replace into Lyricists_Songs (lyricist, title) values ("Romani, Felice", "Furtiva lagrima, Una");

replace into Lyricists_Songs (lyricist, title) values ("Romero, Manuel", "Tomo y Obligo");

replace into Lyricists_Songs (lyricist, title) values ("Rose, Billy", "I've Got a Feeling I'm Falling");

replace into Lyricists_Songs (lyricist, title) values ("Schikaneder, Emanuel", "Alles f@{u}hlt der Liebe Freuden");

replace into Lyricists_Songs (lyricist, title) values ("Schiffer, Marcellus", "Heute Nacht oder nie");

replace into Lyricists_Songs (lyricist, title) values ("Siegel, Ralph Maria", "Capri Fischer");

replace into Lyricists_Songs (lyricist, title) values ("Sigman, Carl", "Where Do I Begin? (Theme from Love Story)");

replace into Lyricists_Songs (lyricist, title) values ("Silvers, Phil", "Nancy with the Laughing Face");

replace into Lyricists_Songs (lyricist, title) values ("Singleton, Charles", "Spanish Eyes (Moon Over Naples)");

replace into Lyricists_Songs (lyricist, title) values ("Sissle, Noble", "I'm Just Wild About Harry");

replace into Lyricists_Songs (lyricist, title) values ("Snyder, Eddie", "Spanish Eyes (Moon Over Naples)");

replace into Lyricists_Songs (lyricist, title) values ("Singleton, Charles", "Strangers in the Night");

replace into Lyricists_Songs (lyricist, title) values ("Snyder, Eddie", "Strangers in the Night");

replace into Lyricists_Songs (lyricist, title) values ("Sondheim, Stephen", "Everything's Coming Up Roses");

replace into Lyricists_Songs (lyricist, title) values ("Sondheim, Stephen", "I Feel Pretty");

replace into Lyricists_Songs (lyricist, title) values ("Sondheim, Stephen", "Something's Coming");

replace into Lyricists_Songs (lyricist, title) values ("Springfield, Tom", "Georgy  Girl");

replace into Lyricists_Songs (lyricist, title) values ("Stillman, Al", "Chances Are");

replace into Lyricists_Songs (lyricist, title) values ("Stillman, Al", "It's Not For Me to Say");

replace into Lyricists_Songs (lyricist, title) values ("Thibaut, Gille", "Comme d'Habitude");

replace into Lyricists_Songs (lyricist, title) values ("Turk, Roy", "I Don't Know Why (I Just Do)");

replace into Lyricists_Songs (lyricist, title) values 
("Unknown", "Rote Sarafan, Der ({\\mediumcy kRASN{\\char'131}{\\char'112} sARAFAN{\\char'137}})");

replace into Lyricists_Songs (lyricist, title) values ("Washington, Ned", "Cosi Cosa");

replace into Lyricists_Songs (lyricist, title) values ("Washington, Ned",  "Nearness of You, The");

replace into Lyricists_Songs (lyricist, title) values ("Washington, Ned", "On Green Dolphin Street");

replace into Lyricists_Songs (lyricist, title) values ("Washington, Ned", "Smoke Rings");

replace into Lyricists_Songs (lyricist, title) values ("Washington, Ned", "Stella By Starlight");

replace into Lyricists_Songs (lyricist, title) values ("Webster, Paul Francis", "Shadow of Your Smile, The");

replace into Lyricists_Songs (lyricist, title) values ("Whiting, George A.", "My Blue Heaven");

replace into Lyricists_Songs (lyricist, title) values ("Whiting, Richard A.", "She's Funny That Way");

replace into Lyricists_Songs (lyricist, title) values ("Williams, Paul", "Rainy Days and Mondays");

replace into Lyricists_Songs (lyricist, title) values ("Williams, Paul", "We've Only Just Begun");

replace into Lyricists_Songs (lyricist, title) values ("Wodehouse, P.G.", "Bill");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein, Oscar II", "Bill");

replace into Lyricists_Songs (lyricist, title) values ("Yellen, Jack", "Ain't She Sweet");

replace into Lyricists_Songs (lyricist, title) values ("Young, Joe", "I'm Gonna Sit Right Down and Write Myself a Letter");

-- /* * (1)  */

-- delete from Composers_Songs where title = "Heart";
-- delete from Lyricists_Songs where title = "Heart";


select "$$$ Composers_Songs and Lyricists_Songs";

replace	into Composers_Songs (composer, title) values ("Adler, Richard", "Heart (You've Gotta Have Heart)");
replace	into Composers_Songs (composer, title) values ("Ross, Jerry", "Heart (You've Gotta Have Heart)");
replace into Lyricists_Songs (lyricist, title) values ("Adler, Richard", "Heart (You've Gotta Have Heart)");
replace into Lyricists_Songs (lyricist, title) values ("Ross, Jerry", "Heart (You've Gotta Have Heart)");

replace into Composers_Songs (composer, title) values ("Ballard, Pat", "Mister Sandman");
replace into Lyricists_Songs (lyricist, title) values ("Ballard, Pat", "Mister Sandman");

replace into Composers_Songs (composer, title) values ("Bart, Lionel", "Consider Yourself");
replace into Lyricists_Songs (lyricist, title) values ("Bart, Lionel", "Consider Yourself");

replace into Composers_Songs (composer, title) values ("Bart, Lionel", "Food, Glorious Food");
replace into Lyricists_Songs (lyricist, title) values ("Bart, Lionel", "Food, Glorious Food");

replace into Composers_Songs (composer, title) values ("Bart, Lionel", "Who Will Buy?");
replace into Lyricists_Songs (lyricist, title) values ("Bart, Lionel", "Who Will Buy?");

replace into Composers_Songs (composer, title) values ("Ben, Jorge", "Mas Que Nada");
replace into Lyricists_Songs (lyricist, title) values ("Ben, Jorge", "Mas Que Nada");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Anything You Can Do");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Anything You Can Do");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Blue Skies");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Blue Skies");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Change Partners");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Change Partners");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Cheek to Cheek");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Cheek to Cheek");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Heat Wave");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Heat Wave");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Isn't This a Lovely Day?");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Isn't This a Lovely Day?");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Let's Face the Music and Dance");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Let's Face the Music and Dance");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "No Strings");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "No Strings");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Piccolino, The");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Piccolino, The");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Pretty A Girl is Like a Melody, A");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Pretty A Girl is Like a Melody, A");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Puttin' On the Ritz");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Puttin' On the Ritz");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "There's No Business Like Show Business");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "There's No Business Like Show Business");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "They Say it's Wonderful");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "They Say it's Wonderful");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Top Hat, White Tie and Tails");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Top Hat, White Tie and Tails");

replace into Composers_Songs (composer, title) values ("Borodin, Alexander", "Polowetzer T@{a}nze (``Stranger in Paradise'')");
replace into Lyricists_Songs (lyricist, title) values ("Borodin, Alexander", "Polowetzer T@{a}nze (``Stranger in Paradise'')");

replace into Composers_Songs (composer, title) values ("Bowman, Brooks", "East of the Sun (and West of the Moon)");
replace into Lyricists_Songs (lyricist, title) values ("Bowman, Brooks", "East of the Sun (and West of the Moon)");

replace into Composers_Songs (composer, title) values ("Bricusse, Leslie", "What Kind of Fool Am I?");
replace into Lyricists_Songs (lyricist, title) values ("Bricusse, Leslie", "What Kind of Fool Am I?");
replace into Composers_Songs (composer, title) values ("Newley, Anthony", "What Kind of Fool Am I?");
replace into Lyricists_Songs (lyricist, title) values ("Newley, Anthony", "What Kind of Fool Am I?");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Lazy River");
replace into Lyricists_Songs (lyricist, title) values ("Carmichael, Hoagy", "Lazy River");
replace into Composers_Songs (composer, title) values ("Arodin, Sidney", "Lazy River");
replace into Lyricists_Songs (lyricist, title) values ("Arodin, Sidney", "Lazy River"); 

replace into Composers_Songs (composer, title) values ("Collazo, Roberto (Bobby)", "{\\'U}ltima Noche, La");
replace into Lyricists_Songs (lyricist, title) values ("Collazo, Roberto (Bobby)", "{\\'U}ltima Noche, La");

replace into Composers_Songs (composer, title) values ("Coward, No@{e}l", "If Love Were All");
replace into Lyricists_Songs (lyricist, title) values ("Coward, No@{e}l", "If Love Were All");

replace into Composers_Songs (composer, title) values ("Coward, No@{e}l", "I'll See You Again");
replace into Lyricists_Songs (lyricist, title) values ("Coward, No@{e}l", "I'll See You Again");

replace into Composers_Songs (composer, title) values ("Coward, No@{e}l", "Parisian Pierrot");
replace into Lyricists_Songs (lyricist, title) values ("Coward, No@{e}l", "Parisian Pierrot");

replace into Composers_Songs (composer, title) values ("Coward, No@{e}l", "Room With a View, A");
replace into Lyricists_Songs (lyricist, title) values ("Coward, No@{e}l", "Room With a View, A");

replace into Composers_Songs (composer, title) values ("Coward, No@{e}l", "I'll Follow My Secret Heart");
replace into Lyricists_Songs (lyricist, title) values ("Coward, No@{e}l", "I'll Follow My Secret Heart");

replace into Composers_Songs (composer, title) values ("Denver, John", "Annie's Song");
replace into Lyricists_Songs (lyricist, title) values ("Denver, John", "Annie's Song");

replace into Composers_Songs (composer, title) values ("DeSylva, B.G.", "Button Up Your Overcoat");
replace into Lyricists_Songs (lyricist, title) values ("DeSylva, B.G.", "Button Up Your Overcoat");

replace into Composers_Songs (composer, title) values ("Brown, Lew", "Button Up Your Overcoat");
replace into Lyricists_Songs (lyricist, title) values ("Brown, Lew", "Button Up Your Overcoat");

replace into Composers_Songs (composer, title) values ("Henderson, Ray", "Button Up Your Overcoat");
replace into Lyricists_Songs (lyricist, title) values ("Henderson, Ray", "Button Up Your Overcoat");

replace into Composers_Songs (composer, title) values ("Dom{\\'\\i}nguez Borr{\\'a}s, Alberto", "Frenesi");
replace into Lyricists_Songs (lyricist, title) values ("Dom{\\'\\i}nguez Borr{\\'a}s, Alberto", "Frenesi");

replace into Composers_Songs (composer, title) values ("Dom{\\'\\i}nguez Borr{\\'a}s, Alberto", "Perfidia");
replace into Lyricists_Songs (lyricist, title) values ("Dom{\\'\\i}nguez Borr{\\'a}s, Alberto", "Perfidia");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "Little White Lies");
replace into Lyricists_Songs (lyricist, title) values ("Donaldson, Walter", "Little White Lies");

replace into Composers_Songs (composer, title) values ("Duke, Vernon", "Paris in New York");
replace into Lyricists_Songs (lyricist, title) values ("Duke, Vernon", "Paris in New York");

replace into Composers_Songs (composer, title) values ("Duke, Vernon", "Autumn in New York");
replace into Lyricists_Songs (lyricist, title) values ("Duke, Vernon", "Autumn in New York");

replace into Composers_Songs (composer, title) values ("Farr{\\'e}s, Osvaldo", "Quiz{\\'a}s, Quiz{\\'a}s, Quiz{\\'a}s");
replace into Lyricists_Songs (lyricist, title) values ("Farr{\\'e}s, Osvaldo", "Quiz{\\'a}s, Quiz{\\'a}s, Quiz{\\'a}s");

replace into Composers_Songs (composer, title) values ("Fisher, Fred", "Chicago (That Toddling Town)");
replace into Lyricists_Songs (lyricist, title) values ("Fisher, Fred", "Chicago (That Toddling Town)");

replace into Composers_Songs (composer, title) values ("Fisher, Mark; Goodwin, Joe and Shay, Larry", "When You're Smiling");
replace into Lyricists_Songs (lyricist, title) values ("Fisher, Mark; Goodwin, Joe and Shay, Larry", "When You're Smiling");

-- delete from Composers_Songs where composer = "Frank, Loesser";
-- delete from Lyricists_Songs where lyricist = "Frank, Loesser";

select * from Composers_Songs where composer = "Loesser, Frank";
select * from Lyricists_Songs where lyricist = "Loesser, Frank";

replace into Composers_Songs (composer, title) values ("Loesser, Frank", "Baby, It's Cold Outside");
replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Baby, It's Cold Outside");

replace into Composers_Songs (composer, title) values ("Loesser, Frank", "Once in Love with Amy");
replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Once in Love with Amy");

replace into Composers_Songs (composer, title) values ("Loesser, Frank", "Guys and Dolls");
replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Guys and Dolls");

replace into Composers_Songs (composer, title) values ("Loesser, Frank", "Woman in Love, A");
replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Woman in Love, A");

replace into Composers_Songs (composer, title) values ("Gordon, Irving", "Unforgettable");
replace into Lyricists_Songs (lyricist, title) values ("Gordon, Irving", "Unforgettable");

replace into Composers_Songs (composer, title) values ("Hatch, Tony", "Downtown");
replace into Lyricists_Songs (lyricist, title) values ("Hatch, Tony", "Downtown");

replace into Composers_Songs (composer, title) values ("Hatch, Tony", "Call Me");
replace into Lyricists_Songs (lyricist, title) values ("Hatch, Tony", "Call Me");

replace into Composers_Songs (composer, title) values ("Hollaender, Friedrich", "Illusions");
replace into Lyricists_Songs (lyricist, title) values ("Hollaender, Friedrich", "Illusions");

-- select * from Composers_Songs where composer = "Howard, Bart";
-- select * from Lyricists_Songs where lyricist = "Howard, Bart";

replace into Composers_Songs (composer, title) values ("Howard, Bart", "Fly Me to the Moon (In Other Words)");
replace into Lyricists_Songs (lyricist, title) values ("Howard, Bart", "Fly Me to the Moon (In Other Words)");

replace into Composers_Songs (composer, title) values ("Howard, Joe E.", "Hello! Ma Baby");
replace into Lyricists_Songs (lyricist, title) values ("Howard, Joe E.", "Hello! Ma Baby");

replace into Composers_Songs (composer, title) values ("Emerson, Ida", "Hello! Ma Baby");
replace into Lyricists_Songs (lyricist, title) values ("Emerson, Ida", "Hello! Ma Baby");

replace into Composers_Songs (composer, title) values ("Hupfeld, Herman", "As Time Goes By");
replace into Lyricists_Songs (lyricist, title) values ("Hupfeld, Herman", "As Time Goes By");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Corcovado");
replace into Lyricists_Songs (lyricist, title) values ("Jobim, Antonio Carlos", "Corcovado");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos",  "Este Seu Olhar");
replace into Lyricists_Songs (lyricist, title) values ("Jobim, Antonio Carlos",  "Este Seu Olhar");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Desafinado");
replace into Lyricists_Songs (lyricist, title) values ("Jobim, Antonio Carlos", "Desafinado");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "O Nosso Amor (Carnival Samba)");
replace into Lyricists_Songs (lyricist, title) values ("Jobim, Antonio Carlos", "O Nosso Amor (Carnival Samba)");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Samba do Avi{\\~a}o");
replace into Lyricists_Songs (lyricist, title) values ("Jobim, Antonio Carlos", "Samba do Avi{\\~a}o");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Wave");
replace into Lyricists_Songs (lyricist, title) values ("Jobim, Antonio Carlos", "Wave");

replace into Composers_Songs (composer, title) values ("Kellette, John", "I'm Forever Blowing Bubbles");
replace into Lyricists_Songs (lyricist, title) values ("Kellette, John", "I'm Forever Blowing Bubbles");

replace into Composers_Songs (composer, title) values ("Brockman, James", "I'm Forever Blowing Bubbles");
replace into Lyricists_Songs (lyricist, title) values ("Brockman, James", "I'm Forever Blowing Bubbles");

replace into Composers_Songs (composer, title) values ("Vincent, Nat", "I'm Forever Blowing Bubbles");
replace into Lyricists_Songs (lyricist, title) values ("Vincent, Nat", "I'm Forever Blowing Bubbles");

replace into Composers_Songs (composer, title) values ("Kahn, Gus", "Toot Toot Tootsie, Goo'bye");
replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Toot Toot Tootsie, Goo'bye");

replace into Composers_Songs (composer, title) values ("Erdman, Ernie", "Toot Toot Tootsie, Goo'bye");
replace into Lyricists_Songs (lyricist, title) values ("Erdman, Ernie", "Toot Toot Tootsie, Goo'bye");

replace into Composers_Songs (composer, title) values ("Russo, Dan", "Toot Toot Tootsie, Goo'bye");
replace into Lyricists_Songs (lyricist, title) values ("Russo, Dan", "Toot Toot Tootsie, Goo'bye");

replace into Composers_Songs (composer, title) values ("Fiorito, Ted", "Toot Toot Tootsie, Goo'bye");
replace into Lyricists_Songs (lyricist, title) values ("Fiorito, Ted", "Toot Toot Tootsie, Goo'bye");

replace into Composers_Songs (composer, title) values ("Kendis, James", "I'm Forever Blowing Bubbles");
replace into Lyricists_Songs (lyricist, title) values ("Kendis, James", "I'm Forever Blowing Bubbles"); 

replace into Composers_Songs (composer, title) values ("Lecuona, Ernesto", "Siempre en mi Coraz{\\'o}n");
replace into Lyricists_Songs (lyricist, title) values ("Lecuona, Ernesto", "Siempre en mi Coraz{\\'o}n");

replace into Composers_Songs (composer, title) values ("Lecuona, Ernesto", "Siboney");
replace into Lyricists_Songs (lyricist, title) values ("Lecuona, Ernesto", "Siboney");

replace into Composers_Songs (composer, title) values ("Lecuona, Ernesto", "So{\\~n}e que me dejabas");
replace into Lyricists_Songs (lyricist, title) values ("Lecuona, Ernesto", "So{\\~n}e que me dejabas");

replace into Composers_Songs (composer, title) values ("Loesser, Frank", "Standing on the Corner");
replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Standing on the Corner");

replace into Composers_Songs (composer, title) values ("Loesser, Frank", "On a Slow Boat to China");
replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "On a Slow Boat to China");

replace into Composers_Songs (composer, title) values ("Mahler, Gustav", "Antonius von Padua Fischpredigt, Des");
replace into Composers_Songs (composer, title) values ("Mahler, Gustav", "Irdische Leben, Das");
replace into Composers_Songs (composer, title) values ("Mahler, Gustav", "Lob des hohen Verstandes");
replace into Composers_Songs (composer, title) values ("Mahler, Gustav", "Rheinlegendchen");
replace into Composers_Songs (composer, title) values ("Mahler, Gustav", "Wer hat das Liedlein erdacht?");

replace into Lyricists_Songs (lyricist, title) values ("Anonymous;  Mahler, Gustav",
"Antonius von Padua Fischpredigt, Des");
replace into Lyricists_Songs (lyricist, title) values ("Anonymous;  Mahler, Gustav", "Irdische Leben, Das");
replace into Lyricists_Songs (lyricist, title) values ("Anonymous;  Mahler, Gustav", "Lob des hohen Verstandes");
replace into Lyricists_Songs (lyricist, title) values ("Anonymous;  Mahler, Gustav", "Rheinlegendchen");
replace into Lyricists_Songs (lyricist, title) values ("Anonymous;  Mahler, Gustav", "Wer hat das Liedlein erdacht?");

replace into Composers_Songs (composer, title) values ("Morgan, Russ", "You're Nobody 'Til Somebody Loves You");
replace into Composers_Songs (composer, title) values ("Stock, Larry", "You're Nobody 'Til Somebody Loves You");
replace into Composers_Songs (composer, title) values ("Cavanaugh, James", "You're Nobody 'Til Somebody Loves You");

replace into Lyricists_Songs (lyricist, title) values ("Morgan, Russ", "You're Nobody 'Til Somebody Loves You");
replace into Lyricists_Songs (lyricist, title) values ("Stock, Larry", "You're Nobody 'Til Somebody Loves You");
replace into Lyricists_Songs (lyricist, title) values ("Cavanaugh, James", "You're Nobody 'Til Somebody Loves You");

replace into Composers_Songs (composer, title) values ("Noble, Ray", "Very Thought of You, The");
replace into Lyricists_Songs (lyricist, title) values ("Noble, Ray", "Very Thought of You, The");

-- delete from Composers_Songs where composer = "O'Sullivan, Gilbert";
-- delete from Lyricists_Songs where lyricist = "O'Sullivan, Gilbert";

select * from Composers_Songs where title = "Claire";

select * from Composers_Songs where title = "Alone Again (Naturally)";

select * from Composers_Songs where composer = "O'Sullivan, Gilbert";
select * from Lyricists_Songs where lyricist = "O'Sullivan, Gilbert";

replace into Composers_Songs (composer, title) values ("O'Sullivan, Gilbert (Ray Gilbert)", "Claire");
replace into Lyricists_Songs (lyricist, title) values ("O'Sullivan, Gilbert (Ray Gilbert)", "Claire");

replace into Composers_Songs (composer, title) values ("O'Sullivan, Gilbert (Ray Gilbert)", "Alone Again (Naturally)");
replace into Lyricists_Songs (lyricist, title) values ("O'Sullivan, Gilbert (Ray Gilbert)", "Alone Again (Naturally)");

replace into Composers_Songs (composer, title) values ("P{\\'e}rez Prado, D{\\'a}maso", "Mambo {\\#}5");
replace into Lyricists_Songs (lyricist, title) values ("P{\\'e}rez Prado, D{\\'a}maso", "Mambo {\\#}5");

replace into Composers_Songs (composer, title) values ("Parks, C.~Carson", "Somethin' Stupid");
replace into Lyricists_Songs (lyricist, title) values ("Parks, C.~Carson", "Somethin' Stupid");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "Begin the Beguine");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "Begin the Beguine");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "It's De-Lovely");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "It's De-Lovely");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "I've Got You Under My Skin");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "I've Got You Under My Skin");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "Just One of Those Things");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "Just One of Those Things");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "Love for Sale");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "Love for Sale");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "Every Time We Say Goodbye");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "Every Time We Say Goodbye");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "I Get a Kick Out of You");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "I Get a Kick Out of You");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "Night and Day");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "Night and Day");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "It's All Right With Me");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "It's All Right With Me");

replace into Composers_Songs (composer, title) values ("Reid, Billy", "I'll Close My Eyes");
replace into Lyricists_Songs (lyricist, title) values ("Reid, Billy", "I'll Close My Eyes");

replace into Composers_Songs (composer, title) values ("Reid, Billy", "It's a Pity to Say `Goodnight'");
replace into Lyricists_Songs (lyricist, title) values ("Reid, Billy", "It's a Pity to Say `Goodnight'");

replace into Composers_Songs (composer, title) values ("Seiler, Eddie",    "I Don't Want to Set the World on Fire");
replace into Lyricists_Songs (lyricist, title) values ("Seiler, Eddie",    "I Don't Want to Set the World on Fire");
replace into Composers_Songs (composer, title) values ("Marcus, Sol",      "I Don't Want to Set the World on Fire");
replace into Lyricists_Songs (lyricist, title) values ("Marcus, Sol",      "I Don't Want to Set the World on Fire");
replace into Composers_Songs (composer, title) values ("Benjamin, Bennie", "I Don't Want to Set the World on Fire");
replace into Lyricists_Songs (lyricist, title) values ("Benjamin, Bennie", "I Don't Want to Set the World on Fire");
replace into Composers_Songs (composer, title) values ("Durham, Eddie",    "I Don't Want to Set the World on Fire");
replace into Lyricists_Songs (lyricist, title) values ("Durham, Eddie",    "I Don't Want to Set the World on Fire");

replace into Composers_Songs (composer, title) values ("Wayne, Bernie", "Blue Velvet");
replace into Lyricists_Songs (lyricist, title) values ("Wayne, Bernie", "Blue Velvet");

replace into Composers_Songs (composer, title) values ("Morris, Lee", "Blue Velvet");
replace into Lyricists_Songs (lyricist, title) values ("Morris, Lee", "Blue Velvet");

replace into Composers_Songs (composer, title) values ("Williams, Hank", "Hey, Good Lookin'");
replace into Lyricists_Songs (lyricist, title) values ("Williams, Hank", "Hey, Good Lookin'");

replace into Composers_Songs (composer, title) values ("Wynette, Tammy", "Stand By Your Man");
replace into Lyricists_Songs (lyricist, title) values ("Wynette, Tammy", "Stand By Your Man");

replace into Composers_Songs (composer, title) values ("Sherrill, Billy", "Stand By Your Man");
replace into Lyricists_Songs (lyricist, title) values ("Sherrill, Billy", "Stand By Your Man");

replace into Composers_Songs (composer, title) values ("Weiss, George David", "What a Wonderful World");
replace into Lyricists_Songs (lyricist, title) values ("Weiss, George David", "What a Wonderful World");
replace into Composers_Songs (composer, title) values ("Thiele, Bob", "What a Wonderful World");
replace into Lyricists_Songs (lyricist, title) values ("Thiele, Bob", "What a Wonderful World");

replace into Composers_Songs (composer, title) values ("Williams, Cootie", "'Round Midnight");
replace into Lyricists_Songs (lyricist, title) values ("Williams, Cootie", "'Round Midnight");
replace into Composers_Songs (composer, title) values ("Monk, Thelonius", "'Round Midnight");
replace into Lyricists_Songs (lyricist, title) values ("Monk, Thelonius", "'Round Midnight");

/* * (1)  Composers and Lyricists */

-- !!! START HERE:  The following code contains errors.  It hasn't (all) been evaluated.
-- LDF 2021.05.11.

**********************************************************************************************

replace into Lyricists (name, name_reverse, birth_date, death_date)
values ("Joseph-McCarthy", "McCarthy, Joseph", '1885-09-27', '1943-12-18');

replace into Composers (name, name_reverse, birth_date, death_date)
values ("Harry Austin Tierney", "Tierney, Harry Austin", '1890-05-21', '1965-03-22');

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Louis \"Lou\" Silvers", "Silvers, Louis \"Lou\"",
'1889-09-6',  '1954-03-26');

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("George Gard \"Buddy\" DeSylva", "DeSylva, George Gard \"Buddy\"",
'1895-01-27', '1950-07-11');

**********************************************************************************************

replace into Composers (name, name_reverse, alternative_name, alternative_name_reverse,
birth_date, death_date) 
values ("Fred Fisher", "Fisher, Fred", "Alfred Breitenbach", "Breitenbach, Alfred",
'1875-09-3', '1942-01-14');

**********************************************************************************************

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Gustav \"Gus\" Gerson Kahn", "Kahn, Gustav \"Gus\" Gerson",
'1886-11-6', '1941-10-8');

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Walter Donaldson", "Donaldson, Walter",
'1893-02-15', '1947-07-15');

**********************************************************************************************

-- "The Charleston" is a jazz composition that was written to accompany
-- the Charleston dance. It was composed in 1923, with lyrics by Cecil
-- Mack and music by James P. Johnson,

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Cecil Mack", "Mack, Cecil", '1873-11-6', '1944-08-1');

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("James Price Johnson", "Johnson, James Price",
'1894-02-1', '1955-11-17'); 

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Joseph Meyer", "Meyer, Joseph", '1894-03-12', '1987-06-22');

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Alexander \"Al\" Dubin", "Dubin, Alexander \"Al\"", '1891-06-10', '1945-02-11');

replace into Lyricists (name, name_reverse, alternative_name, alternative_name_reverse, 
birth_date, death_date) 
values ("Billy Rose", "Rose, Billy", "William Samuel Rosenberg", "Rosenberg, William Samuel",
'1899-09-6', '1966-02-10');

**********************************************************************************************

replace into Lyricists (name, name_reverse, alternative_name, alternative_name_reverse, 
birth_date, death_date) 
values ("Lew Brown", "Brown, Lew", "Louis Brownstein", "Brownstein, Louis", 
'1893-12-10', '1958-02-05');

replace into Composers (name, name_reverse, alternative_name, alternative_name_reverse, 
birth_date, death_date) 
values ("Ray Henderson", "Henderson, Ray", "Raymond Brost", "Brost, Raymond", 
'1896-12-01', '1970-12-31');

**********************************************************************************************

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Sam M. Lewis", "Lewis, Sam M.", '1885-10-25', '1959-11-22'); 

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Joe Young", "Young, Joe", '1889-07-04', '1939-04-21');

**********************************************************************************************

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Noble Lee Sissle", "Sissle, Noble Lee", '1889-07-10', '1975-12-17');

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("James Hubert \"Eubie\" Blake", "Blake, James Hubert \"Eubie\"",
'1887-02-07', '1983-02-12');

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date, notes) 
values ("Benny Davis", "Davis, Benny", '1895-08-21', '1979-12-20',
"Not sure whether Benny Davis is composer, lyricist or both.");

replace into Lyricists (name, name_reverse, birth_date, death_date, notes) 
values ("Benny Davis", "Davis, Benny", '1895-08-21', '1979-12-20',
"Not sure whether Benny Davis is composer, lyricist or both.");

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Milton Ager", "Ager, Milton", '1893-10-6', '1979-05-6');

-- replace into Lyricists (name, name_reverse, birth_date, death_date) 
-- values ("Jack Selig Yellen", "Jacek Jele{\\'n}" '1892-07-6', '1991-04-17');

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Lester Santly", "Santly, Lester", null, null);

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Charles Rudolf Friml", "Friml, Charles Rudolf",
'1879-12-7', '1972-11-12');

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Herbert Pope Stothart", "Stothart, Herbert Pope",  '1885-09-11', '1949-02-1');

replace into Lyricists (name, name_reverse, alternative_name, alternative_name_reverse,
birth_date, death_date) 
values ("Otto Abels Harbach", "Harbach, Otto Abels", 
"Otto Abels Hauerbach", "Hauerbach, Otto Abels",  '1873-08-18', '1963-01-24');

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Oscar Greeley Clendenning Hammerstein II", "Hammerstein II, Oscar Greeley Clendenning",
'1895-07-12', '1960-08-23');

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Isham Edgar Jones", "Jones, Isham Edgar",  '1894-01-31', '1956-10-19');

**********************************************************************************************

replace into Composers (name, name_reverse, alternative_name, alternative_name_reverse,
birth_date, death_date) 
values ("George Gershwin", "Gershwin, George",
"Jacob Bruskin Gershowitz", "Gershowitz, Jacob Bruskin",
'1898-09-26', '1937-07-11');

replace into Lyricists (name, name_reverse, alternative_name, alternative_name_reverse,
birth_date, death_date) 
values ("Ira Gershwin", "Gershwin, Ira",  "Israel Gershowitz", "Gershowitz, Israel",
'1896-12-6', '1983-08-17');
 

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Richard Charles Rodgers", "Rodgers, Richard Charles",  '1902-06-28', '1979-12-30');

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Lorenz Milton Hart", "Hart, Lorenz Milton",  '1895-05-2', '1943-11-22');

**********************************************************************************************

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Edward Madden", "Madden, Edward",  '1878-07-17', '1952-03-11'); 

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Percy Wenrich", "Wenrich, Percy",  '1887-01-23', '1952-03-17'); 

**********************************************************************************************

replace into Lyricists (name, name_reverse) 
values ("Ernie Erdman", "Erdman, Ernie");

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Elmer Schoebel", "Schoebel, Elmer",  '1896-09-8', '1970-12-14');

replace into Composers (name, name_reverse)
values ("Billy Meyers", "Meyers, Billy"); 

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Isham Edgar Jones", "Jones, Isham Edgar",  '1894-01-31', '1956-10-19');

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Jean Schwartz", "Schwartz, Jean",  '1878-11-4', '1956-11-30');

delete from Lyricists where name = "Sam M. Lewis";

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Sam M. Lewis", " Lewis, Sam M.",  '1885-10-25', '1959-11-22'); 

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Joe Young", "Young, Joe",  '1889-07-4', '1939-04-21'); 

**********************************************************************************************

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Harry Bache Smith", "Smith, Harry Bache",  '1860-12-28', '1936-01-1');

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Theodore Frank Snyder", "Snyder, Theodore Frank",  
'1881-08-15', '1965-07-16');

replace into Lyricists (name, name_reverse) 
values ("Francis Wheeler", "Wheeler, Francis");

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Vincent Millie Youmans", "Youmans, Vincent Millie",  '1898-09-27', '1946-04-5');

replace into Lyricists (name, name_reverse, alternative_name, alternative_name_reverse, 
birth_date, death_date) 
values ("Irving Caesar", "Caesar, Irving",  "Isidor Keiser", "Keiser, Isidor",  
'1895-07-4', '1996-12-18');

**********************************************************************************************

replace into Composers (name, name_reverse, alternative_name, alternative_name_reverse, 
birth_date, death_date) 
values ("Jos{\\\'e} Gomes de Abreu", "Abreu, Jos{\\\'e} Gomes de",  
"Zequinha de Abreu", "Abreu, Zequinha de", 
'1880-09-19', '1935-01-22');

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date, notes) 
values ("Dan \"Danny\" Russo", "Russo, Dan \"Danny\"",
'1885-10-13', '1944-12-15', "I think Danny Russo was a composer, but I'm not sure.");

replace into Lyricists (name, name_reverse) 
values ("Ernie Erdman", "Erdman, Ernie");

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("Cole Albert Porter", "Porter, Cole Albert",  '1891-06-9', '1964-10-15');

**********************************************************************************************

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Edwin Eugene Lockhart", "Lockhart, Edwin Eugene",  '1891-07-18', '1957-03-31');

replace into Composers (name, name_reverse, alternative_name, alternative_name_reverse, 
birth_date, death_date) 
values ("Ernest Joseph Seitz", "Seitz, Ernest Joseph",  "Raymond Roberts", "Roberts, Raymond",  
'1892-02-29', '1978-09-10'); 

**********************************************************************************************

replace into Composers (name, name_reverse, birth_date, death_date) 
values ("James Vincent Monaco", "Monaco, James Vincent",  '1885-01-13', '1945-10-16');

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Joseph McCarthy", "McCarthy, Joseph",  '1885-09-27', '1943-12-18'); 

**********************************************************************************************

/* * (1)  */

select name_reverse, name, alternative_name, birth_date, death_date, notes
from Composers order by name_reverse\G

select name_reverse, name, alternative_name, alternative_name_reverse,
birth_date, death_date, notes from Lyricists order by name_reverse\G

/* * (1)  */

delete from Composers_Songs;
delete from Lyricists_Songs;

select * from Composers_Songs order by composer, title;

select * from Lyricists_Songs order by lyricist, title;

select distinct composer from Composers_Songs order by composer;

select distinct lyricist from Lyricists_Songs order by lyricist;

select title, lead_sheet, year, copyright from Songs where year <= 1924 order by title;

select title, musical, film, revue, opera, operetta, year from Songs where musical is not null or film is not null 
or opera is not null or operetta is not null or revue is not null order by title\G

select musical, title, music, words, words_and_music, year from Songs where musical is not null 
and music = "Kurt Weill" order by year;


/* * (1)  */

select "$$$ Productions";

replace into Productions (typename, title) values ("film", "42nd Street (Film)");

replace into Productions (typename, title) values ("film", "Belle of the Nineties");

replace into Productions (typename, title) values ("film", "Big Broadcast of 1938, The");

replace into Productions (typename, title) values ("film", "Breakfast at Tiffany's");

replace into Productions (typename, title) values ("film", "Broadway Melody, The");

replace into Productions (typename, title) values ("film", "Carefree");

replace into Productions (typename, title) values ("film", "Cover Girl");

replace into Productions (typename, title) values ("film", "Dames");

replace into Productions (typename, title) values ("film", "Damsel in Distress, A");

replace into Productions (typename, title) values ("film", "Day at the Races, A");

replace into Productions (typename, title) values ("film", "Destry Rides Again");

replace into Productions (typename, title) values ("film", "Every Night at Eight");

replace into Productions (typename, title) values ("film", "Follow the Fleet");

replace into Productions (typename, title) values ("film", "Gay Divorcee, The");

replace into Productions (typename, title) values ("film", "Gigi");

replace into Productions (typename, title) values ("film", "Godfather, The");

replace into Productions (typename, title) values ("film", "Going Hollywood");

replace into Productions (typename, title) values ("film", "Going My Way");

replace into Productions (typename, title) values ("film", "Gold Diggers of 1933");

replace into Productions (typename, title) values ("film", "Gold Diggers of 1935");

replace into Productions (typename, title) values ("film", "Green Dolphin Street");

replace into Productions (typename, title) values ("film", "Guys and Dolls (Film)");

replace into Productions (typename, title) values ("film", "Homme et une femme, Un");

replace into Productions (typename, title) values ("film", "Laura");

replace into Productions (typename, title) values ("film", "Love Me Tonight");

replace into Productions (typename, title) values ("film", "Melody for Two");

replace into Productions (typename, title) values ("film", "Mondo Cane");

replace into Productions (typename, title) values ("film", "Night at the Opera, A");

replace into Productions (typename, title) values ("film", "One Minute to Zero");

replace into Productions (typename, title) values ("film", "Orfeu Negro");

replace into Productions (typename, title) values ("film", "Ride 'Em Cowboy");

replace into Productions (typename, title) values ("film", "Roman Scandals");

replace into Productions (typename, title) values ("film", "Sandpiper, The");

replace into Productions (typename, title) values ("film", "Shall We Dance");

replace into Productions (typename, title) values ("film", "Some Like It Hot");

replace into Productions (typename, title) values ("film", "Swing Time");

replace into Productions (typename, title) values ("film", "Tammy and the Bachelor");

replace into Productions (typename, title) values ("film", "Thanks for the Memory");

replace into Productions (typename, title) values ("film", "Top Hat");

replace into Productions (typename, title) values ("film", "Vogues of 1938");

replace into Productions (typename, title) values ("film", "Wizard of Oz, The");

replace into Productions (typename, title) values ("opera", "Contes d'Hoffmann, Les");

replace into Productions (typename, title) values ("opera", "Don Giovanni");

replace into Productions (typename, title) values ("opera", "Elisir d’amore, L’");

replace into Productions (typename, title) values ("opera", "Freisch@{u}tz, Der");

replace into Productions (typename, title) values ("opera", "Porgy and Bess");

replace into Productions (typename, title) values ("opera", "Prince Igor");

replace into Productions (typename, title) values ("opera", "P{\^e}cheurs de perles, Les");

replace into Productions (typename, title) values ("opera", "Zauberfl@{o}te, Die");

replace into Productions (typename, title) values ("revue", "Walk a Little Faster");

replace into Productions (typename, title) values ("revue", "Ziegfeld Follies (1908)");

replace into Productions (typename, title) values ("revue", "Ziegfeld Follies 1927");

replace into Productions (typename, title) values ("revue", "Ziegfeld Follies of 1934");

replace into Productions (typename, title) values ("musical", "Annie Get Your Gun");

replace into Productions (typename, title) values ("musical", "Anything Goes");

replace into Productions (typename, title) values ("musical", "As Thousands Cheer");

replace into Productions (typename, title) values ("musical", "Babes in Arms");

replace into Productions (typename, title) values ("musical", "Bells are Ringing");

replace into Productions (typename, title) values ("musical", "Blackbirds of 1930");

replace into Productions (typename, title) values ("musical", "Bombo");

replace into Productions (typename, title) values ("musical", "Boys from Syracuse, The");

replace into Productions (typename, title) values ("musical", "Cabaret");

replace into Productions (typename, title) values ("musical", "Cabin in the Sky");

replace into Productions (typename, title) values ("musical", "Camelot");

replace into Productions (typename, title) values ("musical", "Carnival in Flanders");

replace into Productions (typename, title) values ("musical", "Chorus Line, A");

replace into Productions (typename, title) values ("musical", "Connecticut Yankee, A");

replace into Productions (typename, title) values ("musical", "Conversation Piece");

replace into Productions (typename, title) values ("musical", "Damn Yankees");

replace into Productions (typename, title) values ("musical", "Fiorello!");

replace into Productions (typename, title) values ("musical", "Garrick Gaities");

replace into Productions (typename, title) values ("musical", "Gentlemen Prefer Blondes");

replace into Productions (typename, title) values ("musical", "Guys and Dolls");

replace into Productions (typename, title) values ("musical", "Gypsy");

replace into Productions (typename, title) values ("musical", "Higher and Higher");

replace into Productions (typename, title) values ("musical", "I Married an Angel");

replace into Productions (typename, title) values ("musical", "Johnny Johnson");

replace into Productions (typename, title) values ("musical", "Knickerbocker Holiday");

replace into Productions (typename, title) values ("musical", "Lady in the Dark");

replace into Productions (typename, title) values ("musical", "Lost in the Stars");

replace into Productions (typename, title) values ("musical", "My Fair Lady");

replace into Productions (typename, title) values ("musical", "Oklahoma!");

replace into Productions (typename, title) values ("musical", "Oliver!");

replace into Productions (typename, title) values ("musical", "On the Town");

replace into Productions (typename, title) values ("musical", "One Touch of Venus");

replace into Productions (typename, title) values ("musical", "Paint Your Wagon");

replace into Productions (typename, title) values ("musical", "Pal Joey");

replace into Productions (typename, title) values ("musical", "Present Arms");

replace into Productions (typename, title) values ("musical", "Prince of To-Night, The");

replace into Productions (typename, title) values ("musical", "Red, Hot and Blue");

replace into Productions (typename, title) values ("musical", "Right This Way");

replace into Productions (typename, title) values ("musical", "Roberta");

replace into Productions (typename, title) values ("musical", "Showboat");

replace into Productions (typename, title) values ("musical", "Simple Simon");

replace into Productions (typename, title) values ("musical", "South Pacific");

replace into Productions (typename, title) values ("musical", "Stop the World---I Want to Get Off");

replace into Productions (typename, title) values ("musical", "Street Scene");

replace into Productions (typename, title) values ("musical", "Sweet Adeline");

replace into Productions (typename, title) values ("musical", "Very Warm for May");

replace into Productions (typename, title) values ("musical", "West Side Story");

replace into Productions (typename, title) values ("musical", "Where's Charlie?");

replace into Productions (typename, title) values ("operetta", "Fledermaus, Die");

replace into Productions (typename, title) values ("operetta", "Lustige Witwe, Die");

replace into Productions (typename, title) values ("operetta", "New Moon, The");

replace into Productions (typename, title) values ("operetta", "Zirkusprinzessin, Die");

replace into Productions (typename, title) values ("song_cycle", "14 Lieder aus Des Knaben Wunderhorn");

replace into Productions (typename, title) values ("song_cycle", "Winterreise, Die");

opera       = 1
operetta    = 2
song_cycle  = 3
musical     = 4 
revue       = 5 
film        = 6 

update Productions set type = 1 where typename = "opera";
update Productions set type = 2 where typename = "operetta";
update Productions set type = 3 where typename = "song_cycle";
update Productions set type = 4 where typename = "musical";
update Productions set type = 5 where typename = "revue";
update Productions set type = 6 where typename = "film";


update Songs set do_filecard = true where is_cross_reference = false;

update Songs set do_filecard = true where is_cross_reference = true;

select * from Productions order by title\G

select title, scanned, scanned_filename, eps_filenames from Songs where (scanned is true or length(scanned_filename) > 0) 
and length(eps_filenames) = 0 order by title\G

select title, subtitle from Songs where length(subtitle) > 0;


/* * (1)  */

/* Local Variables: */
/* mode:SQL */
/* outline-minor-mode:t */
/* outline-regexp:"/\\\* \\\*+"  */
/* End: */
