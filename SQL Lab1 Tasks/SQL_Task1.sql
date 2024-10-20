create database Task1DB

use Task1DB

create table Course
(
	CID int primary key identity(1,1),
	CName nvarchar(20),
	Duration int constraint UQ_Duration unique
)

create table Instructor
(
	ID int primary key identity(1,1),
	hiredate date default getdate(),
	IAddress nvarchar(5) constraint Address_Check check (IAddress in ('cairo', 'alex')),
	Salary float constraint Sal_Check check (Salary between 1000 and 5000) default 3000,
	OverTime float constraint UQ_OverTime unique,
	BD date,
	NetSalary as Salary + OverTime,
	age as year(getdate()) - year(BD),
	FName nvarchar(20),
	LName nvarchar(20)
)

create table CourseInstructor
(
	CID int,
	ID int,
	foreign key (CID) references Course(CID) on delete cascade on update cascade,
	foreign key (ID) references Instructor(ID) on delete cascade on update cascade,
	primary key (CID, ID)
)

create table Lab
(
	LID int identity(1,1),
	CID int,
	LabLocation nvarchar(100), 
	Capacity int constraint Capacity_check check(Capacity < 20),
	foreign key (CID) references Course(CID) on delete cascade on update cascade,
	primary key (LID, CID)
)

BACKUP DATABASE Task1DB
TO DISK = 'C:\DB_Backup\Task1DB.bak'
WITH FORMAT, 
     INIT, 
     COMPRESSION, 
     STATS = 10;

Drop database Task1DB

RESTORE DATABASE Task1DB 
FROM DISK = 'C:\DB_Backup\Task1DB.bak'
WITH FILE = 1, 
     NORECOVERY;
