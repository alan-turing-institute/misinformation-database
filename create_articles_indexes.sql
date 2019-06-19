DROP INDEX IF EXISTS [article_url_index] ON [articles_dev]
DROP INDEX IF EXISTS [site_name_index] ON [articles_dev]
DROP INDEX IF EXISTS [crawl_run_index] ON [articles_dev]
DROP INDEX IF EXISTS [publication_datetime_article_url] ON [articles_dev]
DROP INDEX IF EXISTS [recently_inserted_articles_by_site] ON [articles_dev]
GO
CREATE UNIQUE INDEX [article_url_index] ON [articles_dev] ([article_url] ASC);
CREATE INDEX [site_name_index] ON [articles_dev] ([site_name] ASC);
CREATE INDEX [crawl_run_index] ON [articles_dev] ([site_name] ASC, [crawl_datetime] ASC);
CREATE INDEX [publication_datetime_article_url] ON [articles_dev] ([publication_datetime] ASC, [article_url] ASC);
CREATE INDEX [recently_inserted_articles_by_site] ON [articles_dev] ([site_name], [id] DESC);
GO
