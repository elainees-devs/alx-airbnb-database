-- ========================================================
-- Partitioning the BOOKINGS Table by start_date (Yearly)
-- ========================================================

-- Step 1: Create new partitioned BOOKINGS table
CREATE TABLE BOOKINGS (
  booking_id CHAR(36) NOT NULL,
  property_id CHAR(36) NOT NULL,
  user_id CHAR(36) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (booking_id, start_date)
)
PARTITION BY RANGE (YEAR(start_date)) (
  PARTITION p2023 VALUES LESS THAN (2024),
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026),
  PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- Step 2: Insert data from old table into the new partitioned table
INSERT INTO BOOKINGS (
  booking_id, property_id, user_id,
  start_date, end_date, total_price, status, created_at
)
SELECT 
  booking_id, property_id, user_id,
  start_date, end_date, total_price, status, created_at
FROM BOOKING;


-- ========================================================
-- Performance Test Query: Bookings from February 2025
-- ========================================================

EXPLAIN
SELECT 
  booking_id,
  user_id,
  property_id,
  start_date,
  end_date,
  total_price
FROM BOOKINGS
WHERE start_date >= '2025-02-01'
  AND start_date < '2025-03-01';
