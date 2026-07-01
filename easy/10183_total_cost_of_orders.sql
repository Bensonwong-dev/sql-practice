-- Problem: Total Cost Of Orders
-- Source: StrataScratch ID 10183
-- Difficulty: Easy
-- Date: June 2026

-- ===========================================
-- MY SOLUTION (correct, clean)
-- JOIN + SUM aggregate
-- ===========================================

SELECT o.cust_id, c.first_name, SUM(o.total_order_cost) AS total_cost
FROM customers c
JOIN orders o ON o.cust_id = c.id
GROUP BY o.cust_id, c.first_name
ORDER BY c.first_name

-- ===========================================
-- WHAT I LEARNED
-- ===========================================

-- 1. When ORDER BY uses a non-aggregated column,
--    include it in GROUP BY too
--    Strict SQL mode will reject it otherwise
--    Portable and interview-safe habit

-- 2. Always alias aggregate columns clearly
--    SUM(...) AS total_cost not left unnamed

-- 3. Simple JOIN + GROUP BY + aggregate
--    is the right tool here — no window function needed
--    Recognising the simplest approach = maturity
