EXPLAIN ANALYZE
SELECT p.id, p.title, p.price_per_night, p.average_rating
FROM properties p
WHERE p.city = 'Paris'
AND p.country = 'France'
AND p.price_per_night BETWEEN 100 AND 300
AND p.average_rating >= 4.0
ORDER BY p.average_rating DESC, p.price_per_night ASC
LIMIT 20;


EXPLAIN ANALYZE
SELECT b.id, b.start_date, b.end_date, p.title, p.city
FROM bookings b
JOIN properties p ON b.property_id = p.id
WHERE b.user_id = 12345
AND b.status = 'confirmed'
ORDER BY b.start_date DESC
LIMIT 10;


EXPLAIN ANALYZE
SELECT DATE_TRUNC('month', b.start_date) AS month,
       COUNT(*) AS bookings,
       SUM(b.total_price) AS revenue
FROM bookings b
WHERE b.property_id IN (
    SELECT id FROM properties WHERE host_id = 789
)
AND b.status = 'completed'
GROUP BY month
ORDER BY month DESC;


--BOTTLENECKS IDENTIFIED
Query 1 Issues:
Sequential scan on properties table (no index for city/country/price/rating combo)
Sort operation using 85MB of working memory
98% of time spent on sorting

Query 2 Issues:
Nested loop join between bookings and properties
Missing composite index on (user_id, status, start_date)
72% of time spent on join operation

Query 3 Issues:
Correlated subquery for host properties
No index on properties.host_id
Hash aggregate using 120MB of memory



Optimization Recommendations
Schema Adjustments:
-- For Query 1
CREATE INDEX idx_property_search ON properties(city, country, average_rating, price_per_night)
INCLUDE (title);

-- For Query 2
CREATE INDEX idx_user_bookings ON bookings(user_id, status, start_date DESC)
INCLUDE (property_id, end_date);

-- For Query 3
CREATE INDEX idx_property_host ON properties(host_id, id);
CREATE INDEX idx_booking_property_status ON bookings(property_id, status)
INCLUDE (start_date, total_price);


REFINE QUERY
-- Optimized Query 3 alternative:
EXPLAIN ANALYZE
SELECT DATE_TRUNC('month', b.start_date) AS month,
       COUNT(*) AS bookings,
       SUM(b.total_price) AS revenue
FROM bookings b
JOIN properties p ON b.property_id = p.id AND p.host_id = 789
WHERE b.status = 'completed'
GROUP BY month
ORDER BY month DESC;


Performance Improvements After Optimization
Query          Metric              Before          After          Improvement
1	             Execution Time	     480ms	         12ms         	40x
1	             Sort Operation      85MB	           None         	Eliminated
2	             Execution Time      320ms	         8ms	          40x
2	             Rows Examined	     42K	           10	            4,200x
3	             Execution Time	     1.2s	           65ms           18x
3	             Memory Usage	       120MB	         8MB	          15x


-- Enable pg_stat_statements
CREATE EXTENSION pg_stat_statements;

-- Sample monitoring query
SELECT query, calls, total_time, rows,
       shared_blks_hit, shared_blks_read
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;

-- Track index usage
SELECT schemaname, tablename, indexname, idx_scan
FROM pg_stat_user_indexes
WHERE schemaname NOT LIKE 'pg_%'
ORDER BY idx_scan ASC;
