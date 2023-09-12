CREATE DATABASE ToyzUnlimited
go
USE ToyzUnlimited
GO
CREATE TABLE Toys(
	ProductCode VARCHAR(5) PRIMARY KEY,
	Name VARCHAR(30),
	Category VARCHAR(30),
	Manufaturer VARCHAR(40),
	AgeRange VARCHAR (15),
	UnitPrice MONEY,
	NetWeight INT,
	QtyOnHand INT
)
GO
INSERT INTO Toys(ProductCode, Name, Category, Manufaturer, AgeRange, UnitPrice, NetWeight, QtyOnHand) VALUES
	('001', 'Building Blocks', 'Construction Toys', 'LEGO', '3-5 years', 15.99, 600, 25),
    ('002', 'Chess Set', 'Board Games', 'Hasbro', '6-10 years', 19.99, 1000, 30),
    ('003', 'Doll House', 'Dolls & Accessories', 'Mattel', '3-5 years', 29.99, 800, 40),
    ('015', 'Remote Control Car', 'Remote Control Toys', 'RC Pro', '8-12 years', 39.99, 700, 22);
go

CREATE PROCEDURE HeavyToys AS
BEGIN
SELECT * FROM Toys WHERE Netweight > 500;
END;
GO

CREATE PROCEDURE PriceIncrease AS 
BEGIN
 UPDATE Toys SET UnitPrice = UnitPrice + 10;
END;
GO

CREATE PROCEDURE QtyOnHand AS
BEGIN
 UPDATE Toys SET QtyOnHand = QtyOnHand - 5;
END;
GO

EXEC HeavyToys;
GO
EXEC PriceIncrease;
GO
EXEC QtyOnHand;
GO

EXEC sp_helptext 'HeavyToys';
EXEC sp_helptext 'PriceIncrease';
EXEC sp_helptext 'QtyOnHand';

SELECT definition
FROM sys.sql_modules
WHERE object_id = OBJECT_ID('HeavyToys');

SELECT definition
FROM sys.sql_modules
WHERE object_id = OBJECT_ID('PriceIncrease');

SELECT definition
FROM sys.sql_modules
WHERE object_id = OBJECT_ID('QtyOnHand');

SELECT OBJECT_DEFINITION(OBJECT_ID('HeavyToys'));
SELECT OBJECT_DEFINITION(OBJECT_ID('PriceIncrease'));
SELECT OBJECT_DEFINITION(OBJECT_ID('QtyOnHand'));

EXEC sp_depends 'HeavyToys';
EXEC sp_depends 'PriceIncrease';
EXEC sp_depends 'QtyOnHand';
go

ALTER PROCEDURE PriceIncrease AS
BEGIN
    UPDATE Toys SET UnitPrice = UnitPrice + 10;
    SELECT ProductCode, Name, UnitPrice FROM Toys;
END;
go

ALTER PROCEDURE QtyOnHand AS
BEGIN
    UPDATE Toys SET QtyOnHand = QtyOnHand - 5;
    SELECT ProductCode, Name, QtyOnHand FROM Toys;
END;
go
CREATE PROCEDURE SpecificPriceIncrease AS
BEGIN
    UPDATE Toys
    SET UnitPrice = UnitPrice + (QtyOnHand * 10);
END;
go

CREATE PROCEDURE SpecificPriceIncrease AS
BEGIN
    DECLARE @TotalUpdated int;
    UPDATE Toys
    SET UnitPrice = UnitPrice + (QtyOnHand * 10);

    SELECT @TotalUpdated = @@ROWCOUNT;
    SELECT @TotalUpdated AS 'TotalUpdated';
END;
go

CREATE PROCEDURE SpecificPriceIncrease AS
BEGIN
    DECLARE @TotalUpdated int;
    UPDATE Toys
    SET UnitPrice = UnitPrice + (QtyOnHand * 10);

    
    EXEC HeavyToys;
    SELECT @TotalUpdated = @@ROWCOUNT;
    SELECT @TotalUpdated AS 'TotalUpdated';
END;
go

ALTER PROCEDURE PriceIncrease AS
BEGIN
    BEGIN TRY
        UPDATE Toys SET UnitPrice = UnitPrice + 10;
        SELECT ProductCode, Name, UnitPrice FROM Toys;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

DROP PROCEDURE HeavyToys;
DROP PROCEDURE PriceIncrease;
DROP PROCEDURE QtyOnHand;
DROP PROCEDURE SpecificPriceIncrease;
