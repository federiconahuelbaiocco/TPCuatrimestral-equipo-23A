use ClinicaDB
go

ALTER TABLE Personas
ADD Sexo VARCHAR (12) NULL;
GO

ALTER TABLE Personas
ALTER COLUMN Sexo VARCHAR(20) NULL;


UPDATE Personas
SET Sexo = 'No especificado'
WHERE Sexo IS NULL;

