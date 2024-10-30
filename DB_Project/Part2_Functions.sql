use DB_Project_Hotel

--Function 1: Get Hotel Avg Rating
create function GetHotelAverageRating (@HotelID int)
returns decimal(3,2)
begin
	declare @AvgRating decimal(3,2)
	select @AvgRating = AVG(Rating) from Review where HID = @HotelID
	return @AvgRating
end
	
select dbo.GetHotelAverageRating(1)

--Function 2: Get Next Available Room
create function GetNextAvailableRoom (@RoomType nvarchar(10), @HotelID int)
returns int
begin
	declare @RoomNumber int
	select @RoomNumber = Rnumber from Room where Rtype = @RoomType and HID = @HotelID and IsAvailable = 1
	return @RoomNumber
end

select dbo.GetNextAvailableRoom('single', 2)

--Function 3: Calculate Occupancy Rate of a Hotel
create function GetOccupancyRate(@HotelID int)
returns decimal(5,2)
begin
	declare @OccupancyRate decimal(5,2) = 0.00
	declare @ConfirmedBookings int
	declare @TotalBookings int

	select @TotalBookings = COUNT(*) from Booking
									where RID in (select RID from Room
													where HID = @HotelID)
									and DATEDIFF(day, Booking_Date, GETDATE()) <= 30

	select @ConfirmedBookings = COUNT(*) from Booking
										where RID in (select RID from Room
														where HID = @HotelID)
										and Booking_Status not in ('Pending','Canceled')
										and DATEDIFF(day, Booking_Date, GETDATE()) <= 30

	if @TotalBookings > 0
	begin
		set @OccupancyRate = (CAST(@ConfirmedBookings as decimal(5,2)) / CAST(@TotalBookings as decimal(5,2)))*100
	end
	return @OccupancyRate
end

select dbo.GetOccupancyRate(1)