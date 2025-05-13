High-Usage Columns
User Table
Primary Key: id (JOINs in all user-related queries)

Authentication: email (WHERE in login queries)

Search: last_name, first_name (WHERE in user searches)

Analytics: created_at (ORDER BY in reports)

Access Control: role (WHERE in permission checks)

Booking Table
Primary Key: id

Relationships: property_id, user_id (JOINs to properties/users)

Temporal: start_date, end_date (WHERE for availability checks)

Status: status (WHERE in booking management)

Financial: total_price (ORDER BY in reports)

Property Table
Primary Key: id

Relationships: host_id (JOINs to users)

Location: city, country (WHERE in searches)

Pricing: price_per_night (WHERE/ORDER BY in searches)

Quality: average_rating (WHERE/ORDER BY in searches)

Features: amenities (WHERE in searches)


INDEX CREATION
-- User table indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_name ON users(last_name, first_name);
CREATE INDEX idx_users_role_created ON users(role, created_at);

-- Booking table indexes
CREATE INDEX idx_bookings_property_user ON bookings(property_id, user_id);
CREATE INDEX idx_bookings_dates_status ON bookings(start_date, end_date, status);
CREATE INDEX idx_bookings_user_status ON bookings(user_id, status);
CREATE INDEX idx_bookings_price ON bookings(total_price);

-- Property table indexes
CREATE INDEX idx_properties_host ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(city, country);
CREATE INDEX idx_properties_price_rating ON properties(price_per_night, average_rating);
CREATE INDEX idx_properties_amenities ON properties USING gin(amenities);


EXPLAIN ANALYZE
SELECT b.*, p.title 
FROM bookings b
JOIN properties p ON b.property_id = p.id
WHERE b.user_id = 123
AND b.status = 'completed'
ORDER BY b.start_date DESC;


EXPLAIN ANALYZE
SELECT p.* 
FROM properties p
WHERE p.city = 'Paris'
AND p.country = 'France'
AND p.price_per_night BETWEEN 100 AND 300
AND p.average_rating >= 4.0
AND 'WiFi' = ANY(p.amenities)
ORDER BY p.average_rating DESC, p.price_per_night ASC;



