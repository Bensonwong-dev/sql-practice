-- Problem: Wine Varieties Tasted by 'Roger Voss'
-- Source: StrataScratch ID 10024
-- Difficulty: Easy
-- Date: July 2026

-- ===========================================
-- MY SOLUTION (correct)
-- ===========================================

SELECT DISTINCT variety
FROM winemag_p2
WHERE taster_name = 'Roger Voss'
AND region_1 IS NOT NULL

-- ===========================================
-- WHAT I LEARNED
-- ===========================================

-- 1. NULL cannot be compared with = or <>
--    Both silently return no rows
--    Only IS NULL and IS NOT NULL work
--    Mental trigger: see = NULL -> replace immediately

-- 2. DISTINCT correct here — question asks
--    for unique variety names only

-- 3. No join needed — all data in one table
--    two WHERE conditions enough
