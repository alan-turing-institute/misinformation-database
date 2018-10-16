-- Recreate indexes
CREATE UNIQUE INDEX [request_url_index] ON [raw_crawl] ([request_url] ASC) WITH (DROP_EXISTING = ON);
CREATE INDEX [site_name_index] ON [raw_crawl] ([site_name] ASC) WITH (DROP_EXISTING = ON);
CREATE INDEX [crawl_run_index] ON [raw_crawl] ([site_name] ASC, [crawl_date] ASC) WITH (DROP_EXISTING = ON);
GO