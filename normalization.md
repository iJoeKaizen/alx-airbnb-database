USER
user_id UUID PRIMARY KEY,
first_name VARCHAR NOT NULL,
last_name VARCHAR NOT NULL,
email VARCHAR UNIQUE NOT NULL,
password_hash VARCHAR NOT NULL,
phone_number VARCHAR,
role ENUM('guest', 'host', 'admin') NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

LOCATION
location_id UUID PRIMARY KEY,
city VARCHAR NOT NULL,
state VARCHAR,
country VARCHAR NOT NULL

PROPERTY
property_id UUID PRIMARY KEY,
host_id UUID REFERENCES User(user_id),
name VARCHAR NOT NULL,
description TEXT NOT NULL,
location_id UUID REFERENCES Location(location_id),
price_per_night DECIMAL NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

BOOKINGS
booking_id UUID PRIMARY KEY,
property_id UUID REFERENCES Property(property_id),
user_id UUID REFERENCES User(user_id),
start_date DATE NOT NULL,
end_date DATE NOT NULL,
total_price DECIMAL NOT NULL
status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

PAYMENTS
payment_id UUID PRIMARY KEY,
booking_id UUID REFERENCES Booking(booking_id),
amount DECIMAL NOT NULL,
payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL

REVIEW
review_id UUID PRIMARY KEY,
property_id UUID REFERENCES Property(property_id),
user_id UUID REFERENCES User(user_id),
rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
comment TEXT NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

MESSAGE
message_id UUID PRIMARY KEY,
sender_id UUID REFERENCES User(user_id),
recipient_id UUID REFERENCES User(user_id),
message_body TEXT NOT NULL,
sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP


STEPS IN NORMALIZATION
No multi-valued or repeating fields ----- (1NF).
2NF	All tables use atomic primary keys. No partial dependency on composite keys. All tables use primary keys ---------- (2NF)
3NF	Removed derived and transitive dependencies:
- Created a Location table to avoid data redundancy and inconsistencies.
