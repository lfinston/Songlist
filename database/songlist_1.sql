/* /home/laurence/Songlist/database/songlist_1.sql  */
/* Created by Laurence D. Finston (LDF) Sat 24 Apr 2021 01:54:06 PM CEST  */

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

/* The SQL code in this file is meant to be executed after the code in the */
/* file `songlist.sql' in this directory.                                  */

/* This file contains database entries for all of the songs in the series        */
/* _100 Years of Popular Music_ published by Faber, but only from the following  */
/* volumes: 1900, 1920s Vol. 1 and 2, 1930s Vol. 1 and 2 and 1940s Vol. 1 and 2. */

/* !! PLEASE NOTE:  The arguments for the `source' field in the `update'   */
/* contain the additional "source" information from `songlist.sql';        */
/* the ones in the `insert' commmands don't.                               */
/* Therefore, the `update' commands must always be executed.               */
/* The `insert' commands ensure that a database entry exists.              */
/* Database entries for some songs were created by `replace' commands      */ 
/* in the file `songlist.sql'.  These are for songs 1. for which I've      */
/* written lead sheets or partial lead sheets (PLS) or 2. where there      */
/* are no page turns in one or more printed editions (NPT) or              */
/* 3. where I have the same song in two songbooks and can use them to      */
/* play them without having to turn pages (WTS = "with two songbooks").    */
/* Of course, "PLS", "NPT" and "WTS" are only useful to the author or      */
/* people who happen to own the same songbooks that I do.                  */
/* LDF 2021.04.24.  */

/* A  */

