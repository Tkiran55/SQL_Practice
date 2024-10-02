-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
    s.customer_id, 
    SUM(m.price) AS total_amount 
FROM 
    sales s
JOIN 
    menu m ON s.product_id = m.product_id
GROUP BY 
    s.customer_id;

-- 2. How many days has each customer visited the restaurant?
SELECT 
    s.customer_id, 
    COUNT(DISTINCT s.order_date) AS days_visited 
FROM 
    sales s
GROUP BY 
    s.customer_id;

-- 3. What was the first item from the menu purchased by each customer?
SELECT 
    s.customer_id, 
    m.product_name 
FROM 
    sales s
JOIN 
    menu m ON s.product_id = m.product_id
WHERE 
    s.order_date = (
        SELECT MIN(order_date) 
        FROM sales s2 
        WHERE s2.customer_id = s.customer_id
    )
GROUP BY 
    s.customer_id, 
    m.product_name
ORDER BY 
    s.customer_id DESC;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT 
    COUNT(s.product_id) AS most_purchased, 
    m.product_name 
FROM 
    sales s
JOIN 
    menu m ON s.product_id = m.product_id
GROUP BY 
    m.product_name
ORDER BY 
    most_purchased DESC
LIMIT 1;

-- 5. Which item was the most popular for each customer?
WITH customer_item_rank AS (
    SELECT
        s.customer_id,
        m.product_name,
        COUNT(s.product_id) AS purchase_count,
        ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY COUNT(s.product_id) DESC) AS rank
    FROM 
        sales s
    JOIN 
        menu m ON s.product_id = m.product_id
    GROUP BY 
        s.customer_id, m.product_name
)
SELECT 
    customer_id, 
    product_name AS most_popular_item
FROM 
    customer_item_rank
WHERE 
    rank = 1;

-- 6. Which item was purchased first by the customer after they became a member?
SELECT 
    s.customer_id, 
    m.product_name AS first_item_purchased_after_joining, 
    s.order_date
FROM 
    sales s
JOIN 
    menu m ON s.product_id = m.product_id
JOIN 
    members mb ON s.customer_id = mb.customer_id
WHERE 
    s.order_date >= mb.join_date
    AND s.order_date = (
        SELECT MIN(s2.order_date)
        FROM sales s2
        WHERE s2.customer_id = s.customer_id
        AND s2.order_date >= mb.join_date
    );

-- 7. Which item was purchased just before the customer became a member?
SELECT 
    s.customer_id, 
    m.product_name AS last_item_purchased_before_joining, 
    s.order_date
FROM 
    sales s
JOIN 
    menu m ON s.product_id = m.product_id
JOIN 
    members mb ON s.customer_id = mb.customer_id
WHERE 
    s.order_date < mb.join_date
    AND s.order_date = (
        SELECT MAX(s2.order_date)
        FROM sales s2
        WHERE s2.customer_id = s.customer_id
        AND s2.order_date < mb.join_date
    );

-- 8. What is the total items and amount spent for each member before they became a member?
SELECT 
    s.customer_id, 
    COUNT(s.product_id) AS total_items_purchased, 
    SUM(m.price) AS total_amount_spent
FROM 
    sales s
JOIN 
    menu m ON s.product_id = m.product_id
JOIN 
    members mb ON s.customer_id = mb.customer_id
WHERE 
    s.order_date < mb.join_date
GROUP BY 
    s.customer_id;

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT 
    s.customer_id,
    SUM(
        CASE
            WHEN m.product_name = 'sushi' THEN (m.price * 2) * 10  -- 2x points for sushi
            ELSE m.price * 10                                    -- Regular points
        END
    ) AS total_points
FROM 
    sales s
JOIN 
    menu m ON s.product_id = m.product_id
GROUP BY 
    s.customer_id;

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
WITH points_calculation AS (
    SELECT
        s.customer_id,
        m.product_name,
        m.price,
        s.order_date,
        mb.join_date,
        CASE 
            WHEN s.order_date >= mb.join_date AND s.order_date < mb.join_date + INTERVAL '7 days' 
            THEN (m.price * 2) * 10  -- 2x points for the first week
            ELSE m.price * 10         -- Regular points
        END AS points
    FROM 
        sales s
    JOIN 
        menu m ON s.product_id = m.product_id
    JOIN 
        members mb ON s.customer_id = mb.customer_id
    WHERE 
        s.order_date <= '2021-01-31'  -- Consider only purchases up to the end of January
)
SELECT 
    customer_id, 
    SUM(points) AS total_points
FROM 
    points_calculation
WHERE 
    customer_id IN ('A', 'B')  -- Filter for customers A and B
GROUP BY 
    customer_id;
