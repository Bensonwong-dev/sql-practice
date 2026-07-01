-- Problem: Calculate Samantha's and Lisa's Total Sales Revenue
-- Source: StrataScratch ID 10127
-- Difficulty: Easy
-- Date: July 2026

-- ===========================================
-- MY SOLUTION (correct and clean)
-- ===========================================

SELECT SUM(sales_revenue)
FROM sales_performance
WHERE salesperson IN ('Samantha', 'Lisa')

-- ===========================================
-- WHAT I LEARNED
-- ===========================================

-- 1. IN() is the right call over chained OR
--    when filtering on multiple values
--    IN('A', 'B', 'C') vs
--    salesperson = 'A' OR salesperson = 'B' OR salesperson = 'C'
--    Same result, IN() is cleaner and scales better

-- 2. No GROUP BY needed here — question asks
--    for ONE combined total, not per-person
--    SUM() across filtered rows gives that directly

-- 3. No alias needed if output column label
--    doesn't matter — but good habit to add one
--    e.g. SUM(sales_revenue) AS total_revenue
