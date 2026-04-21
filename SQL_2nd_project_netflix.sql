select * from netflix
 
-- 1 Count total number of records in the dataset. --

select count(*) as total_records from netflix

-- 2 Display first 10 rows of the dataset. --

select top 10 *  from netflix

-- 3 Find all unique content types. --

alter table netflix
alter column type varchar(50);


SELECT distinct type
FROM netflix;

-- 4 Count number of Movies. --

select count(title) as count_movies from netflix where type = 'Movie'

alter table netflix
alter column title varchar(500)

-- 5 Count number of TV Shows. --

select count(title) as count_movies from netflix where type = 'TV Show'

-- 6 Find all titles released in 2020. --

select show_id, title from netflix where release_year = 2020

-- 7 Find all titles produced in India. --

alter table netflix
alter column country varchar(500)

select show_id, title from netflix where country = 'India'

-- 8 Find all titles produced in United States. --

select show_id, title from netflix where country = 'United States'

-- 9 Display titles added to Netflix in 2021. --

select * from netflix where year(date_added) = 2021

-- 10 Count number of distinct countries. --

select distinct country from netflix

-- 11 List all unique ratings. -- 

select distinct rating as unique_ratings from netflix

-- 12 Find titles with rating TV-MA. --

select * from netflix where rating = 'TV-MA'

-- 13 Display movies only. --

select show_id, title as movies from netflix where type = 'Movie'

--14 Display TV shows only. --

select show_id, title as TV_shows from netflix where type = 'TV Show'

-- 15 Find titles released before 2000. --

select * from netflix where release_year < 2020

-- 16 Find titles released after 2018. --

select * from netflix where release_year > 2018

-- 17 Find titles where director name is missing. --

select * from netflix where director is NULL

-- 18 Find titles where cast information is missing. --

select * from netflix where cast is NULL

-- 19 Count titles where country is NULL. --

select * from netflix where country is null

-- 20 Find movies longer than 120 minutes. --

select *
from netflix
where type = 'Movie'
AND cast(replace(duration,'min','') as int) > 120;

-- 21 Find TV shows with more than 3 seasons. --

select * 
from netflix 
where type = 'TV Show' 
and cast(replace(replace(duration, 'Seasons', ''), 'Season', '') as int) > 2;

-- 22 Find titles containing word Love. --

select * from netflix where title  like '%Love%'

-- 23 Find titles containing word Life. --

select * from netflix where title like '%Life%'

-- 24 Find titles starting with letter A. --

select * from netflix where title like 'A%'

-- 25 Find titles ending with letter S. --

select * from netflix where title like '%S'

-- 26 Find titles containing Documentary genre. --

select * from netflix where title like '%Documentary%'

-- 27 Find movies released between 2015 and 2020. --

select * from netflix where type = 'Movie' and release_year between 2015 and 2020

-- 28 Find titles added after 2019. --

select title from netflix where year(date_added) > 2019

-- 29 Find titles added before 2015. --

select title from netflix where year(date_added) < 2015

-- 30 Find movies from India or United States. --

select * from netflix where type = 'Movie' and country in ('India', 'United States')

-- 31 Find titles where rating is R or PG-13. --

select title from netflix where rating in ('R', 'PG-13')

-- 32 Find titles where duration is 90 minutes. --

select title
from netflix 
where type = 'Movie'
and cast(replace(duration, 'min', '') as int) > 90;

-- 33 Find titles where genre contains Comedy. --

alter table netflix alter column listed_in varchar(200)

select title from netflix where listed_in like '%Comedies%'

-- 34 Find titles where genre contains Drama. --

select title from netflix where listed_in like '%Drama%'

-- 35 Find titles where description contains crime. --

select title from netflix where listed_in like '%crime%'

-- 36 Count number of titles by type. --

select type, count(title) as count_titles from netflix group by type

-- 37 Count number of titles by rating. --

select rating, count(title) as count_title from netflix group by rating

-- 38 Count number of titles by release year. --

select release_year, count(title) as count_title from netflix group by release_year 

