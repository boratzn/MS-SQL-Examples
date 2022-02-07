use Northwind

select ROW_NUMBER()
over (partition by e.city order by e.city) row_id,
e.EmployeeID,
e.City
from Employees e

use AdventureWorks2012

select * from HumanResources.Employee



select 
(select e.Gender from HumanResources.Employee e where e.BusinessEntityID = edh.BusinessEntityID) cinsiyet,
(select CONCAT(p.FirstName, ' - ', p.LastName, ' - ',p.MiddleName,' - ', p.EmailPromotion) from Person.Person p where p.BusinessEntityID = edh.BusinessEntityID) genel_bilgi,
edh.ModifiedDate
from HumanResources.EmployeeDepartmentHistory edh
where edh.EndDate is not null


--inner join daha performanslý
SELECT x1.cinsiyet,
       x1.genel_bilgi,
       edh.ModifiedDate
FROM HumanResources.EmployeeDepartmentHistory edh
INNER JOIN
  (SELECT p1.BusinessEntityID AS BusinessEntityID,
          e.Gender cinsiyet,
          CONCAT(p1.FirstName, ' - ', p1.LastName, ' - ', p1.MiddleName, ' - ', p1.EmailPromotion) genel_bilgi
   FROM Person.Person p1
   INNER JOIN HumanResources.Employee e ON p1.BusinessEntityID = e.BusinessEntityID) x1 ON x1.BusinessEntityID = edh.BusinessEntityID
WHERE edh.EndDate IS NOT NULL

---------------------------------------------------------------------------------------------------------------------
--subquery tek bir kolon üzerinde iþlem yapar ve çoklayan verilerde hata verir.

use Northwind

select * from [Order Details] o
where exists (select * from Products p1 where p1.ProductID = o.ProductID)

select * from Products p1
where exists (select 1 from [Order Details] o where p1.ProductID = o.ProductID)

select * from Products p1
where p1.ProductID in (select o.ProductID from [Order Details] o where p1.ProductID = o.ProductID)

select * from Products p1
where not exists (select 1 from [Order Details] o where p1.ProductID = o.ProductID)

select * from Products p1
where p1.ProductID not in (select o.ProductID from [Order Details] o where p1.ProductID = o.ProductID)

-- in bütün tabloyu scan eder. Genelde exists kullanýlýr ve daha performanslýdýr.
use AdventureWorks2012
-----------------------SORUNUN CEVABI BU----------------------------------------
select distinct year(eph1.RateChangeDate) as Years,E.*
from HumanResources.Employee E
inner join HumanResources.EmployeePayHistory eph1
on E.BusinessEntityID = eph1.BusinessEntityID
where exists (select 
EPH.RateChangeDate from HumanResources.EmployeePayHistory EPH
where E.BusinessEntityID = EPH.BusinessEntityID
and year(EPH.RateChangeDate) > 2002
)
order by year(eph1.RateChangeDate) asc
---------------------------------------------------------------------------------


--STUFF() 1 string ifadeni ver, 2 start index, 3 length, 4 Deðiþtirilecek string
select STUFF('SQL Tutorial', 1, 3, 'HTTP')

--WITH bir subquery ifadesidir.
use AdventureWorks2012

select JobTitle, MaritalStatus, avg(VacationHours) from HumanResources.Employee E
group by JobTitle,MaritalStatus
having avg(VacationHours) > 
			(select avg(VacationHours)
			from HumanResources.Employee
			where HumanResources.Employee.MaritalStatus = E.MaritalStatus)
			order by 3 desc
