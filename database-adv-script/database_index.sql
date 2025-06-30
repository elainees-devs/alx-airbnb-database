-- ============================
-- Indexes for USER Table
-- ============================

-- Add index on role for WHERE filtering
CREATE INDEX IF NOT EXISTS idx_user_role ON USER(role);


-- ============================
-- Indexes for BOOKING Table
-- ============================

-- Foreign key joins
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON BOOKING(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON BOOKING(property_id);

-- For date-based filtering or ordering
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON BOOKING(start_date);
CREATE INDEX IF NOT EXISTS idx_booking_end_date ON BOOKING(end_date);


-- ============================
-- Indexes for PROPERTY Table
-- ============================

-- Foreign key joins
CREATE INDEX IF NOT EXISTS idx_property_host_id ON PROPERTY(host_id);
CREATE INDEX IF NOT EXISTS idx_property_location_id ON PROPERTY(location_id);


-- ============================
-- Performance Measurement
-- ============================
-- Run EXPLAIN ANALYZE on two key queries

-- 1. Total Number of Bookings per User
EXPLAIN ANALYZE
SELECT 
  u.user_id,
  u.first_name || ' ' || u.last_name AS user_name,
  COUNT(b.booking_id) AS total_bookings
FROM USER u
LEFT JOIN BOOKING b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;


-- 2. Rank Properties by Booking Count
EXPLAIN ANALYZE
SELECT 
  p.property_id,
  p.name AS property_name,
  COUNT(b.booking_id) AS total_bookings,
  ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_number_rank,
  RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_with_ties
FROM PROPERTY p
LEFT JOIN BOOKING b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY total_bookings DESC;
