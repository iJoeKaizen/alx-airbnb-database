-- Create partitioned table structure
CREATE TABLE bookings (
    id SERIAL,
    property_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, start_date)
) PARTITION BY RANGE (start_date);

-- Create partitions for current and historical data
CREATE TABLE bookings_2023_q1 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2023-04-01');

CREATE TABLE bookings_2023_q2 PARTITION OF bookings
    FOR VALUES FROM ('2023-04-01') TO ('2023-07-01');

CREATE TABLE bookings_2023_q3 PARTITION OF bookings
    FOR VALUES FROM ('2023-07-01') TO ('2023-10-01');

CREATE TABLE bookings_2023_q4 PARTITION OF bookings
    FOR VALUES FROM ('2023-10-01') TO ('2024-01-01');

CREATE TABLE bookings_2024_q1 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

-- Default future partition
CREATE TABLE bookings_future PARTITION OF bookings
    FOR VALUES FROM ('2024-04-01') TO (MAXVALUE);


-- Migrate data from original table (if exists)
INSERT INTO bookings 
SELECT * FROM original_bookings_table;

-- Create indexes on each partition
CREATE INDEX idx_bookings_property_part ON bookings(property_id);
CREATE INDEX idx_bookings_user_part ON bookings(user_id);
CREATE INDEX idx_bookings_dates_part ON bookings(start_date, end_date);


-- Before partitioning
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2023-06-01' AND '2023-08-31';

-- After partitioning
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2023-06-01' AND '2023-08-31';
