DELETE
FROM articles_dev
WHERE site_name='dailycaller.com' and (title is NULL OR byline is NULL)
