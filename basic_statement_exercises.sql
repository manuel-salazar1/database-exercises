-- 1. SELECT [Which colums we want to use]
-- 2. FROM [which table we want to use]
-- 3. WHERE [how we're filtering our rows]

select database();
show databases;
use numbers;

-- show me categories for only supergroup one and rename

-- 1. write basic quary and run (SELECT * FROM table)
-- 2. use the WHERE to filter your rows
-- 3. go back to the SELECT and enter in the columns that you want run

-- Rename = as (i.e. category as supergroup_one_category

select category as supergroup_one_category, supergroup
from numbers2
WHERE supergroup = 'one'
;


-- BASIC STATEMENTS EXERCISE STARTS HERE!! :) 

show databases;
-- 1. use the albums_db batabase
use albums_db;
select database();

-- 2. what is the primary key for the albums table?
show tables;
show create table albums;
-- A) PRIMARY KEY (`id`)

-- 3. what does the column named 'name' represent?
SELECT *
FROM albums
;
-- A) the album name

-- 4. what do you think the sales column represents?
-- A) the amount of albums sold


-- 5. find the name of all albums by Pink Floyd. 
SELECT artist, name
FROM albums
WHERE artist = 'Pink Floyd'
;
-- A) The Dark Side of the Moon, The Wall


-- 6. what is the year Sgt. Pepper's lonely hearts club band was released?
SELECT release_date, name
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band"
;
-- A. 1967

-- 7. what is the genre for the album Nevermind?
SELECT genre, name
FROM albums
WHERE name = "Nevermind"
;
-- A. Grunge, Alternative rock

-- 8. which albums were released in the 1990's?
SELECT name, release_date
FROM albums
WHERE release_date BETWEEN 1990 AND 1999
;
/* 
A. The bodyguard, jagged little pill, come on over, falling into you
let's talk about love, dangerous, the immaculate collection,
titanic: music from the motion picture, metallica, nevermind, supernatural
*/

-- 9. which albums had less than 20 million certified sales?
SELECT name, sales as certified_sales
FROM albums
WHERE sales < 20
;

-- A. too many to list

