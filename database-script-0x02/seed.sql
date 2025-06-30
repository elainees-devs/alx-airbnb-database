
INSERT INTO LOCATION (location_id, city, state, country)
VALUES
  ('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', 'Nairobi', 'Nairobi County', 'Kenya'),
  ('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', 'Mombasa', 'Coast', 'Kenya'),
  ('aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', 'Kampala', 'Central', 'Uganda'),
  ('aaaaaaa4-aaaa-aaaa-aaaa-aaaaaaaaaaa4', 'Dar es Salaam', 'Pwani', 'Tanzania'),
  ('aaaaaaa5-aaaa-aaaa-aaaa-aaaaaaaaaaa5', 'Accra', 'Greater Accra', 'Ghana');

INSERT INTO USER (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
  ('11111111-1111-1111-1111-111111111111', 'Alice', 'Walker', 'alice@example.com', 'hashedpass1', '0700000001', 'guest'),
  ('22222222-2222-2222-2222-222222222222', 'Bob', 'Smith', 'bob@example.com', 'hashedpass2', '0700000002', 'host'),
  ('33333333-3333-3333-3333-333333333333', 'Carol', 'Jones', 'carol@example.com', 'hashedpass3', '0700000003', 'guest'),
  ('44444444-4444-4444-4444-444444444444', 'Dan', 'Brown', 'dan@example.com', 'hashedpass4', '0700000004', 'host'),
  ('55555555-5555-5555-5555-555555555555', 'Eve', 'Adams', 'eve@example.com', 'hashedpass5', '0700000005', 'admin');


INSERT INTO PROPERTY (property_id, host_id, name, description, location_id, price_per_night)
VALUES
  ('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', '22222222-2222-2222-2222-222222222222', 'Cozy Apartment Nairobi', 'A nice and cozy 2-bedroom apartment.', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', 35.00),
  ('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', '44444444-4444-4444-4444-444444444444', 'Beach House Mombasa', 'Sea-facing modern house with private beach access.', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', 100.00),
  ('bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3', '22222222-2222-2222-2222-222222222222', 'Budget Room Kampala', 'Affordable and central for backpackers.', 'aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', 20.00),
  ('bbbbbbb4-bbbb-bbbb-bbbb-bbbbbbbbbbb4', '44444444-4444-4444-4444-444444444444', 'Luxury Villa Dar', 'High-end villa with swimming pool.', 'aaaaaaa4-aaaa-aaaa-aaaa-aaaaaaaaaaa4', 250.00),
  ('bbbbbbb5-bbbb-bbbb-bbbb-bbbbbbbbbbb5', '22222222-2222-2222-2222-222222222222', 'Quiet Cottage Accra', 'Peaceful garden cottage.', 'aaaaaaa5-aaaa-aaaa-aaaa-aaaaaaaaaaa5', 50.00);


INSERT INTO BOOKING (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  ('ccccccc1-cccc-cccc-cccc-ccccccccccc1', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', '11111111-1111-1111-1111-111111111111', '2025-07-10', '2025-07-15', 175.00, 'confirmed'),
  ('ccccccc2-cccc-cccc-cccc-ccccccccccc2', 'bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', '33333333-3333-3333-3333-333333333333', '2025-08-01', '2025-08-05', 400.00, 'pending'),
  ('ccccccc3-cccc-cccc-cccc-ccccccccccc3', 'bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3', '11111111-1111-1111-1111-111111111111', '2025-09-10', '2025-09-12', 40.00, 'confirmed'),
  ('ccccccc4-cccc-cccc-cccc-ccccccccccc4', 'bbbbbbb4-bbbb-bbbb-bbbb-bbbbbbbbbbb4', '33333333-3333-3333-3333-333333333333', '2025-10-01', '2025-10-03', 500.00, 'canceled'),
  ('ccccccc5-cccc-cccc-cccc-ccccccccccc5', 'bbbbbbb5-bbbb-bbbb-bbbb-bbbbbbbbbbb5', '11111111-1111-1111-1111-111111111111', '2025-11-15', '2025-11-18', 150.00, 'confirmed');


INSERT INTO PAYMENT (payment_id, booking_id, amount, payment_method)
VALUES
  ('ddddddd1-dddd-dddd-dddd-ddddddddddd1', 'ccccccc1-cccc-cccc-cccc-ccccccccccc1', 175.00, 'credit_card'),
  ('ddddddd2-dddd-dddd-dddd-ddddddddddd2', 'ccccccc2-cccc-cccc-cccc-ccccccccccc2', 400.00, 'paypal'),
  ('ddddddd3-dddd-dddd-dddd-ddddddddddd3', 'ccccccc3-cccc-cccc-cccc-ccccccccccc3', 40.00, 'stripe'),
  ('ddddddd4-dddd-dddd-dddd-ddddddddddd4', 'ccccccc4-cccc-cccc-cccc-ccccccccccc4', 500.00, 'credit_card'),
  ('ddddddd5-dddd-dddd-dddd-ddddddddddd5', 'ccccccc5-cccc-cccc-cccc-ccccccccccc5', 150.00, 'paypal');
  

INSERT INTO REVIEW (review_id, property_id, user_id, rating, comment)
VALUES
  ('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', '11111111-1111-1111-1111-111111111111', 4, 'Nice place, great host!'),
  ('eeeeeee2-eeee-eeee-eeee-eeeeeeeeeee2', 'bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', '33333333-3333-3333-3333-333333333333', 5, 'Perfect beachfront!'),
  ('eeeeeee3-eeee-eeee-eeee-eeeeeeeeeee3', 'bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3', '11111111-1111-1111-1111-111111111111', 3, 'Good value for money.'),
  ('eeeeeee4-eeee-eeee-eeee-eeeeeeeeeee4', 'bbbbbbb4-bbbb-bbbb-bbbb-bbbbbbbbbbb4', '33333333-3333-3333-3333-333333333333', 2, 'Too expensive.'),
  ('eeeeeee5-eeee-eeee-eeee-eeeeeeeeeee5', 'bbbbbbb5-bbbb-bbbb-bbbb-bbbbbbbbbbb5', '11111111-1111-1111-1111-111111111111', 5, 'Beautiful and quiet.');






