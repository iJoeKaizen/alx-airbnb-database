-- ========================
--SAMPLE DATA
-- ========================

-- 1. USERS
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('u1', 'Alice', 'Koomson', 'alice@example.com', 'hashed_pwd_1', '0244444432', 'guest', CURRENT_TIMESTAMP),
('u2', 'Linda', 'Lomo', 'lomo@example.com', 'hashed_pwd_2', '0504444432', 'host', CURRENT_TIMESTAMP),
('u3', 'Richard', 'Peprah', 'peprah@example.com', 'hashed_pwd_3', NULL, 'admin', CURRENT_TIMESTAMP),
('u4', 'Daniel', 'Musah', 'musah@example.com', 'hashed_pwd_4', '0551234567', 'guest', CURRENT_TIMESTAMP);

-- 2. LOCATIONS
INSERT INTO locations (location_id, city, state, country) VALUES
('l1', 'Kumasi', 'KM', 'Ghana'),
('l2', 'Accra', 'ACC', 'Ghana'),
('l3', 'Tema', NULL, 'Ghana');

-- 3. PROPERTIES
INSERT INTO properties (property_id, host_id, name, description, location_id, price_per_night, created_at, updated_at) VALUES
('p1', 'u2', 'Bosomtwe Villa', 'A nice place in Kumash.', 'l1', 600.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('p2', 'u2', 'Sunny Villa', 'Beautiful villa with a pool and garden.', 'l2', 1500.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('p3', 'u4', 'Nyaniba Estate', 'Stylish loft in the heart of Osu Accra.', 'l2', 2500.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 4. BOOKINGS
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('b1', 'p1', 'u2', '2025-06-01', '2025-06-05', 3000.00, 'confirmed', CURRENT_TIMESTAMP),
('b2', 'p2', 'u2', '2025-07-10', '2025-07-15', 7500.00, 'pending', CURRENT_TIMESTAMP),
('b3', 'p3', 'u4', '2025-08-01', '2025-08-03', 7500.00, 'canceled', CURRENT_TIMESTAMP);

-- 5. PAYMENTS
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('pay1', 'b1', 3000.00, CURRENT_TIMESTAMP, 'credit_card'),
('pay2', 'b2', 7500.00, CURRENT_TIMESTAMP, 'Cash');

-- 6. REVIEWS
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at) VALUES
('r1', 'p1', 'u1', 5, 'Excellent stay! Everything was clean and cozy.', CURRENT_TIMESTAMP),
('r2', 'p2', 'u4', 4, 'Nice villa, but a bit far from the city center.', CURRENT_TIMESTAMP),
('r3', 'p3', 'u1', 2, 'Nice design but too noisy at night.', CURRENT_TIMESTAMP);

-- 7. MESSAGES
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('m1', 'u1', 'u2', 'Hi, is the apartment available for next weekend?', CURRENT_TIMESTAMP),
('m2', 'u2', 'u1', 'Yes, it is available. Feel free to book!', CURRENT_TIMESTAMP),
('m3', 'u4', 'u2', 'Can I get a discount for a 5-day stay?', CURRENT_TIMESTAMP),
('m4', 'u2', 'u4', 'Let me check and get back to you.', CURRENT_TIMESTAMP);
