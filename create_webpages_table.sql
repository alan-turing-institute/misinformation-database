IF OBJECT_ID('[webpages]', 'U') IS NULL
CREATE TABLE [webpages]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [site_name] NVARCHAR(800) NOT NULL, -- domain name of the site
    [article_url] NVARCHAR(800) NOT NULL UNIQUE, -- max non-clustered index is 1700 chars. At worst case 2 bytes per UTF-16 char, this is 850 chars. Leave spare bytes for composite indexes. Note RFC 7230, section 3.1.1 recommends supporting at least 8000 octets for URLs 
    [crawl_id] UNIQUEIDENTIFIER, -- identifier of this crawling session
    [crawl_datetime] DATETIME2(7), -- UTC time when crawl was carried out (cannot use DATETIMEOFFSET here as it does not work with pyodbc)
    [blob_key] NVARCHAR(800) NULL, -- location of HTML in blob storage
);
