use ITI

--1.  Create a scalar function that takes date and returns Month name of that date. 
create function GetMonthName(@MonthName date)
returns nvarchar(10)
begin
	declare @MName nvarchar(10)
	select @MName = DATENAME(MONTH, @MonthName)
	return @MName
end

select dbo.GetMonthName(GETDATE()) as [Month Name]

--2.  Create a multi-statements table-valued function that takes 2 integers and returns the values between them. 
create function GetNumbersBetween(@FirstNo int, @SecNo int)
returns @t table
	(
		Number int
	)
	as
	begin

		declare @number int
		set @number = @FirstNo
		while @number < @SecNo -1
		begin
			set @number += 1
			insert into @t select @number
		end

		return
	end

select * from GetNumbersBetween(59,79)
select * from GetNumbersBetween(1,20)
select * from GetNumbersBetween(10,100)

--3.  Create inline function that takes Student No and returns Department Name with Student full name. 
create function StudentDeptName(@St_ID int)
returns table
as return
	(
		select d.Dept_Name as [Dept. Name], s.St_Fname + ' ' + s.St_Lname as [Student]
		from Student s inner join Department d on s.Dept_Id = d.Dept_Id
		where s.St_Id = @St_ID
	)

select * from StudentDeptName(2)
select * from StudentDeptName(5)

--4. Create a scalar function that takes Student ID and returns a message to user  
create function GetNameStatus(@St_Id int)
returns nvarchar(50)
begin
	declare @StatusMessage nvarchar(50)
	if  (select St_Fname
					from Student
					where St_Id = @St_Id) is null
			and (select St_Lname
					from Student
					where St_Id = @St_Id) is null
			set @StatusMessage = 'First name & last name are null'

	else if (select St_Fname
					from Student
					where St_Id = @St_Id) is null
			and (select St_Lname
					from Student
					where St_Id = @St_Id) is not null
			set @StatusMessage = 'first name is null'

	else if  (select St_Lname
					from Student
					where St_Id = @St_Id) is null
			and (select St_Fname
					from Student
					where St_Id = @St_Id) is not null
			set @StatusMessage = 'last name is null'

	else
			set @StatusMessage = 'First name & last name are not null'

	return @StatusMessage
end

select dbo.GetNameStatus(2)
select dbo.GetNameStatus(13)
select dbo.GetNameStatus(14)

--5. Create inline function that takes integer which represents manager ID and displays department name, Manager Name and hiring date  
create function DisplayMngName(@Mgr_ID int)
returns table
	as
	return
	(
		select d.Dept_Name, i.Ins_Name as [Manager Name], d.Manager_hiredate
		from Instructor i inner join Department d on i.Ins_Id = d.Dept_Manager
		where d.Dept_Manager = @Mgr_ID
	)

select * from DisplayMngName(3)

--6. Create multi-statements table-valued function that takes a string 
create function GetPartOfName(@NamePart nvarchar(10))
returns @t table
	(
		id int,
		StName nvarchar(30)
	)
as
begin
	if @NamePart = 'first name'	
		insert into @t select ISNULL(St_Id, 0), ISNULL(St_Fname, 'N/A') from Student
	else if @NamePart = 'last name'
		insert into @t select ISNULL(St_Id, 0), ISNULL(St_Lname, 'N/A') from Student
	else if @NamePart = 'full name'
		insert into @t select ISNULL(St_Id, 0), ISNULL(St_Fname, 'N/A') + ' ' + ISNULL(St_Lname, 'N/A') from Student

	return
end

select * from GetPartOfName('full name')
select * from GetPartOfName('first name')
select * from GetPartOfName('last name')

--7. Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000 and increases it by 20% if Salary >=3000.
use Company_SD
declare EmpCursor cursor 
for select Salary
	from HumanResource.Employee
for update
declare @EmpSal int
open EmpCursor
fetch EmpCursor into @EmpSal
while @@FETCH_STATUS = 0
	begin
		if @EmpSal < 3000
			update HumanResource.Employee
				set Salary += @EmpSal * 0.1
				where current of EmpCursor
		else
			update HumanResource.Employee
				set Salary += @EmpSal * 0.2
				where current of EmpCursor

		fetch EmpCursor into @EmpSal
	end
close EmpCursor
deallocate EmpCursor

select SSN, Salary from HumanResource.Employee

--8. Display Department name with its manager name using cursor.  
use ITI
declare DepMgrCursor cursor
for select i.Ins_Name, d.Dept_Name
	from Instructor i inner join Department d on d.Dept_Manager = i.Ins_Id
for read only
declare @MgrName nvarchar(30), @DeptName nvarchar(10)
open DepMgrCursor
fetch DepMgrCursor into @MgrName, @DeptName
while @@FETCH_STATUS = 0
	begin
		select @MgrName as [Manager Name], @DeptName as [Dept. Name]
		fetch DepMgrCursor into @MgrName, @DeptName
	end
close DepMgrCursor
deallocate DepMgrCursor

--9. Try to display all instructor names in one cell separated by comma. Using Cursor  
declare InsCursor cursor
for select Ins_Name
	from Instructor
	where Ins_Name is not null
for read only
declare @InsName nvarchar(10), @NameCell nvarchar(200) = ''
declare @CheckFirst bit = 0
open InsCursor
fetch InsCursor into @InsName
while @@FETCH_STATUS = 0
	begin
		if @CheckFirst = 0
			set @NameCell = CONCAT(@NameCell, @InsName)
		else
			set @NameCell = CONCAT(@NameCell,', ' ,@InsName)

		fetch InsCursor into @InsName
		set @CheckFirst = 1
	end

	select @NameCell as [Names]
close InsCursor
deallocate InsCursor
