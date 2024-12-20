use DB_Project_Hotel

-- Insert sample data into Hotels
INSERT INTO Hotel (Hname, Hlocation, Hphone, Rating)
VALUES 
('Grand Plaza', 'New York', '123-456-7890', 4.5),
('Royal Inn', 'London', '234-567-8901', 4.0),
('Ocean Breeze', 'Miami', '456-789-0123', 4.2),
('Mountain Retreat', 'Denver', '567-890-1234', 3.9),
('City Lights Hotel', 'Las Vegas', '678-901-2345', 4.7),
('Desert Oasis', 'Phoenix', '789-012-3456', 4.3),
('Lakeview Lodge', 'Minnesota', '890-123-4567', 4.1),
('Sunset Resort', 'California', '345-678-9012', 3.8);

-- Insert sample data into Rooms
INSERT INTO Room (HID, Rnumber, Rtype, Price, IsAvailable)
VALUES 
(1, 101, 'Single', 100, 1),
(1, 102, 'Double', 150, 1),
(1, 103, 'Suite', 300, 1),
(2, 201, 'Single', 90, 1),
(2, 202, 'Double', 140, 0),
(3, 301, 'Suite', 250, 1),
(4, 401, 'Single', 120, 1),
(4, 402, 'Double', 180, 1),
(5, 501, 'Suite', 350, 1),
(5, 502, 'Single', 130, 0),
(6, 601, 'Double', 200, 1),
(6, 602, 'Suite', 400, 0),
(7, 701, 'Single', 110, 1),
(7, 702, 'Double', 160, 1),
(8, 801, 'Suite', 380, 1),
(8, 802, 'Single', 140, 1);

-- Insert sample data into Guests
INSERT INTO Guest (Guest_Fname, Guest_Lname, G_Contact, Id_proof_type, Id_proof_number)
VALUES 
('John', 'Doe', '567-890-1234', 'Passport', 'A1234567'),
('Alice','Smith', '678-901-2345', 'Driver License', 'D8901234'),
('Robert', 'Brown', '789-012-3456', 'ID Card', 'ID567890'),
('Sophia', 'Turner', '012-345-6789', 'Passport', 'B2345678'),
('James', 'Lee', '123-456-7890', 'ID Card', 'ID890123'),
('Emma', 'White', '234-567-8901', 'Driver License', 'DL3456789'),
('Daniel', 'Kim', '345-678-9012', 'Passport', 'C3456789'),
('Olivia', 'Harris', '456-789-0123', 'ID Card', 'ID234567'),
('Noah', 'Brown', '567-891-1234', 'Driver License', 'DL4567890'),
('Ava', 'Scott', '678-900-2345', 'Passport', 'D4567890'),
('Mason', 'Clark', '789-022-3456', 'ID Card', 'ID345678');

-- Insert sample data into Bookings
INSERT INTO Booking (GID, RID, Booking_Date, Checkin_Date, Checkout_Date, Booking_Status, Total_Cost)
VALUES 
(10, 1, '2024-10-01', '2024-10-05', '2024-10-10', 'Confirmed', 500),
(11, 2, '2024-10-15', '2024-10-20', '2024-10-25', 'Pending', 750),
(12, 3, '2024-10-05', '2024-10-07', '2024-10-09', 'Check-in', 600),
(13, 4, '2024-10-10', '2024-10-12', '2024-10-15', 'Confirmed', 360),
(14, 5, '2024-10-16', '2024-10-18', '2024-10-21', 'Pending', 540),
(15, 6, '2024-10-05', '2024-10-08', '2024-10-12', 'Check-in', 800),
(16, 7, '2024-10-22', '2024-10-25', '2024-10-28', 'Confirmed', 450),
(17, 8, '2024-10-15', '2024-10-18', '2024-10-20', 'Pending', 420),
(10, 9, '2024-10-25', '2024-10-27', '2024-10-29', 'Confirmed', 340),
(11, 10, '2024-10-19', '2024-10-21', '2024-10-24', 'Check-in', 480);

-- Insert sample data into Payments
INSERT INTO Payment (Booking_Id, Pdate, Pamount, Pmethod)
VALUES 
(2, '2024-10-02', 250, 'Credit Card'),
(2, '2024-10-06', 250, 'Credit Card'),
(3, '2024-10-16', 750, 'Debit Card'),
(5, '2024-10-11', 180, 'Credit Card'),
(5, '2024-10-14', 180, 'Credit Card'),
(6, '2024-10-17', 270, 'Debit Card'),
(6, '2024-10-20', 270, 'Credit Card'),
(7, '2024-10-06', 400, 'Cash'),
(7, '2024-10-09', 400, 'Credit Card'),
(8, '2024-10-23', 450, 'Debit Card');

-- Insert sample data into Staff
INSERT INTO Staff (S_Fname, S_Lname, S_Pos, S_Contact, HID)
VALUES 
('Michael', 'Johnson', 'Manager', '890-123-4567', 1),
('Emily', 'Davis', 'Receptionist', '901-234-5678', 2),
('David', 'Wilson', 'Housekeeper', '012-345-6789', 3),
('Laura', 'Thompson', 'Manager', '901-234-5678', 4),
('Ryan', 'Foster', 'Receptionist', '012-345-6789', 5),
('Sophia', 'Roberts', 'Housekeeper', '123-456-7890', 6),
('Ethan', 'Walker', 'Chef', '234-567-8901', 7),
('Liam', 'Mitchell', 'Security', '345-678-9012', 8),
('Isabella', 'Martinez', 'Manager', '456-789-0123', 1);

-- Insert sample data into Reviews
INSERT INTO Review (GID, HID, Rating, Comment, Review_Date)
VALUES 
(10, 1, 5, 'Excellent stay!', '2024-10-11'),
(11, 2, 4, 'Good service, but room was small.', '2024-10-26'),
(12, 3, 3, 'Average experience.', '2024-10-12'),
(13, 1, 4, 'Good experience, but room service was slow.', '2024-10-16'),
(14, 2, 5, 'Amazing ambiance and friendly staff.', '2024-10-20'),
(15, 3, 3, 'Decent stay, but room cleanliness needs improvement.', '2024-10-25'),
(16, 4, 4, 'Great location, will visit again!', '2024-10-27'),
(17, 5, 2, 'Not satisfied with the facilities.', '2024-10-29');
