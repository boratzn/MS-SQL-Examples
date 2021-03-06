---FONKS?YONLAR---
--CREATE FUNCTION FN_FOKSIYON_ADI(@PARAMETRE PARAMETRE_TIP)
--RETURNS DON?LECEK_DE?ER?N_T?P?
--AS
--BEGIN
--	RETURN
--END

CREATE FUNCTION FN_TABLO_TOPLAM(@TABLO_ADI VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @TOPLAM_SATIR INT;
	SET @TABLO_ADI = '';
	SET @TOPLAM_SATIR = (SELECT COUNT(*) FROM @TABLO_ADI)
	RETURN @TOPLAM_SATIR
END

DECLARE @SAYI INT;
SET @SAYI = 0;
WHILE(@SAYI < DBO.FN_TABLO_TOPLAM('HESAPLAR'))
	BEGIN
		PRINT CAST(@SAYI AS VARCHAR(50))
		SET @SAYI = @SAYI +1;
	END
---------------------------------------------------------------------------


CREATE FUNCTION FN_SEHIR_BILGI_GET(@SEHIR VARCHAR(50))
RETURNS VARCHAR(50)
AS 
BEGIN
	DECLARE @SEHIR_DURUM VARCHAR(50);
	IF(@SEHIR = 'ANKARA')
		BEGIN
			SET @SEHIR_DURUM = 'BA?KENT'
		END
	ELSE IF(@SEHIR = '?STANBUL')
		BEGIN
			SET @SEHIR_DURUM = 'MEGA ?EH?R'
		END
	ELSE
		BEGIN
			SET @SEHIR_DURUM = 'BA?LI BA?INA B?R ?EH?R'
		END
	RETURN @SEHIR_DURUM
END

SELECT DBO.FN_SEHIR_BILGI_GET('ANKARA')
UNION
SELECT DBO.FN_SEHIR_BILGI_GET('?STANBUL')
UNION
SELECT DBO.FN_SEHIR_BILGI_GET('BURSA')
--------------------------------------------------------------------
-- PRODCUTTAK? ?R?NLER?N?N HEPS?NE ?STED???M?Z ZAMMI YAPAB?LECEZ. % S?N? EL?M?ZLE VER?CEZ DE???KEN OLAB?L?R.
-- FAKAT SATI?I YAPILMAMI? OLAN ?R?NLER G?NCELLENMEYECEK.
-- EN ?OK SATI? YAPILMI? ?R?NE ?SE %10 ?ZER?NDE ZAM YAPILACAK

CREATE FUNCTION FN_URUNLERE_ZAM(@ZAM_ORANI INT)
RETURNS INT
AS
BEGIN 
	DECLARE @UNIT_PRICE INT, @UNIT_PRICE_MAX INT, @COUNT INT, @ID INT;
	DECLARE @PRODUCT_COUNT INT = (SELECT COUNT(*) FROM Northwind.dbo.Products);
	SET @COUNT = 1;

	SET @UNIT_PRICE_MAX = (SELECT xx.UnitPrice FROM (SELECT o.ProductID, o.UnitPrice, SUM(o.Quantity) AS TOPLAM FROM Products p 
	INNER JOIN [Order Details] o
	ON p.ProductID = o.ProductID
	GROUP BY o.ProductID, o.UnitPrice
	ORDER BY TOPLAM DESC) as xx);

	SET @ID = (SELECT xx.ProductID FROM (SELECT o.ProductID, o.UnitPrice, SUM(o.Quantity) AS TOPLAM FROM Products p 
	INNER JOIN [Order Details] o
	ON p.ProductID = o.ProductID
	GROUP BY o.ProductID, o.UnitPrice
	ORDER BY TOPLAM DESC) as xx);

	SET @UNIT_PRICE_MAX = @UNIT_PRICE_MAX + (@UNIT_PRICE_MAX *12)/100;

	UPDATE Products SET UnitPrice = @UNIT_PRICE_MAX WHERE ProductID = @ID

	DECLARE @GECICI_TABLO TABLE (Row_ID INT, ProductID INT,UnitPrice MONEY);

	INSERT INTO @GECICI_TABLO (Row_ID, ProductID, UnitPrice)
	SELECT ROW_NUMBER() over (partition by o.ProductID order by o.ProductID asc) row_id, o.ProductID, o.UnitPrice FROM Products p INNER JOIN [Order Details] o ON p.ProductID = o.ProductID;

	WHILE(@COUNT <= @PRODUCT_COUNT)
		BEGIN 
			
			SET @UNIT_PRICE = (SELECT UnitPrice FROM @GECICI_TABLO WHERE Row_ID = @COUNT)
			SET @UNIT_PRICE = @UNIT_PRICE + (@UNIT_PRICE * @ZAM_ORANI)/100
			UPDATE Products SET UnitPrice = @UNIT_PRICE WHERE ProductID = (SELECT ProductID FROM @GECICI_TABLO WHERE Row_ID = @COUNT)
			
		END
return 1;
END