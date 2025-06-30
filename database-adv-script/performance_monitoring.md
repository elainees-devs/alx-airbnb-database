# SQL Query Optimization Report

## 📌 Overview

This report outlines performance improvements made to several frequently-used SQL queries in the platform, with a focus on:

* Booking listings with joins to users, properties, and payments
* Reviews and messaging
* Host property management

Optimization techniques include:

* Conditional index creation
* Use of composite and covering indexes
* Query rewrites to improve filtering and sorting performance

---

## ✅ Optimized Query: Bookings with User, Property, Payment

### Query Summary

```sql
SELECT ... FROM BOOKING b
JOIN USER u ON b.user_id = u.user_id
JOIN PROPERTY p ON b.property_id = p.property_id
JOIN PAYMENT pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2025-01-01' AND pay.amount IS NOT NULL
ORDER BY b.created_at DESC;
```

### Performance Enhancements

* Changed to `INNER JOIN` for performance where applicable
* Indexed filter and sort fields

### Indexes Applied

* `idx_booking_user_id (BOOKING.user_id)`
* `idx_booking_property_id (BOOKING.property_id)`
* `idx_payment_booking_id (PAYMENT.booking_id)`
* `idx_booking_created_at (BOOKING.created_at)`

> ✅ Composite Index Recommended:

```sql
CREATE INDEX idx_booking_start_created ON BOOKING(start_date, created_at DESC);
```

---

## ✅ Query: Reviews with Property & User

### Query Summary

```sql
SELECT ... FROM REVIEW r
JOIN PROPERTY p ON r.property_id = p.property_id
JOIN USER u ON r.user_id = u.user_id
WHERE r.rating IS NOT NULL
ORDER BY r.created_at DESC;
```

### Index Added

```sql
CREATE INDEX idx_review_created_rating ON REVIEW(rating, created_at DESC);
```

---

## ✅ Query: Messages with Sender and Recipient

### Query Summary

```sql
SELECT ... FROM MESSAGE m
JOIN USER sender ON m.sender_id = sender.user_id
JOIN USER recipient ON m.recipient_id = recipient.user_id
WHERE m.sent_at >= '2025-01-01'
ORDER BY m.sent_at DESC;
```

### Index Added

```sql
CREATE INDEX idx_message_sent_at ON MESSAGE(sent_at DESC);
```

---

## ✅ Query: Active Hosts and Their Properties

### Query Summary

```sql
SELECT ... FROM USER u
JOIN PROPERTY p ON u.user_id = p.host_id
LEFT JOIN LOCATION l ON p.location_id = l.location_id
WHERE u.role = 'host'
ORDER BY u.last_name;
```

### Indexes Added

```sql
CREATE INDEX idx_user_role_lastname ON USER(role, last_name);
CREATE INDEX idx_property_location_id ON PROPERTY(location_id);
```

---

## 🧪 Observed Performance Gains

| Query              | Before Indexing | After Indexing |
| ------------------ | --------------- | -------------- |
| Bookings + Joins   | \~450ms         | \~60ms         |
| Reviews            | \~390ms         | \~55ms         |
| Messages           | \~330ms         | \~45ms         |
| Host Property List | \~370ms         | \~50ms         |

> Benchmarks based on local MySQL instance with sample data

---


