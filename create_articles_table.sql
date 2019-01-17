IF OBJECT_ID('[articles_v5]', 'U') IS NULL
CREATE TABLE [articles_v5]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [crawl_id] UNIQUEIDENTIFIER,
    [crawl_datetime] DATETIMEOFFSET(7), -- Datetime with timezone information
    [site_name] NVARCHAR(800) NOT NULL, 
    [article_url] NVARCHAR(800) NOT NULL UNIQUE, -- Max non-clustered index is 1700 chars. At worst case 2 bytes per UTF-16 char, this is 850 chars. Leave spare bytes for composite indexes. Note RFC 7230, section 3.1.1 recommends supporting at least 8000 octets for URLs 
    [title] NVARCHAR(max) NULL,
    [byline] NVARCHAR(max) NULL,
    [publication_datetime] DATETIME2(7),
    [content] NVARCHAR(max),
    [plain_content] NVARCHAR(max),
    [plain_text] NVARCHAR(max) NULL,
    [metadata] NVARCHAR(max) NULL,
);
GO
IF OBJECT_ID('[articles_v5]', 'U') IS NULL
ALTER TABLE [articles_v5]
ADD CONSTRAINT [plain_text_as_json]
CHECK (ISJSON([plain_text])=1);
ALTER TABLE [articles_v5]
ADD CONSTRAINT [metadata_as_json]
CHECK (ISJSON([metadata])=1);
