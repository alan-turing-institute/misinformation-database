IF OBJECT_ID('[raw_crawl]', 'U') IS NULL
CREATE TABLE [raw_crawl]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [site_name] NVARCHAR(800) NOT NULL, 
    [crawl_date] DATETIMEOFFSET(7), -- Datetime with timezone information
    [request_url] NVARCHAR(800) NOT NULL, -- Max non-clustesred index is 1700 chars. At worst case 2 bytes per UTF-16 char, this is 850 chars. Leave spare bytes for composite indexes. Note RFC 7230, section 3.1.1 recommends supporting at least 8000 octets for URLs 
    [response_url] NVARCHAR(max) NOT NULL -- May differ from original request URL if redirected
);