-- 39 Find number of movies released each year. --

select release_year, count(type) 
from netflix 
where type = 'Movie' group by 
release_year order by release_year

-- 40 Find number of TV shows released each year. --

select release_year, count(type) as TV_shows_per_year 
from netflix 
where type = 'TV Show' 
group by release_year order by release_year

-- 41 Find top 10 countries producing Netflix content. --

select top 11 country, count(title) 
as content from netflix 
group by country order by content desc

-- 42 Find number of titles added each year. --

select year(date_added), count(title) as title_added
from netflix
group by year(date_added) order by year(date_added)

-- 43 Find number of titles added each month. --

select month(date_added), count(title) as title_added
from netflix
group by month(date_added) order by month(date_added)

 -- 44 Find top 10 directors with most titles. --

alter table netflix
alter column director varchar(max)

 select top 11 director, count(title) as directors_titles
 from netflix 
 group by director order by count(title) desc

 -- 45 Find number of titles by genre. --

 select listed_in, count(title) as by_genre
 from netflix 
 group by listed_in order by by_genre

 -- 46 Find average movie release year. --
 select avg(release) from
 (select release_year, count(type) as release 
 from netflix 
 where type = 'Movie' group by release_year) as releasing


-- 47 Find most recent release year. --

select top 1 release_year from netflix order by release_year desc

-- 48 Count titles for each rating category. --

select rating, count(title) as count_by_rating from netflix group by rating

-- 49 Find number of titles produced in each country. --

select country, count(title) as produced_by_country
from netflix 
group by country

-- 50 Find number of movies longer than 120 minutes. --

select title from netflix where type = 'Movie' and cast(replace(duration, 'min', '') as int) > 120

-- 51 Find number of TV shows with more than 2 seasons.

select title 
from netflix where type = 'TV show' 
and cast(replace(replace(duration, 'Seasons', ''), 'Season', '')as int) > 2

-- 52 Find number of titles for each genre and type.

select type, listed_in, count(title) as count_title
from netflix 
group by type, listed_in order by type

-- 53 Find average number of titles released per year. --

 select avg(release) from
 (select release_year, count(title) as release 
 from netflix 
 group by release_year) as releasing_per_year

 -- 54 Find total number of movies added to Netflix. --

 select top 1 type, count(title) as title_movies from netflix group by type order by type

 -- 55 Find most common rating for movies. --

 select top 1 rating, count(type) as type_rating 
 from netflix 
 where type = 'Movie' 
 group by rating order by count(type) desc

 -- 56 Find most common rating for TV shows. --

select top 1 rating, count(type) as type_rating 
from netflix 
where type = 'TV show' 
group by rating order by count(type) desc

-- 57 Find year with highest number of releases. --

select top 1 release_year, count(title) as highest_release
from netflix 
group by release_year order by count(title) desc

-- 58 Find year with lowest number of releases. -- 

select top 1 release_year, count(title) as lowest_release
from netflix 
group by release_year order by count(title) 

-- 59 Find country producing most movies. --

select top 1 country, count(type) as producing_movies 
from netflix 
where type = 'Movie' group by country order by producing_movies desc

-- 60 Find country producing most TV shows. --

select top 1 country, count(type) as producing_movies 
from netflix 
where type = 'TV Show' group by country order by producing_movies desc

-- 61 Find top 5 genres on Netflix. --

-- Movie --

select top 5 listed_in, count(type) as by_genre 
from netflix where type = 'Movie' 
group by listed_in order by by_genre desc

-- TV Show --

select top 5 listed_in, count(type) as by_genre 
from netflix where type = 'TV Show' 
group by listed_in order by by_genre desc

-- 62 Find least popular genres. --

-- Movie

select top 5 listed_in, count(type) as by_genre 
from netflix where type = 'Movie' 
group by listed_in order by by_genre

-- TV Show --

select top 5 listed_in, count(type) as by_genre 
from netflix where type = 'TV Show' 
group by listed_in order by by_genre

-- 63 Find average movie duration.

