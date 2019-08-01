-- Select db v5 articles that are not in blob storage
-- SELECT article_url FROM articles_v5 WHERE articles_v5.site_name NOT IN ('ladylibertysnews.com', 'madworldnews.com', 'palmerreport.com', 'westernjournal.com')
SELECT article_url FROM articles_v5 WHERE articles_v5.site_name IS 'dailykos.com'
EXCEPT
SELECT article_url FROM webpages;