insert ignore into Songs (title, source) values
("Aba Daba Honeymoon", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Aba Daba Honeymoon";

insert ignore into Songs (title, source) values ("About A Quarter To Nine",
"{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "About A Quarter To Nine";

insert ignore into Songs (title, source) values ("Ac-cent-tchu-ate The Positive",
"{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Ac-cent-tchu-ate The Positive";

insert ignore into Songs (title, source) values
("After The Ball", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "After The Ball"; 

insert ignore into Songs (title, source) values ("After You've Gone", 
"{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "After You've Gone";

insert ignore into Songs (title, source) values
("Ain't Misbehavin'", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Ain't Misbehavin'";

insert ignore into Songs (title, source) values
("Ain't We Got Fun", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" 
where title = "Ain't We Got Fun";

insert ignore into Songs (title, source) values
("Alexander's Ragtime Band", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" 
where title =
"Alexander's Ragtime Band", 

insert ignore into Songs (title, source) values
("Alice Blue Gown", 
"{\\bf 100 Years of Popular Music, 1900} and {\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set
source = "{\\bf 100 Years of Popular Music, 1900} and {\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Alice Blue Gown";

select * from Songs where title = "Alice Blue Gown"\G

insert ignore into Songs (title, source) values
("All I Do Is Dream Of You", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "All I Do Is Dream Of You";

insert ignore into Songs (title, source) values
("All Of Me", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "All Of Me";

insert ignore into Songs (title, source) values
("All Of Sudden My Heart Sings", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "All Of Sudden My Heart Sings";

insert ignore into Songs (title, source) values
("All The Things You Are", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "All The Things You Are";

insert ignore into Songs (title, source) values
("All Through The Night", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "All Through The Night";

insert ignore into Songs (title, source) values
("Almost Like Being In Love", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "Almost Like Being In Love";

insert ignore into Songs (title, source) values
("Am I Blue?", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Am I Blue?";

insert ignore into Songs (title, source) values
("Among My Souvenirs", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Among My Souvenirs";

insert ignore into Songs (title, source) values
("Anchors Aweigh", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Anchors Aweigh";

insert ignore into Songs (title, source) values
("And The Angels Sing", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "And The Angels Sing";

insert ignore into Songs (title, source) values
("Anniversary Waltz, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "Anniversary Waltz, The";

insert ignore into Songs (title, source) values
("Another Openin', Another Show", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" 
where title = "Another Openin', Another Show";

insert ignore into Songs (title, source) values
("Anything Goes, "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Anything Goes;

insert ignore into Songs (title, source) values "Anything You Can Do", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}") where title = "Anything You Can Do";

insert ignore into Songs (title, source) values
("April In Paris", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "April In Paris";

insert ignore into Songs (title, source) values
("April Showers", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "April Showers";

insert ignore into Songs (title, source) values
("As Time Goes By", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "As Time Goes By";

insert ignore into Songs (title, source) values
("Autumn In New York", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "Autumn In New York";

insert ignore into Songs (title, source) values
("Avalon", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Avalon";

insert ignore into Songs (title, source) values
("Avalon", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Avalon";

/* B  */

insert ignore into Songs (title, source) values
("Baby Face", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Baby Face";

insert ignore into Songs (title, source) values
("Back In Your Own Backyard", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Back In Your Own Backyard";

insert ignore into Songs (title, source) values
("Ballin' The Jack", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" 
where title = "Ballin' The Jack";

insert ignore into Songs (title, source) values
("Band Played On, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Band Played On, The";

insert ignore into Songs (title, source) values
("Basin Street Blues", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Basin Street Blues";

insert ignore into Songs (title, source) values
("Be A Clown", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Be A Clown";

insert ignore into Songs (title, source) values
("Be My Little Baby Bumble Bee", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Be My Little Baby Bumble Bee";

insert ignore into Songs (title, source) values
("Be My Love", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "Be My Love";

insert ignore into Songs (title, source) values
("Because", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Because";

insert ignore into Songs (title, source) values
("Because My Baby Don't Mean Maybe Now",
"{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Because My Baby Don't Mean Maybe Now";

insert ignore into Songs (title, source) values
("Begin The Beguine", "{\\bf 100 Years of Popular Music, 1930s}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2} and {\\bf The Best of Cole Porter}, p.~30"
where title = "Begin The Beguine";

insert ignore into Songs (title, source) values
("Bells Of St. Mary's, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" 
where title = "Bells Of St. Mary's, The";

insert ignore into Songs (title, source) values
("Best Things In Life Are Free, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Best Things In Life Are Free, The";

insert ignore into Songs (title, source) values
("Bewitched", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "Bewitched";

insert ignore into Songs (title, source) values
("Beyond The Blue Horizon", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Beyond The Blue Horizon";

insert ignore into Songs (title, source) values
("Beyond The Sea (La Mer)", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Beyond The Sea (La Mer)";

insert ignore into Songs (title, source) values
("Bicycle Built For Two, A (Daisy Bell)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Bicycle Built For Two, A (Daisy Bell)";

insert ignore into Songs (title, source) values
("Bill Bailey, Won't You Please Come Home?", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" 
where title = "Bill Bailey, Won't You Please Come Home?";

insert ignore into Songs (title, source) values
("Bird In A Gilded Cage, A", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Bird In A Gilded Cage, A";

insert ignore into Songs (title, source) values
("Birth Of The Blues, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Birth Of The Blues, The";

insert ignore into Songs (title, source) values
("Black Bottom", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Black Bottom";

insert ignore into Songs (title, source) values
("Bless 'Em All", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" 
where title = "Bless 'Em All";

insert ignore into Songs (title, source) values
("Blue Moon", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Blue Moon";

insert ignore into Songs (title, source) values
("Blue Room, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Blue Room, The";

insert ignore into Songs (title, source) values
("Blueberry Hill", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "Blueberry Hill";

insert ignore into Songs (title, source) values
("Blues In The Night", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Blues In The Night";

insert ignore into Songs (title, source) values
("Body And Soul", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Body And Soul";

insert ignore into Songs (title, source) values
("Boy Next Door, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Boy Next Door, The";

insert ignore into Songs (title, source) values
("Bugle Call Rag", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Bugle Call Rag";

insert ignore into Songs (title, source) values
("Busy Doin' Nothing", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" 
where title = "Busy Doin' Nothing";

insert ignore into Songs (title, source) values
("But Not For Me", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "But Not For Me";

insert ignore into Songs (title, source) values
("Button Up Your Overcoat", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Button Up Your Overcoat";

insert ignore into Songs (title, source) values
("Buttons And Bows", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Buttons And Bows";

insert ignore into Songs (title, source) values
("By The Beautiful Sea", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "By The Beautiful Sea";

insert ignore into Songs (title, source) values
("By The Light Of The Silvery Moon", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "By The Light Of The Silvery Moon";

insert ignore into Songs (title, source) values
("Bye Bye Blackbird", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Bye Bye Blackbird";

insert ignore into Songs (title, source) values
("Bye Bye Blues", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Bye Bye Blues";

/* C */

insert ignore into Songs (title, source) values
("California Here I Come", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "California Here I Come";

insert ignore into Songs (title, source) values
("Canadian Capers", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Canadian Capers";

insert ignore into Songs (title, source) values
("Can't Find My Way Home", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" 
where title = "Can't Find My Way Home";

insert ignore into Songs (title, source) values
("Carolina In The Morning", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Carolina In The Morning";

insert ignore into Songs (title, source) values
("Carolina Moon", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Carolina Moon";

insert ignore into Songs (title, source) values
("Charleston, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Charleston, The";

insert ignore into Songs (title, source) values
("Charmaine", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Charmaine";

insert ignore into Songs (title, source) values
("Chattanooga Choo Choo", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Chattanooga Choo Choo";

insert ignore into Songs (title, source) values
("Chicago (That Toddlin' Town)", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" 
where title = "Chicago (That Toddlin' Town)";

insert ignore into Songs (title, source) values
("Chinatown My Chinatown", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Chinatown My Chinatown";

insert ignore into Songs (title, source) values
("Choo Choo Ch'boogie", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" 
where title = "Choo Choo Ch'boogie";

insert ignore into Songs (title, source) values
("Clopin Clopant", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Clopin Clopant";

insert ignore into Songs (title, source) values
("Come Rain Or Come Shine", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Come Rain Or Come Shine";

insert ignore into Songs (title, source) values
("Come To The Ball", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Come To The Ball";

insert ignore into Songs (title, source) values
("Come, Josephine In My Flying Machine (Up She Goes!)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Come, Josephine In My Flying Machine (Up She Goes!)";

insert ignore into Songs (title, source) values
("Coming Home", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "Coming Home";

insert ignore into Songs (title, source) values
("Continental, The", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "Continental, The";

insert ignore into Songs (title, source) values
("Crazy Rhythm", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Crazy Rhythm";

insert ignore into Songs (title, source) values
("Cuddle Up A Little Closer, Lovey Mine", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Cuddle Up A Little Closer, Lovey Mine";

insert ignore into Songs (title, source) values
("Cup Of Coffee, A Sandwich And You, A", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Cup Of Coffee, A Sandwich And You, A";

/* D */

insert ignore into Songs (title, source) values
("Dance Ballerina Dance", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "Dance Ballerina Dance";

insert ignore into Songs (title, source) values
("Dance Little Lady", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Dance Little Lady";

insert ignore into Songs (title, source) values
("Dancing In The Dark", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Dancing In The Dark";

insert ignore into Songs (title, source) values
("Dancing On The Ceiling  (He Dances On My Ceiling)", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "Dancing On The Ceiling (He Dances On My Ceiling)";

insert ignore into Songs (title, source) values
("Dancing With Tears In My Eyes", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Dancing With Tears In My Eyes";

insert ignore into Songs (title, source) values
("Danny Boy (Londonderry Air)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Danny Boy (Londonderry Air)";

insert ignore into Songs (title, source) values
("Darktown Strutters' Ball, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" 
where title = "Darktown Strutters' Ball, The";

insert ignore into Songs (title, source) values
("Day By Day", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Day By Day";

insert ignore into Songs (title, source) values
("Dear Hearts And Gentle People", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}"
where title = "Dear Hearts And Gentle People";

insert ignore into Songs (title, source) values
("Dear Little Café", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Dear Little Café";

insert ignore into Songs (title, source) values
("Deep In My Heart, Dear", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Deep In My Heart, Dear";

insert ignore into Songs (title, source) values
("Deep Purple", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Deep Purple";

insert ignore into Songs (title, source) values
("Delaney's Donkey", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" 
where title = "Delaney's Donkey";

insert ignore into Songs (title, source) values
("Desert Song, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Desert Song, The";

insert ignore into Songs (title, source) values
("Diane", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}"
where title = "Diane";

insert ignore into Songs (title, source) values
("Dinah", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Dinah";

insert ignore into Songs (title, source) values
("Dinner For One Please James", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Dinner For One Please James";

insert ignore into Songs (title, source) values
("Do Nothin' Till You Hear From Me 

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s}"
where title = "Do Nothin' Till You Hear From Me";

insert ignore into Songs (title, source) values
("Does The Spearmint Lose Its Flavour (On The Bedpost Overnight)?",
"{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Does The Spearmint Lose Its Flavour (On The Bedpost Overnight)?";

insert ignore into Songs (title, source) values
("Don't Bring Lulu", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" 
where title = "Don't Bring Lulu";

insert ignore into Songs (title, source) values
("Don't Fence Me In", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" 
where title = "Don't Fence Me In";

insert ignore into Songs (title, source) values
("Don't Get Around Much Anymore", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" 
where title = "Don't Get Around Much Anymore";

insert ignore into Songs (title, source) values
("Don't Sit Under The Apple Tree", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" 
where title = "Don't Sit Under The Apple Tree";

insert ignore into Songs (title, source) values
("Down By The Old Mill Stream", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Down By The Old Mill Stream";

insert ignore into Songs (title, source) values
("Down In The Glen", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "Down In The Glen";

insert ignore into Songs (title, source) values
("Down Yonder", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Down Yonder";

insert ignore into Songs (title, source) values
("Dream", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "Dream";

insert ignore into Songs (title, source) values
("Dream A Little Dream Of Me", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "Dream A Little Dream Of Me";

insert ignore into Songs (title, source) values
("Drinking Song", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Drinking Song";

/* E */

insert ignore into Songs (title, source) values
("Easy To Love", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "Easy To Love";

insert ignore into Songs (title, source) values
("Elmer's Tune", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" 
where title = "Elmer's Tune";

insert ignore into Songs (title, source) values
("Embraceable You", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}"
where title = "Embraceable You";

insert ignore into Songs (title, source) values
("Entertainer, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Entertainer, The";

insert ignore into Songs (title, source) values
("Every Day Is Ladies' Day With Me", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" 
where title = "Every Day Is Ladies' Day With Me";

insert ignore into Songs (title, source) values
("Everybody's Doin' It Now", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Everybody's Doin' It Now";

insert ignore into Songs (title, source) values
("Ev'ry Time We Say Goodbye", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" 
where title = "Ev'ry Time We Say Goodbye";

insert ignore into Songs (title, source) values
("Exactly Like You", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "Exactly Like You";

/* F */

insert ignore into Songs (title, source) values
("Fascinating Rhythm", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Fascinating Rhythm";

insert ignore into Songs (title, source) values
("Fascination", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}"
where title = "Fascination";

insert ignore into Songs (title, source) values
("Fine Romance, A", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}"
where title = "Fine Romance, A";

insert ignore into Songs (title, source) values
("Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)", 
"{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}"
where title = "Five Foot Two, Eyes Of Blue (Has Anybody Seen My Girl?)";  

insert ignore into Songs (title, source) values
("Floral Dance, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900} where title = "Floral Dance, The";

insert ignore into Songs (title, source) values
("Foggy Day, A", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Foggy Day, A"; 

insert ignore into Songs (title, source) values
("For All We Know", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "For All We Know";

insert ignore into Songs (title, source) values
("For Me And My Gal", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "For Me And My Gal";

insert ignore into Songs (title, source) values
("For You", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "For You";

insert ignore into Songs (title, source) values
("Forty-Second Street", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Forty-Second Street";

/* G */

insert ignore into Songs (title, source) values
("Gal In Calico, A", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Gal In Calico, A";

insert ignore into Songs (title, source) values
("Georgia On My Mind", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Georgia On My Mind";

insert ignore into Songs (title, source) values
("Get Happy", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Get Happy";

insert ignore into Songs (title, source) values
("Gipsy, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Gipsy, The";

insert ignore into Songs (title, source) values
("Girls Of My Dreams", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Girls Of My Dreams";

insert ignore into Songs (title, source) values
("Give My Regards To Broadway", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Give My Regards To Broadway";

insert ignore into Songs (title, source) values
("Glory Of Love, The", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Glory Of Love, The";

insert ignore into Songs (title, source) values
("Glow Worm", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Glow Worm";

insert ignore into Songs (title, source) values
("Good Morning", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Good Morning";

insert ignore into Songs (title, source) values
("Good-By Broadway, Hello France!", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Good-By Broadway, Hello France!";

insert ignore into Songs (title, source) values
("Goody Goody", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Goody Goody";

/* H */

insert ignore into Songs (title, source) values
("Hail! Hail! The Gang's All Here", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Hail! Hail! The Gang's All Here";

insert ignore into Songs (title, source) values
("Halfway Down The Stairs", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Halfway Down The Stairs";

insert ignore into Songs (title, source) values
("Hallelujah", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Hallelujah";

insert ignore into Songs (title, source) values
("Happy Days And Lonely Nights", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Happy Days And Lonely Nights";

insert ignore into Songs (title, source) values
("Happy Days Are Here Again", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Happy Days Are Here Again";

insert ignore into Songs (title, source) values
("Harbour Lights", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Harbour Lights";

insert ignore into Songs (title, source) values
("Harlem Nocturne", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Harlem Nocturne";

insert ignore into Songs (title, source) values
("Harrigan", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Harrigan";

insert ignore into Songs (title, source) values
("Has Anybody Ever Seen Kelly?", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Has Anybody Ever Seen Kelly?";

insert ignore into Songs (title, source) values
("Have You Every Been Lonely", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Have You Every Been Lonely";

insert ignore into Songs (title, source) values
("Have You Met Miss Jones?", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Have You Met Miss Jones?";

insert ignore into Songs (title, source) values
("Hear My Song, Violetta", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Hear My Song, Violetta";

insert ignore into Songs (title, source) values
("Heather On The Hill, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Heather On The Hill, The";

insert ignore into Songs (title, source) values
("Heigh-Ho", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Heigh-Ho";

insert ignore into Songs (title, source) values
("Hello! My Baby", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Hello! My Baby";

insert ignore into Songs (title, source) values
("He'd Have To Get Under–Get Out And Get Under (To Fix Up His Automobile)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "He'd Have To Get Under–Get Out And Get Under (To Fix Up His Automobile)";

insert ignore into Songs (title, source) values
("Hinky Dinky Parley-Voo  (Mademoiselle From Armentieres)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Hinky Dinky Parley-Voo  (Mademoiselle From Armentieres)";

insert ignore into Songs (title, source) values
("Hometown", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Hometown";

insert ignore into Songs (title, source) values
("How About You", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "How About You";

insert ignore into Songs (title, source) values
("How Are Things In Glocca Morra?", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "How Are Things In Glocca Morra?";

insert ignore into Songs (title, source) values
("How Can You Buy Killarney", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "How Can You Buy Killarney";

insert ignore into Songs (title, source) values
("How High The Moon", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "How High The Moon";

insert ignore into Songs (title, source) values
("How Long Has This Been Going On?", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "How Long Has This Been Going On?";

/* I */

insert ignore into Songs (title, source) values
("I Apologise", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I Apologise";

insert ignore into Songs (title, source) values
("I Belong To Glasgow", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "I Belong To Glasgow";

insert ignore into Songs (title, source) values
("I Can Give You The Starlight", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I Can Give You The Starlight";

insert ignore into Songs (title, source) values
("I Can't Get Started", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I Can't Get Started";

insert ignore into Songs (title, source) values
("I Can't Give You Anything But Love", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "I Can't Give You Anything But Love";

insert ignore into Songs (title, source) values
("I Couldn't Sleep A Wink Last Night", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "I Couldn't Sleep A Wink Last Night";

insert ignore into Songs (title, source) values
("I Cried For You", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "I Cried For You";

insert ignore into Songs (title, source) values
("I Didn't Know What Time It Was", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I Didn't Know What Time It Was";

insert ignore into Songs (title, source) values
("I Don't Care", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I Don't Care";

insert ignore into Songs (title, source) values
("I Don't Know Why (I Just Do!)", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I Don't Know Why (I Just Do!)";

insert ignore into Songs (title, source) values
("I Don't Stand A Ghost Of A Chance", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I Don't Stand A Ghost Of A Chance";

insert ignore into Songs (title, source) values
("I Don't Want to Set the World on Fire", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I Don't Want to Set the World on Fire";

insert ignore into Songs (title, source) values
("I Don't Want to Walk Without You", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I Don't Want to Walk Without You";

insert ignore into Songs (title, source) values
("I Get A Kick Out Of You", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I Get A Kick Out Of You";

insert ignore into Songs (title, source) values
("I Got A Gal In Kalamazoo", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "I Got A Gal In Kalamazoo";

insert ignore into Songs (title, source) values
("I Got It Bad (And That Ain't Good)", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "I Got It Bad (And That Ain't Good)";

insert ignore into Songs (title, source) values
("I Got Rhythm", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I Got Rhythm";

insert ignore into Songs (title, source) values
("I Gotta Right To Sing The Blues", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I Gotta Right To Sing The Blues";

insert ignore into Songs (title, source) values
("I Guess I'll Have To Change My Plan", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I Guess I'll Have To Change My Plan";

insert ignore into Songs (title, source) values
("I Had The Craziest Dream", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "I Had The Craziest Dream";

insert ignore into Songs (title, source) values
("I Know Why And So Do You", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I Know Why And So Do You";

insert ignore into Songs (title, source) values
("I Love A Piano", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I Love A Piano";

insert ignore into Songs (title, source) values
("I Love My Baby", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "I Love My Baby";

insert ignore into Songs (title, source) values
("I Love The Moon", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I Love The Moon";

insert ignore into Songs (title, source) values
("I Love You For Sentimental Reasons", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I Love You For Sentimental Reasons";

insert ignore into Songs (title, source) values
("I Love You Truly", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I Love You Truly";

insert ignore into Songs (title, source) values
("I Only Have Eyes For You", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I Only Have Eyes For You";

insert ignore into Songs (title, source) values
("I Remember You", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I Remember You";

insert ignore into Songs (title, source) values
("I Surrender Dear", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I Surrender Dear";

insert ignore into Songs (title, source) values
("I Wanna Be Loved By You", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I Wanna Be Loved By You";

insert ignore into Songs (title, source) values
("I Want A Girl (Just Like The Girl That Married  Dear Old Dad)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I Want A Girl (Just Like The Girl That Married  Dear Old Dad)";

insert ignore into Songs (title, source) values
("I Want To Be Happy", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "I Want To Be Happy";

insert ignore into Songs (title, source) values
("I Went To A Marvellous Party", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I Went To A Marvellous Party";

insert ignore into Songs (title, source) values
("I Wish I Could Shimmy Like My Sisters Kate", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "I Wish I Could Shimmy Like My Sisters Kate";

insert ignore into Songs (title, source) values
("I Wonder Where My Baby Is Tonight", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "I Wonder Where My Baby Is Tonight";

insert ignore into Songs (title, source) values
("I Wonder Who's Kissing Her Now", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I Wonder Who's Kissing Her Now";

insert ignore into Songs (title, source) values
("I Won't Dance", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I Won't Dance";

insert ignore into Songs (title, source) values
("I, Yi, Yi, Yi, Yi Like You Very Much", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I, Yi, Yi, Yi, Yi Like You Very Much";

insert ignore into Songs (title, source) values
("Ida, Sweet As Apple Cider", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Ida, Sweet As Apple Cider";

insert ignore into Songs (title, source) values
("If", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "If";

insert ignore into Songs (title, source) values
("If I Knew Susie", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "If I Knew Susie";

insert ignore into Songs (title, source) values
("If I Knock Out The 'L' Of Kelly", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "If I Knock Out The 'L' Of Kelly";

insert ignore into Songs (title, source) values
("If I Should Fall In Love Again", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "If I Should Fall In Love Again";

insert ignore into Songs (title, source) values
("If Love Were All", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "If Love Were All";

insert ignore into Songs (title, source) values
("If You Were The Only Girl In The World ", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "If You Were The Only Girl In The World ";

insert ignore into Songs (title, source) values
("In A Little Spanish Town", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "In A Little Spanish Town";

insert ignore into Songs (title, source) values
("In A Shady Nook By A Babbling Brook", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "In A Shady Nook By A Babbling Brook";

insert ignore into Songs (title, source) values
("In A Shanty In Old Shanty Town", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "In A Shanty In Old Shanty Town";

insert ignore into Songs (title, source) values
("In My Merry Oldsmobile", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "In My Merry Oldsmobile";

insert ignore into Songs (title, source) values
("In The Good Old Summertime", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "In The Good Old Summertime";

insert ignore into Songs (title, source) values
("In The Mood", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "In The Mood";

insert ignore into Songs (title, source) values
("In The Shade Of The Old Apple Tree", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "In The Shade Of The Old Apple Tree";

insert ignore into Songs (title, source) values
("In The Still Of The Night", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "In The Still Of The Night";

insert ignore into Songs (title, source) values
("Indian Love Call", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Indian Love Call";

insert ignore into Songs (title, source) values
("Indian Summer", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Indian Summer";

insert ignore into Songs (title, source) values
("Isle Of Capri", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Isle Of Capri";

insert ignore into Songs (title, source) values
("It Ain't Necessarily So", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "It Ain't Necessarily So";

insert ignore into Songs (title, source) values
("It All Depends On You", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "It All Depends On You";

insert ignore into Songs (title, source) values
("It Can't Be Wrong", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "It Can't Be Wrong";

insert ignore into Songs (title, source) values
("It Could Happen To You", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "It Could Happen To You";

insert ignore into Songs (title, source) values
("It Don't Mean A Thing (If It Ain't Got That Swing)", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "It Don't Mean A Thing (If It Ain't Got That Swing)";

insert ignore into Songs (title, source) values
("It Had To Be You", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "It Had To Be You";

insert ignore into Songs (title, source) values
("It Might As Well Be Spring", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "It Might As Well Be Spring";

insert ignore into Songs (title, source) values
("It's A Great Day For The Irish", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "It's A Great Day For The Irish";

insert ignore into Songs (title, source) values
("It's A Long Way To Tipperary", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "It's A Long Way To Tipperary";

insert ignore into Songs (title, source) values
("It's A Pity To Say `Goodnight'", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "It's A Pity To Say Goodnight";

insert ignore into Songs (title, source) values
("It's A Sin To Tell A Lie", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "It's A Sin To Tell A Lie";

insert ignore into Songs (title, source) values
("It's Been A Long, Long Time", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "It's Been A Long, Long Time";

insert ignore into Songs (title, source) values
("It's De-Lovely", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "It's De-Lovely";

insert ignore into Songs (title, source) values
("It's Easy To Remember", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "It's Easy To Remember";

insert ignore into Songs (title, source) values
("It's Magic", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "It's Magic";

insert ignore into Songs (title, source) values
("It's Only A Paper Moon", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "It's Only A Paper Moon";

insert ignore into Songs (title, source) values
("It's The Talk Of The Town", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "It's The Talk Of The Town";

insert ignore into Songs (title, source) values
("I'll Be Seeing You", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I'll Be Seeing You";

insert ignore into Songs (title, source) values
("I'll Be With You In Apple Blossom Time", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "I'll Be With You In Apple Blossom Time";

insert ignore into Songs (title, source) values
("I'll Close My Eyes", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I'll Close My Eyes";

insert ignore into Songs (title, source) values
("I'll Get By", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "I'll Get By";

insert ignore into Songs (title, source) values
("I'll Make Up For Ev'rything", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I'll Make Up For Ev'rything";

insert ignore into Songs (title, source) values
("I'll See You Again", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = 
"{\\bf 100 Years of Popular Music, 1920s, Volume 1} and "
"{\\bf Sir No{\\\"e}l Coward, His Words and Music}, p.~34" 
where title = "I'll See You Again";

select * from Songs where title = "I'll See You Again"\G

insert ignore into Songs (title, source) values
("I'll See You In My Dreams", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "I'll See You In My Dreams";

insert ignore into Songs (title, source) values
("I'll String Along With You", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I'll String Along With You";

insert ignore into Songs (title, source) values
("I'll Walk Alone", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "I'll Walk Alone";

insert ignore into Songs (title, source) values
("I'm Always Chasing Rainbows", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I'm Always Chasing Rainbows";

insert ignore into Songs (title, source) values
("I'm Beginning To See The Light", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "I'm Beginning To See The Light";

insert ignore into Songs (title, source) values
("I'm Confessin'", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I'm Confessin'";

insert ignore into Songs (title, source) values
("I'm Forever Blowing Bubbles ", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I'm Forever Blowing Bubbles ";

insert ignore into Songs (title, source) values
("I'm Going To Get Lit-Up (When The Lights Go-Up In London)", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "I'm Going To Get Lit-Up (When The Lights Go-Up In London)";

insert ignore into Songs (title, source) values
("I'm Going To See You Today", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "I'm Going To See You Today";

insert ignore into Songs (title, source) values
("I'm In The Mood For Love", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I'm In The Mood For Love";

insert ignore into Songs (title, source) values
("I'm Just Wild About Harry", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "I'm Just Wild About Harry";

insert ignore into Songs (title, source) values
("I'm Looking Over A Four Leaf Clover", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "I'm Looking Over A Four Leaf Clover";

insert ignore into Songs (title, source) values
("I'm Nobody's Baby", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "I'm Nobody's Baby";

insert ignore into Songs (title, source) values
("I'm Putting All My Eggs In One Basket", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I'm Putting All My Eggs In One Basket";

insert ignore into Songs (title, source) values
("I'm Shy Marry Ellen, I'm Shy", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I'm Shy Marry Ellen, I'm Shy";

insert ignore into Songs (title, source) values
("I'm Sitting On Top Of The World", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "I'm Sitting On Top Of The World";

insert ignore into Songs (title, source) values
("I'm Smoothin' High", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I'm Smoothin' High";

insert ignore into Songs (title, source) values
("I'm Sorry I Made You Cry", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I'm Sorry I Made You Cry";

insert ignore into Songs (title, source) values
("I'm Wishing", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I'm Wishing";

insert ignore into Songs (title, source) values
("I've Got A Crush On You", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I've Got A Crush On You";

insert ignore into Songs (title, source) values
("I've Got My Love To Keep Me Warm", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "I've Got My Love To Keep Me Warm";

insert ignore into Songs (title, source) values
("I've Got Rings On My Fingers", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "I've Got Rings On My Fingers";

insert ignore into Songs (title, source) values
("I've Got The World On A String", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I've Got The World On A String";

insert ignore into Songs (title, source) values
("I've Got You Under My Skin",
"{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1} and {\\bf The Best of Cole Porter}"
where title = "I've Got You Under My Skin";

insert ignore into Songs (title, source) values
("I've Heard That Song Before", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}"
where title = "I've Heard That Song Before";

insert ignore into Songs (title, source) values
("I've Never Seen A Straight Banana", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "I've Never Seen A Straight Banana";

insert ignore into Songs (title, source) values
("I've Told Ev'ry Little Star", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "I've Told Ev'ry Little Star";

/* J */

insert ignore into Songs (title, source) values
("Ja-Da (Ja Da, Ja Da, Jing Jing Jing!)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Ja-Da (Ja Da, Ja Da, Jing Jing Jing!)";

insert ignore into Songs (title, source) values
("Japanese Sandman, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Japanese Sandman, The";

insert ignore into Songs (title, source) values
("Java Jive", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Java Jive";

insert ignore into Songs (title, source) values
("Jealousy", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Jealousy";

insert ignore into Songs (title, source) values
("Jeepers Creepers", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Jeepers Creepers";

insert ignore into Songs (title, source) values
("Johnson Rag", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Johnson Rag";

insert ignore into Songs (title, source) values
("Just A Gigolo", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Just A Gigolo";

insert ignore into Songs (title, source) values
("Just A-Sittin' And A-Rockin'", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Just A-Sittin' And A-Rockin'";

insert ignore into Songs (title, source) values
("Just Because She Made Dem Goo-Goo Eyes", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Just Because She Made Dem Goo-Goo Eyes";

insert ignore into Songs (title, source) values
("Just One More Chance", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Just One More Chance";

/* K */

insert ignore into Songs (title, source) values
("K-ra-zy For You", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "K-ra-zy For You";

insert ignore into Songs (title, source) values
("Keep The Home Fires Burning", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Keep The Home Fires Burning";

insert ignore into Songs (title, source) values
("Keep Young And Beautiful", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Keep Young And Beautiful";

insert ignore into Songs (title, source) values
("Kiss Me Again", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Kiss Me Again";

insert ignore into Songs (title, source) values
("Kkkkaty", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Kkkkaty";

/* L */

insert ignore into Songs (title, source) values
("Lady Is A Tramp, The", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Lady Is A Tramp, The";

insert ignore into Songs (title, source) values
("Lady Of Spain", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Lady Of Spain";

insert ignore into Songs (title, source) values
("Last Time I Saw Paris, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Last Time I Saw Paris, The";

insert ignore into Songs (title, source) values
("Laura", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Laura";

insert ignore into Songs (title, source) values
("Lavender Blue (Dilly Dilly)", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Lavender Blue (Dilly Dilly)";

insert ignore into Songs (title, source) values
("Laziest Gal In Town, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Laziest Gal In Town, The";

insert ignore into Songs (title, source) values
("Lazy Bones", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Lazy Bones";

insert ignore into Songs (title, source) values
("Let By-Gones Be By-Gones", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Let By-Gones Be By-Gones";

insert ignore into Songs (title, source) values
("Let Me Call You Sweetheart", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Let Me Call You Sweetheart";

insert ignore into Songs (title, source) values
("Let Me Sing And I'm Happy", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Let Me Sing And I'm Happy";

insert ignore into Songs (title, source) values
("Let The Rest Of The World Go By", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Let The Rest Of The World Go By";

insert ignore into Songs (title, source) values
("Let There Be Love", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Let There Be Love";

insert ignore into Songs (title, source) values
("Let's Call The Whole Things Off", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Let's Call The Whole Things Off";

insert ignore into Songs (title, source) values
("Let's Do It (Let's Fall In Love)", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Let's Do It (Let's Fall In Love)";

insert ignore into Songs (title, source) values
("Let's Fall In Love", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source =
"{\\bf 100 Years of Popular Music, 1930s, Volume 1} and {\\bf The Harold Arlen Songbook}"
where title = "Let's Fall In Love";

insert ignore into Songs (title, source) values
("Let's Misbehave", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Let's Misbehave";

insert ignore into Songs (title, source) values
("Life Is Just A Bowl Of Cherries", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Life Is Just A Bowl Of Cherries";

insert ignore into Songs (title, source) values
("Lilli Marlene", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Lilli Marlene";

insert ignore into Songs (title, source) values
("Limehouse Blues", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Limehouse Blues";

insert ignore into Songs (title, source) values
("Little Grey Home In The West", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Little Grey Home In The West";

insert ignore into Songs (title, source) values
("Little Love, A Little Kiss, A", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Little Love, A Little Kiss, A";

insert ignore into Songs (title, source) values
("Little White Lies", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Little White Lies";

insert ignore into Songs (title, source) values
("London Pride", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "London Pride";

insert ignore into Songs (title, source) values
("Long Ago (And Far Away)", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Long Ago (And Far Away)";

insert ignore into Songs (title, source) values
("Look For The Silver Lining", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Look For The Silver Lining";

insert ignore into Songs (title, source) values
("Love For Sale", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Love For Sale";

insert ignore into Songs (title, source) values
("Love Is Here To Stay", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Love Is Here To Stay";

insert ignore into Songs (title, source) values
("Love Is Just Around The Corner", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Love Is Just Around The Corner";

insert ignore into Songs (title, source) values
("Love Letters In The Sand", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Love Letters In The Sand";

insert ignore into Songs (title, source) values
("Love Me Or Leave Me", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Love Me Or Leave Me";

insert ignore into Songs (title, source) values
("Love Walked In", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Love Walked In";

insert ignore into Songs (title, source) values
("Love, Here Is My Heart", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Love, Here Is My Heart";

insert ignore into Songs (title, source) values
("Lovely Lady", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Lovely Lady";

insert ignore into Songs (title, source) values
("Lovely Way To Spend An Evening, A", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Lovely Way To Spend An Evening, A";

insert ignore into Songs (title, source) values
("Lover Come Back To Me", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}, p.~152" 
where title = "Lover Come Back To Me";

insert ignore into Songs (title, source) values
("Love's Last Word Is Spoken", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Love's Last Word Is Spoken";

insert ignore into Songs (title, source) values
("Love's Old Sweet Song", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Love's Old Sweet Song";

insert ignore into Songs (title, source) values
("Lullaby Of Broadway", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Lullaby Of Broadway";

/* M */

insert ignore into Songs (title, source) values
("Ma (He's Making Eyes At Me)", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Ma (He's Making Eyes At Me)";

insert ignore into Songs (title, source) values
("Mademoiselle De Paris", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Mademoiselle De Paris";

insert ignore into Songs (title, source) values
("Makin' Whoopee!", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Makin' Whoopee!";

insert ignore into Songs (title, source) values
("Mam'selle", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Mam'selle";

insert ignore into Songs (title, source) values
("Man I Love, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Man I Love, The";

insert ignore into Songs (title, source) values
("Manhattan", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Manhattan";

insert ignore into Songs (title, source) values
("Marcheta", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Marcheta";

insert ignore into Songs (title, source) values
("Margie", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Margie";

insert ignore into Songs (title, source) values
("Margie", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Margie";

insert ignore into Songs (title, source) values
("Marta", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Marta";

insert ignore into Songs (title, source) values
("Mary's A Grand Old Name", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Mary's A Grand Old Name";

insert ignore into Songs (title, source) values
("Maybe It's Because I'm A Londoner", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Maybe It's Because I'm A Londoner";

insert ignore into Songs (title, source) values
("Me And My Shadow", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Me And My Shadow";

insert ignore into Songs (title, source) values
("Meet In St. Louis, Louis", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Meet In St. Louis, Louis";

insert ignore into Songs (title, source) values
("Memories", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Memories";

insert ignore into Songs (title, source) values
("Memories Of You", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Memories Of You";

insert ignore into Songs (title, source) values
("Mexicali Rose", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Mexicali Rose";

insert ignore into Songs (title, source) values
("Minnie The Moocher (The Ho-De-Ho Song)", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Minnie The Moocher (The Ho-De-Ho Song)";

insert ignore into Songs (title, source) values
("Miss Annabelle Lee", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Miss Annabelle Lee";

insert ignore into Songs (title, source) values
("Miss Otis Regrets", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Miss Otis Regrets";

insert ignore into Songs (title, source) values
("Mistakes", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Mistakes";

insert ignore into Songs (title, source) values
("Mona Lisa", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Mona Lisa";

insert ignore into Songs (title, source) values
("Mood Indido", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Mood Indido";

insert ignore into Songs (title, source) values
("Moonlight And Roses", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Moonlight And Roses";

insert ignore into Songs (title, source) values
("Moonlight Bay", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Moonlight Bay";

insert ignore into Songs (title, source) values
("Moonlight Becomes You", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Moonlight Becomes You";

insert ignore into Songs (title, source) values
("Moonlight In Vermont", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Moonlight In Vermont";

insert ignore into Songs (title, source) values
("Moonlight Serenade", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Moonlight Serenade";

insert ignore into Songs (title, source) values
("More I See You, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "More I See You, The";

insert ignore into Songs (title, source) values
("More Than You Know", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "More Than You Know";

insert ignore into Songs (title, source) values
("M-O-T-H-E-R (A Word That Means The World To Me)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "M-O-T-H-E-R (A Word That Means The World To Me)";

insert ignore into Songs (title, source) values
("Mother Machree", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Mother Machree";

insert ignore into Songs (title, source) values
("Mountain Greenery", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Mountain Greenery";

insert ignore into Songs (title, source) values
("Music, Maestro, Please!", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Music, Maestro, Please!";

insert ignore into Songs (title, source) values
("Muskrat Ramble", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Muskrat Ramble";

insert ignore into Songs (title, source) values
("My Baby Just Cares For Me", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "My Baby Just Cares For Me";

insert ignore into Songs (title, source) values
("My Blue Heaven", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "My Blue Heaven";

insert ignore into Songs (title, source) values
("My Foolish Heart", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "My Foolish Heart";

insert ignore into Songs (title, source) values
("My Funny Valentine", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "My Funny Valentine";

insert ignore into Songs (title, source) values
("My Gal Sal", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "My Gal Sal";

insert ignore into Songs (title, source) values
("My Heart Belongs To Daddy", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "My Heart Belongs To Daddy";

insert ignore into Songs (title, source) values
("My Heart Stood Still", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "My Heart Stood Still";

insert ignore into Songs (title, source) values
("My Mammy", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "My Mammy";

insert ignore into Songs (title, source) values
("My Melancholy Baby", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "My Melancholy Baby";

insert ignore into Songs (title, source) values
("My Mother's Eyes", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "My Mother's Eyes";

insert ignore into Songs (title, source) values
("My Prayer", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "My Prayer";

insert ignore into Songs (title, source) values
("My Wild Irish Rose", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "My Wild Irish Rose";

insert ignore into Songs (title, source) values
("My Yiddishe Momme", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "My Yiddishe Momme";

/* N */

insert ignore into Songs (title, source) values
("Nancy (With The Laughing Face)", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Nancy (With The Laughing Face)";

insert ignore into Songs (title, source) values
("Nature Boy", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Nature Boy";

insert ignore into Songs (title, source) values
("Near You", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Near You";

select title from Songs where title like("Nearness%");

select title from Songs where title = "Nearness Of You, The";

insert ignore into Songs (title, source) values
("Nearness Of You, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Nearness Of You, The";

insert ignore into Songs (title, source) values
("Nice Work If You Can Get It", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Nice Work If You Can Get It";

insert ignore into Songs (title, source) values
("Night And Day", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Night And Day";

insert ignore into Songs (title, source) values
("Nightingale Sang In Berkeley Square, A", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Nightingale Sang In Berkeley Square, A";

insert ignore into Songs (title, source) values
("Nobody Knows The Trouble I've Seen", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Nobody Knows The Trouble I've Seen";

insert ignore into Songs (title, source) values
("Nobody's Sweetheart", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Nobody's Sweetheart";

insert ignore into Songs (title, source) values
("Now Is The Hour", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Now Is The Hour";

/* O */

insert ignore into Songs (title, source) values
("Oh! Beautiful Doll", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Oh! Beautiful Doll";

insert ignore into Songs (title, source) values
("Oh! What It Seemed To Be", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Oh! What It Seemed To Be";

insert ignore into Songs (title, source) values
("Oh, Johnny, Oh!", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Oh, Johnny, Oh!";

insert ignore into Songs (title, source) values
("Oh, Lady Be Good!", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Oh, Lady Be Good!";

insert ignore into Songs (title, source) values
("Old Devil Moon", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Old Devil Moon";

insert ignore into Songs (title, source) values
("Old Father Thames", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Old Father Thames";

insert ignore into Songs (title, source) values
("On Green Dolphin Street", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "On Green Dolphin Street";

insert ignore into Songs (title, source) values
("On Mother Kelly's Doorstep", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "On Mother Kelly's Doorstep";

insert ignore into Songs (title, source) values
("On The Atchison, Topeka And The Santa Fe", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "On The Atchison, Topeka And The Santa Fe";

insert ignore into Songs (title, source) values
("On The Road To Mandalay", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "On The Road To Mandalay";

insert ignore into Songs (title, source) values
("On The Sunny Side Of The Street", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "On The Sunny Side Of The Street";

insert ignore into Songs (title, source) values
("On Top Of Old Smoky", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "On Top Of Old Smoky";

insert ignore into Songs (title, source) values
("Once In A While", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Once In A While";

insert ignore into Songs (title, source) values
("One For My Baby (And One More For The Road)", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "One For My Baby (And One More For The Road)";

insert ignore into Songs (title, source) values
("One I Love Belongs To Somebody Else, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "One I Love Belongs To Somebody Else, The";

insert ignore into Songs (title, source) values
("Only A Rose", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Only A Rose";

insert ignore into Songs (title, source) values
("Our Love Affair", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Our Love Affair";

insert ignore into Songs (title, source) values
("Over The Rainbow", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Over The Rainbow";

insert ignore into Songs (title, source) values
("Over There", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Over There";

/* P */

insert ignore into Songs (title, source) values
("Pack Up Your Troubles In Your Old Kit Bag  and Smile, Smile, Smile", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Pack Up Your Troubles In Your Old Kit Bag  and Smile, Smile, Smile";

insert ignore into Songs (title, source) values
("Painting The Clouds With Sunshine", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Painting The Clouds With Sunshine";

insert ignore into Songs (title, source) values
("Paper Doll", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Paper Doll";

insert ignore into Songs (title, source) values
("Paradise", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Paradise";

insert ignore into Songs (title, source) values
("Paradise For Two, A", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Paradise For Two, A";

insert ignore into Songs (title, source) values
("Pasadena", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Pasadena";

insert ignore into Songs (title, source) values
("Pedro The Fisherman", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Pedro The Fisherman";

insert ignore into Songs (title, source) values
("Peg O' My Heart", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Peg O' My Heart";

insert ignore into Songs (title, source) values
("Pennsylvania 6-5000", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Pennsylvania 6-5000";

insert ignore into Songs (title, source) values
("Pick Yourself Up", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Pick Yourself Up";

insert ignore into Songs (title, source) values
("Pipes Of Pan Are Calling, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Pipes Of Pan Are Calling, The";

insert ignore into Songs (title, source) values
("Pistol Packin' Mama", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Pistol Packin' Mama";

insert ignore into Songs (title, source) values
("Please Don't Talk About Me When I'm Gone", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Please Don't Talk About Me When I'm Gone";

insert ignore into Songs (title, source) values
("Poor Butterfly", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Poor Butterfly";

insert ignore into Songs (title, source) values
("Pretty Baby", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Pretty Baby";

insert ignore into Songs (title, source) values
("Put On Your Old Grey Bonnet", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Put On Your Old Grey Bonnet";

insert ignore into Songs (title, source) values
("Put Your Arms Around Me, Honey", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Put Your Arms Around Me, Honey";

/* Q */

/* R */

insert ignore into Songs (title, source) values
("Ragtime Cowboy Joe", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Ragtime Cowboy Joe";

insert ignore into Songs (title, source) values
("Red Roses For A Blue Lady", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Red Roses For A Blue Lady";

insert ignore into Songs (title, source) values
("Red Sails In The Sunset", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Red Sails In The Sunset";

insert ignore into Songs (title, source) values
("Rock-A-Bye Your Baby (With A Dixie Melody)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Rock-A-Bye Your Baby (With A Dixie Melody)";

insert ignore into Songs (title, source) values
("Room Five-Hundred-And-Four", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Room Five-Hundred-And-Four";

insert ignore into Songs (title, source) values
("Room With A View, A", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Room With A View, A";

insert ignore into Songs (title, source) values
("Rose Of The Rio Grande", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Rose Of The Rio Grande";

insert ignore into Songs (title, source) values
("Rose Of Washington Square", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Rose Of Washington Square";

insert ignore into Songs (title, source) values
("Rose Room", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Rose Room";

insert ignore into Songs (title, source) values
("Roses Of Picardy", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Roses Of Picardy";

insert ignore into Songs (title, source) values
("'Round Midnight", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "'Round Midnight";

insert ignore into Songs (title, source) values
("Route 66", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Route 66";

insert ignore into Songs (title, source) values
("Runaway Train, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Runaway Train, The";

insert ignore into Songs (title, source) values
("'S Wonderful", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "'S Wonderful";

/* S */

insert ignore into Songs (title, source) values
("S-H-I-N-E", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "S-H-I-N-E";

insert ignore into Songs (title, source) values
("Sally", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Sally";

insert ignore into Songs (title, source) values
("San Francisco", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "San Francisco";

insert ignore into Songs (title, source) values
("Sand In My Shoes", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Sand In My Shoes";

insert ignore into Songs (title, source) values
("Scarlet Ribbons", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Scarlet Ribbons";

insert ignore into Songs (title, source) values
("School Days (When We Were A Couple Of Kids)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "School Days (When We Were A Couple Of Kids)";

insert ignore into Songs (title, source) values
("Sea, The (La Mer)", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Sea, The (La Mer)";

insert ignore into Songs (title, source) values
("Second Hand Rose", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Second Hand Rose";

insert ignore into Songs (title, source) values
("Sentimental Journey", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Sentimental Journey";

insert ignore into Songs (title, source) values
("September In The Rain", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "September In The Rain";

insert ignore into Songs (title, source) values
("September Song", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "September Song";

insert ignore into Songs (title, source) values
("Shaking The Blues Away", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Shaking The Blues Away";

insert ignore into Songs (title, source) values
("She Is Ma Daisy", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "She Is Ma Daisy";

insert ignore into Songs (title, source) values
("Sheik Of Araby, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Sheik Of Araby, The";

insert ignore into Songs (title, source) values
("She's Funny That Way", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "She's Funny That Way";

insert ignore into Songs (title, source) values
("Shine On Harvest Moon", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Shine On Harvest Moon";

insert ignore into Songs (title, source) values
("Ship Without A Sail, A", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Ship Without A Sail, A";

insert ignore into Songs (title, source) values
("Side By Side", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Side By Side";

insert ignore into Songs (title, source) values
("Sidewalks Of New York, The (East Side, West Side)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Sidewalks Of New York, The (East Side, West Side)";

insert ignore into Songs (title, source) values
("Sing As We Go", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Sing As We Go";

insert ignore into Songs (title, source) values
("Singin' In The Rain", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Singin' In The Rain";

insert ignore into Songs (title, source) values
("Skylark", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Skylark";

insert ignore into Songs (title, source) values
("Skyliner", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Skyliner";

insert ignore into Songs (title, source) values
("Smiles", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Smiles";

insert ignore into Songs (title, source) values
("Smilin' Through", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Smilin' Through";

insert ignore into Songs (title, source) values
("Smoke Gets In Your Eyes", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Smoke Gets In Your Eyes";

insert ignore into Songs (title, source) values
("Some Day My Prince Will Come", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Some Day My Prince Will Come";

insert ignore into Songs (title, source) values
("Some Of These Days", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Some Of These Days";

insert ignore into Songs (title, source) values
("Somebody Loves Me", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Somebody Loves Me";

insert ignore into Songs (title, source) values
("Someone Rockin' My Dream Boat", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Someone Rockin' My Dream Boat";

insert ignore into Songs (title, source) values
("Someone to Watch Over Me", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Someone to Watch Over Me";

insert ignore into Songs (title, source) values
("Sometimes I'm Happy", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Sometimes I'm Happy";

insert ignore into Songs (title, source) values
("Song Of Songs, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Song Of Songs, The";

insert ignore into Songs (title, source) values
("South Of The Border", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "South Of The Border";

insert ignore into Songs (title, source) values
("Speak Low", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Speak Low";

insert ignore into Songs (title, source) values
("Spread a Little Happiness", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Spread a Little Happiness";

-- insert ignore into Songs (title, source) values
-- ("Star Dust", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

-- update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Star Dust";

-- delete from Songs where title = "Star Dust";

insert ignore into Songs (title, source) values
("Stars Will Remember, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Stars Will Remember, The";

insert ignore into Songs (title, source) values
("Stay As Sweet As You Are", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Stay As Sweet As You Are";

insert ignore into Songs (title, source) values
("Stella By Starnight", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Stella By Starnight";

insert ignore into Songs (title, source) values
("Steppin' Out With My Baby", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Steppin' Out With My Baby";

insert ignore into Songs (title, source) values
("Stomping At The Savoy", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Stomping At The Savoy";

insert ignore into Songs (title, source) values
("Stormy Weather", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Stormy Weather";

insert ignore into Songs (title, source) values
("Strike Up The Band", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Strike Up The Band";

insert ignore into Songs (title, source) values
("String Of Pearls, A", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "String Of Pearls, A";

insert ignore into Songs (title, source) values
("Summertime", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Summertime";

insert ignore into Songs (title, source) values
("Sun Has Got His Hat On, The", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Sun Has Got His Hat On, The";

insert ignore into Songs (title, source) values
("Sunday Kind Of Love, A", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Sunday Kind Of Love, A";

insert ignore into Songs (title, source) values
("Sunday, Monday Or Always", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Sunday, Monday Or Always";

insert ignore into Songs (title, source) values
("Sunshine Of Your Smile", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Sunshine Of Your Smile";

insert ignore into Songs (title, source) values
("Swanee", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Swanee";

insert ignore into Songs (title, source) values
("Sweet Adeline", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Sweet Adeline";

insert ignore into Songs (title, source) values
("Sweet And Lovely", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Sweet And Lovely";

insert ignore into Songs (title, source) values
("Sweet Georgia Brown", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Sweet Georgia Brown";

insert ignore into Songs (title, source) values
("Sweet Rosie O'Grady", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Sweet Rosie O'Grady";

insert ignore into Songs (title, source) values
("Sweetest Story Ever Told, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Sweetest Story Ever Told, The";

insert ignore into Songs (title, source) values
("Swinging On A Star", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Swinging On A Star";

insert ignore into Songs (title, source) values
("Sympathy", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Sympathy";

insert ignore into Songs (title, source) values
("S'posin'say It With Music", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "S'posin'say It With Music";

/* T */

insert ignore into Songs (title, source) values
("Ta-Ra-Ra Boom-de-ay", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Ta-Ra-Ra Boom-de-ay";

insert ignore into Songs (title, source) values
("'Tain't Nobody's Biz-Ness if I Do", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "'Tain't Nobody's Biz-Ness if I Do";

insert ignore into Songs (title, source) values
("Take Me Out To The Ballgame", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Take Me Out To The Ballgame";

insert ignore into Songs (title, source) values
("Take The 'A' Train", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Take The 'A' Train";

insert ignore into Songs (title, source) values
("Taking A Chance On Love", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Taking A Chance On Love";

insert ignore into Songs (title, source) values
("Tangerine", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Tangerine";

insert ignore into Songs (title, source) values
("Tea for Two", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Tea for Two";

insert ignore into Songs (title, source) values
("Temptation", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Temptation";

insert ignore into Songs (title, source) values
("Tenderly", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}, p.~212" 
where title = "Tenderly";

insert ignore into Songs (title, source) values
("Thanks For The Memory", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Thanks For The Memory";

insert ignore into Songs (title, source) values
("That Lovely Weekend", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "That Lovely Weekend";

insert ignore into Songs (title, source) values
("That Lucky Old Sun", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "That Lucky Old Sun";

insert ignore into Songs (title, source) values
("That Old Black Magic", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "That Old Black Magic";

insert ignore into Songs (title, source) values
("That Old Fashioned Mother Of Mine", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "That Old Fashioned Mother Of Mine";

insert ignore into Songs (title, source) values
("There Goes That Song Again", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "There Goes That Song Again";

insert ignore into Songs (title, source) values
("There Must Be A Way", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "There Must Be A Way";

insert ignore into Songs (title, source) values
("There's A Blue Ridge In My Heart Virginia", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "There's A Blue Ridge In My Heart Virginia";

insert ignore into Songs (title, source) values
("There's A Rainbow 'Round My Shoulder", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "There's A Rainbow 'Round My Shoulder";

insert ignore into Songs (title, source) values
("There's A Small Hotel", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "There's A Small Hotel";

insert ignore into Songs (title, source) values
("They Can't Take That Away From Me", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "They Can't Take That Away From Me";

insert ignore into Songs (title, source) values
("They're Changing The Guard at Buckingham Palace", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "They're Changing The Guard at Buckingham Palace";

insert ignore into Songs (title, source) values
("Things We Did Last Summer, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Things We Did Last Summer, The";

insert ignore into Songs (title, source) values
("This Can't Be Love", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "This Can't Be Love";

insert ignore into Songs (title, source) values
("Thou Swell", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Thou Swell";

insert ignore into Songs (title, source) values
("Three Little Words", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Three Little Words";

insert ignore into Songs (title, source) values
("Three O'clock In The Morning", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Three O'clock In The Morning";

insert ignore into Songs (title, source) values
("Tico-Tico (Tico-Tico No Fuba)", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Tico-Tico (Tico-Tico No Fuba)";

insert ignore into Songs (title, source) values
("Tiger Rag (Hold That Tiger!)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Tiger Rag (Hold That Tiger!)";

insert ignore into Songs (title, source) values
("Till We Meet Again", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Till We Meet Again";

insert ignore into Songs (title, source) values
("Time After Time", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Time After Time";

insert ignore into Songs (title, source) values
("Tip Toe Through The Tulips With Me", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Tip Toe Through The Tulips With Me";

insert ignore into Songs (title, source) values
("To Each His Own", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "To Each His Own";

insert ignore into Songs (title, source) values
("Too Darn Hot", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Too Darn Hot";

insert ignore into Songs (title, source) values
("Too Marvellous For Words", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Too Marvellous For Words";

insert ignore into Songs (title, source) values
("Too-Ra-Loo-Ra-Loo-Ral (That's An Irish Lullaby)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Too-Ra-Loo-Ra-Loo-Ral (That's An Irish Lullaby)";

insert ignore into Songs (title, source) values
("Toot Toot Toosie Goodbye", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Toot Toot Toosie Goodbye";

insert ignore into Songs (title, source) values
("Trolley Song, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Trolley Song, The";

insert ignore into Songs (title, source) values
("Twilight Time", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "Twilight Time";

insert ignore into Songs (title, source) values
("Two Little Boys", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Two Little Boys";

insert ignore into Songs (title, source) values
("Two Sleepy People", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Two Sleepy People";

/* U */

/* V */

insert ignore into Songs (title, source) values
("Valencia", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Valencia";

insert ignore into Songs (title, source) values
("Very Thought Of You, The", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Very Thought Of You, The";

insert ignore into Songs (title, source) values
("Vienna, City Of My Dreams", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Vienna, City Of My Dreams";

/* W */

insert ignore into Songs (title, source) values
("Wait Till The Sun Shines, Nellie", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Wait Till The Sun Shines, Nellie";

insert ignore into Songs (title, source) values
("Walkin' My Baby Back Home", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Walkin' My Baby Back Home";

insert ignore into Songs (title, source) values
("Waltzing In The Clouds", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Waltzing In The Clouds";

insert ignore into Songs (title, source) values
("Way Down Yonder In New Orleans", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Way Down Yonder In New Orleans";

insert ignore into Songs (title, source) values
("Way You Look Tonight, The", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Way You Look Tonight, The";

insert ignore into Songs (title, source) values
("Wee Wee Marie", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Wee Wee Marie";

insert ignore into Songs (title, source) values
("We'll Gather Lilacs", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "We'll Gather Lilacs";

insert ignore into Songs (title, source) values
("We'll Keep A Welcome", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "We'll Keep A Welcome";

insert ignore into Songs (title, source) values
("We're In The Money (The Gold Digger's Song)", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "We're In The Money (The Gold Digger's Song)";

insert ignore into Songs (title, source) values
("What A Difference A Day Made", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "What A Difference A Day Made";

insert ignore into Songs (title, source) values
("What Is This Thing Called Love?", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "What Is This Thing Called Love?";

insert ignore into Songs (title, source) values
("What'll I Do?", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "What'll I Do?";

insert ignore into Songs (title, source) values
("When April Sings", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "When April Sings";

insert ignore into Songs (title, source) values
("When Day Is Done", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "When Day Is Done";

insert ignore into Songs (title, source) values
("When I Take My Sugar To Tea", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "When I Take My Sugar To Tea";

insert ignore into Songs (title, source) values
("When Irish Eyes Are Smiling", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "When Irish Eyes Are Smiling";

insert ignore into Songs (title, source) values
("When It's Apple Blossom Time In Normandy", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "When It's Apple Blossom Time In Normandy";

insert ignore into Songs (title, source) values
("When I'm Cleaning Windows", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "When I'm Cleaning Windows";

insert ignore into Songs (title, source) values
("When My Baby Smiles At Me", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "When My Baby Smiles At Me";

insert ignore into Songs (title, source) values
("When My Sugar Walks Down The Street", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "When My Sugar Walks Down The Street";

insert ignore into Songs (title, source) values
("When Somebody Thinks You're Wonderful", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "When Somebody Thinks You're Wonderful";

insert ignore into Songs (title, source) values
("When The Red, Red Robin Comes Bob, Bob Bobbin' Along", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "When The Red, Red Robin Comes Bob, Bob Bobbin' Along";

insert ignore into Songs (title, source) values
("When The Saints Go Marching In", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "When The Saints Go Marching In";

insert ignore into Songs (title, source) values
("When You Wish Upon A Star", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "When You Wish Upon A Star";

insert ignore into Songs (title, source) values
("When You Wore A Tulip and I Wore A Big Red Rose", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "When You Wore A Tulip and I Wore A Big Red Rose";

insert ignore into Songs (title, source) values
("When You and I Were Seventeen", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "When You and I Were Seventeen";

insert ignore into Songs (title, source) values
("When Your Old Wedding Ring Was New", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "When Your Old Wedding Ring Was New";

insert ignore into Songs (title, source) values
("When You're Smiling", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}, p.~299.");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "When You're Smiling";

insert ignore into Songs (title, source) values
("When You're Smiling At Me", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "When You're Smiling At Me";

insert ignore into Songs (title, source) values
("Where Or When", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Where Or When";

insert ignore into Songs (title, source) values
("Whispering", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Whispering";

insert ignore into Songs (title, source) values
("Whispering Grass", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Whispering Grass";

insert ignore into Songs (title, source) values
("White Cliffs Of Dover, The", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "White Cliffs Of Dover, The";

insert ignore into Songs (title, source) values
("Who", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Who";

insert ignore into Songs (title, source) values
("Who's Sorry Now?", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Who's Sorry Now?";

insert ignore into Songs (title, source) values
("Who's Taking You Home Tonight", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Who's Taking You Home Tonight";

insert ignore into Songs (title, source) values
("Why Do I Love You", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Why Do I Love You";

insert ignore into Songs (title, source) values
("Will You Love Me In December  (As You Do In May?)", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Will You Love Me In December  (As You Do In May?)";

insert ignore into Songs (title, source) values
("Wind, Tell My Sweetheart", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Wind, Tell My Sweetheart";

insert ignore into Songs (title, source) values
("Winter Wonderland", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "Winter Wonderland";

insert ignore into Songs (title, source) values
("With A Song In My Heart", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "With A Song In My Heart";

insert ignore into Songs (title, source) values
("Without A Song", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Without A Song";

insert ignore into Songs (title, source) values
("Wonderful One", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Wonderful One";

insert ignore into Songs (title, source) values
("World Is Waiting For The Sunrise, The", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "World Is Waiting For The Sunrise, The";

/* X */

/* Y */

insert ignore into Songs (title, source) values
("Yankee Doodle Boy, The", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "Yankee Doodle Boy, The";

insert ignore into Songs (title, source) values
("Yes My Darling Daughter", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Yes My Darling Daughter";

insert ignore into Songs (title, source) values
("Yes Sir, That's My Baby", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "Yes Sir, That's My Baby";

insert ignore into Songs (title, source) values
("Yes! We Have No Bananas", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "Yes! We Have No Bananas";

insert ignore into Songs (title, source) values
("You Came Along (From Out Nowhere)", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "You Came Along (From Out Nowhere)";

insert ignore into Songs (title, source) values
("You Can't Stop The Yanks", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "You Can't Stop The Yanks";

insert ignore into Songs (title, source) values
("You Do Something To Me", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "You Do Something To Me";

insert ignore into Songs (title, source) values
("You Don't Have To Tell Me (I Know)", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "You Don't Have To Tell Me (I Know)";

insert ignore into Songs (title, source) values
("You Go To My Head", "{\\bf 100 Years of Popular Music, 1930s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 2}" where title = "You Go To My Head";

insert ignore into Songs (title, source) values
("You Made Me Love You", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "You Made Me Love You";

insert ignore into Songs (title, source) values
("You Make Me Feel So Young", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "You Make Me Feel So Young";

insert ignore into Songs (title, source) values
("You Must Have Been A Beautiful Baby", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "You Must Have Been A Beautiful Baby";

insert ignore into Songs (title, source) values
("You Stepped Out Of A Dream", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "You Stepped Out Of A Dream";

insert ignore into Songs (title, source) values
("You Tell Me Your Dream, I'll Tell You Mine", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "You Tell Me Your Dream, I'll Tell You Mine";

insert ignore into Songs (title, source) values
("Young And Healthy", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "Young And Healthy";

insert ignore into Songs (title, source) values
("Your Kiss Is Sweet", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = 
("Your Kiss Is Sweet",
"{\\bf 100 Years of Popular Music, 1900} and {\\bf 100 Years of Popular Music, 1920s, Volume 2}");

insert ignore into Songs (title, source) values
("Yours", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Yours";

insert ignore into Songs (title, source) values
("You'd Be So Nice To Come Home To", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "You'd Be So Nice To Come Home To";

insert ignore into Songs (title, source) values
("You'll Never Know", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "You'll Never Know";

insert ignore into Songs (title, source) values
("You're A Grand Old Flag", "{\\bf 100 Years of Popular Music, 1900}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1900}" where title = "You're A Grand Old Flag";

insert ignore into Songs (title, source) values
("You're Breaking My Heart", "{\\bf 100 Years of Popular Music, 1940s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 2}" where title = "You're Breaking My Heart";

insert ignore into Songs (title, source) values
("You're In Kentucky Sure As You're Born", "{\\bf 100 Years of Popular Music, 1920s, Volume 2}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 2}" where title = "You're In Kentucky Sure As You're Born";

insert ignore into Songs (title, source) values
("You're My Everything", "{\\bf 100 Years of Popular Music, 1930s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1930s, Volume 1}" where title = "You're My Everything";

insert ignore into Songs (title, source) values
("You're The Cream In My Coffee", "{\\bf 100 Years of Popular Music, 1920s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1920s, Volume 1}" where title = "You're The Cream In My Coffee";

insert ignore into Songs (title, source) values
("You've Done Something To My Heart", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "You've Done Something To My Heart";

/* Z */

insert ignore into Songs (title, source) values
("Zip-A-Dee-Doo-Dah.", "{\\bf 100 Years of Popular Music, 1940s, Volume 1}");

update Songs set source = "{\\bf 100 Years of Popular Music, 1940s, Volume 1}" where title = "Zip-A-Dee-Doo-Dah.";


/* * (1)  SELECT  */

select * from Songs where title = "Nobody's Sweetheart"\G

