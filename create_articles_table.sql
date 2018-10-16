IF OBJECT_ID('[articles]', 'U') IS NULL
CREATE TABLE [articles]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [site_name] NVARCHAR(800) NOT NULL, 
    [crawl_date] DATETIMEOFFSET(7), -- Datetime with timezone information
    [article_url] NVARCHAR(800) NOT NULL, -- Max non-clustered index is 1700 chars. At worst case 2 bytes per UTF-16 char, this is 850 chars. Leave spare bytes for composite indexes. Note RFC 7230, section 3.1.1 recommends supporting at least 8000 octets for URLs 
    [content] NVARCHAR(max) NULL,
    [metadata] NVARCHAR(max) NULL,
);
GO
IF OBJECT_ID('[articles]', 'U') IS NULL
ALTER TABLE [articles]
ADD CONSTRAINT [Article metadata should be formatted as JSON]
CHECK (ISJSON([metadata])=1);