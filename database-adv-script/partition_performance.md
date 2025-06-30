# 📊 Bookings Table Performance Report (Partitioning)

## ✅ Summary

This report outlines the performance improvements observed after applying **partitioning** to the `BOOKINGS` table using MySQL. The table was partitioned by `start_date` (RANGE partitioning), and test queries were run to evaluate efficiency gains.

---

## 🔎 Query Tested

```sql
SELECT * FROM BOOKINGS
WHERE start_date BETWEEN '2025-01-01' AND '2025-12-31';
````

### Execution Plan Output

| ID | Table    | Partitions | Type | Rows | Filtered | Extra       |
| -- | -------- | ---------- | ---- | ---- | -------- | ----------- |
| 1  | BOOKINGS | p2025      | ALL  | 5    | 20.00%   | Using where |

---

## 🚀 Observed Improvements

| Metric               | Before Partitioning     | After Partitioning        |
| -------------------- | ----------------------- | ------------------------- |
| Table Scanned        | Entire `BOOKINGS` table | Only `p2025` partition    |
| Row Filtering        | Full table scan         | Partition pruning applied |
| Query Speed (Est.)   | Slower                  | Faster                    |
| Maintenance Overhead | Higher                  | Reduced                   |

---

## 🧠 Insights

* ✅ **Partition Pruning** is working: Only relevant data from `p2025` is scanned.
* ⚡ **Performance Boost**: Even with small data, the query engine uses optimized paths.
* 💡 **Scalability**: Benefits will scale as data volume increases.

---

## 📌 Recommendations

* Always filter queries using the **partition key** (`start_date`) for optimal performance.
* Add **supporting indexes** on:

  * `user_id`
  * `status`
  * `created_at`
* Simulate a large dataset to measure long-term scalability.
* Consider combining with **sub-partitioning** or **archiving strategy** as data grows.

---

## ✅ Conclusion

Partitioning is an effective strategy for improving query performance on time-series data like bookings. The query engine successfully prunes irrelevant partitions, reducing overhead and speeding up execution.

```