------------------- UNION VE UNION ALL -------------------------

--Birden fazla tabloyu tek bir tablo gibi gösterir
--Kolon veri tipleri ayný olmalýdýr.
--Ýkisi arasýndaki fark union veriyi çoklamazken, union all çoklar ve olduðu gibi getirir.

--1
--1 union bunu sadece 1 diye getirir.
--1
--1 union all bunlarý alt alta tek tek gösterir.

-- ilk select kolonu as olmadan hata verir eðer fiziksel kolon deðilse

select COUNT(*) from Customers --91
select COUNT(*) from Employees --9

select CompanyName from Customers
union
select LastName from Employees

select CompanyName from Customers
union all
select LastName from Employees

select ad, COUNT(*) from(
select CompanyName, 'musteri' as ad from Customers
union
select LastName, 'personel' as ad from Employees) musteriler
group by ad

select Tipad, Region, COUNT(*) toplam_sayi from(
select CompanyName, 'Müþteri' as Tipad , Region as Region from Customers
union
select LastName, 'Þirket Personeli' , '' as Region from Employees
union all
select ad + ' ' + Soyad, 'Dýþ Kaynak' Tipad, '' as Region from PersonelDetay
) musteriler
where Region is not null AND Len(Region) > 0
group by Tipad , Region
