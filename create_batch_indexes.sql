IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('batch_article') AND NAME ='batch_article_index')
    DROP INDEX batch_article_index ON batch_article;
IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('batch_article') AND NAME ='article_url_index')
    DROP INDEX article_url_index ON batch_article;
GO
CREATE UNIQUE INDEX [batch_article_index] ON [batch_article] ([batch_id] ASC, [article_url] ASC);
CREATE INDEX [article_url_index] ON [batch_article] ([article_url] ASC);
GO
