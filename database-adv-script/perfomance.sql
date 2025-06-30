-- ========================================================
-- Initial Query: Bookings with User, Property, Payment
-- ========================================================

SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,

  -- User who made the booking
  u.user_id,
  CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
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
INNER JOIN USER u ON b.user_id = u.user_id
INNER JOIN PROPERTY p ON b.property_id = p.property_id
INNER JOIN PAYMENT pay ON b.booking_id = pay.booking_id
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
  CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
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
-- Conditional Index Creation (MySQL-safe using dynamic SQL)
-- No DELIMITER needed; auto-detects database name
-- ========================================================

-- Get current database
SET @db := DATABASE();

-- Index for JOIN with USER
SELECT IF(
  EXISTS (
    SELECT 1 FROM information_schema.statistics 
    WHERE table_schema = @db 
      AND table_name = 'BOOKING' 
      AND index_name = 'idx_booking_user_id'
  ),
  'SELECT "Index idx_booking_user_id exists";',
  'CREATE INDEX idx_booking_user_id ON BOOKING(user_id);'
) INTO @stmt1;
PREPARE stmt1 FROM @stmt1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

-- Index for JOIN with PROPERTY
SELECT IF(
  EXISTS (
    SELECT 1 FROM information_schema.statistics 
    WHERE table_schema = @db 
      AND table_name = 'BOOKING' 
      AND index_name = 'idx_booking_property_id'
  ),
  'SELECT "Index idx_booking_property_id exists";',
  'CREATE INDEX idx_booking_property_id ON BOOKING(property_id);'
) INTO @stmt2;
PREPARE stmt2 FROM @stmt2;
EXECUTE stmt2;
DEALLOCATE PREPARE stmt2;

-- Index for JOIN with PAYMENT
SELECT IF(
  EXISTS (
    SELECT 1 FROM information_schema.statistics 
    WHERE table_schema = @db 
      AND table_name = 'PAYMENT' 
      AND index_name = 'idx_payment_booking_id'
  ),
  'SELECT "Index idx_payment_booking_id exists";',
  'CREATE INDEX idx_payment_booking_id ON PAYMENT(booking_id);'
) INTO @stmt3;
PREPARE stmt3 FROM @stmt3;
EXECUTE stmt3;
DEALLOCATE PREPARE stmt3;

-- Index for ORDER BY on created_at
SELECT IF(
  EXISTS (
    SELECT 1 FROM information_schema.statistics 
    WHERE table_schema = @db 
      AND table_name = 'BOOKING' 
      AND index_name = 'idx_booking_created_at'
  ),
  'SELECT "Index idx_booking_created_at exists";',
  'CREATE INDEX idx_booking_created_at ON BOOKING(created_at);'
) INTO @stmt4;
PREPARE stmt4 FROM @stmt4;
EXECUTE stmt4;
DEALLOCATE PREPARE stmt4;
