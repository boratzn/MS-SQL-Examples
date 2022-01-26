---------------- SELF JOIN (where ile kullanýlýr) ---------------------

select pd.MedeniId , count(*) toplam from PersonelDetay pd, MedeniDurum md
where pd.MedeniId = md.ID
group by pd.MedeniId

------------------- INNER JOIN ----------------------------

select pd.Ad , ISNULL(pd.Numara,0) as Numara , cns.Cinsiyet from PersonelDetay pd
INNER JOIN Cinsiyet cns
ON pd.CinsiyetId = cns.ID

select pd.ID , md.Medeni_Durum from PersonelDetay pd
INNER JOIN MedeniDurum md
ON pd.MedeniId = md.ID

--kaç evli kaç bekar
select md.Medeni_Durum , count(*) medeni_hal_toplam from PersonelDetay pd
INNER JOIN MedeniDurum md
ON pd.MedeniId = md.ID
group by md.Medeni_Durum

--hangi dinden kaç kiþi
select d.Din , count(*) as Kisi_Sayisi from PersonelDetay pd 
INNER JOIN Din d ON pd.DinId = d.ID
where d.ID NOT IN(9)
group by d.Din
having count(*) > 1
ORDER BY 2

select pd.Ad, md.Medeni_Durum , cs.Cinsiyet, d.Din from PersonelDetay pd
INNER JOIN MedeniDurum md
on md.ID = pd.MedeniId
INNER JOIN Cinsiyet cs
on cs.ID = pd.CinsiyetId
INNER JOIN Din d
on d.ID = pd.DinId

-------------------- LEFT JOIN (Soldaki tabloyu fuller)----------------------------

select pd.Ad, ISNULL(md.Medeni_Durum , 'Medeni Durum Bilgisi BOÞ') from PersonelDetay pd
LEFT JOIN MedeniDurum md
ON pd.MedeniId = md.ID

select pd.Ad,ISNULL(cns.Cinsiyet,'Cinsiyet Bilgisi GÝRÝLMEMÝÞ') from PersonelDetay pd
LEFT JOIN Cinsiyet cns
ON pd.CinsiyetId = cns.ID


-------------------- RIGHT JOIN (Saðdaki tabloyu fuller)----------------------------

select * from Din d
RIGHT JOIN PersonelDetay pd
ON d.ID = pd.DinId

----------------------- CROSS JOIN -----------------------------------

select * from
(
select pd.ID as PersonelId, cns.ID as CinsiyetId, pd.DinId from PersonelDetay pd
CROSS JOIN Cinsiyet cns
) xx
INNER JOIN Din d
ON xx.DinId = d.ID
where d.Din <> 'HRÝSTÝYAN'

