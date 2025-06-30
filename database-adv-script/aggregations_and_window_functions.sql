-- ===========================================
-- Query 1: Total Number of Bookings per User
-- ===========================================

-- This query retrieves all users and the total number of bookings each has made.
-- Uses LEFT JOIN to include users with zero bookings.
-- GROUP BY ensures aggregation by user.
-- ORDER BY sorts users by activity (most to least bookings).

SELECT 
  u.user_id,
  u.first_name || ' ' || u.last_name AS user_name,
  COUNT(b.booking_id) AS total_bookings
FROM USER u
LEFT JOIN BOOKING b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;


-- ===========================================
-- 🏆 Query: Rank Properties by Booking Count (With Ties)
-- ===========================================

-- This query ranks all properties by the number of bookings they’ve received.
-- RANK() allows tied ranks for properties with the same number of bookings.
-- LEFT JOIN includes properties with no bookings (ranked last).
-- Useful for leaderboard-style displays with fairness on ties.

SELECT 
  p.property_id,
  p.name AS property_name,
  COUNT(b.booking_id) AS total_bookings,
  RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM PROPERTY p
LEFT JOIN BOOKING b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;

