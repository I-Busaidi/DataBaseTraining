--PART1
use ITI
--1
select i.Ins_Name as [Name], d.Dept_Name as [Dept. Name]
from Instructor i left join Department d on i.Dept_Id = d.Dept_Id

--2
select s.St_Fname+' '+s.St_Lname as [Student Name], c.Crs_Name as [Course]
from Student s inner join Course c on c.Crs_Id in (select Crs_Id
													from Stud_Course
													where St_Id = s.St_Id
													and Grade is not null)

--3
select t.Top_Name as [Topic], COUNT(c.Crs_Id) as [Courses Number]
from Topic t inner join Course c on c.Top_Id = t.Top_Id
group by t.Top_Name

--4
select MAX(Salary) as [Max Salary], MIN(Salary) as [Min Salary]
from Instructor

--5
select Dept_Name
from Department
where Dept_Id = (select top 1 Dept_Id
					from Instructor
					order by Salary)

--6
select Ins_Name, coalesce(CONVERT(nvarchar(10), Salary), 'Bonus') as [Salary]
from Instructor

--7
select Dept_Id, Salary
from (Select Dept_Id, Salary, ROW_NUMBER() over(partition by Dept_Id order by Salary desc) as RN
		from Instructor) as NewTable
where RN < 3 and Salary is not null

--8
select St_Fname+' '+St_Lname as [Student Name]
from (select *, ROW_NUMBER() over(order by NEWID()) as RN
		from Student)
		as NewTable
where RN = 1

-----------------------------------------------------------
-----------------------------------------------------------

--PART2
use AdventureWorks2012
--1
select *
from Production.Product
where Name like 'B%'

--2
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select *
from Production.ProductDescription
where Description like '%[_]%'

--3
select OrderDate ,SUM(TotalDue) as TotalDue
from Sales.SalesOrderHeader
where OrderDate between '20010701' and '20140731'
group by OrderDate
order by OrderDate

--4
select AVG(distinct ListPrice) as [Average Price]
from Production.Product

--5
select CONCAT('The ', Name, ' is only! $', ListPrice) as [Product Price List]
from Production.Product
where ListPrice between 100 and 120
order by ListPrice

--6
select FORMAT(GETDATE(), 'MMMM dd, yyyy')
union
select FORMAT(GETDATE(), 'dddd MM - dd - yyyy')
union
select FORMAT(GETDATE(), 'dd / MM / yyyy')
union
select FORMAT(GETDATE(), 'yyyy - MM - dd')
union
select FORMAT(GETDATE(), 'yyyy / MM / dd ~ dddd')