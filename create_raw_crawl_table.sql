IF OBJECT_ID('[raw_crawl]', 'U') IS NULL
CREATE TABLE [raw_crawl]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [page_url_prefix] NVARCHAR(800) NOT NULL, -- Max non-clustesred index is 1700 chars. At worst case 2 bytes per UTF-16 char, this is 850 chars. Leave spare bytes for composite indexes.
    [page_url] NVARCHAR(4000) NOT NULL, -- Max nvarchar length is 4000 (although RFC 7230, section 3.1.1 recommends supporting at least 8000 octets)
    [site_url] NVARCHAR(4000) NOT NULL, 
    [crawl_date] DATETIMEOFFSET(7), -- Datetime with timezone information
    [request] VARBINARY(max) NOT NULL,
    [raw_responses] VARBINARY(max) NOT NULL
);