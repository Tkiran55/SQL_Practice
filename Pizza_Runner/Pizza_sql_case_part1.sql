-- A. Pizza Metrics
-- How many pizzas were ordered?
SELECT COUNT(*) AS total_pizzas
FROM customer_orders;

-- How many unique customer orders were made?
SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM customer_orders;

-- How many successful orders were delivered by each runner?
SELECT runner_id, COUNT(DISTINCT order_id) AS successful_deliveries
FROM runner_orders
WHERE cancellation = ''
GROUP BY runner_id;

-- How many of each type of pizza was delivered?
SELECT p.pizza_name, COUNT(ro.order_id) AS pizzas_delivered
FROM runner_orders ro
JOIN customer_orders co ON ro.order_id = co.order_id
JOIN pizza_names p ON co.pizza_id = p.pizza_id
WHERE ro.cancellation = ''
GROUP BY p.pizza_name;

-- How many Vegetarian and Meatlovers were ordered by each customer?
SELECT co.customer_id,
       SUM(CASE WHEN p.pizza_name = 'Meatlovers' THEN 1 ELSE 0 END) AS MeatLovers,
       SUM(CASE WHEN p.pizza_name = 'Vegetarian' THEN 1 ELSE 0 END) AS Vegetarian
FROM customer_orders co
JOIN pizza_names p ON co.pizza_id = p.pizza_id
GROUP BY co.customer_id;

-- What was the maximum number of pizzas delivered in a single order?
SELECT MAX(pizza_count) AS max_pizzas
FROM (
    SELECT order_id, COUNT(*) AS pizza_count
    FROM customer_orders
    GROUP BY order_id
) AS order_counts;

-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT customer_id,
       SUM(CASE WHEN exclusions != '' OR extras IS NOT NULL THEN 1 ELSE 0 END) AS with_changes,
       SUM(CASE WHEN exclusions = '' AND extras IS NULL THEN 1 ELSE 0 END) AS without_changes
FROM customer_orders
WHERE order_id IN (SELECT order_id FROM runner_orders WHERE cancellation = '')
GROUP BY customer_id;

-- How many pizzas were delivered that had both exclusions and extras?
SELECT COUNT(*) AS pizzas_with_exclusions_and_extras
FROM customer_orders
WHERE exclusions != '' AND extras IS NOT NULL
AND order_id IN (SELECT order_id FROM runner_orders WHERE cancellation = '');

-- What was the total volume of pizzas ordered for each hour of the day?
SELECT strftime('%H', order_time) AS hour, COUNT(*) AS total_pizzas
FROM customer_orders
GROUP BY hour
ORDER BY hour;

-- What was the volume of orders for each day of the week?
SELECT strftime('%w', order_time) AS day_of_week, COUNT(*) AS total_orders
FROM customer_orders
GROUP BY day_of_week;
