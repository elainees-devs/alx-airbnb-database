# 🌱 AirBnB Clone — Sample Data

This project provides **sample seed data** for an AirBnB-style database. The dataset is designed to reflect real-world usage across key entities: users, properties, bookings, payments, reviews, messages, and locations.

---

## 📦 Sample Data Overview

The `seed.sql` file inserts **4 records** into each of the following tables:

| Table     | Description                                      |
|-----------|--------------------------------------------------|
| **USER**      | 4 users (2 hosts, 1 guest, 1 admin)                |
| **PROPERTY**  | 4 property listings linked to hosts               |
| **BOOKING**   | 4 bookings tied to guests and properties          |
| **PAYMENT**   | 4 payment transactions for those bookings         |
| **REVIEW**    | 4 guest reviews, each tied to a booking           |
| **MESSAGE**   | 4 messages exchanged between guests and hosts     |
| **LOCATION**  | 4 locations optionally used to normalize geography|

---

## 📄 Seed Details

Each record uses consistent and readable `UUID`-style primary keys (`CHAR(36)` format). The dataset includes:

- A mix of `confirmed`, `pending`, and `canceled` booking statuses
- Payments using various methods like `credit_card`, `paypal`, and `stripe`
- Reviews with ratings from 3 to 5 stars
- Realistic location data for Kenyan cities (e.g., Mombasa, Nairobi, Naivasha)

---

## ✅ How to Use

1. Make sure your database schema is already created.
2. Run the sample data script in your SQL environment:

```bash
mysql -u your_user -p your_database < seed.sql
