-- Recreate indexes
CREATE UNIQUE INDEX [article_url_index] ON [articles] ([article_url] ASC) WITH (DROP_EXISTING = ON);
CREATE INDEX [site_name_index] ON [articles] ([site_name] ASC) WITH (DROP_EXISTING = ON);
CREATE INDEX [crawl_run_index] ON [articles] ([site_name] ASC, [crawl_date] ASC) WITH (DROP_EXISTING = ON);
GO