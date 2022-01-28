--1.. her bir fatura kaydý için barkod kodu olmalý ve uniq olmalý
--2.. fatura tarihi bilgisinin default set edilmesi
--3.. acýklama2 alanýn 'satýþ faturasý' þeklinde set edilmesi
--4.. cari hesap bilgilerinin null olmamasý
--5.. miktarýn 1 den kücük 1000 den büyük olamamasý
--6.. toplam tutar alanýnýn eklenmesi (bu bilgi 3nf aykýrý, denormalize table gerek, sürekli hesaplatmak maliyetli, o yüzden hazýr istiyorum)

--1.. Her bir fatura kaydý için barkod kodu olmalý ve uniq olmalý
ALTER TABLE FATURA_TBL
ADD BARDOD_KODU INT UNIQUE

--2.. Fatura tarihi bilgisinin default set edilmesi
ALTER TABLE FATURA_TBL
ADD CONSTRAINT DF_FATURA_TARIHI
DEFAULT GETDATE() FOR FATURA_TARIH

--3.. Acýklama2 alanýn 'satýþ faturasý' þeklinde set edilmesi
ALTER TABLE FATURA_DETAY_TBL
ADD CONSTRAINT DF_ACIKLAMA2
DEFAULT 'SATIÞ FATURASI' FOR ACIKLAMA2

--4.. Cari hesap bilgilerinin null olmamasý
ALTER TABLE CARI_HESAP_TBL
ADD CONSTRAINT CK_CARI_HESAP_TBL
CHECK (CARI_HESAP_ADI IS NOT NULL AND ODEMELER IS NOT NULL AND TARIH IS NOT NULL)

--5.. Miktarýn 1 den kücük 1000 den büyük olamamasý
ALTER TABLE FATURA_DETAY_TBL
ADD CONSTRAINT CK_MIKTAR_BT
CHECK (MIKTAR BETWEEN 1 AND 1000)

--6.. Toplam tutar alanýnýn eklenmesi (bu bilgi 3nf aykýrý, denormalize table gerek, sürekli hesaplatmak maliyetli, o yüzden hazýr istiyorum)
-- Computed Column
ALTER TABLE FATURA_DETAY_TBL
ADD TOPLAM_TUTAR AS CAST(MIKTAR as decimal) * CAST(BIRIM as decimal)