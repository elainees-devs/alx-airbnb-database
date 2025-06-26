# Database Specification - AirBnB

## Entities and Attributes

### USER

* `user_id`: Primary Key, UUID, Indexed
* `first_name`: VARCHAR, NOT NULL
* `last_name`: VARCHAR, NOT NULL
* `email`: VARCHAR, UNIQUE, NOT NULL
* `password_hash`: VARCHAR, NOT NULL
* `phone_number`: VARCHAR, NULL
* `role`: ENUM (guest, host, admin), NOT NULL
* `created_at`: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

### PROPERTY

* `property_id`: Primary Key, UUID, Indexed
* `host_id`: Foreign Key, references USER(user\_id)
* `name`: VARCHAR, NOT NULL
* `description`: TEXT, NOT NULL
* `location`: VARCHAR, NOT NULL
* `pricepernight`: DECIMAL, NOT NULL
* `created_at`: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP
* `updated_at`: TIMESTAMP, ON UPDATE CURRENT\_TIMESTAMP

### BOOKING

* `booking_id`: Primary Key, UUID, Indexed
* `property_id`: Foreign Key, references PROPERTY(property\_id)
* `user_id`: Foreign Key, references USER(user\_id)
* `start_date`: DATE, NOT NULL
* `end_date`: DATE, NOT NULL
* `total_price`: DECIMAL, NOT NULL
* `status`: ENUM (pending, confirmed, canceled), NOT NULL
* `created_at`: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

### PAYMENT

* `payment_id`: Primary Key, UUID, Indexed
* `booking_id`: Foreign Key, references BOOKING(booking\_id)
* `amount`: DECIMAL, NOT NULL
* `payment_date`: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP
* `payment_method`: ENUM (credit\_card, paypal, stripe), NOT NULL

### REVIEW

* `review_id`: Primary Key, UUID, Indexed
* `property_id`: Foreign Key, references PROPERTY(property\_id)
* `user_id`: Foreign Key, references USER(user\_id)
* `rating`: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
* `comment`: TEXT, NOT NULL
* `created_at`: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

### MESSAGE

* `message_id`: Primary Key, UUID, Indexed
* `sender_id`: Foreign Key, references USER(user\_id)
* `recipient_id`: Foreign Key, references USER(user\_id)
* `message_body`: TEXT, NOT NULL
* `sent_at`: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

## Constraints

### USER Table

* Unique constraint on `email`
* Non-null constraints on required fields

### PROPERTY Table

* Foreign key constraint on `host_id`
* Non-null constraints on essential attributes

### BOOKING Table

* Foreign key constraints on `property_id` and `user_id`
* `status` must be one of `pending`, `confirmed`, or `canceled`

### PAYMENT Table

* Foreign key constraint on `booking_id`, ensuring payment is linked to valid bookings

### REVIEW Table

* Constraint on `rating` values (1–5)
* Foreign key constraints on `property_id` and `user_id`

### MESSAGE Table

* Foreign key constraints on `sender_id` and `recipient_id`

## Indexing

### Primary Keys

* Automatically indexed

### Additional Indexes

* `email` in the USER table
* `property_id` in the PROPERTY and BOOKING tables
* `booking_id` in the BOOKING and PAYMENT tables
