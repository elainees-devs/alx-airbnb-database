-- ============================
-- Indexes for USER Table
-- ============================

-- Add index on role for WHERE filtering
SET @idx := 'idx_user_role';
SET @tbl := 'USER';
SET @sql := (
  SELECT IF(
    EXISTS (
      SELECT 1 FROM information_schema.statistics 
      WHERE table_schema = DATABASE() AND table_name = @tbl AND index_name = @idx
    ),
    'SELECT "Index idx_user_role already exists.";',
    'CREATE INDEX idx_user_role ON USER(role);'
  )
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;


-- ============================
-- Indexes for BOOKING Table
-- ============================

-- Foreign key joins
SET @idx := 'idx_booking_user_id';
SET @tbl := 'BOOKING';
SET @sql := (
  SELECT IF(
    EXISTS (
      SELECT 1 FROM information_schema.statistics 
      WHERE table_schema = DATABASE() AND table_name = @tbl AND index_name = @idx
    ),
    'SELECT "Index idx_booking_user_id already exists.";',
    'CREATE INDEX idx_booking_user_id ON BOOKING(user_id);'
  )
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx := 'idx_booking_property_id';
SET @sql := (
  SELECT IF(
    EXISTS (
      SELECT 1 FROM information_schema.statistics 
      WHERE table_schema = DATABASE() AND table_name = 'BOOKING' AND index_name = @idx
    ),
    'SELECT "Index idx_booking_property_id already exists.";',
    'CREATE INDEX idx_booking_property_id ON BOOKING(property_id);'
  )
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- For date-based filtering or ordering
SET @idx := 'idx_booking_start_date';
SET @sql := (
  SELECT IF(
    EXISTS (
      SELECT 1 FROM information_schema.statistics 
      WHERE table_schema = DATABASE() AND table_name = 'BOOKING' AND index_name = @idx
    ),
    'SELECT "Index idx_booking_start_date already exists.";',
    'CREATE INDEX idx_booking_start_date ON BOOKING(start_date);'
  )
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx := 'idx_booking_end_date';
SET @sql := (
  SELECT IF(
    EXISTS (
      SELECT 1 FROM information_schema.statistics 
      WHERE table_schema = DATABASE() AND table_name = 'BOOKING' AND index_name = @idx
    ),
    'SELECT "Index idx_booking_end_date already exists.";',
    'CREATE INDEX idx_booking_end_date ON BOOKING(end_date);'
  )
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;


-- ============================
-- Indexes for PROPERTY Table
-- ============================

-- Foreign key joins
SET @idx := 'idx_property_host_id';
SET @tbl := 'PROPERTY';
SET @sql := (
  SELECT IF(
    EXISTS (
      SELECT 1 FROM information_schema.statistics 
      WHERE table_schema = DATABASE() AND table_name = @tbl AND index_name = @idx
    ),
    'SELECT "Index idx_property_host_id already exists.";',
    'CREATE INDEX idx_property_host_id ON PROPERTY(host_id);'
  )
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx := 'idx_property_location_id';
SET @sql := (
  SELECT IF(
    EXISTS (
      SELECT 1 FROM information_schema.statistics 
      WHERE table_schema = DATABASE() AND table_name = 'PROPERTY' AND index_name = @idx
    ),
    'SELECT "Index idx_property_location_id already exists.";',
    'CREATE INDEX idx_property_location_id ON PROPERTY(location_id);'
  )
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;


-- ============================
-- Performance Measurement
-- ============================

-- 1. Total Number of Bookings per User
EXPLAIN ANALYZE
SELECT 
  u.user_id,
  CONCAT(u.first_name, ' ', u.last_name) AS user_name,
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
