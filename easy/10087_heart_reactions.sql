-- Problem: Find posts reacted with heart
-- Source: StrataScratch ID 10087
-- Difficulty: Easy
-- Date: June 2026

-- My first attempt (works but not ideal)
select distinct fp.post_id, fp.poster,
fp.post_text, fp.post_keywords, fp.post_date
from facebook_reactions fr
join facebook_posts fp
    on fp.post_id = fr.post_id
where fr.reaction = 'heart'

-- Better solution using EXISTS
select *
from facebook_posts fp
where exists (
    select 1
    from facebook_reactions fr
    where fr.post_id = fp.post_id
    and fr.reaction = 'heart'
)

-- What I learned:
-- DISTINCT star fails on JOINs
-- EXISTS more performant and cleaner
