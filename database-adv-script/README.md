# 🧩 SQL JOINs & Subqueries in an Airbnb Clone Platform

This document explains how `INNER JOIN`, `LEFT JOIN`, `FULL OUTER JOIN`, and subqueries are used in a normalized relational database for a property booking platform, similar to Airbnb.

Each section outlines the relationships queried and what kind of data each operation returns.

---

## 📂 File Structure

* **`joins.sql`** – Contains all `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` queries used to relate users, properties, bookings, payments, reviews, and messages.
* **`subqueries.sql`** – Contains subqueries including:

  * Properties with an average rating greater than 4.0
  * Users who have made more than 3 bookings

---

## 🔗 INNER JOIN Queries

1. **USER + PROPERTY**
   Retrieve all users who are hosts and the properties they own. Filters users to only those with `role = 'host'`.

2. **PROPERTY + LOCATION**
   Get a list of all properties with their associated geographical locations (city and country).

3. **BOOKING + USER + PROPERTY**
   Show all bookings along with guest information and the property booked. Ensures only bookings with valid guest and property records are shown.

4. **PAYMENT + BOOKING + USER + PROPERTY**
   Display payments including who made the payment (guest), for which booking, and for which property.

5. **REVIEW + PROPERTY + USER**
   List all reviews including the reviewer’s name and the property being reviewed. Only shows reviews with valid user and property references.

6. **MESSAGE + USER (Sender and Recipient)**
   Display all messages sent between users with both sender and recipient details.

---

## 🧭 LEFT JOIN Queries

1. **USER ↔ PROPERTY**
   Show all users, even if they have not listed a property. Hosts without listings will have null values for property fields.

2. **PROPERTY ↔ LOCATION**
   List all properties, even if their associated location is missing or not set.

3. **BOOKING ↔ USER**
   Show all bookings and include guest details if they exist. Useful for auditing bookings made by now-deleted users.

4. **BOOKING ↔ PROPERTY**
   Retrieve all bookings, including ones where the related property may no longer exist.

5. **BOOKING ↔ PAYMENT**
   Show all bookings with payment information, if available. Useful to identify unpaid bookings.

6. **PROPERTY ↔ REVIEW**
   Retrieve all properties and their reviews, including properties that have no reviews. Useful for displaying unrated properties alongside reviewed ones.

---

## 🌐 FULL OUTER JOIN Queries

1. **USER ↔ PROPERTY**
   Show all users and all properties, regardless of whether a user owns a property or a property has a valid host.

2. **PROPERTY ↔ LOCATION**
   Combine all properties and all locations, even if either side lacks a connection.

3. **BOOKING ↔ USER**
   List all bookings and all users. Includes unmatched users and bookings; helpful for identifying orphaned or inactive data.

4. **BOOKING ↔ PROPERTY**
   Retrieve all bookings and all properties, even if they're not currently related.

5. **PAYMENT ↔ BOOKING**
   Display all payments and all bookings, including unmatched records (e.g., payments without bookings or vice versa).

6. **REVIEW ↔ USER**
   Show all reviews and users, whether or not they’re connected. Helps detect reviews made by deleted accounts or unused users.

7. **REVIEW ↔ PROPERTY**
   List all reviews and all properties, regardless of whether they reference each other.

8. **MESSAGE ↔ USER (Sender)**
   Display all messages and all users who may have sent a message. Includes orphaned messages or inactive users.

---

## 🧮 Subqueries

1. **Properties with Average Rating > 4.0**
   Finds all properties where the average rating (from reviews) is greater than 4.0.

2. **Users with More Than 3 Bookings**
   A correlated subquery identifies users who have made more than three bookings. Useful for identifying power users or frequent guests.

---

Here’s the updated section for your `README.md` to document the two new analytical SQL queries using `GROUP BY` and window functions.

---

## 📊 Analytical Queries

This section explains how aggregation and window functions are used to derive insights from the booking data.

---

### 1. **Total Number of Bookings per User**

**Purpose:**
Identify how many bookings each user has made. This is useful for understanding user engagement and for generating user-based reports.

**Logic:**

* Uses the `COUNT()` function to total bookings.
* Groups results by user.
* Uses a `LEFT JOIN` to include users who haven’t made any bookings.

**Example Use Cases:**

* Generating leaderboard of most active guests.
* Highlighting inactive users.

---

#### 2. **Rank Properties by Booking Frequency**

**Purpose:**
Rank each property based on how many bookings it has received. This helps identify the most and least popular properties.

**Logic:**

* Uses `COUNT()` to aggregate bookings per property.
* Applies a `RANK()` window function to assign rank based on booking totals.
* Includes properties with zero bookings using `LEFT JOIN`.

**Alternative:**
Replace `RANK()` with `ROW_NUMBER()` if you want a strict sequential ranking without ties.

**Example Use Cases:**

* Displaying top-listed properties on the homepage.
* Performance analysis for hosts and properties.

---

Let me know if you'd like to include visual examples or export the updated README as a file. Here's the Git commit message for this update:

```
git commit -m "docs: update README with analytical SQL queries using GROUP BY and window functions"
```


🧠 Why This Matters
Understanding SQL JOINs and analytical queries is essential for working effectively with relational databases.

This includes mastering:

INNER JOIN, LEFT JOIN, FULL OUTER JOIN — to control which data relationships are shown or preserved

GROUP BY and aggregation functions like COUNT() — to summarize and report on key metrics

Window functions like RANK() or ROW_NUMBER() — to analyze trends, rank items, or create user-based leaderboards

These skills are critical for:

✅ Handling incomplete or inconsistent data

✨ Writing clean, maintainable, and performant SQL

📊 Building accurate reports, dashboards, and data visualizations

🐛 Debugging and auditing relationships across normalized schemas

📈 Gaining business insights from data (e.g., top users, most booked properties, inactive accounts)

In production systems like booking platforms, analytics dashboards, or admin panels, these tools enable data-driven decisions and effective monitoring.

## 👩🏽‍💻 Author

**Elaine Muhombe**
Backend Developer in Training
**ALX | GoMyCode Kenya**

---

## 📝 License

This educational SQL content is free to use and adapt for learning, teaching, or portfolio demonstration purposes.

---
