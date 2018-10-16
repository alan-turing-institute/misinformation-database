SELECT site_name, COUNT(*) AS num_articles
FROM articles
GROUP BY site_name