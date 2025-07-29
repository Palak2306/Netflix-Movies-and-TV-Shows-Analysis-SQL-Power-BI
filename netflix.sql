create database NETFLIX;
use netflix;
select * from netflix_table;

describe netflix.netflix_table;
alter table netflix_table modify show_id varchar(502);
alter table netflix_table modify cast varchar(100000000);
alter table netflix_table modify title varchar(500);
alter table netflix_table modify director varchar(150);
alter table netflix_table modify country varchar(505);
alter table netflix_table modify rating varchar(500);
alter table netflix_table modify listed_in varchar(500);

/*Altering table for primary key contraints */

Alter table netflix_table ADD PRIMARY KEY (show_id);


#Q1. How many movies and TV shows are there in total?

 select count(distinct show_id) from netflix_table;

#Q2. What is the breakdown of movies vs. TV shows in the data? */

 SELECT
 (select count(*) from netflix_table where type = 'movie') as total_movies,
 (select count(*) from netflix_table where type = 'TV show') as Total_shows
 from netflix_table
 limit 1;
 
/* Q3. Total TV showes and movies marked under comedy genres? */
 
 select count(*) from netflix_table where listed_in like '%Comed%';

/* Q4. Total TV showes and movies marked under comedy Romantic? */

 select count(*) from netflix_table where listed_in like '%Roman%';

/* Q5. Compare the number of titles released per year, arrrange it in ascending order */

 select release_year, count(*) as total_release from netflix_table
 group by release_year
 order by release_year desc;

/* Q5.Select year where there was maximum release and count to release*/

 select  release_year, count(*) as total_release from netflix_table
 group by release_year
 order by total_release desc
limit 1;

/* Q6.List total release distribution over years ?*/
 select  release_year, count(*) as total_release from netflix_table
 group by release_year 
 order by total_release desc;

/* Q7.List distinct rating? */
  select distinct rating from netflix_table
  where rating not like '%min%' or rating not like Null;

 /* Q8. Alter table for incorrect data : update duration as 66 min, 74 min, 84 min 
  where show ID is s5814, s5542, s5795 respectively ? */

UPDATE netflix_titles 
SET duration = '66 min' 
WHERE show_id = 's5814';

UPDATE netflix_titles 
SET duration = '74 min' 
WHERE show_id = 's5542';

UPDATE netflix_titles 
SET duration = '84 min' 
WHERE show_id = 's5795';

/* Q9. Alter table for incorrect data : remove rating entry 
  where show ID is s5814, s5542, s5795 respectively ? */

UPDATE netflix_table 
SET rating = NULL
WHERE show_id = 's5814';

UPDATE netflix_table 
SET rating = NULL
WHERE show_id = 's5542';

UPDATE netflix_table 
SET rating = NULL
WHERE show_id = 's5795';

/* Q10. create seprate table for rating having two columns show_id and rating ? */

CREATE TABLE rating_list (
show_id varchar(25),
rating varchar(20)
);

INSERT INTO rating_list (show_id,rating) 
SELECT show_id,rating FROM netflix_table;

/* Q11. create seprate table for rating having two columns show_id and rating ? */

select * from rating_list;

/* Q12. show distribution based on rating ? */

select rating, count(show_id) as show_count from rating_list
group by rating;

/* Q13. Find our showes for which no rating given? */

select title from netflix_table where rating is null  ;

/* Q14. What are the top 10 most common rating categories used across all Netflix content, 
and how many titles fall under each? */

SELECT 
  rl.rating,
  COUNT(nt.show_id) AS total_titles
FROM 
  netflix_table nt
JOIN 
  rating_list rl ON nt.show_id = rl.show_id
GROUP BY 
  rl.rating
ORDER BY 
  total_titles DESC
LIMIT 10;