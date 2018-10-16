Declare @JSON varchar(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'conservativehq.com_extracted.txt', 
    DATA_SOURCE = 'misinformation_crawl_container',
    SINGLE_CLOB) as j

INSERT INTO [articles]
SELECT site_name, article_url, crawl_date, content, microformat_metadata AS metadata FROM OPENJSON (@JSON) 
WITH(
    site_name NVARCHAR(800),
    article_url NVARCHAR(800),
    crawl_date DATETIMEOFFSET(7),
    content NVARCHAR(max) AS JSON,
    microformat_metadata NVARCHAR(max) AS JSON) as articles
