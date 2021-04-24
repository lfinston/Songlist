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

/* * (1)  */

use Songs;

/* * (1) As a user with the privilege of creating users and granting privileges (possibly `root')  */
/*       create user `songlist' and grant privileges on database `Songs' to it.                    */

create user 'songlist'@'localhost;

GRANT ALL ON Songs TO 'songlist'@'localhost';

/* ** (2) Create table `Songs'.  */

drop table Songs;

create table Songs
(
    title varchar(128) unique not null,
    words varchar(128) default null,
    music varchar(128) default null,
    words_and_music varchar(128) default null,
    lead_sheet boolean not null default false,
    partial_lead_sheet boolean not null default false,
    no_page_turns boolean not null default false,
    no_page_turns_with_two_songbooks boolean not null default false,
    arrangement_orchestra boolean not null default false,
    arrangement_solo_guitar boolean not null default false,
    recordings tinyint not null default 0,
    opera varchar(64) default null,
    operetta varchar(64) default null,
    musical varchar(64) default null,
    revue varchar(64) default null,
    film  varchar(64) default null,
    sort_by_production boolean not null default false,
    year int default null,
    copyright varchar(256) default null,
    notes varchar (512) default null
);


alter table Songs add column operetta varchar(64) default null after opera;

alter table Songs add column source varchar(128) default null after notes;

alter table Songs add column words_reverse varchar(128) default null after words;
alter table Songs add column music_reverse varchar(128) default null after music;
alter table Songs add column words_and_music_reverse varchar(128) default null after words_and_music;
alter table Songs add column scanned boolean not null default false after no_page_turns_with_two_songbooks;

alter table Songs modify column copyright varchar(256) default null;

show columns from Songs.Songs;

delete from Songs;

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


/* * (1)  Replace into `Songs'  */

/* ***************************************************** */

/* A  */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year)
values
("Abends in der Taverna", "Aldo von Pinelli", "Pinelli, Aldo von", "Werner Bochmann", "Bochmann, Werner", true, 1, 1940);
/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Ain't Misbehavin'", "Andy Razaf", "Razaf, Andy",
"Thomas ``Fats'' Waller and Harry Brooks", "Waller, Thomas ``Fats'' and Brooks, Harry",
true, 1929);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
recordings, arrangement_solo_guitar,
film)
values
("All God's Children", /* '  */
"Gus Kahn", "Kahn, Gus",
"Walter Jurmann and Bronislaw Kaper", "Jurmann, Walter and Kaper, Bronislaw",
true, 1, true, "A Day at the Races");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("All the Things You Are", "Oscar Hammerstein II", "Hammerstein II, Oscar",
"Jerome Kern", "Kern, Jerome", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Amour est bleu, L'", "Pierre Cour", "Cour, Pierre", "Andr{\\'e} Popp", "Popp, Andr{\\'e}", 
true, 1967);

replace into Songs (title, words_and_music, words_and_music_reverse, notes)
values
("Annie's Song", /* '  */
"John Denver", "Denver, John",
"\\hbox{Score for flute, b-flat clarinet, alto sax.~and tenor sax.}\\hbox{Completed 02.2018.}");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year)
values
("April Showers", "Buddy G.~De Sylva", "De Sylva, Buddy G.", "Louis Silvers", "Silvers, Louis",
true, 1, 1921);

/* ***************************************************** */

replace into Songs (title, lead_sheet, words_and_music, words_and_music_reverse, year)
values
("As Time Goes By", true, "Herman Hupfeld", "Hupfeld, Herman", 1931);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year)
values
("Autumn in New York", "Vernon Duke", "Duke, Vernon", true, 1934);

/* ******************************************************/

/* B  */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, recordings)
values
("Baby, It's Cold Outside", "Frank Loesser", "Frank, Loesser", true, 1 /* '  */); 

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, opera, year)
values
("Barcarole", "Jules Barbier", "Barbier, Jules", "Jacques Offenbach", "Offenbach, Jacques", true,
"Les contes d'Hoffmann", 1881);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, source)
values
("Begin the Beguine", "Cole Porter", "Porter, Cole", true, 1935, 
"{\\copyright} 1935 (Renewed) Warner Bros.~Inc.", "{\\bf The Best of Cole Porter}, p.~30");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
recordings, no_page_turns, year)
values
("Bel Ami", "Hans Fritz Beckmann", "Beckmann, Hans Fritz", "Theo Mackeben", "Mackeben, Theo", 
true, 1, true, 1939);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, 
lead_sheet, year)
values
("Between the Devil and the Deep Blue Sea", "Ted Koehler", "Koehler, Ted", 
"Harold Arlen", "Arlen, Harold", true, 1931);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, musical, 
lead_sheet, sort_by_production)
values
("Bill", "P.G.~Wodehouse and Oscar Hammerstein II", 
"Wodehouse, P.G. and Hammerstein, Oscar II", 
"Jerome Kern", "Kern, Jerome",
"Showboat", true, true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, 
no_page_turns_with_two_songbooks)
values
("Blue Moon", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns)
values
("Blue Skies", "Irving Berlin", "Berlin, Irving", true);

/* ***************************************************** */

replace into Songs (title, lead_sheet, recordings)
values
("Blue Velvet", true, 1);

/* banjo_chord_melody present */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Body and Soul", "Edward Heymann, Frank Eyton und Robert Sour", 
"\\vbox{\\hbox{Heymann, Edward; Eyton Frank;}\\vskip-2pt\\hbox{and Sour, Robert}}", 
"John W.~Green", "Green, John W.", true);

/* ***************************************************** */

replace into Songs (title, lead_sheet)
values
("Buenos Noches Mon Amour", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, arrangement_solo_guitar, year)
values
("By a Waterfall", "Irving Kahal", "Kahal, Irving", "Sammy Fain", "Fain, Sammy", true, 1, true, 1933);

/* C   */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("Camelot", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, "Camelot", true);

/* ***************************************************** */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, recordings, year)
values
("Capri Fischer", "Ralph Maria Siegel", "Siegel, Ralph Maria", "Gerhard Winkler", "Winkler, Gerhard", 
true, 1, 1943);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Caravan", "Irving Mills", "Mills, Irving", "Duke Ellington and Juan Tizol", "Ellington, Duke and Tizol, Juan", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Carioca", "Edward Eliscu and Gus Kahn", "Eliscu, Edward and Kahn, Gus", 
"Vincent Youmans", "Youmans, Vincent", true, 1933);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Carolina in the Morning", "Gus Kahn", "Kahn, Gus", "Walter Donaldson", "Donaldson, Walter", 
true, 1922);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Chances Are", "Al Stillman", "Stillman, Al", "Robert Allen", "Allen, Robert", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Change Partners", "Irving Berlin", "Berlin, Irving", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Cheek to Cheek", "Irving Berlin", "Berlin, Irving", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Chega de Saudade", "Vin{\\'\\i}cius de Moraes", "Moraes, Vin{\\'\\i}cius de",  
"Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year)
values
("Chicago (That Toddling Town)", "Fred Fisher", "Fisher, Fred", true, 1922);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Close to You", "Hal David", "David, Hal", "Burt Bacharach", "Bacharach, Burt", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes, year, no_page_turns)
values
("Comme d'Habitude", "Gille Thibaut", "Thibaut, Gille", "Jacques Revaux and Cluade Fran{\\c c}ois",
"Revaux, Jacques and Fran{\\c c}ois, Claude",
true,
"English title: ``My Way'', English lyrics: Paul Anka", 1967, true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Cocktails for Two", "Sam Coslow", "Coslow, Sam", "Arthur Johnston", "Johnston, Arthur", true, 1934);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical, sort_by_production)
values
("Consider Yourself", "Lionel Bart", "Bart, Lionel", true, "Oliver!", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Continental, The", "Herb Magidson", "Magidson, Herb", "Con Conrad", "Conrad, Con", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Coquette", "Gus Kahn", "Kahn, Gus", "John W.~Green and Carmen Lombardo",
"Green, John W.~and Lombardo, Carmen", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, film, 
no_page_turns_with_two_songbooks)
values
("Cosi Cosa", "Ned Washington", "Washington, Ned", "Walter Jurmann and Bronislaw Kaper",
"Jurmann, Walter and Kaper, Bronislaw",
true, 1935,
"Night at the Opera, A", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Cup of Coffee, a Sandwich and You, A", "Al Dubin and Billy Rose", "Dubin, Al and Rose, Billy",
"Joseph Meyer", "Meyer, Joseph", true, 1925);

/* D */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, scanned, operetta, sort_by_production, year)
values
("Da geh ich zu Maxim", "Victor L{\\'e}on und Leo Stein", "L{\\'e}on, Victor und Stein, Leo",
"Franz Leh{\\'a}r", "Leh{\\'a}r, Franz", true, true, "Lustige Witwe, Die", true, 1905);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Deep Purple", "Mitchell Parish", "Parish, Mitchell", "Peter DeRose", "DeRose, Peter", true, 1939);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Do You Know the Way to San Jose?", "Hal David", "David, Hal", "Burt Bacharach", "Bacharach, Burt", true, 1967);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, copyright, recordings)
values
("Downtown", "Tony Hatch", "Hatch, Tony", true, 
"\\hbox{1964 Welbeck Music Ltd.,}\\hbox{London, England}",
1);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year, copyright)
values
("Dream a Little Dream of Me", "Gus Kahn", "Kahn, Gus",
"Fabian Andre and Wilbur Schwandt", "Andre, Fabian and Schwandt, Wilbur", true, 1, 1931,
"{\\copyright} 1931 Davis, Coots and Engel");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, year, no_page_turns, source)
values
("Du sollst der Kaiser meiner Seele sein",
"Fritz Gr{\\\"u}nbaum und Wilhelm Sterk", "Gr{\\\"u}nbaum, Fritz und Sterk, Wilhelm",
"Robert Stolz", "Stolz, Robert",
1916, true, "Das neue Operettenbuch, Buch 1");

