IF OBJECT_ID('[annotations]', 'U') IS NULL
CREATE TABLE [annotations]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [article_url] NVARCHAR(800) NOT NULL, -- Max non-clustesred index is 1700 chars. At worst case 2 bytes per UTF-16 char, this is 850 chars. Leave spare bytes for composite indexes. Note RFC 7230, section 3.1.1 recommends supporting at least 8000 octets for URLs 
    [annotation] NVARCHAR(max) NULL,
    [user_id] NVARCHAR(20) NOT NULL,
    [created_date] DATETIMEOFFSET(7) NULL, -- Datetime with timezone information
    [updated_date] DATETIMEOFFSET(7) NULL, -- Datetime with timezone information
    [status] INT NULL
);
GO
IF OBJECT_ID('[annotations]', 'U') IS NULL
ALTER TABLE [annotations]
ADD CONSTRAINT [Annotation data should be formatted as JSON]
CHECK (ISJSON([annotation])=1);
GO
IF OBJECT_ID('[annotations]', 'U') IS NULL
ALTER TABLE [annotations]
ADD CONSTRAINT [unique_record]
UNIQUE ([article_url], [user_id]);
GO
IF OBJECT_ID('[annotations]', 'U') IS NULL
ALTER TABLE [annotations]
ADD CONSTRAINT FK_article_annotation
FOREIGN KEY (article_url) REFERENCES articles(article_url);