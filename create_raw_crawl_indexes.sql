-- Drop indexes
IF OBJECT_ID('[page_url_prefix_index]', 'U') IS NOT NULL
DROP INDEX [page_url_prefix_index] ON [raw_crawl];
IF OBJECT_ID('[crawl_site_index]', 'U') IS NOT NULL
DROP INDEX [crawl_site_index] ON [raw_crawl];
IF OBJECT_ID('[crawl_run_index]', 'U') IS NOT NULL
DROP INDEX [crawl_run_index] ON [raw_crawl];
GO
-- Recreate indexes
CREATE UNIQUE INDEX [page_url_prefix_index] ON [raw_crawl] ([page_url_prefix] ASC);
CREATE INDEX [crawl_site_index] ON [raw_crawl] ([site_url] ASC);
CREATE INDEX [crawl_run_index] ON [raw_crawl] ([site_url] ASC, [crawl_date] ASC);
GO