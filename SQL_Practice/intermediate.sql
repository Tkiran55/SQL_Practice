-- 1. Calculate the total revenue generated from sales for each product category.
SELECT sum(total_price) as total_revenue, category FROM Sales
join Products on Sales.product_id = Products.product_id
GROUP by Products.category;

-- 2. Find the product category with the highest average unit price.
SELECT category from Products
GROUP BY category
ORDER BY AVG(unit_price) DESC
LIMIT 1;

--3. Identify products with total sales exceeding 30.Products
SELECT p.product_name
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.total_price) > 30;

-- 4. Count the number of sales made in each month.
SELECT DATE_FORMAT(s.sale_date, '%Y-%m') AS month, COUNT(*) AS sales_count
FROM Sales s
GROUP BY month;

-- 5. Determine the average quantity sold for products with a unit price greater than $100.Products
SELECT AVG(quality_sold) FROM Sales
JOIN Products on Sales.product_id = Products.product_id
where unit_price > 100;

-- 6. Retrieve the product name and total sales revenue for each product.
SELECT product_name, SUM(total_price) FROM Sales
JOIN Products on Sales.product_id = Products.product_id
GROUP by product_name;

-- 7. List all sales along with the corresponding product names.
SELECT sale_id, product_name FROM Sales
JOIN Products on Sales.product_id = Products.product_id

-- 8. Retrieve the product name and total sales revenue for each product.