/* ***************************************************** */

delete from Songs where title = "Durch die Wälder, durch die Auen";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, copyright, opera)
values
("Durch die W{\\\"a}lder, durch die Auen", "Friedrich Kind", "Kind, Friedrich", "Carl Maria von Weber", "Weber, Carl Maria von",
true, "Public Domain", "Freisch{\\\"u}tz, Der");

/* ***************************************************** */

/* E   */

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, partial_lead_sheet, year)
values
("East of the Sun (and West of the Moon)", "Brooks Bowman", "Bowman, Brooks", true, true, 1934);

/* East of the Sun has both a lead sheet and a partial lead sheet!  */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Embraceable You", "Ira Gershwin", "Gershwin, Ira", "George Gershwin", "Gershwin, George", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, recordings)
values
("Es leuchten die Sterne", "Bruno Balz", "Balz, Bruno", "Leo Leux", "Leux, Leo", 1);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Every Time We Say Goodbye", "Cole Porter", "Porter, Cole", true);

/* ***************************************************** */

/* F   */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, year)
values
("Feuilles Mortes, Les", "Jacques Prevert", "Prevert, Jacques", "Joseph Kosma", "Kosma, Joseph", true, 1947);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Fine and Dandy", "Paul James (James Paul Warburg)", "James, Paul (Warburg, James Paul)",
"Kay Swift", "Swift, Kay", true, 1930);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Fine Romance, A", "Dorothy Fields", "Fields, Dorothy", "Jerome Kern", "Kern, Jerome", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns_with_two_songbooks)
values
("Fly Me to the Moon", "Bart Howard", "Howard, Bart", true);

/* ***************************************************** */

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

select * from Songs where words = "Sam M.~Lewis and Joe Widow Young";
select * from Songs where music = "Ray Henderson";



insert ignore into Songs (title, source) values
("Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)", 
"{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

select * from Songs where music = "Ray Henderson"\G

select * from Songs where title = "Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)"\G

delete from Songs where music = "Ray Henderson";

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Five Foot Two, Eyes Of Blue\\par\\S (Has Anybody Seen My Girl?)",
"Sam M.~Lewis and Joe Young", "Lewis, Sam M.~and Young, Joe",
"Ray Henderson", "Henderson, Ray", true, 1925); 

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, copyright)
values
("Fools Rush In (Where Angels Fear to Tread)", "Johnny Mercer", "Mercer, Johnny",
"Rube Bloom", "Bloom, Rube", true,
"{\\copyright} 1940 WB Music Corp.~(Renewed)");

/* ***************************************************** */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, recordings, year)
values
("Frauen sind keine Engel", "Hans Fritz Beckmann", "Beckmann, Hans Fritz", "Theo Mackeben", "Mackeben, Theo", true, 1, 1944);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse)
values
("Frenesi", "Alberto Dom{\\'\\i}nguez Borr{\\'a}s", "Dom{\\'\\i}nguez Borr{\\'a}s, Alberto");

/* G   */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("Georgia on my Mind", "Stuart Gorrell", "Gorrell, Stuart", "Hoagy Carmichael", "Carmichael, Hoagy", true, 1);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, copyright)
values
("Georgy  Girl", "Tom Springfield", "Springfield, Tom", "Jim Dale", "Dale, Jim", true,
"\\hbox{1966 and 1967 Springfield Music Ltd., London.}\\hbox{Chapell \\& Co., Inc., publisher.}");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, film)
values
("Gigi", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, "Gigi");

/* H   */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes)
values
("Harbour Lights", "Jimmy Kennedy", "Kennedy, Jimmy", "Hugh Williams", "Williams, Hugh", true,
"Hugh Williams is the pseudonym of exiled Austrian composer Will Grosz.");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns_with_two_songbooks)
values
("Heart and Soul", "Frank Loesser", "Loesser, Frank", "Hoagy Carmichael", "Carmichael, Hoagy", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Heartaches", "John Klenner", "Klenner, John", "Al Hoffmann", "Hoffmann, Al", true, 1931);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, musical)
values
("Heat Wave", "Irving Berlin", "Berlin, Irving", true, 1933, "{\\copyright} 1933 (Renewed)",
"As Thousands Cheer");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, year)
values
("Heute Nacht oder nie", "Marcellus Schiffer", "Schiffer, Marcellus", "Mischa Spoliansky", "Spoliansky, Mischa", true, 1932);

/* recordings 1 ? Not found. */

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Hey, Good Lookin'", "Hank Williams", "Williams, Hank", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("Homme et une femme, Un", "Pierre Barouh", "Barouh, Pierre", "Francis Lai", "Lai, Francis", true, "Homme et une femme, Un");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Hooray For Hollywood", "Johnny Mercer", "Mercer, Johnny", "Richard A.~Whiting", "Whiting, Richard A.", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("How About You?", "Ralph Freed", "Freed, Ralph", "Burton Lane", "Lane, Burton", true);

/* banjo chords accomp.  */

/* I   */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year, copyright)
values
("I Can Dream, Can't I?", "Irving Kahal", "Kahal, Irving", "Sammy Fain", "Fain, Sammy", true,
"Right This Way", 1937, "{\\copyright} 1937 by Chappell \\& Co. Copyright Renewed");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("I Can't Get Started", "Ira Gershwin", "Gershwin, Ira", "Vernon Duke", "Duke, Vernon", true);

/* ***************************************************** */value

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("I Could Have Danced All Night", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, 1);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("I Cover the Waterfront", "Edward Heyman", "Heyman, Edward", "John W.~Green", "Green, John W.", true, 1);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("I Don't Know Why (I Just Do)", "Roy Turk", "Turk, Roy", "Fred E.~Ahlert", "Ahlert, Fred E.", true, 1931);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical)
values
("I Feel Pretty", "Stephen Sondheim", "Sondheim, Stephen", "Leonard Bernstein", "Bernstein, Leonard", true,  "West Side Story");

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical)
values
("I Get a Kick Out of You", "Cole Porter", "Porter, Cole", true, "Anything Goes");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical)
values
("I Married an Angel", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true, "I Married an Angel");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("I Only Have Eyes for You", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, "Dames");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("I Say a Little Prayer", "Hal David", "David, Hal", "Burt Bacharach", "Bacharach, Burt", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("I Talk to the Trees", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, "Paint Your Wagon", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright)
values
("If Love Were All", "No{\\\"e}l Coward", "Coward, No{\\\"e}l",  true, 1929, "{\\copyright} 1929 (Renewed).");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("If I Should Ever Leave You", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true,
"Camelot", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year, copyright)
values
("I'll Be Seeing You", "Irving Kahal", "Kahal, Irving", "Sammy Fain", "Fain, Sammy", true,
"Right This Way", 1938, "{\\copyright} 1938 by Williamson Music Co.~(Renewed).");

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, copyright, year)
values
("I'll Close My Eyes", "Billy Reid", "Reid, Billy", true, "{\\copyright} 1945.", 1945);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes)
values
("I'll Never Fall in Love Again", "Hal David", "David, Hal", "Burt Bacharach", "Bacharach, Burt", true,
"Keys:  E$\\flat$ (original) and D.");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("I'll Remember April", "Patricia Johnston and Don Raye", "Johnston, Patricia and Raye, Don", 
"Gene de Paul", "Paul, Gene de", true, 1);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, source)
values
("I'll See You Again", "No{\\\"e}l Coward", "Coward, No{\\\"e}l",  true, 1929, "{\\copyright} 1929 (Renewed).",
"{\\bf Sir No{\\\"e}l Coward, His Words and Music}, p.~34");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("I'll See You in My Dreams", "Gus Kahn", "Kahn, Gus", "Isham Jones", "Jones, Isham", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("I'll String Along With You", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, 1934);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, notes, arrangement_solo_guitar, year)
values
("Illusions", "Friedrich Hollaender", "Hollaender, Friedrich", true, "Score but no lead sheet!", true, 1948);

