# SQL Practice — Benson Wong

## Purpose
Daily SQL practice on StrataScratch
building toward Data Engineer role.

## Progress
| Difficulty | Solved |
|---|---|
| Easy | 7 |
| Medium | 0 |
| Hard | 0 |

## Key Learnings
- EXISTS cleaner than DISTINCT for filtering
- Read expected output BEFORE writing code
- ABS() for absolute difference questions
- CASE WHEN inside MAX() for cross-group comparison
- IN() cleaner than multiple OR conditions
- CTEs make complex logic readable
- ROW_NUMBER vs RANK vs DENSE_RANK differences
- Simple GROUP BY + MAX beats window function
  when problem only needs highest value
- Never name CTE same as source table
- Always check ORDER BY in requirements
- Window functions (RANK, ROW_NUMBER) cannot be
  filtered in WHERE — they run after WHERE, need
  CTE/subquery to filter on them
- Aggregates in subqueries must be scoped with the
  SAME join/filter as the outer query, or you risk
  comparing against the wrong population
- Subquery vs CTE: filtering on a VALUE → subquery
  with MAX (no extra column); filtering on a
  POSITION (top N, Nth highest) → CTE with RANK
  (extra column is justified)
- ### Window Functions
OVER() = defines the window (group of rows)
PARTITION BY = divides into groups (like GROUP BY
               but keeps all rows)
ORDER BY inside OVER = sorts within each partition

ROW_NUMBER() = unique number per row even if tied
RANK()       = same rank for ties, skips next number
DENSE_RANK() = same rank for ties, no skipping

SUM() OVER() = running total within partition
AVG() OVER() = group average alongside each row
LAG()        = access previous row value
LEAD()       = access next row value

Most common pattern:
WITH ranked AS (
    SELECT *, ROW_NUMBER() OVER(
        PARTITION BY group_col
        ORDER BY value_col DESC) AS rn
    FROM table)
SELECT * FROM ranked WHERE rn = 1
- AVG() OVER(PARTITION BY...) keeps every row, unlike
  GROUP BY which collapses to one row per group
- Window function "extra column" is the deliverable
  when a problem needs row-level detail AND a
  group-level stat in the same output
- Just displaying a group stat alongside row detail
  → window function directly, CTE unnecessary
  (CTE only earns its place when filtering on the
  windowed column afterward)
