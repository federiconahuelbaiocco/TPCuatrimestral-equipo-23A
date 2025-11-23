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
PRINT '✓ EntradaHistorial limpiada';

DELETE FROM dbo.HistorialMedico;
PRINT '✓ HistorialMedico limpiada';

DELETE FROM dbo.Turnos;
PRINT '✓ Turnos limpiada';

IF OBJECT_ID('dbo.TurnosTrabajo', 'U') IS NOT NULL
BEGIN
    DELETE FROM dbo.TurnosTrabajo;
    PRINT '✓ TurnosTrabajo limpiada';
END

DELETE FROM dbo.Medico_Especialidad;
PRINT '✓ Medico_Especialidad limpiada';

DELETE FROM dbo.Usuarios;
PRINT '✓ Usuarios limpiada';

DELETE FROM dbo.Medicos;
PRINT '✓ Medicos limpiada';

DELETE FROM dbo.PACIENTES;
PRINT '✓ PACIENTES limpiada';

DELETE FROM dbo.Personas;
PRINT '✓ Personas limpiada';

DELETE FROM dbo.Domicilios;
PRINT '✓ Domicilios limpiada';

-- Reiniciar los contadores IDENTITY a 0
DBCC CHECKIDENT ('dbo.Domicilios', RESEED, 0);
DBCC CHECKIDENT ('dbo.Personas', RESEED, 0);
DBCC CHECKIDENT ('dbo.Usuarios', RESEED, 0);
DBCC CHECKIDENT ('dbo.HistorialMedico', RESEED, 0);
DBCC CHECKIDENT ('dbo.EntradaHistorial', RESEED, 0);
DBCC CHECKIDENT ('dbo.Turnos', RESEED, 0);

IF OBJECT_ID('dbo.TurnosTrabajo', 'U') IS NOT NULL
    DBCC CHECKIDENT ('dbo.TurnosTrabajo', RESEED, 0);

PRINT '✓ Contadores IDENTITY reiniciados';

PRINT '========================================';
PRINT '✓ Limpieza completada exitosamente';
PRINT 'Base de datos lista para Script 5';
PRINT '========================================';
GO


USE ClinicaDB;
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Turnos') AND name = 'MotivoConsulta')
BEGIN
    ALTER TABLE dbo.Turnos
    ADD MotivoConsulta VARCHAR(255) NULL;
    
    PRINT '✓ Columna MotivoConsulta agregada a tabla Turnos';
END
ELSE
BEGIN
    PRINT '• Columna MotivoConsulta ya existe en tabla Turnos';
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.PACIENTES') AND name = 'FechaNacimiento')
BEGIN
    ALTER TABLE dbo.PACIENTES
    ADD FechaNacimiento DATE NULL;
    
    PRINT '✓ Columna FechaNacimiento agregada a tabla PACIENTES';
END
ELSE
BEGIN
    PRINT '• Columna FechaNacimiento ya existe en tabla PACIENTES';
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Personas') AND name = 'Mail')
BEGIN
    -- Si Email existe pero Mail no
    IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Personas') AND name = 'Email')
    BEGIN
        PRINT '• Columna Email ya existe en Personas (Mail es alias)';
    END
    ELSE
    BEGIN
        ALTER TABLE dbo.Personas
        ADD Mail VARCHAR(255) NULL;
        
        PRINT '✓ Columna Mail agregada a tabla Personas';
    END
END
ELSE
BEGIN
    PRINT '• Columna Mail ya existe en tabla Personas';
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CoberturasMedicas')
BEGIN
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'COBERTURA')
    BEGIN
        EXEC sp_rename 'dbo.COBERTURA', 'CoberturasMedicas';
        PRINT '✓ Tabla COBERTURA renombrada a CoberturasMedicas';
    END
END
ELSE
BEGIN
    PRINT '• Tabla CoberturasMedicas ya existe';
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.PACIENTES') AND name = 'IdCoberturaMedica')
BEGIN
    ALTER TABLE dbo.PACIENTES
    ADD IdCoberturaMedica INT NULL;
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'CoberturasMedicas')
    BEGIN
        ALTER TABLE dbo.PACIENTES
        ADD CONSTRAINT FK_Pacientes_Cobertura 
        FOREIGN KEY (IdCoberturaMedica) REFERENCES dbo.CoberturasMedicas(idCoberturaMedica);
        
        PRINT '✓ Columna IdCoberturaMedica agregada a PACIENTES con FK';
    END
    ELSE IF EXISTS (SELECT * FROM sys.tables WHERE name = 'COBERTURA')
    BEGIN
        ALTER TABLE dbo.PACIENTES
        ADD CONSTRAINT FK_Pacientes_Cobertura 
        FOREIGN KEY (IdCoberturaMedica) REFERENCES dbo.COBERTURA(idCoberturaMedica);
        
        PRINT '✓ Columna IdCoberturaMedica agregada a PACIENTES con FK';
    END
    ELSE
    BEGIN
        PRINT '✓ Columna IdCoberturaMedica agregada a PACIENTES (sin FK - tabla cobertura no existe)';
    END
END
ELSE
BEGIN
    PRINT '• Columna IdCoberturaMedica ya existe en PACIENTES';
END
GO

