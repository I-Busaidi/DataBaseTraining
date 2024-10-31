use DB_Project_Hotel

--View 1: Top Rated Hotels
create view VTopRatedHotels
as
	select h.Hname as [Hotel Name], COUNT(r.RID) as [Number of Rooms], AVG(r.Price) as [Average Room Price]
	from Hotel h inner join Room r on h.HID = r.HID
	where h.Rating > 4.5
	group by h.Hname

select * from VTopRatedHotels

--View 2: Guest and number of bookings
create view VGuestBookings
as
	select 
		g.GID as [ID], 
		g.Guest_Fname + ' ' + g.Guest_Lname as [Guest Name], 
		g.G_Contact as [Phone No.], 
		COUNT(b.Booking_Id) as [No. of bookings], 
		SUM(b.Total_Cost) as [Total Amount Spent]
	from Guest g inner join Booking b on g.GID = b.GID
	group by g.GID, g.Guest_Fname, g.Guest_Lname, g.G_Contact

select * from VGuestBookings

--View 3: Available rooms for each hotel
create view VAvailableRooms
as
	select h.HID as [Hotel ID], 
	h.Hname as [Hotel Name], 
	r.Rnumber as [Room Number], 
	r.Rtype as [Room Type], 
	r.Price
	from Room r inner join Hotel h on h.HID = r.HID
	where r.IsAvailable = 1
	order by r.Rtype, r.Price offset 0 rows

select * from VAvailableRooms

--View 4: Booking Summary
create view VBookingSummary
as
	select h.HID as [ID], h.Hname as [Hotel],
		COUNT(b.Booking_Id) as [Total Bookings],
		(select COUNT(*)
		from Booking b
		inner join Room r
		on b.RID = r.RID where r.HID = h.HID and b.Booking_Status = 'Confirmed')
		as [Confirmed Bookings],
		(select COUNT(*)
		from Booking b
		inner join Room r
		on b.RID = r.RID where r.HID = h.HID and b.Booking_Status = 'Pending')
		as [Pending Bookings],
		(select COUNT(*)
		from Booking b
		inner join Room r
		on b.RID = r.RID where r.HID = h.HID and b.Booking_Status = 'Canceled')
		as [Canceled Bookings]
	from Hotel h left join Room r on r.HID = h.HID left join Booking b on b.RID = r.RID
	group by h.Hname, h.HID


select * from VBookingSummary

--View 5: List Payment Records along with guest name, hotel name,
--Booking status and total payment made by each guest.
create view VPaymentHistory
as
	select p.PID as ID, 
	p.Pdate as [Payment Date], 
	p.Pmethod as [Payment Method], 
	g.Guest_Fname + ' ' + g.Guest_Lname as [Guest Name],
	h.Hname as [Hotel Name],
	b.Booking_Status,
	p.Pamount as [Payment Amount]
	from Payment p left join Booking b on p.Booking_Id = b.Booking_Id 
	inner join Guest g on g.GID = b.GID
	left join Hotel h on h.HID in (select HID
									from Room where RID = b.RID)

select * from VPaymentHistory