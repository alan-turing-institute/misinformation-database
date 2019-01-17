DROP INDEX IF EXISTS [article_url_index] ON [articles_v5]
DROP INDEX IF EXISTS [site_name_index] ON [articles_v5]
DROP INDEX IF EXISTS [crawl_run_index] ON [articles_v5]
GO
CREATE UNIQUE INDEX [article_url_index] ON [articles_v5] ([article_url] ASC);
CREATE INDEX [site_name_index] ON [articles_v5] ([site_name] ASC);
CREATE INDEX [crawl_run_index] ON [articles_v5] ([site_name] ASC, [crawl_datetime] ASC);
CREATE INDEX [publication_datetime_article_url] ON [articles_v5] ([publication_datetime] ASC, [article_url] ASC);
GO
