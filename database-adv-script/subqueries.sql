-- Select all property details
SELECT *
FROM PROPERTY
WHERE property_id IN (
  -- Subquery: Get property IDs where the average rating > 4.0
  SELECT property_id
  FROM REVIEW
  GROUP BY property_id
  HAVING AVG(rating) > 4.0
);


-- Select distinct user records from the USER table
SELECT DISTINCT u.*
FROM USER u
WHERE (
  -- Correlated subquery: Count how many bookings this user has made
  SELECT COUNT(*)
  FROM BOOKING b
  WHERE b.user_id = u.user_id
) > 3; -- Only include users with more than 3 bookings

