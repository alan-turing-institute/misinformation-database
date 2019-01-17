-- Add new batch to the table of batches
INSERT INTO [batch](name, priority, created_date, active) 
VALUES ('First annotation batch', 1, '2019-01-09', 1)

-- Create batch for articles that are currently being added
INSERT INTO [batch](name, priority, created_date, active) 
VALUES ('Current crawl', 10, '2019-01-09', 0)

-- Make old batch inactive
UPDATE [batch] 
SET active = 0
WHERE id = 1 

-- Add articles into batch_article table
INSERT INTO [batch_article](batch_id, article_url, added_date)
SELECT 4, article_url, '01/09/2019' FROM [articles_v5]
