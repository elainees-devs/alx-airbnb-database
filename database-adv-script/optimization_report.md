## 📊 Optimization Report

### 📝 Query Description

This report analyzes and optimizes a SQL query that retrieves booking records along with user, property, and payment details from an Airbnb-like relational database.

---

### ⚙️ Original Query

The original query joins the following tables:

* `BOOKING` (core entity)
* `USER` (guest who made the booking)
* `PROPERTY` (booked property)
* `PAYMENT` (if any)

It retrieves booking info, guest name, property name, and payment method, ordered by booking creation time.

---

### 🔍 Performance Analysis (Before Indexing)

The query was profiled using `EXPLAIN ANALYZE`. The execution plan showed:

| Observation                    | Detail                                                   |
| ------------------------------ | -------------------------------------------------------- |
| ❌ **Sequential Scans**         | `Seq Scan on BOOKING`, `USER`, `PROPERTY`, and `PAYMENT` |
| ❌ **Hash Joins**               | High cost hash joins on all foreign key relations        |
| ❌ **Sort Operation**           | Sorting by `b.created_at` with no index                  |
| 🐢 **Estimated Cost**          | `cost=0.00..1400.50`                                     |
| 🕓 **Execution Time (Sample)** | \~8.23 to 8.27 ms for 200 rows (example from EXPLAIN)    |
| 💾 **Rows Processed**          | 200 rows in result set                                   |

---

### ✅ Optimization Steps

**1. Indexed High-Usage Columns**

```sql
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON BOOKING(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON BOOKING(property_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON PAYMENT(booking_id);
CREATE INDEX IF NOT EXISTS idx_booking_created_at ON BOOKING(created_at);
```

**2. Refactored Query for Efficiency**

* Kept only necessary columns.
* Used `INNER JOIN` only where relationships are mandatory.
* Preserved `LEFT JOIN` only for `PAYMENT` (optional).
* Ordered using indexed column: `b.created_at`.

**3. Reduced Expression Overhead**

* Added `COALESCE()` to avoid null concatenation issues on user names.

---

### ⚡ Performance Results (After Indexing)

| Metric                  | Before Indexing      | After Indexing             |
| ----------------------- | -------------------- | -------------------------- |
| Join Strategy           | Hash Join + Seq Scan | Index Nested Loop (faster) |
| Sorting                 | In-memory            | Index-assisted             |
| Execution Plan Cost     | \~1400               | \~300–600 (estimate)       |
| Execution Time (Sample) | \~8.2 ms             | \~2.1–3.5 ms               |
| Query Responsiveness    | Medium               | Fast                       |

---

### 💡 Key Takeaways

| Lesson                                         | Impact                                    |
| ---------------------------------------------- | ----------------------------------------- |
| Indexing join/filter columns                   | Reduces scan and hash cost                |
| Indexing sort columns                          | Optimizes ORDER BY                        |
| Using `EXPLAIN ANALYZE`                        | Essential for real-world diagnostics      |
| Avoiding unnecessary joins/columns             | Minimizes CPU and memory usage            |
| Using appropriate join types (`INNER`, `LEFT`) | Preserves semantics while improving speed |

---

### 📁 Files Involved

| File Name                | Purpose                                          |
| ------------------------ | ------------------------------------------------ |
| `performance.sql`        | Query, `EXPLAIN ANALYZE`, and raw output         |
| `database_index.sql`     | Index creation statements for performance tuning |
| `optimization_report.md` | This documentation/report                        |

---

### 👩🏽‍💻 Author

**Elaine Muhombe**
Backend Developer in Training
**ALX | GoMyCode Kenya**

---

### 📜 License

This performance tuning and optimization content is free for educational and learning purposes. Attribution appreciated.


