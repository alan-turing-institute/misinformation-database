-- Create the raw crawl table
CREATE TABLE [raw_crawl]
(
    [id] INT NOT NULL IDENTITY PRIMARY KEY,
    [url] NVARCHAR(850) NOT NULL, -- Max length restricted to half the 1700 byte max for a nonclustered index (max NVCHAR is 4000 and RFC 7230, section 3.1.1 recommends supporting at least 8000 octets)
    [request] VARBINARY(max) NOT NULL,
    [raw_responses] VARBINARY(max) NOT NULL
);
GO
-- Create indexes 
CREATE UNIQUE INDEX [url_index] ON [raw_crawl] ([url] ASC);
GO