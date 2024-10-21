use Company_SD

--1. Dsiplay all employees data
select * 
from Employee

--2. Display employee fname, lname, salary, dept number
select Fname, Lname, Salary, Dno
from Employee

--3. Display all project names, locations, dept
select Pname, Plocation, Dnum
from Project

--4. Employee name and annual commission
select Fname+' '+Lname as [Full Name], (Salary*12*10/100) as [Annual Commission]
from Employee

--5. Display employee id, name where salary > 1000 LE
select SSN, Fname+' '+Lname as [Name]
from Employee
where Salary > 1000

--6. Display employee id, name where salary > 10000 LE
select SSN, Fname+' '+Lname as [Name]
from Employee
where Salary*12 > 10000

--7. Display name and salary of female employees
select Fname+' '+Lname as [Name], Salary
from Employee
where Sex = 'F'

--8. Display each department id, name, which are managed by manager with id = 968574
select Dnum, Dname 
from Departments
where MGRSSN = 968574

--9. Display id, name, location of projects controlled by department 10
select Pnumber, Pname, Plocation
from Project
where Dnum = 10

--10. Inserting new data
insert into Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
values('Ibrahim', 'Al Busaidi', 102672, 18-06-1998, 'Al khoud, As Seeb, Muscat', 'M', 3000, 112233, 30)

--11. Another case of inserting new data, Superssn and salary null
insert into Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
values('Rashid', 'Al Ghailani', 102660, 23-06-1999, 'Al Ansab, Muscat, Oman', 'M', null, null,30)

--12. Upgrading salary by 20%
update Employee
set Salary += Salary*20/100
where SSN=102672
