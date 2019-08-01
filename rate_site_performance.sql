SELECT WEBPAGES.site_name, WEBPAGES.num_pages_crawled, ARTICLES.num_articles, ARTICLES.no_date, ARTICLES.no_byline, ARTICLES.no_title, ARTICLES.no_content
FROM (
    (
        SELECT site_name,
            COUNT(CASE WHEN publication_datetime IS NULL THEN 1 END) AS no_date,
            COUNT(CASE WHEN byline IS NULL THEN 1 END) AS no_byline,
            COUNT(CASE WHEN title IS NULL THEN 1 END) AS no_title,
            COUNT(CASE WHEN content IS NULL THEN 1 END) AS no_content,
            COUNT(*) AS num_articles
        FROM articles_v6
        GROUP BY site_name
    ) ARTICLES
    FULL OUTER JOIN
    (
        SELECT site_name,
            COUNT(*) AS num_pages_crawled
        FROM webpages
        GROUP BY site_name
    ) WEBPAGES
    ON WEBPAGES.site_name = ARTICLES.site_name
)
ORDER BY site_name ASC