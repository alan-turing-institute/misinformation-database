SELECT site_name, COUNT(*) AS num_pages_crawled
FROM webpages
GROUP BY site_name
ORDER BY site_name

