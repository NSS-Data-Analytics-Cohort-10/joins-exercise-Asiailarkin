-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT specs.film_title, specs.release_year, revenue.worldwide_gross
FROM specs
INNER JOIN revenue
USING (movie_id)
ORDER BY revenue.worldwide_gross ASC;

-- "Semi-Tough", 1977, 37187139

-- 2. What year has the highest average imdb rating?

SELECT specs.release_year, AVG(rating.imdb_rating) AS avg_imdb_rating
FROM rating
INNER JOIN specs ON rating.movie_id = specs.movie_id
GROUP BY specs.release_year
ORDER BY AVG(rating.imdb_rating) DESC;

-- 1991 , 7.45

-- 3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT specs.film_title, specs.mpaa_rating, revenue.worldwide_gross
FROM specs
INNER JOIN revenue ON specs.movie_id = revenue.movie_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;

-- Toy Story 4

---------------------------------------------------------------------------

SELECT specs.film_title, distributors.company_name, specs.mpaa_rating, revenue.worldwide_gross
FROM specs
INNER JOIN revenue ON specs.movie_id = revenue.movie_id
INNER JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;

-- Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT distributors.company_name, COUNT(specs.film_title) AS number_of_movies
FROM distributors
FULL JOIN specs ON specs.domestic_distributor_id = distributors.distributor_id
GROUP BY distributors.company_name
ORDER BY number_of_movies DESC;


-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT distributors.company_name, AVG(revenue.film_budget) AS avg_film_budget
FROM specs
INNER JOIN revenue ON specs.movie_id = revenue.movie_id
INNER JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
GROUP BY distributors.company_name
ORDER BY avg_film_budget DESC
LIMIT 5;


-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT COUNT(specs.film_title)
FROM specs
INNER JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
WHERE distributors.headquarters NOT LIKE '%CA%';

-- 2

-------------------------------------------------------------------------------------

SELECT specs.film_title, distributors.company_name, distributors.headquarters, rating.imdb_rating
FROM specs
INNER JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN rating ON specs.movie_id = rating.movie_id
WHERE distributors.headquarters NOT LIKE '%CA%';

-- "Dirty Dancing" - 7.0

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT specs.film_title, AVG(rating.imdb_rating) AS avg_rating, specs.length_in_min
FROM specs
LEFT JOIN rating ON specs.movie_id = rating.movie_id
WHERE specs.length_in_min > 120
GROUP BY specs.length_in_min, specs.film_title

UNION

SELECT specs.film_title, AVG(rating.imdb_rating) AS avg_rating, specs.length_in_min
FROM specs
LEFT JOIN rating ON specs.movie_id = rating.movie_id
WHERE specs.length_in_min <= 120
GROUP BY specs.length_in_min, specs.film_title


-- Less than 2 hours