/* mark_blue  */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("I'm in the Mood for Love", "Dorothy Fields", "Fields, Dorothy", "Jimmy McHugh", "McHugh, Jimmy", true, 1);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, notes)
values
("I'm Shooting High", "Ted Koehler and Charles Wilmott", "Koehler, Ted and Wilmott, Charles",
"Jimmy McHugh", "McHugh, Jimmy", true, 1935, "Additional words by Charles Wilmott");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns_with_two_songbooks)
values
("Imagination", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("In a Sentimental Mood", "Manny Kurtz, Irving Mills", "Kurtz, Manny and Mills, Irving", "Duke Ellington", "Ellington, Duke", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Isn't It Romantic?", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Isn't This a Lovely Day?", "Irving Berlin", "Berlin, Irving", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("It Could Happen to You", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true);


/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("It Had to be You", "Gus Kahn", "Kahn, Gus", "Isham Jones", "Jones, Isham", true, 1924);

 
/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("It's a Pity to Say Goodnight", "Billy Reid", "Reid, Billy", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("It's All Right With Me", "Cole Porter", "Porter, Cole", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("It's Not For Me to Say", "Al Stillman", "Stillman, Al", "Robert Allen", "Allen, Robert", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source)
values
("I've Got a Pocketful of Dreams", "Johnny Burke", "Burke, Johnny", "James V.~Monaco", "Monaco, James V.", true, 1938,
"Classic Songs of Johnny Burke, Hollywood's Songwriter, p.~41");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("I've Got the World on a String", "Ted Koehler", "Koehler, Ted", "Harold Arlen", "Arlen, Harold",
true, 1932);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year, copyright, source)
values
("I've Got You Under My Skin", "Cole Porter", "Porter, Cole", true, 1936, 
"{\\copyright} 1936 by Chappell {\\&} Co.~ (Renewed)", "{\\bf The Best of Cole Porter}");

/* J   */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year)
values
("Ja und Nein", "Willy Dehmel", "Dehmel, Willy", "Franz Grothe", "Grothe, Franz", true, 1, 1939);

/* ***************************************************** */

/* Instrumental.  Words added later.  */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, scanned, copyright, year)  
values
("Jalousie ``Tango Tzigane'' (Jealousy)", "None", "None", "Jacob Gade", "Gade, Jacob", true, true,
"{\\copyright} 1925.  Public Domain.", 1925);

#words: Vera Bloom (Engl.)

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Japanese Sandman", "Raymond B.~Egan", "Egan, Raymond B.", "Richard A.~Whiting", "Whiting, Richard A.", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("Jeepers Creepers", "Johnny Mercer", "Mercer, Johnny", "Harry Warren", "Warren, Harry", true, 1);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("June in Janury", "Leo Robin", "Robin, Leo", "Ralph Rainger", "Rainger, Ralph", true);

/* ***************************************************** */

/* K   */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Komm, Zigany",
"Julius Brammer und Alfred Gr{\\\"u}nwald",
"Brammer, Julius und Gr{\\\"u}nwald, Alfred",
"Emmerich K{\\'a}lm{\\'a}n", "K{\\'a}lm{\\'a}n, Emmerich", true, 1932);

/* Film-Operetta:  Gr{\\\"a}fin Mariza using melodies by K\\'alman.         */
/* comment: (ungarisch: K{\\'a}lm{\\'a}n Imre;  eigentlich: Imre Koppstein  */
/* Copyright 1957                                                           */

/* L  */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, opera)
values
("L{\\`a} ci darem la mano", "Lorenzo Da Ponte", "Da Ponte, Lorenzo", "Wolfgang Amadeus Mozart",
"Mozart, Wolfgang Amadeus", 
true, "Don Giovanni");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Lady in Red, The", "Mort Dixon", "Dixon, Mort", "Allie Wrubel", "Wrubel, Allie", true, 1935);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year)
values
("Lady is a Tramp, The", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true, "Babes in Arms", 1937);

/* ***************************************************** */

/*  !!! Get lyricists!  */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, notes)
values
("Lady of Spain",
"Erell Reaves and Henry Tilsley", "Reaves, Erell and Tilsley, Henry",
"Tolchard Evans", "Evans, Tolchard", true, 1931,
"\"Erell Reaves\" is a pseudonym of Stanley J.~Damerell and Robert Hargreaves");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, arrangement_solo_guitar, notes,
copyright, film)
values
("Laura", "Johnny Mercer", "Mercer, Johnny", "David Raksin", "Raksin, David", true, true,
"Arrangement Andantino.", 
"{\\copyright} 1945 EMI Catalogue Partnership and EMI Robbins Catalog Inc., USA 
Worldwide print rights controlled by Warner Bros. Publications Inc./IMP Ltd.",
"Laura");

/* ***************************************************** */

/*  ?? Question mark in film title?  */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("Let's Call the Whole Thing Off", "Ira Gershwin", "Gershwin, Ira", "George Gershwin", "Gershwin, George", true,
"Shall We Dance");

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Let's Face the Music and Dance", "Irving Berlin", "Berlin, Irving", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, notes, year)
values
("Let's Fall in Love", "Ted Koehler", "Koehler, Ted", "Harold Arlen", "Arlen, Harold", true, "Source: The Harold Arlen Songbook", 
1933);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, scanned, operetta, notes, sort_by_production, year)
values
("Lippen schweigen", 
"Victor L{\\'e}on und Leo Stein", "L{\\'e}on, Victor und Stein, Leo",
"Franz Leh{\\'a}r", "Leh{\\'a}r, Franz", true, true, "Lustige Witwe, Die",
"English title:  The Merry Widow Waltz", true, 1905);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, scanned, operetta, sort_by_production, year)
values
("Lied vom dummen Reiter, Das", 
"Victor L{\\'e}on und Leo Stein", "L{\\'e}on, Victor und Stein, Leo",
"Franz Leh{\\'a}r", "Leh{\\'a}r, Franz", true, true,
"Lustige Witwe, Die", true, 1905);

/* ***************************************************** */

/*  Check words!! */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Lisboa Antiga", "Jos{\\'e} Galhardo", "Galhardo, Jos{\\'e}", 
"Raul Portela and Amadeu do Vale", "Portela, Raul and Vale, Amadeu do", true, 1937);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Little White Lies", "Walter Donaldson", "Donaldson, Walter", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Liza (All the Clouds'll Roll Away)", "Ira Gershwin and Gus Kahn", "Gershwin, Ira and Kahn, Gus",
"George Gershwin", "Gershwin, George", true,
1929);
/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("Long Ago (and Far Away)", "Ira Gershwin", "Gershwin, Ira", "Jerome Kern", "Kern, Jerome", true, "Cover Girl");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, year)
values
("Lost in the Stars", "Maxwell Anderson", "Anderson, Maxwell", "Kurt Weill", "Weill, Kurt", true, "Lost in the Stars",
1949);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Love for Sale", "Cole Porter", "Porter, Cole", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Love Me or Leave Me", "Gus Kahn", "Kahn, Gus", "Walter Donaldson", "Donaldson, Walter", true, 1928);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
operetta, year, copyright, source)
values
("Lover Come Back to Me", "Oscar Hammerstein II", "Hammerstein II, Oscar",
"Sigmund Romberg", "Romberg, Sigmund", true, "New Moon, The", 1928,
"{\\copyright} 1928 Warner Bros.~Inc. Copyright Renewed",
"{\\bf 100 Years of Popular Music, 1920s Volume 1}, p.~152");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("Lulu's Back in Town", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, 1);

/* M   */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("Make Believe", "Oscar Hammerstein II", "Hammerstein II, Oscar", "Jerome Kern", "Kern, Jerome", true,  "Showboat", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns_with_two_songbooks, year)
values
("Mambo {\\#}5", "D{\\'a}maso P{\\'e}rez Prado", "P{\\'e}rez Prado, D{\\'a}maso", true, 1948);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes)
values
("Manh{\\~a} da Carnaval", "Ant{\\^o}nio Maria", "Maria, Ant{\\^o}nio",
"Luiz Bonf{\\'a}", "Bonf{\\'a}, Luiz", true, "Score for Andantino completed 23.02.2018.");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("Many a New Day", "Oscar Hammerstein II", "Hammerstein II, Oscar", "Richard Rodgers", "Rodgers, Richard", true,
"Oklahoma!", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, partial_lead_sheet, operetta, year)
values
("Mein Herr Marquis", "Karl Haffner, Richard Gen{\\'e}e", "Haffner, Karl und Gen{\\'e}e, Richard", 
"Johann Strau{\\ss} (Sohn)", "Strau{\\ss} (Sohn), Johann", true, "Die Fledermaus", 1874);
 	
/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, notes)
values
("Message From the Man in the Moon, A", "Gus Kahn", "Kahn, Gus", "Walter Jurmann and Bronislaw Kaper",
"Jurmann, Walter and Kaper, Bronislaw",
true, "A Day at the Races", "Cut from film");

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, partial_lead_sheet, year)
values
("Mister Sandman", "Pat Ballard", "Ballard, Pat", true, 1954);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Misty", "Johnny Burke", "Burke, Johnny", "Errol Garner", "Garner, Errol", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, partial_lead_sheet, musical)
values
("Moon-Faced, Starry-Eyed", "Langston Hughes", "Hughes, Langston", "Kurt Weill", "Weill, Kurt", true,
"Street Scene");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright)
values
("Moonglow", "Eddie DeLange", "DeLange, Eddie", "Will Hudson and Irving Mills", "Hudson, Will and Mills, Irving", 
true, 1934, "{\\copyright} 1934 Mills Music");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source)
values
("Moonlight Bay", "Edward Madden", "Madden, Edward", "Percy Wenrich", "Wenrich, Percy", true, 1912,
"{\bf 100 Years of Popular Music, 1900s}");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Moonlight Becomes You", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Moonlight Serenade", "Mitchell Parish", "Parish, Mitchell", "Glenn Miller", "Miller, Glenn", true);



