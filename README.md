# SQL Practice — Benson Wong

## Purpose
Daily SQL practice on StrataScratch
building toward Data Engineer role.

## Progress
| Difficulty | Solved |
|---|---|
| Easy | 4 |
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
- Include ORDER BY column in GROUP BY too —
  strict SQL mode rejects it otherwise
- Always alias aggregate columns clearly
### Window Functions
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
