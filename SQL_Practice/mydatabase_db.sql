-- Creating Sales table

CREATE TABLE Sales (
  sale_id PRIMARY key, 
  product_id INT,
  quality_sold INT, 
  sale_date DATE, 
  total_price DECIMAL(10,2)
  );

-- Inserting data into Sales table  
INSERT INTO sales (sale_id, product_id, quality_sold, sale_date, total_price) VALUES 
(1,101,5,'2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);

-- Creating Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

-- Inserting data into Products table
INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);