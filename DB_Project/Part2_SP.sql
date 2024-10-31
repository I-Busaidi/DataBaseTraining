use DB_Project_Hotel

--Stored Procedure 1: Mark a room unavailable
create proc sp_MarkRoomUnavailable @BookingID int
as
	begin
		declare @RoomID int
		select @RoomID = RID from Booking where Booking_Id = @BookingID
		update Room set IsAvailable = 0 where RID = @RoomID
		if @@ROWCOUNT > 0
			select 'Room marked unavailable successfully'
		else
			select 'Room could not be updated or not found'
	end

--Stored Procedure 2: Update booking status
create proc sp_UpdateBookingStatus @BookingID int
as
	begin
		declare @CurrentDate date
		declare @CheckinDate date
		declare @CheckoutDate date
		declare @BookingStatus nvarchar(10)
		declare @SetStatus nvarchar(10)

		set @CurrentDate = GETDATE()
		select @CheckinDate = Checkin_Date from Booking where Booking_Id = @BookingID
		select @CheckoutDate = Checkout_Date from Booking where Booking_Id = @BookingID
		select @BookingStatus = Booking_Status from Booking where Booking_Id = @BookingID

		if @CheckinDate is null and @CheckoutDate is null and @BookingStatus <> 'Canceled'
		begin
			set @SetStatus = 'Pending'
		end

		else if @CurrentDate < @CheckinDate and @BookingStatus <> 'Canceled'
		begin
			set @SetStatus = 'Confirmed'
		end

		else if @CurrentDate >= @CheckinDate and @CurrentDate < @CheckoutDate and @BookingStatus <> 'Canceled'
		begin
			set @SetStatus = 'Check-in'
		end

		else if @CurrentDate >= @CheckoutDate and @BookingStatus <> 'Canceled'
		begin
			set @SetStatus = 'Check-out'
		end

		else 
		begin
			set @SetStatus = 'Canceled'
		end

		update Booking set Booking_Status = @SetStatus where Booking_Id = @BookingID

	end

--Stored Procedure 3: Rank Guests By Spending
alter proc sp_RankGuestsBySpending
as
begin
	select *
	from (select g.GID as ID, g.Guest_Fname+' '+g.Guest_Lname as [Guest Name], 
				SUM(b.Total_Cost) as [Total Spending], 
				DENSE_RANK() over(order by SUM(b.Total_Cost) desc) as [Guest Rank]
			from Booking b inner join Guest g on g.GID = b.GID
			group by g.GID, g.Guest_Fname, g.Guest_Lname) as TempTable
end

sp_RankGuestsBySpending