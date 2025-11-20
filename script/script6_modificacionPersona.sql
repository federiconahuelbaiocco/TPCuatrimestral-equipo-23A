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


USE ClinicaDB;
GO

PRINT '--- Iniciando Limpieza de Base de Datos ---';

-- 1. Borrar datos en orden inverso a las relaciones (Foreign Keys)
DELETE FROM dbo.EntradaHistorial;
DELETE FROM dbo.HistorialMedico;
DELETE FROM dbo.Turnos;
DELETE FROM dbo.TurnosTrabajo; 
DELETE FROM dbo.Usuarios;
DELETE FROM dbo.Medicos;
DELETE FROM dbo.Pacientes;
DELETE FROM dbo.Personas;
DELETE FROM dbo.COBERTURA;
DELETE FROM dbo.Roles;
DELETE FROM dbo.Especialidades;
DELETE FROM dbo.CONSULTORIOS;

-- Reiniciar los contadores IDENTITY a 0
DBCC CHECKIDENT ('dbo.COBERTURA', RESEED, 0);
DBCC CHECKIDENT ('dbo.Roles', RESEED, 0);
DBCC CHECKIDENT ('dbo.Especialidades', RESEED, 0);
DBCC CHECKIDENT ('dbo.CONSULTORIOS', RESEED, 0);
DBCC CHECKIDENT ('dbo.Personas', RESEED, 0);
DBCC CHECKIDENT ('dbo.Usuarios', RESEED, 0);

PRINT '--- Limpieza completada. Base lista para recibir Script 5 ---';
GO