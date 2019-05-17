SELECT DATEPART(month, publication_datetime) AS month, DATEPART(year, publication_datetime) AS year, COUNT(*) AS num_articles
FROM articles_v5
WHERE site_name='prisonplanet.com'
GROUP BY DATEPART(year, publication_datetime), DATEPART(month, publication_datetime)