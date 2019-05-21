SELECT site_name, CAST(publication_datetime as varchar(7)) AS date, COUNT(*) AS num_articles
FROM articles_dev
GROUP BY site_name, CAST(publication_datetime as varchar(7))
ORDER BY date