select avg(numeric_duration) from
(select cast(replace(duration, 'min', '') as int) as numeric_duration
from netflix 
where type = 'Movie') as average

-- 64 Find longest movie duration.

select top 1 numeric_duration from
(select cast(replace(duration, 'min', '') as int) as numeric_duration
from netflix 
where type = 'Movie') as average order by numeric_duration desc

-- 65 Find shortest movie duration. --

select top 4 numeric_duration from
(select cast(replace(duration, 'min', '') as int) as numeric_duration
from netflix 
where type = 'Movie') as t order by numeric_duration

-- 66Find oldest movie in dataset. -- 

select top 1 * from netflix order by release_year

-- 67 Find newest movie in dataset.--

select top 1 * from netflix order by release_year desc

-- 68 Find top actors appearing in most titles. --

alter table netflix
alter column cast nvarchar(max)

select top 1 * from (select cast, count(title) as count_tites from netflix group by cast) as t where
cast is not NULL order by cast

-- 69 Find directors who directed most Netflix titles. --

select * from (select director, count(title) as count_directors
from netflix 
group by director) as t 
where director is not null order by count_directors desc

-- 71 Categorize movies as Short (<90 min), Medium (90–120), Long (>120). --

select title,
case when cast(replace(duration, 'min', '') as int) < 90 then 'Short'
     when cast(replace(duration, 'min', '') as int) between 90 and 120 then 'Medium'
	 else 'Long'
	 end as categories_of_movies_duration
from netflix
where type = 'Movie'

-- 72 Categorize titles as Old (before 2000) or Modern. --

select title,
case when release_year < 2000 then 'Old'
     else 'Modern'
	 end as era
from netflix

-- 73 Categorize countries as USA vs Non-USA. --

select title, 
case when country = 'United States' then 'USA'
	 else 'Non-USA'
	 end as countries
from netflix

-- 74 Categorize ratings as Adult vs Kids. --

select distinct rating from netflix

select title,
case when rating in ('TV-Y', 'TV-Y7', 'TV-Y7-FV', 'TV-G', 'G') then 'Kids'
	 else 'Adults'
end as 'rating_category'
from netflix
where rating not like '%min%'

-- 75 Categorize movies as Classic (<2000) or New.--

select title,
case when release_year < 2000 then 'Classic'
     else 'New'
	 end as era
from netflix
where type = 'Movie'

-- 76 Create a column showing Movie or Series. --
select title,
case when type = 'Movie' then 'Movie'
	 else 'Series'
	 end as 'categories_type'
from netflix


select * from netflix


-- 81 Find movies with duration greater than average duration. --

select * from netflix where type = 'Movie' and cast(replace(duration, 'min', '') as int) > 
(select avg(cast(replace(duration, 'min', '') as int)) from netflix where type = 'Movie')

-- 82 Find countries with more titles than average country titles. --

select country, titles_count 
from  (
        select country, count(*) as titles_count 
        from netflix 
        group by country
 ) as t
 where titles_count > (
       select avg(titles_count) 
       from (
            select country, count(*) as titles_count 
            from netflix 
            group by country)as t2)

-- 83 Find years where releases were higher than average releases. --

select release_year, count_release_yr 
from (select release_year, count(release_year) as count_release_yr 
      from netflix 
      group by release_year) as t
where count_release_yr > (select avg(count_release_yr) 
                          from (select release_year, count(release_year) as count_release_yr 
                                from netflix 
                                group by release_year) as t)

-- 84 Find directors with more titles than average director titles. --

select director, directors_count from
(select director, count(title) as directors_count 
from netflix 
where director is not null group by director) as t
where directors_count > (select avg(directors_count) from (select director, count(title) as directors_count 
from netflix 
where director is not null group by director) as t)

-- 85 Find movies released in the most popular year. --

select title 
from netflix 
where type = 'Movie' and release_year = (select top 1 release_year
                                        from netflix 
                                        where type = 'Movie' group by release_year 
                                        order by count(title) desc)

