use ITI

--1
create view VSt_Name_CName
as
	select s.St_Fname+ ' ' +s.St_Lname as [Student Name], c.Crs_Name as [Course Name]
	from Student s inner join Stud_Course sc on s.St_Id = sc.St_Id
	inner join Course c on c.Crs_Id = sc.Crs_Id
	where sc.Grade > 50

--2
create view VMGR_Topics
with encryption
as
	select distinct i.Ins_Name as [Name], t.Top_Name as [Topic]
	from Instructor i inner join Ins_Course ic on i.Ins_Id = ic.Ins_Id
	inner join Topic t on t.Top_Id = (select Top_Id
										from Course
										where Crs_Id = ic.Crs_Id)
	where exists (select Dept_Manager
							from Department
							where i.Ins_Id = Dept_Manager)

--3
create view VInsDept
as
	select i.Ins_Name as [Name], d.Dept_Name as [Dept. Name]
	from Instructor i inner join Department d on i.Dept_Id = d.Dept_Id
	where d.Dept_Name in ('SD','Java')

--4
create view V1
as
	select *
	from Student
	where St_Address in ('Alex','Cairo')

revoke update on V1 from [User]

--5
use Company_SD

create view ProjectWorkers
as
	select p.Pname as [Project], COUNT(w.ESSn) as [Number of Employees]
	from Project p inner join Works_for w on p.Pnumber = w.Pno
	group by p.Pname

--6
create schema Company
alter schema Company transfer dbo.Departments
alter schema Company transfer dbo.Project

create schema HumanResource
alter schema HumanResource transfer dbo.Employee

--7
use ITI

select TABLE_SCHEMA, TABLE_NAME, TABLE_CATALOG, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA not in ('information_schema', 'sys')
order by TABLE_SCHEMA, TABLE_NAME


