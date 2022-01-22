select c.Address, c.City, c.ContactName from Customers as c

select c.Region,c.Address, c.* from Customers as c with(nolock)

select top 10 c.* from Customers c

select top 10 percent c.* from Customers c

select top 10 percent c.City, c.ContactName from Customers c

select * from Employees emp
where emp.EmployeeID = '9' --Eðer string bir deðer girersek convert hatasý alýrýz ama sadece sayý olursa sýkýntý çýkmaz.

select * from Employees emp
where emp.LastName = 'Davolio' OR emp.LastName='King'

select * from Employees
where EmployeeID in (5,6)

select * from Employees
where EmployeeID not in (5,6)-- in ve not in performansý kötü yönde etkiler.

select * from Employees
where FirstName not in ('Nancy', 'Robert')

select * from Employees
where Region is null

select * from Employees
where Region is not null

--OPERATÖRLER
-- <> eþit deðil
-- !< küçük deðil
-- !> büyük deðil

select o.CustomerID, o.OrderDate, o.* from Orders as o with(nolock)

select top 10 o.* from Orders o

select top 10 percent o.* from Orders o

select top 10 percent o.OrderDate, o.ShipAddress from Orders o

select * from Orders o
where o.CustomerID = '9' --Eðer string bir deðer girersek convert hatasý alýrýz ama sadece sayý olursa sýkýntý çýkmaz.

select * from Orders
where OrderID in (5,6)

select * from Orders
where OrderID not in (5,6)-- in ve not in performansý kötü yönde etkiler.

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
where o.ShipName like 'C%' -- ile baþlayanlar

select o.ShipName, o.* from Orders o
where o.ShipName like '%Min%' -- içerisinde

select o.ShipName, o.* from Orders o
where o.ShipName like '%C' -- ile bitenler

select o.Shipname, o.* from Orders o 
where o.ShipAddress like 'V%r' -- baþýnda v olup sonunda r olanlar

select o.ShipName, o.* from Orders o
where o.ShipName like '_r%' -- ikinci karakterleri r olanlar

select o.ShipName, o.* from Orders o
where o.ShipName like '[HW]%' -- ilk harfi H ve W olanlar

select * from Products

select p.CategoryID, p.ProductID, p.SupplierID from Products p
order by SupplierID DESC

select p.CategoryID, p.ProductID, p.SupplierID from Products p
order by 2,3 Desc


select c.Region, isnull(c.Region, 'BOÞ') as REGÝON, c.* from Customers c

select c.Region, isnull(c.Region, 'BOÞ') as REGÝON, c.* from Customers c 
where isnull(c.Region, 'BOÞ') = 'BOÞ'

select coalesce(c.Region, 'BOÞ') , isnull(c.Region, 'BOÞ') from Customers c

select coalesce(c.Region, 'BOÞ') + ' ' + isnull(c.Region, 'BOÞ') from Customers c

select c.City + ' ' + c.Address + ' ' + ' Kefil :' + c.ContactName from Customers c

alter table Customers
add fax2 nvarchar(50)

select Fax, fax2 , isnull(nullif(Fax,fax2), 'Veri Tekrarý') from Customers -- nullif eðer veri tekrarý varsa null döndürür

select count(*) from Customers 
where nullif(Fax,fax2) is null
