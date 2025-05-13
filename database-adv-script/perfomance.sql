---Initial Query 

SELECT 
    bookings.id AS booking_id,
    bookings.start_date,
    bookings.end_date,
    users.id AS user_id,
    users.first_name,
    users.last_name,
    properties.id AS property_id,
    properties.name AS property_name,
    properties.location,
    payments.id AS payment_id,
    payments.payment_method,
    payments.amount,
    payments.created_at
FROM bookings
JOIN users ON bookings.user_id = users.id
JOIN properties ON bookings.property_id = properties.id
LEFT JOIN payments ON payments.booking_id = bookings.id;

---Performance Analysis with EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT 
    bookings.id AS booking_id,
    bookings.start_date,
    bookings.end_date,
    users.id AS user_id,
    users.first_name,
    users.last_name,
    properties.id AS property_id,
    properties.name AS property_name,
    properties.location,
    payments.id AS payment_id,
    payments.payment_method,
    payments.amount,
    payments.created_at
FROM bookings
JOIN users ON bookings.user_id = users.id
JOIN properties ON bookings.property_id = properties.id
LEFT JOIN payments ON payments.booking_id = bookings.id;

---Performance Issues

--  1. Full Table Scans:
     --- Sequential scans on large tables due to missing indexes
     --- No index utilization for sorting (ORDER BY)

-- 2. Inefficient Joins:
   --- Nested loops causing O(n²) complexity
   --- All payments joined even when not needed

-- 3. Memory Intensive:
   --- Large result set (all historical bookings)
   --- Heavy sorting operation in memory

-- 4. Redundant Data:
   --- Retrieving all columns including unused ones
   --- No filtering of results 

CREATE INDEX idx_bookings_dates ON bookings(start_date);
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_property ON bookings(property_id);
CREATE INDEX idx_payments_booking ON payments(booking_id, status);


--- Refactored query
WITH recent_bookings AS (
    SELECT 
        b.id,
        b.start_date,
        b.end_date,
        b.status,
        b.total_price,
        b.user_id,
        b.property_id
    FROM 
        bookings b
    WHERE 
        b.start_date >= CURRENT_DATE - INTERVAL '6 months'
    ORDER BY 
        b.start_date DESC
    LIMIT 500
)
SELECT 
    rb.id AS booking_id,
    rb.start_date,
    rb.end_date,
    rb.status,
    rb.total_price,
    u.id AS user_id,
    u.first_name,
    u.last_name,
    p.id AS property_id,
    p.title AS property_title,
    p.city,
    p.country,
    pay.amount,
    pay.payment_method,
    pay.status AS payment_status
FROM 
    recent_bookings rb
JOIN 
    users u ON rb.user_id = u.id
JOIN 
    properties p ON rb.property_id = p.id
LEFT JOIN 
    payments pay ON rb.id = pay.booking_id 
                AND pay.status = 'completed'
ORDER BY 
    rb.start_date DESC;


