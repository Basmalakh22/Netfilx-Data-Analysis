# Netfilx-Data-Analysis

## Overview

- This project explores and analyzes the Netflix Titles Dataset using SQL. The queries are designed to extract valuable insights, such as content distribution, popular genres, trends over time, and key contributors to the platform.

## Dataset

- The dataset used is netflix_titles, which includes the following key columns:
  - `show_id`
  - `type (Movie/TV Show)`
  - `title`
  - `director`
  - `cast`
  - `country`
  - `date_added`
  - `release_year`
  - `rating`
  - `duration`
  - `listed_in`
  - `description`

## SQL Queries Summary

1. General Dataset Preview

```sql
SELECT * FROM netflix_titles;
```

2. Movies vs TV Shows Count

- Counts the total number of Movies and TV Shows.

```sql
SELECT type, COUNT(*) AS total_content FROM netflix_titles GROUP BY type;
```

3. Most Common Rating per Type
- Finds the most frequent rating for both Movies and TV Shows.

4. Movies Released in 2020
-  Lists all Movies that were released in the year 2020.

5. Top 5 Countries by Content Count
- Identifies the top five countries with the most Netflix content.

6. Longest Movie
- Finds the longest movie in the dataset based on duration.

7. Recent Content
- Lists content added to Netflix in the last five years.

8. Director-Specific Content
- Finds all content by the director Rajiv Chilaka.

9. TV Shows with More Than 5 Seasons
- Lists all TV shows that have more than five seasons.

10. Genre Distribution
- Counts the number of content items in each genre.

11. India's Content Release Trends
- Finds the top five years with the highest average content release in India.

12. Documentaries
- Lists all movies categorized as Documentaries.

13. Content Without a Director
- Identifies content that lacks director information.

14. Salman Khan Movies in the Last 10 Years
- Counts the number of movies featuring Salman Khan released in the last decade.

15. Top 10 Actors in Indian Movies
- Finds the top 10 actors who have appeared most frequently in Indian-produced movies.

16. Content Categorization: 'Good' vs 'Bad'
- Categorizes content based on whether their descriptions contain the words 'kill' or 'violence'.

## Tools Used

- SQL Server (or equivalent RDBMS)
- SQL analytical functions (e.g., RANK(), STRING_SPLIT)
- Data cleaning with TRY_CAST, CHARINDEX, and TRIM

## Purpose

- This project helps in understanding:
- Content trends over time and geography
- Key contributors (directors, actors)
- Patterns in content type, rating, and genre
- Insights for marketing, recommendation systems, and content acquisition strategies
