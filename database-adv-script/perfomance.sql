-- ========================================================
-- Initial Query: Bookings with User, Property, Payment
-- ========================================================

-- This query joins multiple tables to show complete booking info:
-- - Who made the booking (USER)
-- - Which property was booked (PROPERTY)
-- - Payment details (if any)

-- ========================================================
-- Filtered Query: Recent Paid Bookings with Details
-- ========================================================

-- This version includes filters:
-- - Only include bookings after Jan 1, 2024
-- - Only include bookings that have a payment record

SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,

  -- User who made the booking
  u.user_id,
  u.first_name || ' ' || u.last_name AS guest_name,
  u.email,

  -- Property booked
  p.property_id,
  p.name AS property_name,
  p.price_per_night,

  -- Payment information
  pay.payment_id,
  pay.amount,
  pay.payment_method,
  pay.payment_date

FROM BOOKING b

-- Join the guest
INNER JOIN USER u ON b.user_id = u.user_id

-- Join the property
INNER JOIN PROPERTY p ON b.property_id = p.property_id

-- Join only bookings that have payments
INNER JOIN PAYMENT pay ON b.booking_id = pay.booking_id

-- Apply filters
WHERE b.start_date >= '2025-01-01'
  AND pay.amount IS NOT NULL

ORDER BY b.created_at DESC;


-- ========================================================
-- Performance Analysis: EXPLAIN ANALYZE
-- ========================================================

EXPLAIN ANALYZE
SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,

  u.user_id,
  u.first_name || ' ' || u.last_name AS guest_name,
  u.email,

  p.property_id,
  p.name AS property_name,
  p.price_per_night,

  pay.payment_id,
  pay.amount,
  pay.payment_method,
  pay.payment_date

FROM BOOKING b
INNER JOIN USER u ON b.user_id = u.user_id
INNER JOIN PROPERTY p ON b.property_id = p.property_id
LEFT JOIN PAYMENT pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;


-- ========================================================
-- Sample Execution Plan Output (Before Indexing)
-- ========================================================

-- Sort  (cost=1400.00..1400.50 rows=200 width=...)
--   Sort Key: b.created_at DESC
--   -> Hash Left Join
--        Hash Cond: (b.booking_id = pay.booking_id)
--        -> Hash Join
--             Hash Cond: (b.property_id = p.property_id)
--             -> Hash Join
--                  Hash Cond: (b.user_id = u.user_id)
--                  -> Seq Scan on BOOKING b
--                  -> Seq Scan on USER u
--             -> Seq Scan on PROPERTY p
--        -> Seq Scan on PAYMENT pay


-- ========================================================
-- Recommended Indexes for Improved Performance
-- ========================================================

-- Index for JOIN with USER
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON BOOKING(user_id);

-- Index for JOIN with PROPERTY
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON BOOKING(property_id);

-- Index for JOIN with PAYMENT
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON PAYMENT(booking_id);

-- Index for ORDER BY clause
CREATE INDEX IF NOT EXISTS idx_booking_created_at ON BOOKING(created_at);
