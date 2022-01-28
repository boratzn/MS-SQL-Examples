--1.. her bir fatura kayd� i�in barkod kodu olmal� ve uniq olmal�
--2.. fatura tarihi bilgisinin default set edilmesi
--3.. ac�klama2 alan�n 'sat�� faturas�' �eklinde set edilmesi
--4.. cari hesap bilgilerinin null olmamas�
--5.. miktar�n 1 den k�c�k 1000 den b�y�k olamamas�
--6.. toplam tutar alan�n�n eklenmesi (bu bilgi 3nf ayk�r�, denormalize table gerek, s�rekli hesaplatmak maliyetli, o y�zden haz�r istiyorum)

--1.. Her bir fatura kayd� i�in barkod kodu olmal� ve uniq olmal�
ALTER TABLE FATURA_TBL
ADD BARDOD_KODU INT UNIQUE

--2.. Fatura tarihi bilgisinin default set edilmesi
ALTER TABLE FATURA_TBL
ADD CONSTRAINT DF_FATURA_TARIHI
DEFAULT GETDATE() FOR FATURA_TARIH

--3.. Ac�klama2 alan�n 'sat�� faturas�' �eklinde set edilmesi
ALTER TABLE FATURA_DETAY_TBL
ADD CONSTRAINT DF_ACIKLAMA2
DEFAULT 'SATI� FATURASI' FOR ACIKLAMA2

--4.. Cari hesap bilgilerinin null olmamas�
ALTER TABLE CARI_HESAP_TBL
ADD CONSTRAINT CK_CARI_HESAP_TBL
CHECK (CARI_HESAP_ADI IS NOT NULL AND ODEMELER IS NOT NULL AND TARIH IS NOT NULL)

--5.. Miktar�n 1 den k�c�k 1000 den b�y�k olamamas�
ALTER TABLE FATURA_DETAY_TBL
ADD CONSTRAINT CK_MIKTAR_BT
CHECK (MIKTAR BETWEEN 1 AND 1000)

--6.. Toplam tutar alan�n�n eklenmesi (bu bilgi 3nf ayk�r�, denormalize table gerek, s�rekli hesaplatmak maliyetli, o y�zden haz�r istiyorum)
-- Computed Column
ALTER TABLE FATURA_DETAY_TBL
ADD TOPLAM_TUTAR AS CAST(MIKTAR as decimal) * CAST(BIRIM as decimal)