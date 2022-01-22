select c.Address, c.City, c.ContactName from Customers as c

select c.Region,c.Address, c.* from Customers as c with(nolock)

select top 10 c.* from Customers c

select top 10 percent c.* from Customers c

select top 10 percent c.City, c.ContactName from Customers c

select * from Employees emp
where emp.EmployeeID = '9' --E�er string bir de�er girersek convert hatas� al�r�z ama sadece say� olursa s�k�nt� ��kmaz.

select * from Employees emp
where emp.LastName = 'Davolio' OR emp.LastName='King'

select * from Employees
where EmployeeID in (5,6)

select * from Employees
where EmployeeID not in (5,6)-- in ve not in performans� k�t� y�nde etkiler.

select * from Employees
where FirstName not in ('Nancy', 'Robert')

select * from Employees
where Region is null

select * from Employees
where Region is not null

--OPERAT�RLER
-- <> e�it de�il
-- !< k���k de�il
-- !> b�y�k de�il

select o.CustomerID, o.OrderDate, o.* from Orders as o with(nolock)

select top 10 o.* from Orders o

select top 10 percent o.* from Orders o

select top 10 percent o.OrderDate, o.ShipAddress from Orders o

select * from Orders o
where o.CustomerID = '9' --E�er string bir de�er girersek convert hatas� al�r�z ama sadece say� olursa s�k�nt� ��kmaz.

select * from Orders
where OrderID in (5,6)

select * from Orders
where OrderID not in (5,6)-- in ve not in performans� k�t� y�nde etkiler.

select * from Orders

select * from Orders
where ShipCountry not in ('France', 'Belgium')

select * from Orders
where ShipRegion is null

select * from Orders
where ShipRegion is not null

select * from Orders
where Freight > 50

select * from Orders
where Freight > 50

select ShipVia, * from Orders
where ShipVia between 1 and 3

select o.ShipName, o.* from Orders o
where o.ShipName like 'C%' -- ile ba�layanlar

select o.ShipName, o.* from Orders o
where o.ShipName like '%Min%' -- i�erisinde

select o.ShipName, o.* from Orders o
where o.ShipName like '%C' -- ile bitenler

select o.Shipname, o.* from Orders o 
where o.ShipAddress like 'V%r' -- ba��nda v olup sonunda r olanlar

select o.ShipName, o.* from Orders o
where o.ShipName like '_r%' -- ikinci karakterleri r olanlar

select o.ShipName, o.* from Orders o
where o.ShipName like '[HW]%' -- ilk harfi H ve W olanlar

select * from Products

select p.CategoryID, p.ProductID, p.SupplierID from Products p
order by SupplierID DESC

select p.CategoryID, p.ProductID, p.SupplierID from Products p
order by 2,3 Desc


select c.Region, isnull(c.Region, 'BO�') as REG�ON, c.* from Customers c

select c.Region, isnull(c.Region, 'BO�') as REG�ON, c.* from Customers c 
where isnull(c.Region, 'BO�') = 'BO�'

select coalesce(c.Region, 'BO�') , isnull(c.Region, 'BO�') from Customers c

select coalesce(c.Region, 'BO�') + ' ' + isnull(c.Region, 'BO�') from Customers c

select c.City + ' ' + c.Address + ' ' + ' Kefil :' + c.ContactName from Customers c

alter table Customers
add fax2 nvarchar(50)

select Fax, fax2 , isnull(nullif(Fax,fax2), 'Veri Tekrar�') from Customers -- nullif e�er veri tekrar� varsa null d�nd�r�r

select count(*) from Customers 
where nullif(Fax,fax2) is null
