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


-- ================================================
-- Query: Rank Properties by Booking Count
--           Using ROW_NUMBER() and RANK()
-- ================================================

-- This query returns all properties along with:
-- - total number of bookings
-- - their rank using ROW_NUMBER (unique sequence)
-- - their rank using RANK (allows ties)

SELECT 
  p.property_id,
  p.name AS property_name,
  
  -- Total bookings received by the property
  COUNT(b.booking_id) AS total_bookings,

  -- Assigns a unique ranking (1, 2, 3, ...) with no ties
  ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_number_rank,

  -- Assigns ranking with ties (e.g., 1, 2, 2, 4)
  RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_with_ties

FROM PROPERTY p
LEFT JOIN BOOKING b ON p.property_id = b.property_id

-- Group by property so we can count bookings
GROUP BY p.property_id, p.name

-- Order by total bookings descending
ORDER BY total_bookings DESC;

