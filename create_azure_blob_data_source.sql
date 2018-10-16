CREATE MASTER KEY
GO
CREATE DATABASE SCOPED CREDENTIAL [database-crawl-storage-read]   
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'SAS_TOKEN_GOES_HERE' DELETE_ME;
GO
CREATE EXTERNAL DATA SOURCE misinformation_crawl_container
    WITH  (
        TYPE = BLOB_STORAGE,
        LOCATION = 'https://misinformation.blob.core.windows.net/crawl', 
        CREDENTIAL = [database-crawl-storage-read]  
    );
