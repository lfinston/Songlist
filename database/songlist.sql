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

use Songs;

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

alter table Songs modify column copyright varchar(256) default null;

show columns from Songs.Songs;

delete from Songs;

/* Replace into `Songs'  */

/* ***************************************************** */

/* A  */

replace into Songs (title, music, music_reverse, lead_sheet, recordings)
values
("Abends in der Taverna", "Werner Bochmann", "Bochmann, Werner", true, 1);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Ain't Misbehavin'", "Thomas ``Fats'' Waller", "Waller, Thomas ``Fats''", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings, arrangement_solo_guitar,
film)
values
("All God's Children", /* '  */
"Gus Kahn", "Kahn, Gus", "Walter Jurmann and Bronislaw Kaper", "Jurmann, Walter and Kaper, Bronislaw",
true, 1, true, "A Day at the Races");

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("All the Things You Are", "Jerome Kern", "Kern, Jerome", true);

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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("April Showers", "Buddy G.~De Sylva", "De Sylva, Buddy G.", "Louis Silvers", "Silvers, Louis", true, 1);

/* ***************************************************** */

replace into Songs (title, lead_sheet, words_and_music, words_and_music_reverse, year)
values
("As Time Goes By", true, "Herman Hupfeld", "Hupfeld, Herman", 1931);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Autumn in New York", "Vernon Duke", "Duke, Vernon", true);

/* Also words?  */

/* ******************************************************/

/* B  */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet, recordings)
values
("Baby, It's Cold Outside", "Frank Loesser", "Frank, Loesser", true, 1 /* '  */); 

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, opera)
values
("Barcarole", "Jacques Offenbach", "Offenbach, Jacques", true, "Les contes d'Hoffmann");

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, recordings, no_page_turns)
values
("Bel Ami", "Theo Mackeben", "Mackeben, Theo", true, 1, true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("Between the Devil and the Deep Blue Sea", "Ted Koehler", "Koehler, Ted", "Harold Arlen", "Arlen, Harold", true, 1931);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, musical, lead_sheet, sort_by_production)
values
("Bill", "P.G.~Wodehouse and Oscar Hammerstein II", "Wodehouse, P.G. and Hammerstein, Oscar II", "Jerome Kern", "Kern, Jerome",
"Showboat", true, true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, 
no_page_turns_with_two_songbooks)
values
("Blue Moon", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true, true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
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
("Body and Soul", "Edward Heymann, Frank Eyton und Robert Sour", "Heymann, Edward; Eyton Frank; and Sour, Robert", 
"John W.~Green", "Green, John W.", true);

/* ***************************************************** */

replace into Songs (title, lead_sheet)
values
("Buenos Noches Mon Amour", true);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, recordings, arrangement_solo_guitar)
values
("By a Waterfall", "Sammy Fain", "Fain, Sammy", true, 1, true);

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

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Carioca", "Vincent Youmans", "Youmans, Vincent", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Carolina in the Morning", "Gus Kahn", "Kahn, Gus", "Walter Donaldson", "Donaldson, Walter", true);

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
("Chega de Saudade", "Vin{\\'i}cius de Moraes", "Moraes, Vin{\\'i}cius de",  
"Antonio Carlos Jobim", "Jobim, Antonio Carlos",  true);

/* ***************************************************** */

replace into Songs (title, words_and_music, words_and_music_reverse, lead_sheet)
values
("Chicago (That Toddling Town)", "Fred Fisher", "Fisher, Fred", true);

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

/* D */

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, operetta, sort_by_production)
values
("Da geh ich zu Maxim", "Franz Leh{\\'a}r", "Leh{\\'a}r, Franz ", true, "Lustige Witwe, Die", true);

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

replace into Songs (title, music, music_reverse, lead_sheet, year, no_page_turns, notes)
values
("Du sollst der Kaiser meiner Seele sein", "Robert Stolz", "Stolz, Robert", true, 1916, true,
"Source:  Das neue Operettenbuch, Buch 1");

/* ***************************************************** */

