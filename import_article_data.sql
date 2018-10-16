Declare @JSON varchar(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'youngcons.com_extracted.txt', 
    DATA_SOURCE = 'misinformation_crawl_container',
    SINGLE_CLOB) as j

INSERT INTO [articles](site_name, crawl_date, article_url, content, metadata)
SELECT site_name, crawl_date, article_url, content, microformat_metadata AS metadata FROM OPENJSON (@JSON) 
WITH(
    site_name NVARCHAR(800),
    crawl_date DATETIMEOFFSET(7),
    article_url NVARCHAR(800),
    content NVARCHAR(max) AS JSON,
    microformat_metadata NVARCHAR(max) AS JSON) as articles
