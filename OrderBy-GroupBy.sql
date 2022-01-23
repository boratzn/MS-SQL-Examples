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

--y�llara g�re m��teririnin toplam sipari�

select year(OrderDate), CustomerID, count(*) [Sipari� Say�s�] from Orders
group by CustomerID,year(OrderDate)
having count(*) > 4

-- Birinci tabloda olup ikinci tabloda olmayan
select ProductID from Products where ProductID in(1,2,3)
except
select CategoryID from Categories where CategoryID in(1,3,5)

select City from Employees
except
select City from Customers 

-- intersect birinci ve ikinci tabloda ortak olanlar� al�r(kesi�enleri al�r)
select City from Employees
intersect
select City from Customers 

--product tablomun i�inde catego�d si �oklayan ve kesi�en tablolar�m�n unitstock miktar� 200 den fazla olan
-- m��terimin i�erisinden personellirimin �ehir bilgileri ayn� olan kay�tlar� bulup bu �ehirlere ba�l� sipari�lerin neler oldu�u ve fiyat� 100 den b�y�k

select e.TitleOfCourtesy, 
case when e.TitleOfCourtesy = 'Ms.' then 'Bayan'
when e.TitleOfCourtesy = 'Mrs.' then 'Evli Bayan'
when e.TitleOfCourtesy = 'Mr.' then 'Erkek'
else 'Di�er' 
end
from Employees e
