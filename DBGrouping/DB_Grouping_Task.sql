use Company_SD

--1
select Sum(w.Hours) as [Sum of Hours], p.Pname as [Project Name]
from Works_for w inner join Project p on w.Pno = p.Pnumber
group by p.Pname

--2
select d.Dname as [Dept. Name], Max(e.Salary) as [Max Salary], Min(e.Salary) as [Min Salary], AVG(e.Salary) as [Avg Salary]
from Departments d inner join Employee e on d.Dnum = e.Dno
group by d.Dname

