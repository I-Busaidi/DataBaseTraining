use Company_SD

--1
select Dependent_name, Sex
from Dependent 
where Sex = 'F' and ESSN in (select SSN
								from Employee where Sex = 'F')
union all

select Dependent_name, Sex
from Dependent
where Sex = 'M' and ESSN in (select SSN
								from Employee where Sex = 'M')

--2
select p.Pname, sum(w.Hours) as [Total Hours]
from Project p inner join Works_for w on p.Pnumber = w.Pno
group by p.Pname

--3
select *
from Departments
where Dnum in (select top 1 Dno
				from Employee
				order by SSN)

--4
select d.Dname, MAX(e.Salary) as [Max Sal], MIN(e.Salary) as [Min Sal], AVG(e.Salary) as [AVG Sal]
from Departments d inner join Employee e on e.Dno = d.Dnum
group by d.Dname

--5
select Fname + ' ' + Lname as [Full Name]
from Employee
where SSN in (select MGRSSN
				from Departments)
		and SSN not in (select ESSN
						from Dependent)

--6
select d.Dnum, d.Dname, COUNT(e.SSN) as [Employee count]
from Departments d inner join Employee e on d.Dnum = e.Dno
where (select AVG(Salary) from Employee where Dno = Dnum) < (select AVG(Salary) from Employee)
group by d.Dnum, d.Dname

--7
select e.Lname, e.Fname, p.Pname
from Employee e inner join Works_for w on e.SSN = w.ESSn inner join Project p on p.Pnumber = w.Pno
order by e.Dno

--8
select Salary
from Employee
where SSN in (select top 2 SSN
				from Employee
				order by Salary desc)

--9
select Fname + ' ' + Lname as [Full name]
from Employee
where Fname + ' ' + Lname in (Select Dependent_name
					from Dependent)

--10
select SSN, Fname + ' ' + Lname
from Employee
where exists (select ESSN
				from Dependent
				where ESSN = SSN)

--11
insert into Departments
values ('DEPT IT', 100, 112233, 01-11-2006)

--12
update Departments
set MGRSSN = 968574
where Dnum = 100

update Employee
set Dno = 100
where SSN = 968574

update Departments
set MGRSSN = 102672
where Dnum = 20

update Employee
set Dno = 20
where SSN = 102672

update Employee
set Superssn = 102672, Dno = 20
where SSN = 102660

--13
delete from Dependent
where ESSN = 223344

update Departments
set MGRSSN = 102672
where MGRSSN = 223344

update Employee
set Superssn = 102672
where Superssn = 223344

update Works_for
set ESSn = 102672
where ESSn = 223344

delete from Employee
where SSN = 223344

--14
update Employee
set Salary += Salary*0.3
where SSN in (select ESSn
				from Works_for
				where Pno = (select Pnumber
								from Project
								where Pname = 'Al Rabwah'))



