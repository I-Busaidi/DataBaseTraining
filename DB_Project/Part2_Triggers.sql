use DB_Project_Hotel

--Trigger 1: Update room availability to unavailable when booking is done.
create trigger trg_UpdateRoomAvailability
on Booking
instead of insert
as
begin
	if (select IsAvailable from Room r inner join inserted i on r.RID = i.RID) = 0
	begin
		select 'Room is not available'
	end
	
	else
	begin
		insert into Booking (GID, RID, Checkin_Date, Checkout_Date, Booking_Date, Total_Cost, Booking_Status) 
		select GID, RID, Checkin_Date, Checkout_Date, Booking_Date, Total_Cost, Booking_Status from inserted

		update Room
		set IsAvailable = 0
		where RID = (select RID from inserted)
	end
end

---------------------------------------------------------------
--Trigger 2: Calculate total revenue.
create trigger trg_CalculateTotalRevenue
on Payment
after insert
as
begin
	select h.Hname as [Hotel], SUM(p.Pamount) as [Hotel Revenue] 
	from Payment p inner join Hotel h 
	on h.HID in (select r.HID
					from Room r
					inner join Booking b
					on b.RID = r.RID
					where b.Booking_Id = p.Booking_Id)
	group by h.Hname
end

---------------------------------------------------------------
--Trigger 3: Check-In Date Validation
create trigger trg_CheckInDateValidation
on Booking
instead of insert
as
begin
	if exists (select 1 from inserted where Checkin_Date > Checkout_Date)
	begin
		select 'Check-in date cannot be after check-out date'
	end

	else
	begin
		insert into Booking (GID, RID, Checkin_Date, Checkout_Date, Booking_Date, Total_Cost, Booking_Status)
		select GID, RID, Checkin_Date, Checkout_Date, Booking_Date, Total_Cost, Booking_Status from inserted
	end
end

--Cannot create 2 instead of insert triggers on the same table, must combine the 2 into 1 trigger:
create trigger trg_UpdateRoomAndValidateCheckIn
on Booking
instead of insert
as
begin
	declare @RoomIsAvailable bit
	declare @DateValid bit
	set @DateValid = 0
	set @RoomIsAvailable = 0
	--Check room availability and update
	if (select IsAvailable from Room r inner join inserted i on r.RID = i.RID) = 0
	begin
		select 'Room is not available'
	end
	
	else
	begin
		set @RoomIsAvailable = 1
	end

	--check-in date validation:
	if exists (select 1 from inserted where Checkin_Date > Checkout_Date)
	begin
		select 'Check-in date cannot be after check-out date'
	end

	else
	begin
		set @DateValid = 1
	end
	
	if @RoomIsAvailable = 1 and @DateValid = 1
	begin
		insert into Booking (GID, RID, Checkin_Date, Checkout_Date, Booking_Date, Total_Cost, Booking_Status)
		select GID, RID, Checkin_Date, Checkout_Date, Booking_Date, Total_Cost, Booking_Status from inserted

		update Room
		set IsAvailable = 0
		where RID = (select RID from inserted)
	end
end

---------------------------------------------------------------
--Trigger to update hotel rating each time a guest reviews it.
create trigger trg_UpdateRating
on Review
after insert
as
begin
	update Hotel
	set Rating = (select AVG(Rating) from Review where HID = (select HID from inserted))
	where HID = (select HID from inserted)
end