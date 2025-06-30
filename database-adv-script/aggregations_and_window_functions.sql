-- Get the total number of bookings made by each user
SELECT 
  u.user_id,
  u.first_name || ' ' || u.last_name AS user_name,
  
  -- Count how many bookings each user has made
  COUNT(b.booking_id) AS total_bookings

FROM USER u

-- Join bookings made by the user (if any)
LEFT JOIN BOOKING b ON u.user_id = b.user_id

-- Group by user to aggregate booking counts
GROUP BY u.user_id, u.first_name, u.last_name

-- Order from most to least bookings
ORDER BY total_bookings DESC;


-- Rank properties by total number of bookings using ROW_NUMBER
SELECT 
  p.property_id,
  p.name AS property_name,
  COUNT(b.booking_id) AS total_bookings,
  
  -- Assign a unique sequential rank (no ties)
  ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank

FROM PROPERTY p
LEFT JOIN BOOKING b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;
