-- BOOKINGS MADE BY EACH USER
SELECT 
    users.id AS user_id,
    users.first_name,
    users.last_name,
    COUNT(bookings.id) AS total_bookings
FROM users
LEFT JOIN bookings ON users.id = bookings.user_id
GROUP BY users.id, users.first_name, users.last_name;


SELECT 
    property_id,
    COUNT(*) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS booking_row_number
FROM 
    bookings
GROUP BY 
    property_id;

