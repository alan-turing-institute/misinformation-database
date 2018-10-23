IF OBJECT_ID('[batch]', 'U') IS NULL
CREATE TABLE [batch]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [name] NVARCHAR(max),
    [priority] INT,
    [created_date] DATETIMEOFFSET(7)
);
GO
IF OBJECT_ID('[batch_article]', 'U') IS NULL
CREATE TABLE [batch_article]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [batch_id] INT NOT NULL,
    [article_url] NVARCHAR(800),
    [added_date] DATETIMEOFFSET(7)
);
GO
