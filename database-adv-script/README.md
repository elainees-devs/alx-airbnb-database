# 🧩 SQL JOINs in a Airbnb clone Platform

This document explains how `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` queries are used in a normalized relational database for a property booking platform, similar to Airbnb.

Each section outlines the relationships queried and what kind of data each JOIN returns.

---

## 🔗 INNER JOIN Queries

### 1. USER + PROPERTY
**Purpose:** Retrieve all users who are hosts and the properties they own. This filters users to only those with the `role = 'host'`.

### 2. PROPERTY + LOCATION
**Purpose:** Get a list of all properties with their associated geographical locations (city and country).

### 3. BOOKING + USER + PROPERTY
**Purpose:** Show all bookings, along with guest information and the property booked. Ensures only bookings with valid guest and property records are shown.

### 4. PAYMENT + BOOKING + USER + PROPERTY
**Purpose:** Display payments including who made the payment (guest), for which booking, and for which property.

### 5. REVIEW + PROPERTY + USER
**Purpose:** List all reviews including the reviewer’s name and the property being reviewed. Only shows reviews with valid user and property references.

### 6. MESSAGE + USER (Sender and Recipient)
**Purpose:** Display all messages sent between users with both sender and recipient details.

---

## 🧭 LEFT JOIN Queries

### 1. USER ↔ PROPERTY
**Purpose:** Show all users, even if they have not listed a property. Hosts without listings will have NULL values for property fields.

### 2. PROPERTY ↔ LOCATION
**Purpose:** List all properties, even if their associated location is missing or not set.

### 3. BOOKING ↔ USER
**Purpose:** Show all bookings and include guest details if they exist. Useful for auditing bookings made by now-deleted users.

### 4. BOOKING ↔ PROPERTY
**Purpose:** Retrieve all bookings, including ones where the related property may no longer exist.

### 5. BOOKING ↔ PAYMENT
**Purpose:** Show all bookings with payment information, if available. Useful to identify unpaid bookings.

---

## 🌐 FULL OUTER JOIN Queries

### 1. USER ↔ PROPERTY
**Purpose:** Show all users and all properties, regardless of whether a user owns a property or a property has a valid host.

### 2. PROPERTY ↔ LOCATION
**Purpose:** Combine all properties and all locations, even if either side lacks a connection.

### 3. BOOKING ↔ USER
**Purpose:** List all bookings and all users. Includes unmatched users and bookings, helpful for identifying orphaned or inactive data.

### 4. BOOKING ↔ PROPERTY
**Purpose:** Retrieve all bookings and all properties, even if they're not currently related.

### 5. PAYMENT ↔ BOOKING
**Purpose:** Display all payments and all bookings, including unmatched records (e.g., payments without bookings or vice versa).

### 6. REVIEW ↔ USER
**Purpose:** Show all reviews and users, whether or not they’re connected. Helps detect reviews made by deleted accounts or unused users.

### 7. REVIEW ↔ PROPERTY
**Purpose:** List all reviews and all properties, regardless of whether they reference each other.

### 8. MESSAGE ↔ USER (Sender)
**Purpose:** Display all messages and all users who may have sent a message. Includes orphaned messages or inactive users.

---

## 🧠 Why This Matters

Understanding the differences between `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` is essential for:
- Handling incomplete or inconsistent data
- Building reliable queries for reports and audits
- Ensuring that UI views (e.g., dashboards, search results) don’t break due to missing foreign key relationships

---


## 👩🏽‍💻 Author

Elaine Muhombe  
Backend Developer in Training  
ALX | GoMyCode Kenya  

---

## 📝 License

This educational SQL content is free to use and adapt for learning, teaching, or portfolio demonstration purposes.
