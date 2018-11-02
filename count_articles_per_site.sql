SELECT site_name, COUNT(*) AS num_articles
FROM articles_v3
GROUP BY site_name