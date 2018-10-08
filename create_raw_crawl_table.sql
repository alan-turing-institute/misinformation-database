-- Create the raw crawl table
CREATE TABLE [raw_crawl]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [page_url] NVARCHAR(850) NOT NULL, -- Max length restricted to half the 1700 byte max for a nonclustered index (max NVCHAR is 4000 and RFC 7230, section 3.1.1 recommends supporting at least 8000 octets)
    [site_url] NVARCHAR(800) NOT NULL, -- Max length restricted to less than half the 1700 byte max to permit some space for composite indexes including site URL
    [crawl_date] DATETIMEOFFSET(7), -- Datetime with timezone information
    [request] VARBINARY(max) NOT NULL,
    [raw_responses] VARBINARY(max) NOT NULL
);
GO
-- Create indexes 
CREATE UNIQUE INDEX [page_url_index] ON [raw_crawl] ([page_url] ASC);
CREATE INDEX [crawl_site_index] ON [raw_crawl] ([site_url] ASC);
CREATE INDEX [crawl_run_index] ON [raw_crawl] ([site_url] ASC, [crawl_date] ASC);
GO