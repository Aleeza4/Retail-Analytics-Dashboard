-- ============================================
-- Query 1: Top 10 Countries by Revenue
-- ============================================

SELECT
    c.country,
    ROUND(SUM(s.revenue), 2) AS total_revenue
FROM sales s
JOIN orders o
    ON s.invoice_no = o.invoice_no
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC
LIMIT 10;

-- ============================================
-- Query 2: Monthly Revenue Trend
-- ============================================

SELECT
    DATE_TRUNC('month', o.invoice_date::timestamp) AS month,
    ROUND(SUM(s.revenue), 2) AS total_revenue
FROM sales s
JOIN orders o
    ON s.invoice_no = o.invoice_no
GROUP BY month
ORDER BY month;

-- ============================================
-- Query 3: Top 20 Customers by Spending
-- ============================================

SELECT
    c.customer_id,
    c.country,
    ROUND(SUM(s.revenue), 2) AS total_spending
FROM sales s
JOIN orders o
    ON s.invoice_no = o.invoice_no
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.country
ORDER BY
    total_spending DESC
LIMIT 20;

-- ============================================
-- Query 4: Top Selling Products
-- ============================================

SELECT
    p.stock_code,
    p.description,
    SUM(s.quantity) AS total_quantity_sold,
    ROUND(SUM(s.revenue), 2) AS total_revenue
FROM sales s
JOIN products p
    ON s.stock_code = p.stock_code
GROUP BY
    p.stock_code,
    p.description
ORDER BY
    total_quantity_sold DESC
LIMIT 20;

-- ============================================
-- Query 5: Average Order Value by Country
-- ============================================

SELECT
    c.country,
    COUNT(DISTINCT o.invoice_no) AS total_orders,
    ROUND(SUM(s.revenue), 2) AS total_revenue,
    ROUND(
        SUM(s.revenue) / COUNT(DISTINCT o.invoice_no),
        2
    ) AS average_order_value
FROM sales s
JOIN orders o
    ON s.invoice_no = o.invoice_no
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY
    c.country
ORDER BY
    average_order_value DESC;