SELECT *
FROM netflix_titles

-- Count the number of Movies vs TV Shows
SELECT type,
       COUNT(*) as total_content
FROM netflix_titles
GROUP BY type

-- Find the most common rating for movies and TV shows
SELECT type,
       rating
FROM
(
SELECT type,
       rating,
	   COUNT(*) AS rating_count,
	   RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking

FROM netflix_titles
GROUP BY  type,rating
)AS t
WHERE ranking =  1

-- List all movies released in a specific year (e.g., 2020)
SELECT title,
       release_year
FROM netflix_titles
WHERE release_year = 2020

-- Find the top 5 countries with the most content on Netflix
SELECT TOP 5 TRIM(value) AS country,
             COUNT(*) AS total_content
FROM (
    SELECT show_id, 
	      value
    FROM netflix_titles
    CROSS APPLY STRING_SPLIT(country, ',')
    WHERE country IS NOT NULL
) AS split_data
GROUP BY TRIM(value)
ORDER BY total_content DESC

-- Identify the longest movie
SELECT title,
       duration
FROM netflix_titles
WHERE type = 'Movie'
      AND TRY_CAST(LEFT(duration, CHARINDEX(' ', duration + ' ') - 1) AS INT) = (
      SELECT MAX(TRY_CAST(LEFT(duration, CHARINDEX(' ', duration + ' ') - 1) AS INT))
	  FROM netflix_titles
	  WHERE type = 'Movie')

-- Find content added in the last 5 years
SELECT type,
       title,
       YEAR(date_added) AS year_added
FROM netflix_titles
WHERE date_added >=DATEADD(YEAR, -5, GETDATE()); -- WHERE YEAR(date_added) >= 2020


-- Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT type,
       title
FROM netflix_titles
WHERE director = 'Rajiv Chilaka'

-- List all TV shows with more than 5 seasons
SELECT type,
       duration
FROM netflix_titles
WHERE type = 'TV'
      AND ISNUMERIC(LEFT(duration, CHARINDEX(' ', duration + ' ') - 1)) = 1
      AND CAST(LEFT(duration, CHARINDEX(' ', duration + ' ') - 1) AS INT) > 5;



-- Count the number of content items in each genre
SELECT genre,
       COUNT(*) AS total_content
FROM (
    SELECT value AS genre
    FROM netflix_titles
    CROSS APPLY STRING_SPLIT(listed_in, ',')
) AS split_genres
GROUP BY genre
ORDER BY total_content DESC;

/* Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
*/
SELECT TOP 5
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        CAST(COUNT(show_id) AS FLOAT) / 
        (SELECT COUNT(show_id) FROM netflix_titles WHERE country = 'India') * 100, 
        2
    ) AS avg_release
FROM netflix_titles
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC;

-- List all movies that are documentaries
SELECT type,
       listed_in
FROM netflix_titles
WHERE type = 'Movie'
      AND listed_in = 'Documentaries'; 

-- Find all content without a director
SELECT title, 
       type, 
       director
FROM netflix_titles
WHERE director IS NULL 
      OR director = '';

-- Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT COUNT(*) AS total_movies
FROM netflix_titles
WHERE (cast LIKE '%Salman Khan%' OR cast LIKE '%Salman Khan%')
      AND YEAR(date_added) >= YEAR(GETDATE()) - 10
      AND type = 'Movie';

-- Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT TOP 10 actor_split.value AS actor,
       COUNT(*) AS number_of_movies
FROM netflix_titles
CROSS APPLY STRING_SPLIT(cast, ',') AS actor_split 
WHERE country = 'India'
    AND type = 'Movie'
GROUP BY actor_split.value
ORDER BY number_of_movies DESC;

/*
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/

SELECT 
    CASE 
        WHEN LOWER(description) LIKE '%kill%' OR LOWER(description) LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS content_category,
    COUNT(*) AS total_items
FROM netflix_titles
GROUP BY 
    CASE 
        WHEN LOWER(description) LIKE '%kill%' OR LOWER(description) LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END;
