DROP INDEX IF EXISTS [article_url_index] ON [webpages]
GO
CREATE UNIQUE INDEX [article_url_index] ON [webpages] ([article_url] ASC);
GO
