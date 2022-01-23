select c.CustomerID, c.City from Customers c
group by c.CustomerID, c.City

select c.City, count(*) toplam_musteri from Customers c
group by c.City
order by toplam_musteri desc

select e.TitleOfCourtesy, count(*) from Employees e
group by e.TitleOfCourtesy
order by 2

select p.CategoryID, avg(p.UnitsInStock) ortalama_stok from Products p
group by p.CategoryID
order by 1

select o.CustomerID, sum(o.Freight) from Orders o
group by o.CustomerID
order by 2 desc

SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;

select distinct e.TitleOfCourtesy, e.BirthDate from Employees e

select distinct e.TitleOfCourtesy, count(e.TitleOfCourtesy) from Employees e
group by e.TitleOfCourtesy
order by 2

select distinct e.Title + ' ' + e.TitleOfCourtesy
from Employees e

--having filtrelemeye yarar
select p.CategoryID, avg(p.UnitsInStock) as ortalama from Products p
group by p.CategoryID
having avg(p.UnitsInStock) > 27
order by ortalama desc

select r.RegionDescription, count(*) from Region r
group by r.RegionDescription
having count(*) > 1

select ProductID, sum(Quantity) from [Order Details] 
where OrderID>10000
group by ProductID
having sum(Quantity) > 1300 

--yýllara göre müþteririnin toplam sipariþ

select year(OrderDate), CustomerID, count(*) [Sipariþ Sayýsý] from Orders
group by CustomerID,year(OrderDate)
having count(*) > 4

-- Birinci tabloda olup ikinci tabloda olmayan
select ProductID from Products where ProductID in(1,2,3)
except
select CategoryID from Categories where CategoryID in(1,3,5)

select City from Employees
except
select City from Customers 

-- intersect birinci ve ikinci tabloda ortak olanlarý alýr(kesiþenleri alýr)
select City from Employees
intersect
select City from Customers 

--product tablomun içinde categoýd si çoklayan ve kesiþen tablolarýmýn unitstock miktarý 200 den fazla olan
-- müþterimin içerisinden personellirimin þehir bilgileri ayný olan kayýtlarý bulup bu þehirlere baðlý sipariþlerin neler olduðu ve fiyatý 100 den büyük

select e.TitleOfCourtesy, 
case when e.TitleOfCourtesy = 'Ms.' then 'Bayan'
when e.TitleOfCourtesy = 'Mrs.' then 'Evli Bayan'
when e.TitleOfCourtesy = 'Mr.' then 'Erkek'
else 'Diðer' 
end
from Employees e