delete from Songs where title = "Durch die Wälder, durch die Auen";

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, copyright, opera)
values
("Durch die W{\\\"a}lder, durch die Auen", "Friedrich Kind", "Kind, Friedrich", "Carl Maria von Weber", "Carl Maria Weber, von",
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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, copyright)
values
("Fools Rush In (Where Angels Fear to Tread)", "Johnny Mercer", "Mercer, Johnny", "Rube Bloom", "Bloom, Rube", true,
"{\\copyright} 1940 WB Music Corp.~(Renewed)");

/* ***************************************************** */

/* ***************************************************** */

replace into Songs (title, music, music_reverse, no_page_turns, recordings)
values
("Frauen sind keine Engel", "Theo Mackeben", "Mackeben, Theo", true, 1);

/* ***************************************************** */

replace into Songs (title, music, music_reverse)
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

replace into Songs (title, music, music_reverse, no_page_turns)
values
("Heute Nacht oder nie", "Mischa Spoliansky", "Spoliansky, Mischa", true);

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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("I Can't Get Started", "Ira Gershwin", "Gershwin, Ira", "Vernon Duke", "Duke, Vernon", true);

/* ***************************************************** */value

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("I Could Have Danced All Night", "Alan Jay Lerner", "Alan Lerner, Jay", "Frederick Loewe", "Loewe, Frederick", true, 1);

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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("I'll See You in My Dreams", "Gus Kahn", "Kahn, Gus", "Isham Jones", "Jones, Isham", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("I'll String Along With You", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, 1934);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, notes, arrangement_solo_guitar)
values
("Illusions", "Friedrich Hollaender", "Hollaender, Friedrich", true, "Score but no lead sheet!", true);

/* mark_blue  */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("I'm in the Mood for Love", "Dorothy Fields", "Fields, Dorothy", "Jimmy McHugh", "McHugh, Jimmy", true, 1);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("I'm Shooting High", "Harold Arlen", "Arlen, Harold", true);

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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("I've Got the World on a String", /* ' */ "Ted Koehler", "Koehler, Ted", "David Raksin", "Raksin, David", true);

/* J   */

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, recordings, notes)
values
("Ja und Nein", "Franz Grothe", "Grothe, Franz", true, 1,
 "\\hbox{Verse not in}\\hbox{{\\largeit 100 Years of Popular Music, Music_reverse, 1900s.}}");

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, copyright)
values
("Jalousie ``Tango Tzigane'' (Jealousy)", "Jacob Gade", "Gade, Jacob", true,
"{\\copyright} 1925.  Public Domain.");

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

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Komm, Zigany", "Emmerich K{\\'a}lm{\\'a}n", "K{\\'a}lm{\\'a}n, Emmerich", true);

/* Film-Operetta:  Gr{\"a}fin Mariza (possibly.  Check!!!) */

/* comment: (ungarisch: K{\\'a}lm{\\'a}n Imre;  eigentlich: Imre Koppstein  */

/* L  */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, opera)
values
("L{\\`a} ci darem la mano", "Lorenzo Da Ponte", "Da Ponte, Lorenzo", "Wolfgang Amadeus Mozart",
"Mozart, Wolfgang Amadeus", 
true, "Don Giovanni");

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Lady in Red, The", "Allie Wrubel", "Wrubel, Allie", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Lady is a Tramp, The", "Lorenz Hart", "Hart, Lorenz", "Richard Rodgers", "Rodgers, Richard", true);

/* ***************************************************** */

/*  !!! Get lyricists!  */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Lady of Spain", "Tolchard Evans", "Evans, Tolchard", true);

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

replace into Songs (title, music, music_reverse, no_page_turns, notes)
values
("Let's Fall in Love", "Harold Arlen", "Arlen, Harold", true, "Source: The Harold Arlen Songbook");

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, operetta, notes, sort_by_production)
values
("Lippen schweigen", "Franz Leh{\\'a}r", "Leh{\\'a}r  Franz", true, "Lustige Witwe, Die",
"English title:  The Merry Widow Waltz", true);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet, operetta, sort_by_production)
values
("Lied vom dummen Reiter, Das", "Franz Leh{\\'a}r", "Leh{\\'a}r  Franz", true, 
"Lustige Witwe, Die", true);

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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, recordings)
values
("Lulu's Back in Town", "Al Dubin", "Dubin, Al", "Harry Warren", "Warren, Harry", true, 1);

