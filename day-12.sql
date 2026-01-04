-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH messages_sent_per_user_per_day AS (
  SELECT 
    sender_id, 
    DATE(sent_at) AS day, 
    COUNT(message_id) AS messages_count
  FROM npn_messages
  GROUP BY sender_id, day
),
rank_sender AS (
  SELECT
    sender_id,
    day,
    RANK() OVER(PARTITION BY day ORDER BY messages_count DESC) AS rank
  FROM messages_sent_per_user_per_day
  )
SELECT day, user_name
FROM npn_users
LEFT JOIN rank_sender
ON user_id = sender_id
WHERE rank = 1;
