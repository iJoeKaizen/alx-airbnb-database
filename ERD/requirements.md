![ERD!]([https://drive.google.com/file/d/16CARNY6_7Cr8ENznagtjybeqBbXZr06u/view?usp=sharing](https://drive.google.com/file/d/16CARNY6_7Cr8ENznagtjybeqBbXZr06u/view?usp=sharing))


Relationship between Entities
User	Property	1-to-Many	A host can own multiple properties
User	Booking	1-to-Many	A guest can make multiple bookings
User	Review	1-to-Many	A user can leave multiple reviews
User	Message	1-to-Many (self-ref)	Users can send/receive messages
Property	Booking	1-to-Many	A property can be booked many times
Property	Review	1-to-Many	A property can have many reviews
Booking	Payment	1-to-1	Each booking has one payment
