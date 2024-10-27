use ITI

--1
create proc ShowStNumber
as
	select d.Dept_Name, COUNT(s.St_Id) as [No. of Students]
	from Student s inner join Department d on s.Dept_Id = d.Dept_Id
	group by d.Dept_Name

ShowStNumber

--2
use Company_SD
create proc CheckEmpNo @P_Id int
as
begin
	if not exists (select Pno
					from Works_for where @P_Id = Pno)
	begin
		select 'Project does not exist'
	end

	else if (select COUNT(w.ESSn)
		from Works_for w inner join HumanResource.Employee e on e.SSN = w.ESSn
		where @P_Id = w.Pno) >= 3
	begin
		select 'The number of employees in the project ID = ' + CONVERT(nvarchar(10), @P_Id) + ' is 3 or more.'
	end

	else 
	begin
		declare EmpCursor cursor
		for select e.Fname + ' ' + e.Lname
			from HumanResource.Employee e inner join Works_for w on w.ESSn = e.SSN
			where w.Pno = @P_Id
		for read only
		declare @EmpName nvarchar(25), @NameCell nvarchar(50) = ''
		declare @CheckFirst bit = 0
		open EmpCursor
		fetch EmpCursor into @EmpName
		while @@FETCH_STATUS = 0

			begin
				if @CheckFirst = 0
					set @NameCell = CONCAT(@NameCell,'Employee 1: ', @EmpName)
				else
					set @NameCell = CONCAT(@NameCell,', Employee 2: ' ,@EmpName)

				fetch EmpCursor into @EmpName
				set @CheckFirst = 1
			end

			select @NameCell as [Names]
		close EmpCursor
		deallocate EmpCursor
	end
end

CheckEmpNo 400
CheckEmpNo 100

--3
create proc UpdateProjEmp @OldEmp int, @NewEmp int, @ProjNo int
as
	update Works_for
	set ESSn = @NewEmp
	where ESSn = @OldEmp and Pno = @ProjNo

UpdateProjEmp 223344, 669955, 100


--4
alter table Company.Project
	add Budget money

update Company.Project
set Budget = 100000

create table ProjectAudit
(
	Pno int,
	UserName nvarchar(20),
	ModifiedDate date,
	Budget_Old money,
	Budget_New money,
	foreign key (Pno) references Company.Project(Pnumber),
	primary key (Pno, ModifiedDate)
)

create trigger BudgetUpdate
on Company.Project
after update
as
	if UPDATE(Budget)
		insert into ProjectAudit select i.Pnumber, SUSER_NAME(), GETDATE(), d.Budget, i.Budget from inserted i inner join deleted d on i.Pnumber = d.Pnumber

--5
use ITI
create trigger NoDeptInsert
on Department
instead of insert
as
	select CONCAT('this user ', SUSER_NAME(), 'Cannot insert new records into the table "Department"')

insert into Department values (90, 'test', 'test', 'Alex', 1, GETDATE())

--6
use Company_SD
create trigger NoMarchInsert
on HumanResource.Employee
instead of insert
as
	if format(GETDATE(), 'MMMM') = 'march'
		select 'No new record insertions are allowed in March'
	else
		insert into HumanResource.Employee select * from inserted

--7
use ITI
create table StudentAudit
(
	AuditNumber int identity (1,1),
	ServerUserName nvarchar(50),
	InsertDate date, 
	Note nvarchar(200),
	primary key (AuditNumber, InsertDate)
)

create trigger StudentInsert
on Student
after insert
as
	insert into StudentAudit values (SUSER_NAME(), GETDATE(), CONCAT(SUSER_NAME(), ' inserted new row with key = ', (select St_Id from inserted),  ' in table "Student"'))

--8
create trigger StudentDelete
on Student
instead of delete
as
	insert into StudentAudit values (SUSER_NAME(), GETDATE(), CONCAT(SUSER_NAME(), ' tried to delete row with key = ', (select St_Id from deleted),  ' from table "Student"'))
