-- INNER JOIN Queries
-- USER + PROPERTY Join Query
SELECT 
  u.user_id,
  u.first_name || ' ' || u.last_name AS host_name,
  p.property_id,
  p.name AS property_name,
  p.price_per_night
FROM USER u
INNER JOIN PROPERTY p ON u.user_id = p.host_id
WHERE u.role = 'host';

-- PROPERTY+LOCATION Join Query
SELECT 
  p.property_id,
  p.name AS property_name,
  l.city,
  l.country
FROM PROPERTY p
INNER JOIN LOCATION l ON p.location_id = l.location_id;

-- BOOKING+USER+PROPERTY Join Query
SELECT 
  b.booking_id,
  u.first_name || ' ' || u.last_name AS guest_name,
  p.name AS property_name,
  b.start_date,
  b.end_date,
  b.total_price
FROM BOOKING b
INNER JOIN USER u ON b.user_id = u.user_id
INNER JOIN PROPERTY p ON b.property_id = p.property_id;

-- PAYMENT+BOOKING+USER+PROPERTY Join Query
SELECT 
  pay.payment_id,
  pay.amount,
  pay.payment_method,
  u.first_name || ' ' || u.last_name AS guest_name,
  p.name AS property_name,
  pay.payment_date
FROM PAYMENT pay
INNER JOIN BOOKING b ON pay.booking_id = b.booking_id
INNER JOIN USER u ON b.user_id = u.user_id
INNER JOIN PROPERTY p ON b.property_id = p.property_id;


-- REVIEW+PROPERTY+USER Join Query
SELECT 
  r.review_id,
  prop.name AS property_name,
  u.first_name || ' ' || u.last_name AS reviewer_name,
  r.rating,
  r.comment,
  r.created_at
FROM REVIEW r
INNER JOIN PROPERTY prop ON r.property_id = prop.property_id
INNER JOIN USER u ON r.user_id = u.user_id;


-- MESSAGE+USER Join Query
SELECT 
  m.message_id,
  sender.first_name || ' ' || sender.last_name AS sender_name,
  recipient.first_name || ' ' || recipient.last_name AS recipient_name,
  m.message_body,
  m.sent_at
FROM MESSAGE m
INNER JOIN USER sender ON m.sender_id = sender.user_id
INNER JOIN USER recipient ON m.recipient_id = recipient.user_id;


-- LEFT JOIN Queries
--USER ↔ PROPERTY
SELECT 
  u.user_id,
  u.first_name || ' ' || u.last_name AS user_name,
  u.role,
  p.property_id,
  p.name AS property_name
FROM USER u
LEFT JOIN PROPERTY p ON u.user_id = p.host_id;

--PROPERTY ↔ LOCATION
SELECT 
  p.property_id,
  p.name AS property_name,
  l.city,
  l.country
FROM PROPERTY p
LEFT JOIN LOCATION l ON p.location_id = l.location_id;

--BOOKING ↔ USER
SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  u.first_name || ' ' || u.last_name AS guest_name
FROM BOOKING b
LEFT JOIN USER u ON b.user_id = u.user_id;

-- BOOKING ↔ PROPERTY
SELECT 
  b.booking_id,
  p.name AS property_name,
  b.start_date,
  b.end_date
FROM BOOKING b
LEFT JOIN PROPERTY p ON b.property_id = p.property_id;

-- BOOKING ↔ PAYMENT
SELECT 
  b.booking_id,
  b.start_date,
  pay.amount,
  pay.payment_method
FROM BOOKING b
LEFT JOIN PAYMENT pay ON b.booking_id = pay.booking_id;


-- FULL OUTER JOIN Queries
-- USER ↔ PROPERTY
SELECT 
  u.user_id,
  u.first_name || ' ' || u.last_name AS user_name,
  u.role,
  p.property_id,
  p.name AS property_name
FROM USER u
FULL OUTER JOIN PROPERTY p ON u.user_id = p.host_id;

-- PROPERTY ↔ LOCATION
SELECT 
  p.property_id,
  p.name AS property_name,
  l.location_id,
  l.city,
  l.country
FROM PROPERTY p
FULL OUTER JOIN LOCATION l ON p.location_id = l.location_id;

-- BOOKING ↔ USER
SELECT 
  b.booking_id,
  u.user_id,
  u.first_name || ' ' || u.last_name AS guest_name,
  b.start_date,
  b.end_date
FROM BOOKING b
FULL OUTER JOIN USER u ON b.user_id = u.user_id;

-- BOOKING ↔ PROPERTY
SELECT 
  b.booking_id,
  p.property_id,
  p.name AS property_name,
  b.start_date,
  b.end_date
FROM BOOKING b
FULL OUTER JOIN PROPERTY p ON b.property_id = p.property_id;

-- PAYMENT ↔ BOOKING
SELECT 
  pay.payment_id,
  b.booking_id,
  pay.amount,
  pay.payment_method,
  b.start_date,
  b.end_date
FROM PAYMENT pay
FULL OUTER JOIN BOOKING b ON pay.booking_id = b.booking_id;

-- REVIEW ↔ USER
SELECT 
  r.review_id,
  u.user_id,
  u.first_name || ' ' || u.last_name AS reviewer_name,
  r.rating,
  r.comment
FROM REVIEW r
FULL OUTER JOIN USER u ON r.user_id = u.user_id;

-- REVIEW ↔ PROPERTY
SELECT 
  r.review_id,
  p.property_id,
  p.name AS property_name,
  r.rating,
  r.comment
FROM REVIEW r
FULL OUTER JOIN PROPERTY p ON r.property_id = p.property_id;

-- MESSAGE ↔ USER
SELECT 
  m.message_id,
  sender.user_id,
  sender.first_name || ' ' || sender.last_name AS sender_name,
  m.message_body
FROM MESSAGE m
FULL OUTER JOIN USER sender ON m.sender_id = sender.user_id;


