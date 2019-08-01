-- Update articles_v6 from articles_v5
UPDATE
    articles_v6
SET
    articles_v6.crawl_id = SELECTEDROWS.crawl_id,
    articles_v6.crawl_datetime = SELECTEDROWS.crawl_datetime,
    articles_v6.content = SELECTEDROWS.content,
    articles_v6.plain_content = SELECTEDROWS.plain_content,
    articles_v6.plain_text = SELECTEDROWS.plain_text
FROM
    articles_v6
    INNER JOIN
        (
            SELECT OLD.*
            FROM (    
                (SELECT DISTINCT article_url FROM annotations) ANNOTATIONS
                LEFT JOIN
                (SELECT * FROM articles_v5) OLD ON OLD.article_url = ANNOTATIONS.article_url
                LEFT JOIN
                (SELECT article_url FROM articles_v6) NEW ON NEW.article_url = ANNOTATIONS.article_url
            )
            WHERE NEW.article_url IS NOT NULL
        ) AS SELECTEDROWS
    ON
        (articles_v6.article_url = SELECTEDROWS.article_url) AND (articles_v6.site_name = SELECTEDROWS.site_name)

-- Insert rows in articles_v6 from articles_v5
INSERT INTO
    articles_v6 (crawl_id, crawl_datetime, site_name, article_url, title, byline, publication_datetime, content, plain_content, plain_text, metadata)
SELECT
    SELECTEDROWS.crawl_id, SELECTEDROWS.crawl_datetime, SELECTEDROWS.site_name, SELECTEDROWS.article_url, SELECTEDROWS.title, SELECTEDROWS.byline, SELECTEDROWS.publication_datetime, SELECTEDROWS.content, SELECTEDROWS.plain_content, SELECTEDROWS.plain_text, SELECTEDROWS.metadata
FROM
    (
        SELECT OLD.*
        FROM (    
            (SELECT DISTINCT article_url FROM annotations) ANNOTATIONS
            LEFT JOIN
            (SELECT * FROM articles_v5) OLD ON OLD.article_url = ANNOTATIONS.article_url
            LEFT JOIN
            (SELECT article_url FROM articles_v6) NEW ON NEW.article_url = ANNOTATIONS.article_url
        )
        WHERE NEW.article_url IS NULL
    ) AS SELECTEDROWS