-- 86 Find titles from countries producing top 5 content. --

select title, country from netflix where country in 
    (select top 5 country from netflix where country is not null
    group by country
    order by count(title) desc 
   ) 

-- 87 Find genres with above average number of titles. --

select listed_in, count_title_by_genere 
from (select listed_in, count(title) as count_title_by_genere 
      from netflix 
      group by listed_in) as t1 
where count_title_by_genere > (select avg(count_title_by_genere) as average 
                               from (select listed_in, count(title) as count_title_by_genere 
                                     from netflix 
                                     group by listed_in) as t)

-- 88 Find titles with longest duration using subquery. --

select title from netflix where type = 'Movie' and cast(replace(duration, 'min', '') as int) = 
(select max(cast(replace(duration, 'min', '') as int)) as max_duration from netflix where type = 'Movie')

-- 89 Find titles with highest release year. --
select title from netflix where release_year = (select max(release_year) from netflix)

-- 90 Find titles with lowest release year. --

select title from netflix where release_year = (select min(release_year) from netflix)

-- 91 Rank countries by number of titles. --

/* select * from(
select c.customer_id, c.name,
o.order_id, row_number()over(partition by c.customer_id order by c.customer_id)
as repeat_customer from customers c inner join
orders o on c.customer_id =o.customer_id)t where repeat_customer = 2 */

select country, dense_rank()over(order by count(title) desc) as rank_based_on_title from netflix where country is not null
group by country

-- 92 Rank directors by number of titles. --

select director, dense_rank()over(order by count(title) desc) as rank_based_on_title from netflix where director is not null
group by director

-- 93 Rank genres by popularity. --

select listed_in, dense_rank()over(order by count(title) desc) as rank_for_genre from netflix
group by listed_in

-- 94 Find top 5 countries using RANK(). --

select top 5 country, 
rank()over(order by count(title) desc) as top_5_countries 
from netflix 
where country is not null group by country

-- 95 Calculate running total of titles released per year. --

/* select order_date, sum(total_amount), sum(sum(total_amount))
over(order by order_date) as running_total from orders group by order_date */

select release_year, sum(total) over(order by release_year) as running_total from
(select release_year, count(title) as total from netflix group by release_year)as t

-- 96 Calculate cumulative titles added over years. --

select release_year, sum(total) over(order by release_year) as running_total from
(select release_year, count(title) as total from netflix group by release_year)as t

-- 97 Find top 3 directors using DENSE_RANK(). --

select director, rank_of_directors from (
select director, dense_rank()over(order by count(title) desc) as rank_of_directors 
from netflix where director is not null group by director) as t
where rank_of_directors <= 3

-- 98 Rank movies by release year. --

select release_year, title, rank()over(order by release_year) as rank_by_release_year
from netflix where type = 'Movie' and title is not null

-- 99 Calculate percentage contribution of each country. --

select country, (count_titles * 100.0 / sum(count_titles) over()) as percentages from
(
select country, count(title) as count_titles
from netflix 
where country is not null 
group by country) as t order by count_titles desc

select * from netflix

-- 100 Find top genre for each year using ROW_NUMBER(). --

select release_year, listed_in from
    (select release_year, listed_in, count(title) as genere_counting, 
    row_number()over(partition by release_year order by count(title) desc) as ranking
    from netflix 
    group by release_year, listed_in) as t
where ranking = 1

-- 101 Find year-wise growth rate of Netflix content --

select release_year, ((title_by_year - previous_year) * 1.0 / previous_year) * 100 as growth_rate 
from
    (select release_year, title_by_year, 
    lag(title_by_year, 1, 0) over(order by release_year) as previous_year 
    from
        (select release_year, count(title) as title_by_year 
        from netflix
         group by release_year) 
    as t) 
  as t1 where previous_year != 0

-- 102 Calculate moving average of releases (3-year window) --

