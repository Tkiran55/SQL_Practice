-- B. Runner and Customer Experience
-- How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT strftime('%Y-%W', registration_date) AS week_period, COUNT(*) AS runners_signed_up
FROM runners
GROUP BY week_period;

-- What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT runner_id, 
       AVG((strftime('%s', pickup_time) - strftime('%s', order_time)) / 60.0) AS average_minutes
FROM runner_orders ro
JOIN customer_orders co ON ro.order_id = co.order_id
WHERE ro.cancellation = ''
GROUP BY runner_id;

-- Is there any relationship between the number of pizzas and how long the order takes to prepare?
SELECT COUNT(co.order_id) AS number_of_pizzas, 
       AVG((strftime('%s', pickup_time) - strftime('%s', order_time)) / 60.0) AS average_preparation_time
FROM runner_orders ro
JOIN customer_orders co ON ro.order_id = co.order_id
WHERE ro.cancellation = ''
GROUP BY co.order_id
ORDER BY number_of_pizzas;

-- What was the average distance travelled for each customer?
SELECT co.customer_id, 
       AVG(CAST(REPLACE(ro.distance, 'km', '') AS FLOAT)) AS average_distance
FROM runner_orders ro
JOIN customer_orders co ON ro.order_id = co.order_id
WHERE ro.cancellation = ''
GROUP BY co.customer_id;

-- What was the difference between the longest and shortest delivery times for all orders?
SELECT (MAX(strftime('%s', ro.pickup_time) - strftime('%s', co.order_time)) / 60.0) -
       (MIN(strftime('%s', ro.pickup_time) - strftime('%s', co.order_time)) / 60.0) AS delivery_time_difference
FROM runner_orders ro
JOIN customer_orders co ON ro.order_id = co.order_id
WHERE ro.cancellation = '';

-- What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT runner_id,
       AVG(CAST(REPLACE(distance, 'km', '') AS FLOAT) / 
       (CAST(REPLACE(duration, 'minutes', '') AS FLOAT) / 60.0)) AS average_speed
FROM runner_orders
WHERE cancellation = ''
GROUP BY runner_id;

-- What is the successful delivery percentage for each runner?
SELECT runner_id,
       (COUNT(CASE WHEN cancellation = '' THEN 1 END) * 100.0 / COUNT(*)) AS successful_delivery_percentage
FROM runner_orders
GROUP BY runner_id;
