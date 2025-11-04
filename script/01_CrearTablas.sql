-- =========================================================================
-- Script para crear la Base de Datos y Estructura Inicial para ClinicaDB
-- =========================================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ClinicaDB')
BEGIN
    CREATE DATABASE ClinicaDB;
    PRINT 'Base de datos ClinicaDB creada.';
END
ELSE
BEGIN
    PRINT 'La base de datos ClinicaDB ya existe.';
END
GO

USE ClinicaDB;
GO


PRINT 'Creando tabla Domicilios...';
IF OBJECT_ID('dbo.Domicilios', 'U') IS NOT NULL
    DROP TABLE dbo.Domicilios;

CREATE TABLE dbo.Domicilios (
    IdDomicilio INT IDENTITY(1,1) NOT NULL,
    Calle VARCHAR(200) NOT NULL,
    Altura VARCHAR(20) NOT NULL,
    Piso VARCHAR(10) NULL,
    Departamento VARCHAR(10) NULL,
    Localidad VARCHAR(100) NOT NULL,
    Provincia VARCHAR(100) NOT NULL,
    CodigoPostal VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Domicilios PRIMARY KEY CLUSTERED (IdDomicilio ASC)
);
PRINT 'Tabla Domicilios creada.';
GO

PRINT 'Creando tabla Personas...';
IF OBJECT_ID('dbo.Personas', 'U') IS NOT NULL
    DROP TABLE dbo.Personas;

IF OBJECT_ID('dbo.Domicilios', 'U') IS NULL
BEGIN
    PRINT 'Error Crítico: La tabla Domicilios es necesaria y no existe. Abortando.';
END
ELSE
BEGIN
    CREATE TABLE dbo.Personas (
        IdPersona INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(100) NOT NULL,
        Apellido VARCHAR(100) NOT NULL,
        Dni VARCHAR(20) NOT NULL,
        Email VARCHAR(255) NULL,
        Telefono VARCHAR(50) NULL,
        Activo BIT NOT NULL DEFAULT 1,
        IdDomicilio INT NULL,

        CONSTRAINT PK_Personas PRIMARY KEY CLUSTERED (IdPersona ASC),
        CONSTRAINT UQ_Personas_Dni UNIQUE (Dni),
        CONSTRAINT FK_Personas_Domicilios FOREIGN KEY (IdDomicilio) REFERENCES dbo.Domicilios(IdDomicilio) ON DELETE SET NULL -- Si se borra el domicilio, queda nulo en Persona
    );
    PRINT 'Tabla Personas creada.';
END;
GO

PRINT 'Creando tabla Especialidades...';
IF OBJECT_ID('dbo.Especialidades', 'U') IS NOT NULL
    DROP TABLE dbo.Especialidades;

CREATE TABLE dbo.Especialidades (
    IdEspecialidad INT IDENTITY(1,1) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    
    CONSTRAINT PK_Especialidades PRIMARY KEY CLUSTERED (IdEspecialidad ASC)
);
PRINT 'Tabla Especialidades creada.';
GO

PRINT 'Creando tabla Medicos...';
IF OBJECT_ID('dbo.Medicos', 'U') IS NOT NULL
    DROP TABLE dbo.Medicos;

IF OBJECT_ID('dbo.Personas', 'U') IS NULL
BEGIN
    PRINT 'Error Crítico: La tabla Personas es necesaria y no existe. Abortando.';
END
ELSE
BEGIN
    CREATE TABLE dbo.Medicos (
        IdPersona INT NOT NULL, 
        Matricula VARCHAR(50) NOT NULL,
        IdUsuario INT NULL DEFAULT -1, 

        CONSTRAINT PK_Medicos PRIMARY KEY CLUSTERED (IdPersona ASC),
        CONSTRAINT FK_Medicos_Personas FOREIGN KEY (IdPersona) REFERENCES dbo.Personas(IdPersona) ON DELETE CASCADE

    );
    PRINT 'Tabla Medicos creada.';
END;
GO