select release_year, ((title_by_year + previous_year + previous_2_year) / 3) as average_years from
(select release_year, title_by_year, previous_year, lag(previous_year, 1, 0) over(order by release_year) as previous_2_year
from
(select release_year, title_by_year, 
    lag(title_by_year, 1, 0) over(order by release_year) as previous_year 
    from
        (select release_year, count(title) as title_by_year 
        from netflix
         group by release_year) 
    as t) as t1) as t2

-- 103 Find cumulative number of titles over years --

select release_year, count_of_title, sum(count_of_title) over(order by release_year) as cum_sum_of_titles from
(select release_year, count(title) as count_of_title 
from netflix 
group by release_year) as t

-- 104 Find year with highest growth in content --

select top 1 release_year, count_of_title - previous_year as growth 
from
    (select release_year, count_of_title, lag(count_of_title, 1, 0)over(order by release_year) as previous_year 
    from
        (select release_year, count(title) count_of_title 
        from netflix 
        group by release_year) as t) as t1 
        where previous_year is not null order by growth desc

-- 105 Compare growth of Movies vs TV Shows over time --

select release_year, movies_difference - TV_Show_difference as diff
from
    (select t1.release_year, t1.movies_difference, t2.TV_Show_difference
    from 
        (select release_year, movie_count - previous_movie_count as movies_difference
        from
            (select release_year, movie_count, lag(movie_count, 1, 0)over(order by release_year) as previous_movie_count
            from
            (select release_year, count(title) as movie_count
            from netflix 
            where type = 'Movie' group by release_year) as t) as t1) as t1

            inner join

        (select release_year, TV_Shows_count - previous_movie_count as TV_Show_difference
        from
            (select release_year, TV_Shows_count, lag(TV_Shows_count, 1, 0)over(order by release_year) as previous_movie_count
            from
                (select release_year, count(title) as TV_Shows_count
                from netflix 
                where type = 'TV Show' group by release_year) as t) 
            as t2
        ) as t2 
on t1.release_year = t2.release_year) as t3 order by release_year

-- 106 Top 5 directors per country using ROW_NUMBER() --

select director, country 
from 
    (select director, country, count(title) as directors_title_counts, 
    row_number()over(partition by country order by count(title) desc) as rank_of_directors
    from netflix 
    where director is not null and country is not null 
    group by director, country) as t
where rank_of_directors <= 5

select * from netflix

-- 107 Find most consistent directors (active across multiple years) --

select distinct director 
from 
(
    select director, release_year, count(title) as count_by_years, 
    row_number()over(partition by director order by release_year) as rank_by_consistency
    from netflix
    where director is not null 
    group by director, release_year) as t
where rank_by_consistency >= 3

-- 108 rank_genre within each year --

select release_year, listed_in, count(title) as rank_by_years, 
    row_number()over(partition by release_year order by count(title) desc) as ranks
from netflix 
group by release_year, listed_in


-- 109 top 3 director using dense rank()

select top 3 director, titles, 
dense_rank()over(order by titles desc) as rank_of_directors
from
    (select director, count(title) as titles 
    from netflix 
    where director is not null group by director) as t

-- 110 rank countries by total content contribution --

select country, titles_by_country, dense_rank()over(order by titles_by_country desc) as ranks
from
(select country, count(title) as titles_by_country 
from netflix 
where country is not null group by country) as t

-- 111 find countries contributing top 80% content

select country from 
(
select country, sum(percentages)over(order by country desc) as cumsum
from
(
select country, (titles_by_country * 100.0 / sum(titles_by_country) over()) as percentages 
from
(select country, count(title) as titles_by_country 
from netflix 
where country is not null group by country) as t 
) as t1) as t2 
where cumsum <= 83.50

-- 112 find directors above average number of titles --

select director 
from (select director, count(title) as titles_by_directors 
     from netflix 
     where director is not null group by director) as t
where titles_by_directors > (select avg(titles_by_directors) 
            from (select director, count(title) as titles_by_directors 
                 from netflix 
                 where director is not null group by director) as t1)

-- 113 find genre with above average popularity --

select listed_in 
from (select listed_in, count(title) as count_by_titles 
     from netflix 
     group by listed_in) as t
