-- Commulative Analysis

-- Calculate the otal sales per month and the running total of sales over time

-- Calculate the total sales per month

-- and the running total of sales over time month

SELECT
	t.order_date,
	t.total_sales,
	-- UNBOUNDED PRECEDING AND CURRENT ROW
	SUM(t.total_sales)  OVER (ORDER BY t.order_date) AS running_total_sales
FROM (

SELECT
	DATETRUNC(month,order_date) as order_date,
	SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month,order_date)
) t

 -- experiment
SELECT
	t.order_date,
	t.total_sales,
	-- UNBOUNDED PRECEDING AND CURRENT ROW
	SUM(t.total_sales)  OVER (PARTITION BY YEAR(order_date) ORDER BY t.order_date) AS running_total_sales
FROM (

SELECT
	DATETRUNC(month,order_date) as order_date,
	SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month,order_date)
) t

-- and the running total of sales over time month
SELECT
	t.order_date,
	t.total_sales,
	-- UNBOUNDED PRECEDING AND CURRENT ROW
	SUM(t.total_sales)  OVER (ORDER BY t.order_date) AS running_total_sales
FROM (

SELECT
	DATETRUNC(year,order_date) as order_date,
	SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year,order_date)
) t



SELECT
	t.order_date,
	t.total_sales,
	-- UNBOUNDED PRECEDING AND CURRENT ROW
	SUM(t.total_sales)  OVER (ORDER BY t.order_date) AS running_total_sales,
	AVG(avg_price) OVER (ORDER BY t.order_date) AS moving_average
FROM (

SELECT
	DATETRUNC(month,order_date) as order_date,
	SUM(sales_amount) as total_sales,
	AVG(price) as avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month,order_date)
) t