/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Mr.~Lucky", "Jay Livingston and Ray Evans", "Livingston, Jay and Evans, Ray", 
"Henry Mancini", "Mancini, Henry", true, 1960);

/* words?  */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("My Baby Just Cares for Me", "Gus Kahn", "Kahn, Gus", "Walter Donaldson", "Donaldson, Walter", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, revue, year)
values
("My Blue Heaven", "George A.~Whiting", "Whiting, George A.", "Walter Donaldson", "Donaldson, Walter", true,
"Ziegfeld Follies 1927", 1927);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, scanned, year)
values
("My Melancholy Baby", "George A. Norton", "Norton, George A.", "Ernie Burnett", "Burnett, Ernie", true, true, 1912);

/* N   */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("Nancy with the Laughing Face", "Phil Silvers", "Silvers, Phil", "Jimmy van Heusen", "Heusen, Jimmy van", true, 1);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year, copyright)
values
("Nevertheless (I'm In Love With You)", "Bert Kalmar", "Kalmar, Bert", "Harry Ruby", "Ruby, Harry", true, 1,
1931,
"{\\copyright} 1931 DeSylva, Brown and Henderson");

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, copyright, year)
values
("Night and Day", "Cole Porter", "Porter, Cole", true,
"{\\copyright} 1932 Warner Bros.~Inc.~(Renewed)", 1932);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("No Strings", "Irving Berlin", "Berlin, Irving", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Nobody's Sweetheart", "Gus Kahn and Ernest Erdman", "Kahn, Gus and Erdman, Ernest", 
"Billy Meyers and Elmer Schoebel", "Meyers, Billy and Schoebel, Elmer", 
true);

select "!!! N";

/* O   */

/* ***************************************************** */

select "!!! O";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, source)
values
("Oh! You Crazy Moon", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true, 1939,
"Classic Songs of Johnny Burke, Hollywood's Songwriter, p.~59");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("On a Clear Day", "Alan Jay Lerner", "Lerner, Alan Jay", "Burton Lane", "Lane, Burton", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("On a Slow Boat to China", "Frank Loesser", "Loesser, Frank", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("On the Street Where You Live", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true,  "My Fair Lady",
true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("On the Sunny Side of the Street", "Dorothy Fields", "Fields, Dorothy", "Jimmy McHugh", "McHugh, Jimmy", true, 1);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Out of Nowhere", "Edward Heyman", "Heyman, Edward", "John W.~Green", "Green, John W.", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("Over the Rainbow", "E.Y.~``Yip'' Harburg", "Harburg, E.Y.~``Yip''", "Harold Arlen", "Arlen, Harold", true, "Wizard of Oz, The");

select "!!! End O";

/* P   */

/* ***************************************************** */

select "!!! P";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Para Vigo me voy (Say ``Si, Si'')", "Francia Luban", "Luban, Francia", "Ernesto Lecuona", "Lecuona, Ernesto",
true, 1935);

#/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Paris in New York", "Vernon Duke", "Duke, Vernon", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Parisian Pierrot", "No{\\\"e}l Coward", "Coward, No{\\\"e}l", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Pennies from Heaven", "Johnny Burke", "Burke, Johnny", "Arthur Johnston", "Johnston, Arthur", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("People Will Say We're in Love", "Oscar Hammerstein II", "Hammerstein II, Oscar", "Richard Rodgers", "Rodgers, Richard", true, 
"Oklahoma!", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year)
values
("Perfidia", "Alberto Dom{\\'\\i}nguez Borr{\\'a}s", 
"Dom{\\'\\i}nguez Borr{\\'a}s, Alberto", 
true, 1939);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, film)
values
("Piccolino, The", "Irving Berlin", "Berlin, Irving", true, "Top Hat");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year)
values
("Pick Yourself Up", "Dorothy Fields", "Fields, Dorothy", "Jerome Kern", "Kern, Jerome", true, "Swing Time", 1936);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, opera)
values
("Polowetzer T{\\\"a}nze (``Stranger in Paradise'')", "Alexander Borodin", "Borodin, Alexander", true,
"Prince Igor");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Prelude to a Kiss", "Irving Gordon and Irving Mills", "Gordon, Irving and Mills, Irving", "Duke Ellington", 
"Ellington, Duke", 
true, 1938);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Pretty A Girl is Like a Melody, A", "Irving Berlin", "Berlin, Irving", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Prisoner of Love", "Leo Robin", "Robin, Leo", "Russ Columbo and Clarence Gaskill", 
"Columbo, Russ and Gaskill, Clarence",
true, 1931);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, year)
values
("Put on a Happy Face", "Lee Adams", "Adams, Lee", 
"Charles Strouse", "Strouse, Charles", true, 1, 1960);

select "!!! End P";

/* Q   */

/* ***************************************************** */

select "!!! Q";

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns, year)
values
("Quiz{\\'a}s, Quiz{\\'a}s, Quiz{\\'a}s", "Osvaldo Farr{\\'e}s", "Farr{\\'e}s, Osvaldo", true, 1947);

select "!!! End Q";

/* R   */

select "!!! R";

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Rainy Night in Rio, A", "Leo Robin", "Robin, Leo", "Arthur Schwartz", "Schwartz, Arthur", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Red Sails in the Sunset", "Jimmy Kennedy", "Kennedy, Jimmy", "Hugh Williams", "Williams, Hugh", true, 1935);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Rock-a-Bye Your Baby (With a Dixie Melody)", "Sam M.~Lewis and Joe Young", "Lewis, Sam M. and Young, Joe", 
"Jean Schwarz", "Schwarz, Jean", true, 1918);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Room With a View, A", "No{\\\"e}l Coward", "Coward, No{\\\"e}l", true);

select "!!! End R";

/* S   */

select "!!! S";

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year)
values
("Samba do Avi{\\~a}o", "Antonio Carlos Jobim", "Jobim, Antonio Carlos", true, 1962);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("September in the Rain", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, 1);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns_with_two_songbooks, musical)
values
("September Song", "Maxwell Anderson", "Anderson, Maxwell", "Kurt Weill", "Weill, Kurt", true, "Knickerbocker Holiday");

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Shadow of Your Smile, The", "Johnny Mandel", "Mandel, Johnny", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year, sort_by_production)
values
("Shuffle Off to Buffalo", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, "42nd Street", 1933, true);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Siboney", "Ernesto Lecuona", "Lecuona, Ernesto", true);

#/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Siempre en mi Coraz{\\'o}n", "Ernesto Lecuona", "Lecuona, Ernesto", true);

/* ***************************************************** */

/*  Words Johnny Mercer??  */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Skylark", "Hoagy Carmichael", "Carmichael, Hoagy", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, musical)
values
("Smoke Gets in Your Eyes", "Otto Harbach", "Harbach, Otto", "Jerome Kern", "Kern, Jerome", true, 1933, "Roberta");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Smoke Rings", "Ned Washington", "Washington, Ned", "H.~Eugene Gifford", "Gifford, H.~Eugene ", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Somebody Loves Me", "Ballard MacDonald and Buddy DeSylva", 
"MacDonald, Ballard and DeSylva, Buddy", 
"George Gershwin", "Gershwin, George",
true, 1924);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Someone to Watch Over Me", "Ira Gershwin", "Gershwin, Ira", "George Gershwin", "Gershwin, George", true, 1926);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, year)
values
("Somethin' Stupid", "C.~Carson Parks", "Parks, C.~Carson", true, 1966);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Sophisticated Lady", "Mitchell Parish and Irving Mills",
"Parish, Mitchell and Mills, Irving", 
"Duke Ellington", "Ellington, Duke",
true, 1933);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("South of the Border", "Jimmy Kennedy", "Kennedy, Jimmy", "Michael Carr", "Carr, Michael", true, 1939);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, notes, year)
values
("Spanish Eyes (Moon Over Naples)", "Charles Singleton/Eddie Snyder", "Singleton, Charles/Snyder, Eddie", 
"Bert Kaempfert", "Kaempfert, Bert", true, "Source: Best of Bert Kaempfert", 1964);

/* delete from Songs where title = ""Spanish Eyes (Moon Over Naples";  */

/* select title from Songs\G  */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical)
values
("Speak Low", "Ogden Nash", "Nash, Ogden", "Kurt Weill", "Weill, Kurt", true, "One Touch of Venus");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, recordings)
values
("Speak Softly, Love", "Larry Kusik", "Kusik, Larry", "Nino Rota", "Rota, Nino", 1);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, partial_lead_sheet, year)
values
("Stand By Your Man", "Tammy Wynette and Billy Sherrill",
"Wynette, Tammy and Sherrill, Billy", true, 1968);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Standing on the Corner", "Frank Loesser", "Loesser, Frank", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Stardust", "Mitchell Parish", "Parish, Mitchell", "Hoagy Carmichael", "Carmichael, Hoagy", true);

