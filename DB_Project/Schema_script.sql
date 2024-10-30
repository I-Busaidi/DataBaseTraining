create database DB_Project_Hotel

use DB_Project_Hotel

create table Hotel
(
	HID int primary key identity(1,1),
	Hname nvarchar(30) unique not null,
	Hlocation nvarchar(50) not null,
	Hphone nvarchar(20) not null,
	Rating decimal(3, 2) default 0
)

create table Guest
(
	GID int primary key identity(1,1),
	G_Contact nvarchar(20) unique,
	Guest_Fname nvarchar(20),
	Guest_Lname nvarchar(20),
	Id_proof_type nvarchar(20) not null check(Id_proof_type in ('ID Card','Passport','Driver License')),
	Id_proof_number nvarchar(20) not null
)

create table Room
(
	RID int primary key identity(1,1),
	Rnumber int unique not null,
	Rtype nvarchar(10) not null check (Rtype in ('Single', 'Double', 'Suite')),
	Price money check(Price > 0),
	HID int not null,
	IsAvailable bit default 1,
	foreign key (HID) references Hotel(HID) on delete cascade on update cascade
)

create table Staff
(
	S_Id int primary key identity(1,1),
	S_Pos nvarchar(20),
	S_Contact nvarchar(20) not null,
	S_Fname nvarchar(20),
	S_Lname nvarchar(20),
	HID int not null,
	foreign key (HID) references Hotel(HID) on delete cascade on update cascade
)

create table Booking
(
	Booking_Id int unique identity(1,1),
	GID int not null,
	RID int not null,
	Checkin_Date date,
	Checkout_Date date,
	Booking_Date date not null,
	Total_Cost money check(Total_Cost > 0),
	Booking_Status nvarchar(10) default 'Pending' check(Booking_Status in ('Confirmed', 'Canceled', 'Check-in', 'Check-out', 'Pending')) not null,
	foreign key (GID) references Guest(GID) on delete cascade on update cascade,
	foreign key (RID) references Room(RID) on delete cascade on update cascade,
	primary key (Booking_Id, GID, RID)
)

create table Payment
(
	PID int primary key identity(1,1),
	Pdate date not null,
	Pmethod nvarchar(20) check (Pmethod in ('Cash','Credit Card', 'Debit Card')),
	Pamount money not null check(Pamount > 0),
	Booking_Id int not null,
	foreign key (Booking_Id) references Booking(Booking_Id) on delete cascade on update cascade
)

create table Review
(
	Review_Id int unique identity(1,1),
	GID int not null,
	HID int not null,
	Review_Date date not null,
	Comment nvarchar(200) default 'No comments',
	Rating decimal(3, 2) check (Rating between 1 and 5),
	foreign key (GID) references Guest(GID) on delete cascade on update cascade,
	foreign key (HID) references Hotel(HID) on delete cascade on update cascade,
	primary key (Review_Id, GID, HID)
)