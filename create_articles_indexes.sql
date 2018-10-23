IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('articles_v2') AND NAME ='article_url_index')
    DROP INDEX article_url_index ON articles_v2;
IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('articles_v2') AND NAME ='site_name_index')
    DROP INDEX site_name_index ON articles_v2;
IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('articles_v2') AND NAME ='crawl_run_index')
    DROP INDEX crawl_run_index ON articles_v2;
GO
CREATE UNIQUE INDEX [article_url_index] ON [articles_v2] ([article_url] ASC);
CREATE INDEX [site_name_index] ON [articles_v2] ([site_name] ASC);
CREATE INDEX [crawl_run_index] ON [articles_v2] ([site_name] ASC, [crawl_date] ASC);
GO