/* recording?  */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, notes)
values
("Stars Fell on Alabama", "Mitchell Parish", "Parish, Mitchell", "Frank Perkins", "Perkins, Frank", 
true, 1934, "Banjo chord melody");

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Stella By Starlight", "Victor Young", "Young, Victor", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, notes, year)
values
("Strangers in the Night", "Charles Singleton/Eddie Snyder", "Singleton, Charles/Snyder, Eddie",
"Bert Kaempfert", "Kaempfert, Bert", true, "Source: Best of Bert Kaempfert", 1965);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year)
values
("Sure Thing", "Ira Gershwin", "Gershwin, Ira", "Jerome Kern", "Kern, Jerome", true, "Cover Girl", 1944);

select "!!! End S";

/* T   */

select "!!! T";

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
musical, year)
values
("Taking a Chance on Love", "John La Touche and Ted Fetter", "La Touche, John and Fetter, Ted",
"Vernon Duke", "Duke, Vernon", true,
"Cabin in the Sky", 1940);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, year, film)
values
("Tammy", "Ray Evans", "Evans, Ray", "Jay Livingston", "Livingston, Jay", true, 1957, "Tammy and the Bachelor");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright)
values
("Tangerine", "Johnny Mercer", "Mercer, Johnny", "Victor Schertzinger", "Schertzinger, Victor", true,
1942, "{\\copyright} 1942 Famous Music Corp., USA");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Tea for Two", "Irving Caesar", "Caesar, Irving", "Vincent Youmans", "Youmans, Vincent", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Ten Cents a Dance", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true, 1930);


/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns,
year, source)
values
("Tenderly", "Jack Lawrence", "Lawrence, Jack", "Walter Gross", "Gross, Walter", 
true, 1946, "{\\bf 100 Years of Popular Music 1940s, Vol. 1, p.~212}");


/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
film, year)
values
("Thanks for the Memory", "Leo Robin", "Robin, Leo", "Ralph Rainger", "Rainger, Ralph", true,
"The Big Broadcast of 1938", 1938);

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year, copyright)
values
("That Old Feeling", "Lew Brown", "Brown, Lew", "Sammy Fain", "Fain, Sammy", true,
"Vogues of 1938", 1937, "{\\copyright} 1937, Renewed 1965.");

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical, sort_by_production)
values
("There's No Business Like Show Business", "Irving Berlin", "Berlin, Irving", true, "Annie Get Your Gun", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("These Foolish Things", "Holt Marvell (Eric Maschwitz)", 
"Marvell, Holt (Maschwitz, Eric)", 
"Jack Strachey", "Strachey, Jack", true, 1935);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("They Call the Wind Maria", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, "Paint Your Wagon",
true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, musical, sort_by_production)
values
("They Say it's Wonderful", "Irving Berlin", "Berlin, Irving", true, "Annie Get Your Gun", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes)
values
("This Can't be Love", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true,
"\\hbox{}\\hbox{\\hskip-\\noteswd Verse incomplete on lead sheet and score.\\hss}");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Tico Tico no Fuba", "Aloysio de Oliveira", "Oliveira, Aloysio de",
"Zequinha de Abreu", "Abreu, Zequinha de", true, 1917);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Tiptoe Through the Tulips With Me", "Al Dubin", "Dubin, Al", "Joe Burke", "Burke, Joe", true, 1929);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Top of the World", "John Bettis", "Bettis, John", "Richard Carpenter", "Carpenter, Richard", true);

select "!!! End T";

/*  U  */

select "!!! U";

/* ***************************************************** */

replace into Songs (title, no_page_turns)
values
("{\\'U}ltima Noche, La", true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, no_page_turns, year)
values
("Unforgettable", "Irving Gordon", "Gordon, Irving", true, 1951);

select "!!! End U";

/* ***************************************************** */

/*  V  */

select "!!! V";

select "!!! End V";

/*  W  */

select "!!! W";

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film)
values
("Way You Look Tonight, The", "Dorothy Fields", "Fields, Dorothy", "Jerome Kern", "Kern, Jerome", true,
"Swing Time");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year)
values
("Wedding of the Painted Doll, The", "Arthur Freed", "Freed, Arthur", "Nacio Herb Brown", "Nacio Brown, Herb", true,
"The Broadway Melody", 1929);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, no_page_turns, musical, sort_by_production)
values
("Wouldn't It Be Loverly?", "Alan Jay Lerner", "Lerner, Alan Jay", "Frederick Loewe", "Loewe, Frederick", true, 
"My Fair Lady", true);

/* ***************************************************** */

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

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year, copyright)
values
("You Go to My Head", "Haven Gillespie", "Gillespie, Haven", "J.~Fred Coots", "Coots, J.~Fred", true,
1938, "{\\copyright} 1938 Remick Music");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year, sort_by_production)
values
("Young and Healthy", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, "42nd Street", 1933, true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, year, sort_by_production)
values
("You're Getting to Be a Habit With Me", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true,
"42nd Street", 1933, true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, scanned)
values
("You Made Me Love You", "Joe McCarthy", "McCarthy, Joe", "James Monaco", "Monaco, James", true, true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, arrangement_solo_guitar)
values
("You Took Advantage of Me", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true, true);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, notes)
values
("You've Got That Look", "Friedrich Hollaender", "Hollaender, Friedrich", true, "Too low.  Must transpose!");

/* mark_blue  */
/* words: Frank Loesser (Check!)  */

select "!!! End Y";

/*  Z  */

select "!!! Z";

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, operetta, year)
values
("Zwei M{\\\"a}rchenaugen",
"Julius Brammer und Alfred Gr{\\\"u}nwald",
"Brammer, Julius und Gr{\\\"u}nwald, Alfred",
"Emmerich K{\\'a}lm{\\'a}n", "K{\\'a}lm{\\'a}n, Emmerich", true, "Die Zirkusprinzessin", 1926);

/* Copyright 1951  */

select "!!! End Z";

/* ***************************************************** */

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

replace into Composers_Songs (composer, title) values ("Ahlert, Fred E.", "I Don't Know Why (I Just Do)");

replace into Composers_Songs (composer, title) values ("Allen, Robert", "It's Not For Me to Say");

replace into Composers_Songs (composer, title) values ("Allen, Robert", "Chances Are");

replace into Composers_Songs (composer, title) values ("Andre, Fabian", "Dream a Little Dream of Me");

replace into Composers_Songs (composer, title) values ("Schwandt, Wilbur", "Dream a Little Dream of Me");

replace into Composers_Songs (composer, title) values ("Arlen, Harold", "Between the Devil and the Deep Blue Sea");

replace into Composers_Songs (composer, title) values ("Arlen, Harold", "Let's Fall in Love");

replace into Composers_Songs (composer, title) values ("Arlen, Harold", "I've Got the World on a String");

replace into Composers_Songs (composer, title) values ("Arlen, Harold", "Over the Rainbow");

replace into Composers_Songs (composer, title) values ("Bacharach, Burt", "I'll Never Fall in Love Again");

replace into Composers_Songs (composer, title) values ("Bacharach, Burt", "I Say a Little Prayer");

replace into Composers_Songs (composer, title) values ("Bacharach, Burt", "Do You Know the Way to San Jose?");

replace into Composers_Songs (composer, title) values ("Bacharach, Burt", "Close to You");

replace into Composers_Songs (composer, title) values ("Barris, Harry", "Wrap Your Troubles in Dreams");

replace into Composers_Songs (composer, title) values ("Bernstein, Leonard", "I Feel Pretty");

replace into Composers_Songs (composer, title) values ("Bloom, Rube", "Fools Rush In (Where Angels Fear to Tread)");

replace into Composers_Songs (composer, title) values ("Bochmann, Werner", "Abends in der Taverna");

replace into Composers_Songs (composer, title) values ("Bonf{\\'a}, Luiz", "Manh{\\~a} da Carnaval");

replace into Composers_Songs (composer, title) values ("Burke, Joe", "Tiptoe Through the Tulips With Me");

replace into Composers_Songs (composer, title) values ("Burnett, Ernie", "My Melancholy Baby");

replace into Composers_Songs (composer, title) values ("Weber, Carl Maria von", "Durch die W{\\\"a}lder, durch die Auen");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Heart and Soul");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Georgia on my Mind");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Skylark");

replace into Composers_Songs (composer, title) values ("Carmichael, Hoagy", "Stardust");

replace into Composers_Songs (composer, title) values ("Carpenter, Richard", "Top of the World");

replace into Composers_Songs (composer, title) values ("Carr, Michael", "South of the Border");

replace into Composers_Songs (composer, title) values ("Columbo, Russ", "Prisoner of Love");

replace into Composers_Songs (composer, title) values ("Gaskill, Clarence", "Prisoner of Love");

replace into Composers_Songs (composer, title) values ("Conrad, Con", "Continental, The");

replace into Composers_Songs (composer, title) values ("Coots, J.~Fred", "You Go to My Head");

replace into Composers_Songs (composer, title) values ("Dale, Jim", "Georgy  Girl");

replace into Composers_Songs (composer, title) values ("DeRose, Peter", "Deep Purple");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "Carolina in the Morning");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "Love Me or Leave Me");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "My Blue Heaven");

replace into Composers_Songs (composer, title) values ("Donaldson, Walter", "My Baby Just Cares for Me");

