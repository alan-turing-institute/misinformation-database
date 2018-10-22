Declare @JSON varchar(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'youngcons.com_extracted.txt', 
    DATA_SOURCE = 'misinformation_crawl_container',
    SINGLE_CLOB) as j

INSERT INTO [articles_v2](crawl_id, crawl_date, site_name, article_url,
    title, author, publication_date, plain_content,
    structured_content, metadata)
SELECT 
    crawl_id, crawl_date, site_name, article_url, title, author, publication_date,
    plain_content, structured_content, metadata FROM OPENJSON (@JSON) 
WITH(
    crawl_id UNIQUEIDENTIFIER,
    crawl_date DATETIMEOFFSET(7),
    site_name NVARCHAR(800),
    article_url NVARCHAR(800),
    title NVARCHAR(max),
    author NVARCHAR(max),
    publication_date DATETIME2(7),
    plain_content NVARCHAR(max) AS JSON,
    structured_content NVARCHAR(max) AS JSON,
    metadata NVARCHAR(max) AS JSON) as articles
