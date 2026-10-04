CREATE TABLE pizza_sales (
    pizza_id INTEGER PRIMARY KEY,
    order_id INTEGER ,
    pizza_name_id TEXT ,
    quantity INTEGER ,
    order_date DATE ,
    order_time TIME ,
    unit_price NUMERIC(10,2),
    total_price NUMERIC(10,2) ,
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name TEXT
);
select * from pizza_sales;

-- KPI
-- 1. TOTAL REVENUE
SELECT SUM(total_price) AS TOTAL_REVENUE FROM pizza_sales;

-- 2. TOTAL ORDERS
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales;

-- 3. AVERAGE ORDER VALUE
SELECT CAST(CAST(SUM(total_price) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
AS DECIMAL(10,2)) AS Avg_Pizzas_per_order
FROM pizza_sales;

-- 4. TOTAL PIZZA SOLD
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

-- 5. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;

select * from pizza_sales;
-- B.ANALYSIS

-- 1. Monthly Trend for Total Revenue
SELECT TO_CHAR( Order_date, 'MONTH') AS Month, 
SUM (total_price) AS total_revenue 
FROM pizza_sales
GROUP BY TO_CHAR( Order_date, 'MONTH');

-- 2. Daily Trend for Total Orders
SELECT TO_CHAR( Order_date, 'DAY') AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY TO_CHAR( Order_date, 'DAY');

-- 3. % of Sales by Pizza Category
SELECT pizza_category, 
CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- 4. % of Sales by Pizza Size
SELECT pizza_size, 
CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
order by pizza_size;

-- 5.Total Pizzas Sold by Pizza Size and Category
SELECT PIZZA_SIZE,SUM(QUANTITY) AS TOTAL_PIZZAS_SOLD
FROM PIZZA_SALES
GROUP BY PIZZA_SIZE;
SELECT PIZZA_CATEGORY,SUM(QUANTITY) AS TOTAL_PIZZAS_SOLD
FROM PIZZA_SALES
GROUP BY PIZZA_CATEGORY;

-- 6. Revenue by Pizza Name
SELECT PIZZA_NAME, SUM(TOTAL_PRICE) AS TOTAL_REVENUE
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_REVENUE ASC
LIMIT 5;

select * from pizza_sales;

-- Top & Bottom Analysis

-- 1. Top Pizza by Revenue
SELECT PIZZA_NAME, SUM(TOTAL_PRICE) AS TOTAL_REVENUE
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_REVENUE DESC
LIMIT 5;

-- 2. Bottom Pizza by Revenue
SELECT PIZZA_NAME, SUM(TOTAL_PRICE) AS TOTAL_REVENUE
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_REVENUE 
LIMIT 5;

-- 3. Top Pizza by Orders
SELECT PIZZA_NAME, COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_ORDERS DESC
LIMIT 5;

-- 4. Bottom Pizza by Orders
SELECT PIZZA_NAME, COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_ORDERS 
LIMIT 5;

-- 5.Top Pizza by Quantity Sold
SELECT PIZZA_NAME, SUM(QUANTITY) AS TOTAL_QUANTITY_SOLD
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_QUANTITY_SOLD DESC
LIMIT 5;

-- 6.Bottom Pizza by Quantity Sold
SELECT PIZZA_NAME, SUM(QUANTITY) AS TOTAL_QUANTITY_SOLD
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_QUANTITY_SOLD ASC
LIMIT 5;

