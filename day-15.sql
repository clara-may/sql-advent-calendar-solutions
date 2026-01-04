-- SQL Advent Calendar - Day 15
-- Title: The Grinch's Mischief Tracker
-- Difficulty: hard
--
-- Question:
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--

-- Table Schema:
-- Table: grinch_mischief_log
--   log_date: DATE
--   mischief_score: INTEGER
--

-- My Solution:

WITH cte AS (
  SELECT 
  log_date,
  mischief_score AS today_score,
  LAG(mischief_score, 1) OVER(ORDER BY log_date ASC) AS yesterday_score
FROM grinch_mischief_log)
SELECT 
  log_date,
  today_score - yesterday_score AS points_difference
FROM cte;