/* M   */

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("Make Believe", "Oscar Hammerstein II", "Hammerstein II, Oscar ", "Jerome Kern", "Kern, Jerome", true,  "Showboat", true);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, no_page_turns_with_two_songbooks)
values
("Mambo {\\#}5", "D{\\'a}maso P{\\'e}rez Prado", "P{\\'e}rez Prado, D{\\'a}maso", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, notes)
values
("Manh{\\~a} da Carnaval", "Ant{\\^o}nio Maria", "Maria, Ant{\\^o}nio",
"Luiz Bonf{\\'a}", "Bonf{\\'a}, Luiz", true, "Score for Andantino completed 23.02.2018.");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, musical, sort_by_production)
values
("Many a New Day", "Oscar Hammerstein II", "Hammerstein II, Oscar ", "Richard Rodgers", "Rodgers, Richard", true,
"Oklahoma!", true);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, partial_lead_sheet, operetta)
values
("Mein Herr Marquis", "Johann Strau{\\ss} (Sohn)", "Strau{\\ss} (Sohn), Johann", true, "Die Fledermaus");

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, film, notes)
values
("Message From the Man in the Moon, A", "Gus Kahn", "Kahn, Gus", "Walter Jurmann and Bronislaw Kaper",
"Jurmann, Walter and Kaper, Bronislaw",
true, "A Day at the Races", "Cut from film");

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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Moonlight Becomes You", "Johnny Burke", "Burke, Johnny", "Jimmy van Heusen", "Heusen, Jimmy van", true);

/* ***************************************************** */

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("Moonlight Serenade", "Mitchell Parish", "Parish, Mitchell", "Glenn Miller", "Miller, Glenn", true);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Mr.~Lucky", "Henry Mancini", "Mancini, Henry", true);

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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet, year)
values
("My Melancholy Baby", "George A. Norton", "Norton, George A.", "Ernie Burnett", "Burnett, Ernie", true, 1912);

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

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Para Vigo me voy (Say ``Si, Si'')", "Ernesto Lecuona", "Lecuona, Ernesto", true);

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
("People Will Say We're in Love", "Oscar Hammerstein II", "Hammerstein II, Oscar ", "Richard Rodgers", "Rodgers, Richard", true, 
"Oklahoma!", true);

/* ***************************************************** */

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Perfidia", "Alberto Dom{\\\\'\\\\i}nguez Borr{\\\\'a}s", 
"Dom{\\\\'\\\\i}nguez Borr{\\\\'a}s, Alberto", 
true);

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

replace into Songs (title, music, music_reverse, lead_sheet, recordings)
values
("Put on a Happy Face", "Charles Strouse", "Strouse, Charles", true, 1);

select "!!! End P";

/* Q   */

/* ***************************************************** */

select "!!! Q";

replace into Songs (title, no_page_turns)
values
("Quizas, Quizas, Quizas", true);

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
("Room With a View, A", "No{\\\"e}l Coward", "Coward, No{\\\"e}l ", true);

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

replace into Songs (title, music, music_reverse, no_page_turns, notes)
values
("Spanish Eyes", "Bert Kaempfert", "Kaempfert, Bert", true, "Source: Best of Bert Kaempfert");

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

replace into Songs (title, music, music_reverse, no_page_turns, notes)
values
("Strangers in the Night", "Bert Kaempfert", "Kaempfert, Bert", true, "Source: Best of Bert Kaempfert");

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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet,
film, year)
values
("Thanks for the Memory", "Leo Robin", "Robin, Leo", "Ralph Rainger", "Rainger, Ralph", true,
"The Big Broadcast of 1938", 1938);

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

replace into Songs (title, words, words_reverse, music, music_reverse, lead_sheet)
values
("You Made Me Love You", "Joe McCarthy", "McCarthy, Joe", "James Monaco", "Monaco, James", true);

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

replace into Songs (title, music, music_reverse, lead_sheet)
values
("Zwei M{\\\"a}rchenaugen", "Emmerich K{\\'a}lm{\\'a}n", 
"K{\\'a}lm{\\'a}n, Emmerich", true);

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


/* Local Variables: */
/* mode:SQL */
/* outline-minor-mode:t */
/* End: */
