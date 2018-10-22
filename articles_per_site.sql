SELECT site_name, COUNT(*) AS num_articles
FROM articles_v2
GROUP BY site_name