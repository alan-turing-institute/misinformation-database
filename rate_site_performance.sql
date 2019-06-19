SELECT site_name,
    COUNT(CASE WHEN publication_datetime IS NULL THEN 1 END) AS no_date,
    COUNT(CASE WHEN byline IS NULL THEN 1 END) AS no_byline,
    COUNT(CASE WHEN title IS NULL THEN 1 END) AS no_title,
    COUNT(CASE WHEN content IS NULL THEN 1 END) AS no_content,
    COUNT(*) AS total
FROM articles_dev
GROUP BY site_name

-- SELECT * FROM articles_dev WHERE publication_datetime is NULL