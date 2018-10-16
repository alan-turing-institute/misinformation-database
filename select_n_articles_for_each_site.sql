WITH sorted_articles_by_site AS (
    SELECT *, ROW_NUMBER() 
    over (
        PARTITION BY [site_name] 
        order by [id]
    ) AS row_num 
    FROM [articles]
)
SELECT * FROM sorted_articles_by_site WHERE row_num <= 10