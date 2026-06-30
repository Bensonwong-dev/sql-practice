-- Problem: Workers With The Highest Salaries
-- Source: StrataScratch ID 10353
-- Difficulty: Easy
-- Date: June 2026

-- ===========================================
-- WRONG ATTEMPT 1 (window function in WHERE)
-- ===========================================

select salary, first_name, rank() over(order by salary desc) as rnum
from worker w
join title t on t.worker_ref_id = worker_id
where rnum = 1

-- Fails because window functions execute AFTER
-- WHERE in SQL's logical order — rnum does not
-- exist yet at that stage

-- ===========================================
-- WRONG ATTEMPT 2 (aggregate in WHERE, wrong scope)
-- ===========================================

WHERE w.salary = (SELECT MAX(salary) FROM worker)

-- Fails for two reasons:
-- 1. Aggregate functions can't be used directly
--    in WHERE without a subquery
-- 2. Even as a subquery, this scopes to MAX
--    salary across ALL workers, not just workers
--    who have a title record — if the highest
--    paid worker has no title, zero rows match

-- ===========================================
-- CORRECT SOLUTION A — scoped subquery
-- ===========================================

SELECT 
    t.worker_title
FROM worker w
JOIN title t
    ON w.worker_id = t.worker_ref_id
WHERE w.salary = (
    SELECT MAX(w2.salary)
    FROM worker w2
    JOIN title t2
        ON w2.worker_id = t2.worker_ref_id
)

-- Subquery repeats the same join so MAX(salary)
-- is scoped to only titled workers, matching
-- what the problem actually asks for

-- ===========================================
-- CORRECT SOLUTION B — RANK() in CTE
-- ===========================================

WITH ranked AS (
    SELECT 
        t.worker_title,
        w.salary,
        RANK() OVER(ORDER BY w.salary DESC) AS rnum
    FROM worker w
    JOIN title t
        ON w.worker_id = t.worker_ref_id
)
SELECT worker_title
FROM ranked
WHERE rnum = 1

-- Join happens first (filters to titled workers
-- only), THEN ranking runs on that filtered set
-- — scoping is correct by construction, no need
-- to duplicate the join manually like Solution A

-- ===========================================
-- WHAT I LEARNED
-- ===========================================

-- 1. Window functions cannot be filtered in WHERE
--    — they run after WHERE in execution order.
--    Need a CTE/subquery to filter on them.

-- 2. Aggregates (MAX, etc) also cannot be used
--    directly in WHERE — need GROUP BY/HAVING
--    or a subquery.

-- 3. When using a subquery for MAX(), scope it
--    with the SAME join/filter as the outer query.
--    Otherwise you may be comparing against a value
--    from a different (unfiltered) population.

-- 4. CTE/window approach naturally avoids this
--    scoping mistake because the join filters
--    the rows BEFORE ranking happens.

-- 5. Subquery vs CTE — pick based on what you're
--    filtering on:
--    - Filtering on a VALUE (e.g. "equals the max")
--      → subquery with MAX(), no extra column needed
--    - Filtering on a POSITION (e.g. "top 3",
--      "2nd highest", explicit tie handling)
--      → CTE with RANK/DENSE_RANK/ROW_NUMBER,
--        extra column is justified since there's
--        no other way to express "position" in SQL
