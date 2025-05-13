--# INNER JOIN
SELECT 
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.start_date,
    bookings.end_date,
    users.id AS user_id,
    users.first_name,
    users.last_name,
    users.email
FROM bookings
INNER JOIN users ON bookings.users_id = users.id;


--# LEFT JOIN
SELECT 
    properties.id AS property_id,
    properties.name,
    properties.location,
    reviews.id AS review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews ON properties.id = reviews.property_id
    ORDER BY properties.name ASC;


--# FULL OUTER JOIN
SELECT 
    users.id AS user_id,
    users.first_name,
    users.email,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.start_date,
    bookings.end_date
FROM users
FULL OUTER JOIN bookings ON users.id = bookings.user_id;

