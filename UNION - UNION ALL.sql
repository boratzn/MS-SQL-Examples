------------------- UNION VE UNION ALL -------------------------

--Birden fazla tabloyu tek bir tablo gibi g�sterir
--Kolon veri tipleri ayn� olmal�d�r.
--�kisi aras�ndaki fark union veriyi �oklamazken, union all �oklar ve oldu�u gibi getirir.

--1
--1 union bunu sadece 1 diye getirir.
--1
--1 union all bunlar� alt alta tek tek g�sterir.

-- ilk select kolonu as olmadan hata verir e�er fiziksel kolon de�ilse

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
select CompanyName, 'M��teri' as Tipad , Region as Region from Customers
union
select LastName, '�irket Personeli' , '' as Region from Employees
union all
select ad + ' ' + Soyad, 'D�� Kaynak' Tipad, '' as Region from PersonelDetay
) musteriler
where Region is not null AND Len(Region) > 0
group by Tipad , Region