replace into Composers_Songs (composer, title) values ("Duke, Vernon", "Taking a Chance on Love");

replace into Composers_Songs (composer, title) values ("Duke, Vernon", "I Can't Get Started");

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

replace into Composers_Songs (composer, title) values ("Gade, Jacob", "Jalousie ``Tango Tzigane'' (Jealousy)");

replace into Composers_Songs (composer, title) values ("Garner, Errol", "Misty");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Someone to Watch Over Me");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Let's Call the Whole Thing Off");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Liza (All the Clouds'll Roll Away)");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Somebody Loves Me");

replace into Composers_Songs (composer, title) values ("Gershwin, George", "Embraceable You");

replace into Composers_Songs (composer, title) values ("Gifford, H.~Eugene", "Smoke Rings");

replace into Composers_Songs (composer, title) values ("Giraud, Hubert", "Buenos Noches Mon Amour");

replace into Composers_Songs (composer, title) values ("Green, John W.", "I Cover the Waterfront");

replace into Composers_Songs (composer, title) values ("Green, John W.", "Body and Soul");

replace into Composers_Songs (composer, title) values ("Green, John W.", "Out of Nowhere");

replace into Composers_Songs (composer, title) values ("Green, John W.", "Coquette");

replace into Composers_Songs (composer, title) values ("Lombardo, Carmen", "Coquette");

replace into Composers_Songs (composer, title) values ("Gross, Walter", "Tenderly");

replace into Composers_Songs (composer, title) values ("Grothe, Franz", "Ja und Nein");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Moonlight Becomes You");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Nancy with the Laughing Face");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "It Could Happen to You");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Imagination");

replace into Composers_Songs (composer, title) values ("Heusen, Jimmy van", "Oh! You Crazy Moon");

replace into Composers_Songs (composer, title) values ("Hoffmann, Al", "Heartaches");

replace into Composers_Songs (composer, title) values ("Hollaender, Friedrich", "You've Got That Look");

replace into Composers_Songs (composer, title) values ("Hudson, Will", "Moonglow");

replace into Composers_Songs (composer, title) values ("Mills, Irving", "Moonglow");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Chega de Saudade");

replace into Composers_Songs (composer, title) values ("Johnston, Arthur", "Cocktails for Two");

replace into Composers_Songs (composer, title) values ("Johnston, Arthur", "Pennies from Heaven");

replace into Composers_Songs (composer, title) values ("Jones, Isham", "I'll See You in My Dreams");

replace into Composers_Songs (composer, title) values ("Jurmann, Walter", "All God's Children");

replace into Composers_Songs (composer, title) values ("Kaper, Bronislaw", "All God's Children");

replace into Composers_Songs (composer, title) values ("Jurmann, Walter", "Cosi Cosa");

replace into Composers_Songs (composer, title) values ("Kaper, Bronislaw", "Cosi Cosa");

replace into Composers_Songs (composer, title) values ("Jurmann, Walter", "Message From the Man in the Moon, A");

replace into Composers_Songs (composer, title) values ("Kaper, Bronislaw", "Message From the Man in the Moon, A");

replace into Composers_Songs (composer, title) values ("K{\\'a}lm{\\'a}n, Emmerich", "Komm, Zigany");

replace into Composers_Songs (composer, title) values ("K{\\'a}lm{\\'a}n, Emmerich", "Zwei M{\\\"a}rchenaugen");

replace into Composers_Songs (composer, title) values ("Kaempfert, Bert", "Strangers in the Night");

replace into Composers_Songs (composer, title) values ("Kaempfert, Bert", "Spanish Eyes (Moon Over Naples)");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "All the Things You Are");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Make Believe");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Way You Look Tonight, The");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Long Ago (and Far Away)");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Fine Romance, A");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Pick Yourself Up");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Bill");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Smoke Gets in Your Eyes");

replace into Composers_Songs (composer, title) values ("Kern, Jerome", "Sure Thing");

replace into Composers_Songs (composer, title) values ("Kosma, Joseph", "Feuilles Mortes, Les");

replace into Composers_Songs (composer, title) values ("Lai, Francis", "Homme et une femme, Un");

replace into Composers_Songs (composer, title) values ("Lane, Burton", "On a Clear Day");

replace into Composers_Songs (composer, title) values ("Lane, Burton", "How About You?");

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

replace into Composers_Songs (composer, title) values ("Monaco, James", "You Made Me Love You");

replace into Composers_Songs (composer, title) values ("Monaco, James V.", "I've Got a Pocketful of Dreams");

replace into Composers_Songs (composer, title) values ("Mozart, Wolfgang Amadeus", "L{\\`a} ci darem la mano");

replace into Composers_Songs (composer, title) values ("Nacio Brown, Herb", "Wedding of the Painted Doll, The");

replace into Composers_Songs (composer, title) values ("Offenbach, Jacques", "Barcarole");

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

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Lady is a Tramp, The");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "You Took Advantage of Me");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Ten Cents a Dance");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Isn't It Romantic?");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "This Can't be Love");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Blue Moon");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "People Will Say We're in Love");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "I Married an Angel");

replace into Composers_Songs (composer, title) values ("Rodgers, Richard", "Many a New Day");

replace into Composers_Songs (composer, title) values ("Rota, Nino", "Speak Softly, Love");

replace into Composers_Songs (composer, title) values ("Ruby, Harry", "Nevertheless (I'm In Love With You)");

replace into Composers_Songs (composer, title) values ("Schertzinger, Victor", "Tangerine");

replace into Composers_Songs (composer, title) values ("Schwartz, Arthur", "Rainy Night in Rio, A");

replace into Composers_Songs (composer, title) values ("Schwarz, Jean", "Rock-a-Bye Your Baby (With a Dixie Melody)");

replace into Composers_Songs (composer, title) values ("Silvers, Louis", "April Showers");

replace into Composers_Songs (composer, title) values ("Spoliansky, Mischa", "Heute Nacht oder nie");

replace into Composers_Songs (composer, title) values ("Stolz, Robert", "Du sollst der Kaiser meiner Seele sein");

replace into Composers_Songs (composer, title) values ("Strachey, Jack", "These Foolish Things");

replace into Composers_Songs (composer, title) values ("Strau{\\ss} (Sohn), Johann", "Mein Herr Marquis");

replace into Composers_Songs (composer, title) values ("Strouse, Charles", "Put on a Happy Face");

replace into Composers_Songs (composer, title) values ("Swift, Kay", "Fine and Dandy");

replace into Composers_Songs (composer, title) values ("Waller, Thomas ``Fats''", "Ain't Misbehavin'");

replace into Composers_Songs (composer, title) values ("Brooks, Harry", "Ain't Misbehavin'");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Young and Healthy");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Jeepers Creepers");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Shuffle Off to Buffalo");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "September in the Rain");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "You're Getting to Be a Habit With Me");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "I'll String Along With You");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "I Only Have Eyes for You");

replace into Composers_Songs (composer, title) values ("Warren, Harry", "Lulu's Back in Town");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Speak Low");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "September Song");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Lost in the Stars");

replace into Composers_Songs (composer, title) values ("Weill, Kurt", "Moon-Faced, Starry-Eyed");

replace into Composers_Songs (composer, title) values ("Whiting, Richard A.", "Hooray For Hollywood");

replace into Composers_Songs (composer, title) values ("Whiting, Richard A.", "Japanese Sandman");

replace into Composers_Songs (composer, title) values ("Williams, Hugh", "Harbour Lights");

replace into Composers_Songs (composer, title) values ("Williams, Hugh", "Red Sails in the Sunset");

replace into Composers_Songs (composer, title) values ("Winkler, Gerhard", "Capri Fischer");

replace into Composers_Songs (composer, title) values ("Wrubel, Allie", "Lady in Red, The");

replace into Composers_Songs (composer, title) values ("Youmans, Vincent", "Carioca");

replace into Composers_Songs (composer, title) values ("Youmans, Vincent", "Tea for Two");

replace into Composers_Songs (composer, title) values ("Young, Victor", "Stella By Starlight");

/* * (1)  */

replace into Lyricists_Songs (lyricist, title) values ("Heymann, Edward", "Body and Soul");

replace into Lyricists_Songs (lyricist, title) values ("Eyton Frank", "Body and Soul");

replace into Lyricists_Songs (lyricist, title) values ("Sour, Robert", "Body and Soul");

replace into Lyricists_Songs (lyricist, title) values ("Adams, Lee", "Put on a Happy Face");

replace into Lyricists_Songs (lyricist, title) values ("Anderson, Maxwell", "Lost in the Stars");

replace into Lyricists_Songs (lyricist, title) values ("Anderson, Maxwell", "September Song");

replace into Lyricists_Songs (lyricist, title) values ("Balz, Bruno", "Es leuchten die Sterne");

replace into Lyricists_Songs (lyricist, title) values ("Barbier, Jules", "Barcarole");

replace into Lyricists_Songs (lyricist, title) values ("Barouh, Pierre", "Homme et une femme, Un");

replace into Lyricists_Songs (lyricist, title) values ("Beckmann, Hans Fritz", "Bel Ami");

replace into Lyricists_Songs (lyricist, title) values ("Beckmann, Hans Fritz", "Frauen sind keine Engel");

