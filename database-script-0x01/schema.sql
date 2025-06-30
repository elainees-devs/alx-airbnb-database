CREATE DATABASE IF NOT EXISTS airbnb_clone_db;
USE airbnb_clone_db;

-- ---------------------------
-- USER Table
-- ---------------------------
CREATE TABLE `USER` (
  user_id CHAR(36) PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  role ENUM('guest', 'host', 'admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------
-- LOCATION Table
-- ---------------------------
CREATE TABLE LOCATION (
  location_id CHAR(36) PRIMARY KEY,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100),
  country VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- ---------------------------
-- PROPERTY Table
-- ---------------------------
CREATE TABLE PROPERTY (
  property_id CHAR(36) PRIMARY KEY,
  host_id CHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  location_id CHAR(36) NOT NULL,
  price_per_night DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES `USER`(user_id),
  FOREIGN KEY (location_id) REFERENCES LOCATION(location_id),
  INDEX (host_id),
  INDEX (location_id)
) ENGINE=InnoDB;

-- ---------------------------
-- BOOKING Table
-- ---------------------------
CREATE TABLE BOOKING (
  booking_id CHAR(36) PRIMARY KEY,
  property_id CHAR(36) NOT NULL,
  user_id CHAR(36) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES PROPERTY(property_id),
  FOREIGN KEY (user_id) REFERENCES `USER`(user_id),
  INDEX (property_id),
  INDEX (user_id)
) ENGINE=InnoDB;

-- ---------------------------
-- PAYMENT Table
-- ---------------------------
CREATE TABLE PAYMENT (
  payment_id CHAR(36) PRIMARY KEY,
  booking_id CHAR(36) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
  FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id),
  INDEX (booking_id)
) ENGINE=InnoDB;

-- ---------------------------
-- REVIEW Table
-- ---------------------------
CREATE TABLE REVIEW (
  review_id CHAR(36) PRIMARY KEY,
  property_id CHAR(36) NOT NULL,
  user_id CHAR(36) NOT NULL,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES PROPERTY(property_id),
  FOREIGN KEY (user_id) REFERENCES `USER`(user_id),
  INDEX (property_id),
  INDEX (user_id)
) ENGINE=InnoDB;

-- ---------------------------
-- MESSAGE Table
-- ---------------------------
CREATE TABLE MESSAGE (
  message_id CHAR(36) PRIMARY KEY,
  sender_id CHAR(36) NOT NULL,
  recipient_id CHAR(36) NOT NULL,
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES `USER`(user_id),
  FOREIGN KEY (recipient_id) REFERENCES `USER`(user_id),
  INDEX (sender_id),
  INDEX (recipient_id)
) ENGINE=InnoDB;
