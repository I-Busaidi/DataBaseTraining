use DB_Project_Hotel

--Hotel Table Indexes
--Hotel Name Index
create nonclustered index HotelNameIndex
on Hotel (Hname asc)

--Hotel Rating Index
create nonclustered index HotelRatingIndex
on Hotel (Rating desc)

-------------------------------------------
--Room Table Indexes
--Room Hotel ID index
create nonclustered index RoomHotelIndex
on Room (Rnumber, HID asc)

--Room type Index
create nonclustered index RoomTypeIndex
on Room (Rtype asc)

-------------------------------------------
--Booking Table Indexes
--Booking Guest ID index
create nonclustered index BookingGuestID
on Booking (GID asc)

--Booking Status Index
create nonclustered index BookingStatusIndex
on Booking (Booking_Status asc)

--Booking Room, Check in date, Check out date Index
create nonclustered index BookingRoomDateIndex
on Booking (RID, Checkin_Date, Checkout_Date asc)