replace into Lyricists_Songs (lyricist, title) values ("Bettis, John", "Top of the World");

replace into Lyricists_Songs (lyricist, title) values ("Brammer, Julius", "Zwei M{\\\"a}rchenaugen");

replace into Lyricists_Songs (lyricist, title) values ("Brown, Lew", "That Old Feeling");

replace into Lyricists_Songs (lyricist, title) values ("Gr{\\\"u}nwald, Alfred", "Zwei M{\\\"a}rchenaugen");

replace into Lyricists_Songs (lyricist, title) values ("Brammer, Julius", "Komm, Zigany");

replace into Lyricists_Songs (lyricist, title) values ("Gr{\\\"u}nwald, Alfred", "Komm, Zigany");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Misty");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Moonlight Becomes You");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Oh! You Crazy Moon");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Pennies from Heaven");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "It Could Happen to You");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "I've Got a Pocketful of Dreams");

replace into Lyricists_Songs (lyricist, title) values ("Burke, Johnny", "Imagination");

replace into Lyricists_Songs (lyricist, title) values ("Caesar, Irving", "Tea for Two");

replace into Lyricists_Songs (lyricist, title) values ("Coslow, Sam", "Cocktails for Two");

replace into Lyricists_Songs (lyricist, title) values ("Cour, Pierre", "Amour est bleu, L'");

replace into Lyricists_Songs (lyricist, title) values ("Da Ponte, Lorenzo", "L{\\`a} ci darem la mano");

replace into Lyricists_Songs (lyricist, title) values ("David, Hal", "Close to You");

replace into Lyricists_Songs (lyricist, title) values ("David, Hal", "I'll Never Fall in Love Again");

replace into Lyricists_Songs (lyricist, title) values ("David, Hal", "Do You Know the Way to San Jose?");

replace into Lyricists_Songs (lyricist, title) values ("David, Hal", "I Say a Little Prayer");

replace into Lyricists_Songs (lyricist, title) values ("De Sylva, Buddy G.", "April Showers");

replace into Lyricists_Songs (lyricist, title) values ("Dehmel, Willy", "Ja und Nein");

replace into Lyricists_Songs (lyricist, title) values ("DeLange, Eddie", "Moonglow");

replace into Lyricists_Songs (lyricist, title) values ("Dixon, Mort", "Lady in Red, The");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "I'll String Along With You");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "I Only Have Eyes for You");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Lulu's Back in Town");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Tiptoe Through the Tulips With Me");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "September in the Rain");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Shuffle Off to Buffalo");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "Young and Healthy");

replace into Lyricists_Songs (lyricist, title) values ("Dubin, Al", "You're Getting to Be a Habit With Me");

replace into Lyricists_Songs (lyricist, title) values ("Egan, Raymond B.", "Japanese Sandman");

replace into Lyricists_Songs (lyricist, title) values ("Eliscu, Edward", "Carioca");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Carioca");

replace into Lyricists_Songs (lyricist, title) values ("Evans, Ray", "Tammy");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "On the Sunny Side of the Street");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "I'm in the Mood for Love");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "Way You Look Tonight, The");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "Fine Romance, A");

replace into Lyricists_Songs (lyricist, title) values ("Fields, Dorothy", "Pick Yourself Up");

replace into Lyricists_Songs (lyricist, title) values ("Fontenoy, Marc", "Buenos Noches Mon Amour");

replace into Lyricists_Songs (lyricist, title) values ("Freed, Arthur", "Wedding of the Painted Doll, The");

replace into Lyricists_Songs (lyricist, title) values ("Freed, Ralph", "How About You?");

replace into Lyricists_Songs (lyricist, title) values ("Galhardo, Jos{\\'e}", "Lisboa Antiga");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Let's Call the Whole Thing Off");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Sure Thing");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Someone to Watch Over Me");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Long Ago (and Far Away)");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Embraceable You");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "I Can't Get Started");

replace into Lyricists_Songs (lyricist, title) values ("Gershwin, Ira", "Liza (All the Clouds'll Roll Away)");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Liza (All the Clouds'll Roll Away)");

replace into Lyricists_Songs (lyricist, title) values ("Gillespie, Haven", "You Go to My Head");

replace into Lyricists_Songs (lyricist, title) values ("Gordon, Irving", "Prelude to a Kiss");

replace into Lyricists_Songs (lyricist, title) values ("Mills, Irving", "Prelude to a Kiss");

replace into Lyricists_Songs (lyricist, title) values ("Gorrell, Stuart", "Georgia on my Mind");

replace into Lyricists_Songs (lyricist, title) values ("Gr{\\\"u}nbaum, Fritz", "Du sollst der Kaiser meiner Seele sein");

replace into Lyricists_Songs (lyricist, title) values ("Sterk, Wilhelm", "Du sollst der Kaiser meiner Seele sein");

replace into Lyricists_Songs (lyricist, title) values ("Haffner, Karl", "Mein Herr Marquis");

replace into Lyricists_Songs (lyricist, title) values ("Gen{\\'e}e, Richard", "Mein Herr Marquis");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "All the Things You Are");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "Lover Come Back to Me");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "People Will Say We're in Love");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "Many a New Day");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein II, Oscar", "Make Believe");

replace into Lyricists_Songs (lyricist, title) values ("Harbach, Otto", "Smoke Gets in Your Eyes");

replace into Lyricists_Songs (lyricist, title) values ("Harburg, E.Y.~``Yip''", "Over the Rainbow");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Blue Moon");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "This Can't be Love");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Lady is a Tramp, The");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Ten Cents a Dance");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "I Married an Angel");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "You Took Advantage of Me");

replace into Lyricists_Songs (lyricist, title) values ("Hart, Lorenz", "Isn't It Romantic?");

replace into Lyricists_Songs (lyricist, title) values ("Heyman, Edward", "Out of Nowhere");

replace into Lyricists_Songs (lyricist, title) values ("Heyman, Edward", "I Cover the Waterfront");

replace into Lyricists_Songs (lyricist, title) values ("Hughes, Langston", "Moon-Faced, Starry-Eyed");

replace into Lyricists_Songs (lyricist, title) values ("James, Paul (Warburg, James Paul)", "Fine and Dandy");

replace into Lyricists_Songs (lyricist, title) values ("Johnston, Patricia", "I'll Remember April");

replace into Lyricists_Songs (lyricist, title) values ("Raye, Don", "I'll Remember April");

replace into Lyricists_Songs (lyricist, title) values ("Kahal, Irving", "By a Waterfall");

replace into Lyricists_Songs (lyricist, title) values ("Kahal, Irving", "I Can Dream, Can't I?");

replace into Lyricists_Songs (lyricist, title) values ("Kahal, Irving", "I'll Be Seeing You");

replace into Lyricists_Songs (lyricist, title) values ("Kahn, Gus", "Love Me or Leave Me");

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

replace into Lyricists_Songs (lyricist, title) values ("Kind, Friedrich", "Durch die W{\\\"a}lder, durch die Auen");

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

replace into Lyricists_Songs (lyricist, title) values ("Livingston, Jay", "Mr.~Lucky");

replace into Lyricists_Songs (lyricist, title) values ("Evans, Ray", "Mr.~Lucky");

replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Heart and Soul");

replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "You've Got That Look");

replace into Lyricists_Songs (lyricist, title) values ("Luban, Francia", "Para Vigo me voy (Say ``Si, Si'')");

replace into Lyricists_Songs (lyricist, title) values ("MacDonald, Ballard", "Somebody Loves Me");

replace into Lyricists_Songs (lyricist, title) values ("DeSylva, Buddy", "Somebody Loves Me");

replace into Lyricists_Songs (lyricist, title) values ("Lawrence, Jack", "Tenderly");

replace into Lyricists_Songs (lyricist, title) values ("Magidson, Herb", "Continental, The");

replace into Lyricists_Songs (lyricist, title) values ("Maria, Ant{\\^o}nio", "Manh{\\~a} da Carnaval");

replace into Lyricists_Songs (lyricist, title) 
values ("Marvell, Holt (Maschwitz, Eric)", "These Foolish Things");

replace into Lyricists_Songs (lyricist, title) values ("McCarthy, Joe", "You Made Me Love You");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Jeepers Creepers");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Skylark");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Hooray For Hollywood");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Tangerine");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Laura");

replace into Lyricists_Songs (lyricist, title) values ("Mercer, Johnny", "Fools Rush In (Where Angels Fear to Tread)");

replace into Lyricists_Songs (lyricist, title) values ("Mills, Irving", "Caravan");

/* select * from Lyricists_Songs where title = "Chega de Saudade";  */

replace into Lyricists_Songs (lyricist, title) values ("Moraes, Vin{\\'\\i}cius de", "Chega de Saudade");

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

replace into Lyricists_Songs (lyricist, title) values ("Reaves, Erell", "Lady of Spain");

replace into Lyricists_Songs (lyricist, title) values ("Tilsley, Henry", "Lady of Spain");

replace into Lyricists_Songs (lyricist, title) values ("Robin, Leo", "June in Janury");

replace into Lyricists_Songs (lyricist, title) values ("Robin, Leo", "Thanks for the Memory");

replace into Lyricists_Songs (lyricist, title) values ("Robin, Leo", "Rainy Night in Rio, A");

