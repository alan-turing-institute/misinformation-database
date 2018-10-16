-- Drop indexes
IF OBJECT_ID('[request_url_index]', 'U') IS NOT NULL
DROP INDEX [request_url_index] ON [raw_crawl];
IF OBJECT_ID('[site_name_index]', 'U') IS NOT NULL
DROP INDEX [site_name_index] ON [raw_crawl];
IF OBJECT_ID('[crawl_run_index]', 'U') IS NOT NULL
DROP INDEX [crawl_run_index] ON [raw_crawl];
GO
-- Recreate indexes
CREATE UNIQUE INDEX [request_url_index] ON [raw_crawl] ([request_url] ASC);
CREATE INDEX [site_name_index] ON [raw_crawl] ([site_name] ASC);
CREATE INDEX [crawl_run_index] ON [raw_crawl] ([site_name] ASC, [crawl_date] ASC);
GO