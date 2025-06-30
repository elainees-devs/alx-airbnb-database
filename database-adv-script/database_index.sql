-- ============================
-- Indexes for USER Table
-- ============================

-- Primary key already indexed
-- Add index on role for WHERE filtering
CREATE INDEX idx_user_role ON USER(role);

-- ============================
-- Indexes for BOOKING Table
-- ============================

-- Foreign key joins
CREATE INDEX idx_booking_user_id ON BOOKING(user_id);
CREATE INDEX idx_booking_property_id ON BOOKING(property_id);

-- For date-based filtering or ordering
CREATE INDEX idx_booking_start_date ON BOOKING(start_date);
CREATE INDEX idx_booking_end_date ON BOOKING(end_date);

-- ============================
-- Indexes for PROPERTY Table
-- ============================

-- Foreign key joins
CREATE INDEX idx_property_host_id ON PROPERTY(host_id);
CREATE INDEX idx_property_location_id ON PROPERTY(location_id);