where count_by_titles > (select avg(count_by_titles) 
                        from (select listed_in, count(title) as count_by_titles 
                             from netflix group by listed_in) as t1)

-- 114 find the title released in most popular year -- 

select title 
from netflix
where release_year = 
    (select release_year 
    from (select release_year, count(title) as count_by_release_year 
          from netflix 
          group by release_year) as t
    where count_by_release_year = 
        (select max(count_by_release_year) 
        from (select release_year, count(title) as count_by_release_year 
             from netflix group by release_year) as t1))


-- 115 find countries with more than average titles

select country
from (select country, count(title) as count_title_by_country 
      from netflix 
      group by country) as t
where count_title_by_country > (select avg(count_title_by_country) 
                                from (select country, count(title) as count_title_by_country 
                                      from netflix 
                                      group by country) as t1)

-- 116 running total of titles per year --

select release_year, sum(titles_by_years)over(order by release_year) as cum_sum
from
(select release_year, count(title) as titles_by_years from netflix group by release_year) as t

-- 117 running total of titles per country --

select country, sum(titles_by_country)over(order by country) as cum_sum
from
(select country, count(title) as titles_by_country from netflix where country is not null group by country) as t

-- 118 percentages countribution of each country -- 

select country, percentages_by_country 
from (select country, (count_using_country * 100.0 / sum(count_using_country)over()) as percentages_by_country 
     from (select country, count(title) as count_using_country 
           from netflix 
           where country is not null group by country) as t) as t1
order by percentages_by_country desc

-- 119 year over year growth using lag() --

select release_year, (titles_by_years - previous_year) as growth
from
    (select release_year, titles_by_years, 
     lag(titles_by_years, 1, 0) over(order by release_year) as previous_year
    from
        (select release_year, count(title) as titles_by_years 
         from netflix group by release_year) as t) as t1

-- 120 compare current year VS previous year releases

select release_year, (titles_by_years - previous_year) as growth
from
    (select release_year, titles_by_years, 
     lag(titles_by_years, 1, 0) over(order by release_year) as previous_year
    from
        (select release_year, count(title) as titles_by_years 
         from netflix group by release_year) as t) as t1

-- 121 which country produce most movies --

select top 1 country from
(select country, count(title) as count_by_country
from netflix 
where type = 'Movie' and country is not null 
group by country) as t order by count_by_country desc

-- 122 which country produce most TV Shows --

select top 1 country from
(select country, count(title) as count_by_country
from netflix 
where type = 'TV Show' and country is not null 
group by country) as t order by count_by_country desc

-- 123 most common rating per country

select country, count_by_rating from
(select country, rating, count(rating) as count_by_rating, 
row_number()over(partition by country order by count(rating) desc) as ratings 
from netflix 
where rating is not null and country is not null 
group by country, rating) as t
where ratings = 1

-- 124 most popular genre overall --

select * from netflix

select top 1 listed_in from
(select listed_in, count(title) as count_by_genre 
from netflix 
group by listed_in) as t 
order by count_by_genre desc

-- 125 content distribution (Movies VS TV Shows)

select type, (title_by_type * 100.0 / (select sum(title_by_type)
                                       from (select type, count(title) as title_by_type 
                                            from netflix 
                                            group by type)as t )) as distribution
from (select type, count(title) as title_by_type 
      from netflix 
      group by type) as t2

-- 126 Directors in multiple countries --

select director, multiple_countries 
from (select director, count(distinct country) as multiple_countries 
      from netflix 
      where director is not null group by director) as t
where multiple_countries > 1 order by multiple_countries desc

-- 127 Directors : Movies + TV Show --

select t1.director, t1.by_movies, t2.by_TV_Shows 
from
(select director, count(title) as by_movies 
from netflix 
where director is not null and type = 'Movie' 
group by director) as t1

inner join

(select director, count(title) as by_TV_Shows
from netflix 
where director is not null and type = 'TV Show' 
group by director) as t2

on t1.director = t2.director




































 



 


