
--sat��lar�m�n kategorilerine g�re listesi
select o.OrderID, p.ProductName, c.CategoryName from [Order Details] o
inner join Products p
on o.ProductID = p.ProductID
inner join Categories c
on p.CategoryID = c.CategoryID
order by c.CategoryName

--hangi �r�nden ve kategoriden toplamda 50 den fazla satt���m �r�n listesi
select p.ProductName, c.CategoryName, sum(od.Quantity) as [Total Quantity] from [Order Details] od
inner join Products p
on od.ProductID = p.ProductID
inner join Categories c
on p.CategoryID = c.CategoryID
group by p.ProductName, c.CategoryName
having sum(od.Quantity) > 50
order by c.CategoryName

--en �ok sat�� yapan ilk �� personelim
select top 3 e.EmployeeID, e.FirstName, e.LastName, count(*) as [Total Count] from Employees e
inner join Orders o
on o.EmployeeID = e.EmployeeID
group by e.EmployeeID, e.FirstName, e.LastName
order by count(*) desc

--en �ok sat�lan kategori
select top 1 c.CategoryName, count(*) from [Order Details] od
inner join Products p
on od.ProductID = p.ProductID
inner join Categories c
on p.CategoryID = c.CategoryID
group by c.CategoryName
order by 2 desc

--hangi �al��an ne kadar �r�n satm��, b�lge baz�nda gelirimiz nedir
select e.EmployeeID, e.FirstName, e.LastName, sum(od.Quantity) as [Total Sales],  sum(od.Quantity*od.UnitPrice) from Employees e
inner join Orders o
on o.EmployeeID = e.EmployeeID
inner join [Order Details] od
on od.OrderID = o.OrderID


-- lojistik maliyetim nedir ? 
select sum(o.Freight) as [Total Freight] from Orders o

--�irket �al��anlar�m�n ya� ve m��teri �al��anlar�m�n ya� ortalamas� listesi
select avg(floor(DATEDIFF(YEAR, e.BirthDate, getdate()))) as [Ya� Ortalamas�] from Employees e

--�lke baz�nda sat�� cirom ne kadar. en y�ksek sat�� yapan ve en az sat�� yap�lan iki �lkeyi kpi olarak g�rmek istiyorum. (tek select)
select kpi, Country, total_sales_price, total_product_sales
from (select top 1 '�ok Satan' as kpi,  c.Country as Country, sum(od.Quantity*od.UnitPrice) as total_sales_price, sum(od.Quantity) as total_product_sales
from Orders o
inner join [Order Details] od on o.OrderID = od.OrderID
inner join Customers c on o.CustomerID = c.CustomerID
group by c.Country
order by total_product_sales desc
union 
select top 1 'Az Satan' as kpi, c.Country as Country, sum(od.Quantity*od.UnitPrice) as total_sales_price, sum(od.Quantity) as total_product_sales
from Orders o
inner join [Order Details] od on o.OrderID = od.OrderID
inner join Customers c on o.CustomerID = c.CustomerID
group by c.Country
order by total_product_sales asc) as kpi_tbl
order by total_product_sales desc

-- �lke ve m��teri da��l�m� listesi

select c.Country, count(*) from Customers c
group by c.Country
order by count(*) desc

--fiyat� en d���k olan �r�nlerimin sat�� miktarlar� listesi
select p.ProductName, p.UnitPrice, sum(od.Quantity) as [Sat�� Miktar�] from Products p
inner join [Order Details] od
on p.ProductID = od.ProductID
group by p.ProductName, p.UnitPrice
order by p.UnitPrice asc
