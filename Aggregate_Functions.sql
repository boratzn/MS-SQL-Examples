use Northwind

--AVG()
select avg(UnitPrice) from [Order Details]

select avg(UnitPrice), avg(Quantity) from [Order Details]

--COUNT()
select count(*) from [Order Details]

select count(distinct OrderID) from [Order Details]
where OrderID = 10248
order by 1 asc

--çok büyük toplamlar için
select COUNT_BIG(*) from [Order Details]

--sum int, numeric, decimal tpolamlarýný alýr
select sum(Quantity) from [Order Details]

--En Yakýn tamsayý
select CEILING(3.6)

--Aþaðýya yuvarlayanlar
select Floor(3.4)
select FLOOR(3.7)

--Round(sayi, 1) 1 olarak yazýlan karakter noktadan sonraki ikinci sayýdan baþlýyor. (index 0 dan baþlar)
select round(3.562, 1)

--ASCII'de karþýlýk gelen sayýyý verir
select ascii('C') -- 67
select ascii('D') -- 68
select ascii('B') -- 66

--RAND() tek baþýna 0,324765500616938
select convert(int, rand()*100)

--unique bir deðer oluþturur
select NEWID()

--saati göstermez sadece tarih gösterir
select convert(date, getdate())  

--convert ve cast
select convert(varchar(2), 23)

select convert(int, '25')

select cast(25 as varchar(2))

select cast('20' as int)

select convert(nvarchar(10), cast(25 as varchar(2)))

--charindex istenilen karakterin hangi indexte olduðunu döner
select CHARINDEX('L', 'ALÝ', 3)

select FirstName+ ' '+LastName,
CHARINDEX('L', FirstName+' '+LastName, 1) from Employees

--left ve right

select left(FirstName, 3), FirstName from Employees

select right(FirstName, 2), FirstName from Employees

--LTRIM / RTRIM / TRIM
select LTRIM('        DENEME')

select RTRIM('DENEME          ')

select LTRIM('        DENEME')

select RTRIM(LTRIM('        DENEME      '))

select TRIM('        DENEME      ')

--REVERSE metni tersine çevirir
select reverse('Bora') 

--UPPER büyük harfe çevirir
select upper('Bora')

-- LOWER Küçük harfe çevirir
select lower('ASDFASDFASF')

--SUBSTRING metnin belli bir kýsmýný almamýza yarar(index 1 den baþlar)
select substring('Bora', 1,2)

-- REPLACE istediðimiz karakterleri belirlediðimiz yeni karakterlele deðiþtirir
select LastName, replace(LastName, 'u', 'X') from Employees

--CONCAT verilen alanlarý birleþtirir
select concat(LastName, FirstName) from Employees

select CONCAT_WS(' - ', LastName, FirstName, TitleOfCourtesy) from Employees

--gün ay yýl

select top 1 day(OrderDate) from Orders 
select top 1 month(OrderDate) from Orders 
select top 1 year(OrderDate) from Orders 

--dateadd tarihe ekleme yapar
select top 1 dateadd(yy, 1, OrderDate), o.OrderDate from Orders o
select top 1 dateadd(mm, 1, OrderDate), o.OrderDate from Orders o
select top 1 dateadd(dd, 1, OrderDate), o.OrderDate from Orders o

--datediff iki tarih arasýndaki farký bulur
select datediff(yy, o.OrderDate, o.ShippedDate)  yýl_farký, o.OrderDate, o.ShippedDate from Orders o

select datediff(yy, o.OrderDate, o.ShippedDate)  yýl_farký,  
datediff(mm, o.OrderDate, o.ShippedDate)  ay_farký,
datediff(dd, o.OrderDate, o.ShippedDate)  gün_farký
from Orders o

select datename(yy, o.OrderDate) from Orders o
select datename(mm, o.OrderDate) from Orders o
select datename(dd, o.OrderDate) from Orders o

--ABS
select ABS(-4.5)

select PI()

select DEGREES(PI()/2)

--sign sayý pozitifse 1 negatifse -1 0 ise 0 döndürür
select sign(155), sign(-155), sign(0)

select RADIANS(181)

--OVER PARTITION BY

select ROW_NUMBER() over (partition by Adi, soyadi order by adi asc) row_id,
Adi, Soyadi, Telefon, Adres
from PersonelTBL

select city,
ROW_NUMBER() over (partition by city order by city) row_id
from Northwind.dbo.Employees

select 
ROW_NUMBER() over (partition by adi order by adi) row_id,
Adi, Soyadi, Telefon, Adres into #PersonelTBL_YDK
from PersonelDB.dbo.PersonelTBL

select * from #PersonelTBL_YDK

delete from #PersonelTBL_YDK
where row_id > 1
