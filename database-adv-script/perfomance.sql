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

-- ==============================================
-- Optimized Query: Reviews with Property & User
-- ==============================================

SELECT 
  r.review_id,
  r.rating,
  r.comment,
  r.created_at,

  -- Property Info
  p.property_id,
  p.name AS property_name,

  -- Reviewer Info
  u.user_id,
  CONCAT(u.first_name, ' ', u.last_name) AS reviewer_name

FROM REVIEW r
INNER JOIN PROPERTY p ON r.property_id = p.property_id
INNER JOIN USER u ON r.user_id = u.user_id

WHERE r.rating IS NOT NULL
ORDER BY r.created_at DESC;

-- Suggested index
CREATE INDEX idx_review_created_rating 
ON REVIEW(rating, created_at DESC);


-- ====================================================
-- Optimized Query: Messages with Sender and Recipient
-- ====================================================

SELECT 
  m.message_id,
  m.message_body,
  m.sent_at,

  -- Sender
  sender.user_id AS sender_id,
  CONCAT(sender.first_name, ' ', sender.last_name) AS sender_name,

  -- Recipient
  recipient.user_id AS recipient_id,
  CONCAT(recipient.first_name, ' ', recipient.last_name) AS recipient_name

FROM MESSAGE m
INNER JOIN USER sender ON m.sender_id = sender.user_id
INNER JOIN USER recipient ON m.recipient_id = recipient.user_id

WHERE m.sent_at >= '2025-01-01'
ORDER BY m.sent_at DESC;

-- Suggested index
CREATE INDEX idx_message_sent_at 
ON MESSAGE(sent_at DESC);


-- ====================================================
-- Optimized Query: Active Hosts and Their Properties
-- ====================================================

SELECT 
  u.user_id,
  CONCAT(u.first_name, ' ', u.last_name) AS host_name,
  u.email,

  p.property_id,
  p.name AS property_name,
  p.price_per_night,
  l.city,
  l.country

FROM USER u
INNER JOIN PROPERTY p ON u.user_id = p.host_id
LEFT JOIN LOCATION l ON p.location_id = l.location_id

WHERE u.role = 'host'
ORDER BY u.last_name;

-- Suggested index
CREATE INDEX idx_user_role_lastname 
ON USER(role, last_name);

-- Optional for location-based filters
CREATE INDEX idx_property_location_id 
ON PROPERTY(location_id);

