-- 1. Retrieve all columns from the Sales table.
SELECT * from Sales;

-- 2. Retrieve the product_name and unit_price from the Products table.
Select product_name, unit_price FROM Products;

-- 3. Retrieve the sale_id and sale_date from the Sales table.
SELECT sale_id, sale_date FROM Sales;

-- 4. Filter the Sales table to show only sales with a total_price greater than $100.
SELECT * from Sales 
WHERE total_price > 100;

-- 5. Filter the Products table to show only products in the ‘Electronics’ category.
SELECT * from Products
WHERE category = 'Electronics';

-- 6. Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024.
SELECT sale_id, total_price FROM Sales
WHERE sale_date = '2024-01-03';

-- 7. Retrieve the product_id and product_name from the Products table for products with a unit_price greater than $100.
SELECT product_id, product_name FROM Products
WHERE unit_price > 100;

-- 8. Calculate the total revenue generated from all sales in the Sales table.
SELECT SUM(total_price) as total_revenue FROM Sales;

-- 9. Calculate the average unit_price of products in the Products table.
SELECT AVG(unit_price) as average_unit_price FROM Products;

-- 10. Calculate the total quantity_sold from the Sales table.
SELECT SUM(quality_sold)AS total_quantity_sold FROM Sales;

-- 11. Retrieve the sale_id, product_id, and total_price from the Sales table for sales with a quantity_sold greater than 4.
SELECT sale_id, product_id, total_price from Sales
WHERE quality_sold > 4;

-- 12. Retrieve the product_name and unit_price from the Products table, ordering the results by unit_price in descending order.
SELECT product_name, unit_price FROM Products
ORDER BY unit_price DESC;

-- 13. Retrieve the total_price of all sales, rounding the values to two decimal places.
SELECT Round(sum(total_price),2) AS total_sales from Sales;

-- 14. Calculate the average total_price of sales in the Sales table.
SELECT AVG(total_price) AS average_total_price FROM Sales;

-- 15. Retrieve the sale_id and sale_date from the Sales table, formatting the sale_date as ‘YYYY-MM-DD’.
SELECT sale_id, DATE_FORMAT(sale_date, '%Y-%m-%d') AS formatted_date FROM Sales;

-- 16. Calculate the total revenue generated from sales of products in the ‘Electronics’ category.
SELECT SUM(Sales.total_price) as total_revenue, Products.product_name FROM Sales
JOIN Products on Sales.product_id = Products.product_id
where Products.category='Electronics';

-- 17. Retrieve the product_name and unit_price from the Products table, filtering the unit_price to show only values between $20 and $600.Products
SELECT product_name, unit_price FROM Products
where unit_price BETWEEN 20 AND 600;

-- 18. Retrieve the product_name and category from the Products table, ordering the results by category in ascending order.
SELECT product_name, category FROM Products
ORDER by category ASC;

-- 19. Calculate the total quantity_sold of products in the ‘Electronics’ category.
SELECT sum(quality_sold) as total_quantity_sold FROM Sales
join Products on Sales.product_id= Products.product_id
where Products.category = 'Electronics';

-- 20. Retrieve the product_name and total_price from the Sales table, calculating the total_price as quantity_sold multiplied by unit_price.
SELECT product_name, total_price FROM Sales
JOIN Products on Sales.product_id=Products.product_id
where total_price = quality_sold*unit_price;