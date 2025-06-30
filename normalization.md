# 📚 Database Normalization to 3NF

## 🧾 Overview

This database schema follows the principles of **Third Normal Form (3NF)** to minimize redundancy and ensure data integrity.

---

## 🔄 Normalization Process

### ✅ 1NF – *First Normal Form*

**Requirements:**

* Each table cell contains **atomic values** (no repeating groups)
* All records are **unique**
* Each attribute contains values from the **same domain**

**Implementation:**

* All tables use **single-value fields**
* **Primary keys** ensure unique records
* Proper **data types** enforce domain integrity

---

### ✅ 2NF – *Second Normal Form*

**Requirements:**

* Must satisfy **1NF**
* All non-key attributes must depend on the **entire primary key**

**Implementation:**

* Use of **single-column primary keys** satisfies 2NF
* **Composite keys avoided** where possible
* **Example:** In the `BOOKING` table, all fields depend on `booking_id`

---

### ✅ 3NF – *Third Normal Form*

**Requirements:**

* Must satisfy **2NF**
* No **transitive dependencies** (non-key attributes don’t depend on other non-key attributes)

**Implementation:**

* A separate `LOCATION` table was created to eliminate transitive dependencies from `PROPERTY`
* All non-key attributes depend **only on the primary key**
* **Example:** In `LOCATION`, `city`, `state`, and `country` depend solely on `location_id`

---

## 🌍 Location Table Normalization

### 📉 Before Normalization

```sql
PROPERTY (
  property_id UUID PRIMARY KEY,
  host_id UUID NOT NULL,
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR NOT NULL,
  price_per_night DECIMAL NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES USER(user_id)
)
```

### 📈 After Normalization

```sql
LOCATION (
  location_id UUID PRIMARY KEY,
  country VARCHAR(100) NOT NULL,
  state_province VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20),
  address_line1 VARCHAR(255) NOT NULL,
  address_line2 VARCHAR(255),
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8)
)
```

```sql
PROPERTY (
  property_id UUID PRIMARY KEY,
  host_id UUID NOT NULL,
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location_id UUID NOT NULL,
  price_per_night DECIMAL NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES USER(user_id),
  FOREIGN KEY (location_id) REFERENCES LOCATION(location_id)
)
```

---

## ✅ Benefits of This Design

* 🚀 **Efficient Storage**: Avoids repeating address details across multiple properties
* 🔍 **Better Querying**: Enables filtering by country, city, etc.
* 🗺️ **Geospatial Support**: `latitude` and `longitude` enable map-based features
* 🔐 **Data Consistency**: Centralized address data ensures referential integrity

---


