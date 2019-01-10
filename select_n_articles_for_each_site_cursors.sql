DECLARE @Count INT = 5;
DECLARE @SiteCursor CURSOR;
DECLARE @SiteUrl NVARCHAR(800)
DECLARE @CursorResult TABLE (article_url nvarchar(800)) 

BEGIN
   SET @SiteCursor = CURSOR FOR
   SELECT DISTINCT site_name from dbo.articles_v4

   OPEN @SiteCursor
   FETCH NEXT FROM @SiteCursor
   INTO @SiteUrl

   WHILE @@FETCH_STATUS = 0
   BEGIN
       INSERT INTO @CursorResult
       SELECT TOP (10) article_url
       FROM articles_v4
       WHERE site_name = @SiteUrl

       FETCH NEXT FROM @SiteCursor
       INTO @SiteUrl
   END;

   CLOSE @SiteCursor;
   DEALLOCATE @SiteCursor;
END;

SELECT * FROM @CursorResult