replace into Lyricists_Songs (lyricist, title) values ("Robin, Leo", "Prisoner of Love");

replace into Lyricists_Songs (lyricist, title) values ("Schiffer, Marcellus", "Heute Nacht oder nie");

replace into Lyricists_Songs (lyricist, title) values ("Siegel, Ralph Maria", "Capri Fischer");

replace into Lyricists_Songs (lyricist, title) values ("Silvers, Phil", "Nancy with the Laughing Face");

replace into Lyricists_Songs (lyricist, title) values ("Singleton, Charles", "Spanish Eyes (Moon Over Naples)");

replace into Lyricists_Songs (lyricist, title) values ("Snyder, Eddie", "Spanish Eyes (Moon Over Naples)");

replace into Lyricists_Songs (lyricist, title) values ("Singleton, Charles", "Strangers in the Night");

replace into Lyricists_Songs (lyricist, title) values ("Snyder, Eddie", "Strangers in the Night");

replace into Lyricists_Songs (lyricist, title) values ("Sondheim, Stephen", "I Feel Pretty");

replace into Lyricists_Songs (lyricist, title) values ("Springfield, Tom", "Georgy  Girl");

replace into Lyricists_Songs (lyricist, title) values ("Stillman, Al", "Chances Are");

replace into Lyricists_Songs (lyricist, title) values ("Stillman, Al", "It's Not For Me to Say");

replace into Lyricists_Songs (lyricist, title) values ("Thibaut, Gille", "Comme d'Habitude");

replace into Lyricists_Songs (lyricist, title) values ("Turk, Roy", "I Don't Know Why (I Just Do)");

replace into Lyricists_Songs (lyricist, title) values ("Washington, Ned", "Cosi Cosa");

replace into Lyricists_Songs (lyricist, title) values ("Washington, Ned", "Smoke Rings");

replace into Lyricists_Songs (lyricist, title) values ("Washington, Ned", "Stella By Starlight");

replace into Lyricists_Songs (lyricist, title) values ("Webster, Paul Francis", "Shadow of Your Smile, The");

replace into Lyricists_Songs (lyricist, title) values ("Whiting, George A.", "My Blue Heaven");

replace into Lyricists_Songs (lyricist, title) values ("Wodehouse, P.G.", "Bill");

replace into Lyricists_Songs (lyricist, title) values ("Hammerstein, Oscar II", "Bill");

/* * (1)  */

replace into Composers_Songs (composer, title) values ("Ballard, Pat", "Mister Sandman");
replace into Lyricists_Songs (lyricist, title) values ("Ballard, Pat", "Mister Sandman");

replace into Composers_Songs (composer, title) values ("Bart, Lionel", "Consider Yourself");
replace into Lyricists_Songs (lyricist, title) values ("Bart, Lionel", "Consider Yourself");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "No Strings");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "No Strings");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Pretty A Girl is Like a Melody, A");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Pretty A Girl is Like a Melody, A");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Heat Wave");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Heat Wave");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Piccolino, The");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Piccolino, The");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "There's No Business Like Show Business");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "There's No Business Like Show Business");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Isn't This a Lovely Day?");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Isn't This a Lovely Day?");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Cheek to Cheek");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Cheek to Cheek");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Change Partners");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Change Partners");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "They Say it's Wonderful");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "They Say it's Wonderful");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Blue Skies");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Blue Skies");

replace into Composers_Songs (composer, title) values ("Berlin, Irving", "Let's Face the Music and Dance");
replace into Lyricists_Songs (lyricist, title) values ("Berlin, Irving", "Let's Face the Music and Dance");

replace into Composers_Songs (composer, title) values ("Borodin, Alexander", "Polowetzer T{\\\"a}nze (``Stranger in Paradise'')");
replace into Lyricists_Songs (lyricist, title) values ("Borodin, Alexander", "Polowetzer T{\\\"a}nze (``Stranger in Paradise'')");

replace into Composers_Songs (composer, title) values ("Bowman, Brooks", "East of the Sun (and West of the Moon)");
replace into Lyricists_Songs (lyricist, title) values ("Bowman, Brooks", "East of the Sun (and West of the Moon)");

replace into Composers_Songs (composer, title) values ("Collazo, Roberto (Bobby)", "{\\'U}ltima Noche, La");
replace into Lyricists_Songs (lyricist, title) values ("Collazo, Roberto (Bobby)", "{\\'U}ltima Noche, La");

replace into Composers_Songs (composer, title) values ("Coward, No{\\\"e}l", "If Love Were All");
replace into Lyricists_Songs (lyricist, title) values ("Coward, No{\\\"e}l", "If Love Were All");

replace into Composers_Songs (composer, title) values ("Coward, No{\\\"e}l", "I'll See You Again");
replace into Lyricists_Songs (lyricist, title) values ("Coward, No{\\\"e}l", "I'll See You Again");

replace into Composers_Songs (composer, title) values ("Coward, No{\\\"e}l", "Parisian Pierrot");
replace into Lyricists_Songs (lyricist, title) values ("Coward, No{\\\"e}l", "Parisian Pierrot");

replace into Composers_Songs (composer, title) values ("Coward, No{\\\"e}l", "Room With a View, A");
replace into Lyricists_Songs (lyricist, title) values ("Coward, No{\\\"e}l", "Room With a View, A");


replace into Composers_Songs (composer, title) values ("Denver, John", "Annie's Song");
replace into Lyricists_Songs (lyricist, title) values ("Denver, John", "Annie's Song");

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

replace into Composers_Songs (composer, title) values ("Frank, Loesser", "Baby, It's Cold Outside");
replace into Lyricists_Songs (lyricist, title) values ("Frank, Loesser", "Baby, It's Cold Outside");

replace into Composers_Songs (composer, title) values ("Gordon, Irving", "Unforgettable");
replace into Lyricists_Songs (lyricist, title) values ("Gordon, Irving", "Unforgettable");

replace into Composers_Songs (composer, title) values ("Hatch, Tony", "Downtown");
replace into Lyricists_Songs (lyricist, title) values ("Hatch, Tony", "Downtown");

replace into Composers_Songs (composer, title) values ("Hollaender, Friedrich", "Illusions");
replace into Lyricists_Songs (lyricist, title) values ("Hollaender, Friedrich", "Illusions");

replace into Composers_Songs (composer, title) values ("Howard, Bart", "Fly Me to the Moon");
replace into Lyricists_Songs (lyricist, title) values ("Howard, Bart", "Fly Me to the Moon");

replace into Composers_Songs (composer, title) values ("Hupfeld, Herman", "As Time Goes By");
replace into Lyricists_Songs (lyricist, title) values ("Hupfeld, Herman", "As Time Goes By");

replace into Composers_Songs (composer, title) values ("Jobim, Antonio Carlos", "Samba do Avi{\\~a}o");
replace into Lyricists_Songs (lyricist, title) values ("Jobim, Antonio Carlos", "Samba do Avi{\\~a}o");

replace into Composers_Songs (composer, title) values ("Lecuona, Ernesto", "Siempre en mi Coraz{\\'o}n");
replace into Lyricists_Songs (lyricist, title) values ("Lecuona, Ernesto", "Siempre en mi Coraz{\\'o}n");

replace into Composers_Songs (composer, title) values ("Lecuona, Ernesto", "Siboney");
replace into Lyricists_Songs (lyricist, title) values ("Lecuona, Ernesto", "Siboney");

replace into Composers_Songs (composer, title) values ("Loesser, Frank", "Standing on the Corner");
replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "Standing on the Corner");

replace into Composers_Songs (composer, title) values ("Loesser, Frank", "On a Slow Boat to China");
replace into Lyricists_Songs (lyricist, title) values ("Loesser, Frank", "On a Slow Boat to China");

replace into Composers_Songs (composer, title) values ("P{\\'e}rez Prado, D{\\'a}maso", "Mambo {\\#}5");
replace into Lyricists_Songs (lyricist, title) values ("P{\\'e}rez Prado, D{\\'a}maso", "Mambo {\\#}5");

replace into Composers_Songs (composer, title) values ("Parks, C.~Carson", "Somethin' Stupid");
replace into Lyricists_Songs (lyricist, title) values ("Parks, C.~Carson", "Somethin' Stupid");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "Begin the Beguine");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "Begin the Beguine");

replace into Composers_Songs (composer, title) values ("Porter, Cole", "I've Got You Under My Skin");
replace into Lyricists_Songs (lyricist, title) values ("Porter, Cole", "I've Got You Under My Skin");

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

/* * (1)  Composers and Lyricists */

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

"The Charleston" is a jazz composition that was written to accompany
the Charleston dance. It was composed in 1923, with lyrics by Cecil
Mack and music by James P. Johnson,

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Cecil Mack", "Mack, Cecil", '1873-11-6', '1944-08-1')

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

replace into Lyricists (name, name_reverse, birth_date, death_date) 
values ("Jack Selig Yellen", Jacek Jeleń; '1892-07-6', '1991-04-17');

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

/* * (1)  */


/* Local Variables: */
/* mode:SQL */
/* outline-minor-mode:t */
/* outline-regexp:"/\\\* \\\*+"  */
/* End: */
