create database TestDb

SELECT Convert(int,'25') -- int'e convert eder

select cast('25' as int)

select convert(int, cast('25' as int))

--computed table
CREATE TABLE FATURA_TBL
(
ID int identity primary key,
FATURA_TARIH date,
MIKTAR int,
BIRIM_FIYAT int,
TUTAR AS (MIKTAR*BIRIM_FIYAT),
KDV_DAHIL_TUTAR AS (MIKTAR*BIRIM_FIYAT) * 1.18
)

--~~~~~~~~~~~~~ INSERT ~~~~~~~~~~~~~~~~

INSERT INTO FATURA_TBL
(FATURA_TARIH, MIKTAR, BIRIM_FIYAT)
VALUES(GETDATE(), 11, 11)

INSERT INTO FATURA_TBL
VALUES(GETDATE(), 12, 12)

--ÇOKLU INSERT
INSERT INTO FATURA_TBL
(FATURA_TARIH, MIKTAR, BIRIM_FIYAT)
VALUES
(GETDATE(), 13, 13),
(GETDATE(), 14, 14),
(GETDATE(), 15, 15),
(GETDATE(), 16, 16)

select * INTO #FATURA_TBL_TEST from FATURA_TBL

SELECT * FROM #FATURA_TBL_TEST

CREATE TABLE FATURA_TBL_TEST2
(
ID int identity primary key,
FATURA_TARIH date,
MIKTAR int,
BIRIM_FIYAT int,
TUTAR int,
KDV_DAHIL_TUTAR int
)

SET IDENTITY_INSERT dbo.FATURA_TBL_TEST2 ON;
INSERT INTO FATURA_TBL_TEST2
([ID],[FATURA_TARIH], [MIKTAR], [BIRIM_FIYAT], [TUTAR], [KDV_DAHIL_TUTAR])
SELECT [ID],[FATURA_TARIH], [MIKTAR], [BIRIM_FIYAT], [TUTAR], [KDV_DAHIL_TUTAR]
FROM FATURA_TBL

select ROW_NUMBER() OVER(ORDER BY FATURA_TARIH) AS ROW_NUM,
[ID],[FATURA_TARIH], [MIKTAR], [BIRIM_FIYAT], [TUTAR], [KDV_DAHIL_TUTAR] INTO #FATURA_TBL_TEST2_GECICI
from FATURA_TBL_TEST2

select *, NEWID() PK_ID from #FATURA_TBL_TEST2_GECICI


--~~~~~~~~~~~ DELETE ~~~~~~~~~~~~~~

DELETE FROM FATURA_TBL_TEST2 WHERE TUTAR IS NULL

SET IDENTITY_INSERT dbo.FATURA_TBL_TEST2 ON;
INSERT INTO FATURA_TBL_TEST2
([ID],[FATURA_TARIH], [MIKTAR], [BIRIM_FIYAT], [TUTAR], [KDV_DAHIL_TUTAR], [ROW_NUM])
select 4,[FATURA_TARIH], [MIKTAR], [BIRIM_FIYAT], [TUTAR], [KDV_DAHIL_TUTAR],
ROW_NUMBER() OVER(ORDER BY FATURA_TARIH) AS ROW_NUM
from FATURA_TBL
WHERE ID=2


--ÇÝFTLEYEN KAYITLARI BUL
--MAX YADA MIN ID YE BAK

DELETE FROM FATURA_TBL_TEST2 WHERE ID IN
(
select MAX(ID)
--FATURA_TARIH, MIKTAR, BIRIM_FIYAT, TUTAR, KDV_DAHIL_TUTAR, ROW_NUM, COUNT(*) AS coklayan_satir_sayisi 
from FATURA_TBL_TEST2
GROUP BY FATURA_TARIH, MIKTAR, BIRIM_FIYAT, TUTAR, KDV_DAHIL_TUTAR, ROW_NUM
having COUNT(*) > 1
)

select * from FATURA_TBL_TEST2
--------------------------------------------------------------------------------------------------
---------------UPDATE-------------------------
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

--------------------------------------------------------------------------------------------------------------------
