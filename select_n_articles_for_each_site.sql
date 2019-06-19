DECLARE @num_articles_per_site INT = 20;

WITH sorted_articles_by_site AS (
    SELECT *, ROW_NUMBER() 
    over (
        PARTITION BY [site_name] 
        order by [id]
    ) AS row_num 
    FROM [articles_dev]
)
SELECT * FROM sorted_articles_by_site WHERE row_num <= @num_articles_per_site
