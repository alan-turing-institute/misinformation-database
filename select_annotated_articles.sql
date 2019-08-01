-- Select annotated articles that are either not in blob storage (no blob key) or not in the article database (no crawl id)
SELECT ANNOTATIONS.article_url, WEBPAGES.site_name, WEBPAGES.blob_key, ARTICLES.crawl_id
FROM (
    (SELECT DISTINCT article_url FROM annotations) ANNOTATIONS
    FULL OUTER JOIN
    (SELECT article_url, crawl_id FROM articles_v6) ARTICLES ON ARTICLES.article_url = ANNOTATIONS.article_url
    FULL OUTER JOIN
    (SELECT article_url, blob_key, site_name FROM webpages) WEBPAGES ON WEBPAGES.article_url = ANNOTATIONS.article_url
)
WHERE ANNOTATIONS.article_url IS NOT NULL AND (WEBPAGES.blob_key IS NULL OR ARTICLES.crawl_id IS NULL)
ORDER BY site_name ASC