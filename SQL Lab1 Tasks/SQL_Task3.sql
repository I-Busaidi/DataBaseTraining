use Company_SD

--13. Display Dept id, name and its manager id, name
select d.Dnum as [Dept. ID], d.Dname as [Dept. Name], e.SSN as [Manager ID], e.Fname+' '+e.Lname as [Manager Name]
from Departments d inner join Employee e on d.MGRSSN = e.SSN

--14. Display name of departments and name of projects under it
select d.Dname as [Dept. Name], p.Pname as [Project Name]
from Departments d inner join Project p on p.Dnum = d.Dnum
order by d.Dname

--15. Display all data of all dependents associated with the employee they depend on
select *
from Employee e inner join Dependent d on e.SSN = d.ESSN
order by e.Fname

--16. Display id, name, location of projects in cairo or alex
select Pnumber, Pname, Plocation
from Project
where City in ('Cairo', 'Alex')

--17. Display the projects full data of projects with a name starts with "a"
select *
from Project
where Pname like 'a%'

--18. Display all employees in Dept. 30 whose salary is from 1000 to 2000
select * from Employee
where Salary between 1000 and 2000

--19. Retrieve the names of all employees in dept. 10 who works more than or equal to 10hrs
--in Al Rabwah project.
select distinct e.Fname+' '+e.Lname as [Name]
from Works_for w inner join Employee e on w.ESSn = e.SSN inner join Departments d on e.Dno = 10
where w.Hours >= 10

--20. employees directly supervised by Kamel Mohammed
select e1.Fname + ' ' + e1.Lname as [Name]
from Employee e1 inner join Employee e2 on e1.Superssn = e2.SSN and e2.Fname = 'Kamel' and e2.Lname = 'Mohamed'

--21. Names of all employees and the names of projects they are working on
select e.Fname + ' ' + e.Lname as [Employee Name], p.Pname as [Project Name]
from Employee e left join Departments d on e.Dno = d.Dnum inner join Project p on p.Dnum = d.Dnum
order by p.Pname

--22. dept manager info, dept name for projects in Cairo
select p.Pnumber as [Project number], d.Dname as [Dept. Name], e.Lname as [Mgr. L Name], e.Address, e.Bdate
from Project p inner join Departments d on p.Dnum = d.Dnum left join Employee e on e.SSN = d.MGRSSN
where p.City = 'Cairo'

--23. data of all managers
select e.Fname, e.Lname, e.SSN, e.Bdate, e.Address, e.Sex, e.Salary, e.Superssn, e.Dno
from Employee e inner join Departments d on d.MGRSSN = e.SSN

--24. All employees data and their dependents
select *
from Employee e left join Dependent d on e.SSN = d.ESSN