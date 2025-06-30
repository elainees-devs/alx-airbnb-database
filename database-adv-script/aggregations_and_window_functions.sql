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


-- Rank all properties based on how many times they've been booked
SELECT 
  p.property_id,
  p.name AS property_name,
  
  -- Count bookings per property
  COUNT(b.booking_id) AS total_bookings,

  -- Assign a ranking based on booking count (highest = rank 1)
  RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank

FROM PROPERTY p

-- Join bookings for each property (if any)
LEFT JOIN BOOKING b ON p.property_id = b.property_id

-- Group by property to count bookings per listing
GROUP BY p.property_id, p.name

-- Order by rank (optional, for display purposes)
ORDER BY booking_rank;