PRINT 'Creando SP sp_ListarEspecialidades...';
IF OBJECT_ID('dbo.sp_ListarEspecialidades', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarEspecialidades;
GO

CREATE PROCEDURE dbo.sp_ListarEspecialidades
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdEspecialidad, Descripcion FROM dbo.Especialidades;
END
GO
PRINT 'SP sp_ListarEspecialidades creado.';
GO

PRINT 'Creando SP sp_ListarMedicosActivos...';
IF OBJECT_ID('dbo.sp_ListarMedicosActivos', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarMedicosActivos;
GO

CREATE PROCEDURE dbo.sp_ListarMedicosActivos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        P.IdPersona, P.Dni, P.Nombre, P.Apellido, P.Email, P.Telefono, P.Activo,
        M.Matricula, M.IdUsuario 
        -- Puedes añadir JOIN con Domicilios aquí si necesitas esos datos
        -- , D.Calle, D.Altura, D.Localidad ...
    FROM 
        dbo.Personas P
    INNER JOIN 
        dbo.Medicos M ON P.IdPersona = M.IdPersona
    -- LEFT JOIN dbo.Domicilios D ON P.IdDomicilio = D.IdDomicilio -- Ejemplo de JOIN con Domicilios
    WHERE 
        P.Activo = 1;
END
GO
PRINT 'SP sp_ListarMedicosActivos creado.';
GO

-- =========================================================================
-- == PASO 4: (Opcional) Insertar Datos de Ejemplo ==
-- =========================================================================
PRINT 'Insertando datos de ejemplo...';

-- Insertar Domicilios (si la tabla está vacía)
IF NOT EXISTS (SELECT 1 FROM dbo.Domicilios)
BEGIN
    INSERT INTO dbo.Domicilios (Calle, Altura, Localidad, Provincia, CodigoPostal) VALUES
    ('Av. Siempre Viva', '742', 'Springfield', 'Provincia X', 'B1617'),
    ('Calle Falsa', '123', 'Don Torcuato', 'Buenos Aires', 'B1611');
    PRINT 'Domicilios de ejemplo insertados.';
END

-- Insertar Especialidades (si la tabla está vacía)
IF NOT EXISTS (SELECT 1 FROM dbo.Especialidades)
BEGIN
    INSERT INTO dbo.Especialidades (Descripcion) VALUES 
    ('Cardiología'), ('Dermatología'), ('Pediatría'), ('Odontología'), ('Clínica Médica');
    PRINT 'Especialidades de ejemplo insertadas.';
END

-- Insertar Persona y Medico de ejemplo (si no existen)
IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Dni = '12345678')
BEGIN
    -- Asumimos que existe un domicilio con IdDomicilio=1
    INSERT INTO dbo.Personas (Dni, Nombre, Apellido, Email, Telefono, Activo, IdDomicilio) 
    VALUES ('12345678', 'Juan', 'Perez', 'jperez@mail.com', '1122334455', 1, 1);
    
    -- Obtener el ID recién insertado
    DECLARE @IdPersonaJuan INT = SCOPE_IDENTITY(); 

    -- Insertar en Medicos usando el ID obtenido
    INSERT INTO dbo.Medicos (IdPersona, Matricula, IdUsuario) 
    VALUES (@IdPersonaJuan, 'MN12345', -1); 

    PRINT 'Medico de ejemplo (Juan Perez) insertado.';
END

IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Dni = '87654321')
BEGIN
    -- Asumimos que existe un domicilio con IdDomicilio=2
    INSERT INTO dbo.Personas (Dni, Nombre, Apellido, Email, Telefono, Activo, IdDomicilio) 
    VALUES ('87654321', 'Maria', 'Gomez', 'mgomez@mail.com', '1166778899', 1, 2);

    DECLARE @IdPersonaMaria INT = SCOPE_IDENTITY(); 

    INSERT INTO dbo.Medicos (IdPersona, Matricula, IdUsuario) 
    VALUES (@IdPersonaMaria, 'MP54321', -1); 
    PRINT 'Medico de ejemplo (Maria Gomez) insertado.';
END
GO

PRINT '========================================';
PRINT 'Script completado.';
PRINT 'Verificando datos insertados:';
SELECT * FROM dbo.Domicilios;
SELECT * FROM dbo.Especialidades;
SELECT P.IdPersona, P.Nombre, P.Apellido, M.Matricula FROM dbo.Personas P JOIN dbo.Medicos M ON P.IdPersona = M.IdPersona;
GO
-- =========================================================================