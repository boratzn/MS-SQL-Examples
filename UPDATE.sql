select * from Products
select * from Categories where CategoryName = 'Beverages'

UPDATE Products
SET UnitsInStock = UnitsInStock + 10
from Products p inner join Categories c
on p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Beverages'

--Ms. KADIN, Dr. ERKEK, Mrs. KADIN, Mr. ERKEK
select * from Customers

update Employees
set bolge_kod = 'TR'
where EmployeeID between 1 and 5

update Employees
set bolge_kod = 'ENG'
where EmployeeID between 5 and 9

update Employees
set TitleOfCourtesy = (case
when emp.TitleOfCourtesy = 'Mr.' then 'ERKEK'
when emp.TitleOfCourtesy = 'Mrs.' then 'KADIN'
else 'ERKEK'  end)
from Employees emp inner join
(
select o.EmployeeID from Orders o inner join Customers c
on o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 1996 and c.City in('Kirkland', 'Stuttgart', 'Seattle', 'London', 'Salzburg')
) xx on emp.EmployeeID = xx.EmployeeID
where emp.bolge_kod = 'ENG'

select * from Employees

