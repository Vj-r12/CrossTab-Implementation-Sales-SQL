

/**********          CROSSTAB / PIVOT TABLE          **********/ 



-- Q1. Create the cross tab to analyze the city performance of quantity sold in category.


CREATE EXTENSION TABLEFUNC;


WITH QUANTITY_SALES_PIVOT_TABLE AS
	(
		SELECT *
		FROM CROSSTAB ('select city,category,sum(quantity) from list_of_orders join orders_detail on
	                    list_of_orders.order_id = orders_detail.order_id group by city,category order by 1',
						'values (''Clothing''),(''Electronics''),(''Furniture'')')
		AS (CITY varchar,CLOTHING bigint,ELECTRONICS bigint,FURNITURE bigint)
		UNION
		SELECT *
		FROM CROSSTAB ('select ''Grand_total'',category,sum(quantity) from list_of_orders join orders_detail
	                    on list_of_orders.order_id = orders_detail.order_id group by category',
						'values (''Clothing''),(''Electronics''),(''Furniture'')') 
		AS (CITY varchar, CLOTHING bigint, ELECTRONICS bigint, FURNITURE bigint)
	)
SELECT CITY,
	CLOTHING,
	ELECTRONICS,
	FURNITURE,
	(CLOTHING + ELECTRONICS + FURNITURE) AS GRAND_TOTAL
FROM QUANTITY_SALES_PIVOT_TABLE
ORDER BY GRAND_TOTAL;



-- Q2. Create the cross tab to analyze the city amount of sales by category.


WITH AMOUNT_PIVOT_TABLE AS
	(
		SELECT *
		FROM CROSSTAB ('select city,category,sum(total_amount) from list_of_orders join orders_detail
					    on list_of_orders.order_id = orders_detail.order_id group by city,category order by 1',
					    'values (''Clothing''),(''Electronics''),(''Furniture'')') 
		AS (CITY varchar,CLOTHING bigint,ELECTRONICS bigint,FURNITURE bigint)
		UNION 
		SELECT *
		FROM CROSSTAB ('select ''Grand_Total'',category,sum(total_amount) from list_of_orders join orders_detail
					    on list_of_orders.order_id = orders_detail.order_id group by category',
						'values (''Clothing''),(''Electronics''),(''Furniture'')')
		AS (CITY varchar,CLOTHING bigint,ELECTRONICS bigint,FURNITURE bigint)
	)
SELECT CITY,
	CLOTHING,
	ELECTRONICS,
	FURNITURE,
    (CLOTHING + ELECTRONICS + FURNITURE) AS GRAND_TOTAL
FROM AMOUNT_PIVOT_TABLE
ORDER BY GRAND_TOTAL;	