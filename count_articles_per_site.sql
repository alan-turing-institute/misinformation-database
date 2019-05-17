SELECT site_name, COUNT(*) AS num_articles
FROM articles_dev
GROUP BY site_name
