USE ClinicaDB;
GO

-- SPs para Especialidades 
-- =========================================================================

-- SP: Listar Especialidades
USE ClinicaDB;
GO

IF OBJECT_ID('dbo.sp_ListarEspecialidades', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarEspecialidades;
GO

CREATE PROCEDURE dbo.sp_ListarEspecialidades
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdEspecialidad, Descripcion 
    FROM dbo.Especialidades
    WHERE Activo = 1;
END
GO


-- SP: Agregar Especialidad 

USE ClinicaDB;
GO

IF OBJECT_ID('dbo.sp_AgregarEspecialidad', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarEspecialidad;
GO

CREATE PROCEDURE dbo.sp_AgregarEspecialidad
    @Descripcion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO dbo.Especialidades (Descripcion)
    VALUES (@Descripcion);
END
GO

-- SP: Modificar Especialidad

USE ClinicaDB;
GO

IF OBJECT_ID('dbo.sp_ModificarEspecialidad', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ModificarEspecialidad;
GO

CREATE PROCEDURE dbo.sp_ModificarEspecialidad
    @IdEspecialidad INT,
    @NuevaDescripcion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE dbo.Especialidades
    SET Descripcion = @NuevaDescripcion
    WHERE IdEspecialidad = @IdEspecialidad;
END
GO

-- SP: Eliminar Especialidad

USE ClinicaDB;
GO

IF OBJECT_ID('dbo.sp_EliminarLogicoEspecialidad', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarLogicoEspecialidad;
GO

CREATE PROCEDURE dbo.sp_EliminarLogicoEspecialidad
    @IdEspecialidad INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE dbo.Especialidades
    SET Activo = 0
    WHERE IdEspecialidad = @IdEspecialidad;
END
GO

-- modificar especialidades para baja logica 

USE ClinicaDB;
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('dbo.Especialidades') AND name = 'Activo')
BEGIN
    ALTER TABLE dbo.Especialidades
    ADD Activo BIT NOT NULL DEFAULT 1;
    PRINT 'Columna Activo agregada a Especialidades.';
END
GO

USE ClinicaDB;
GO

ALTER PROCEDURE dbo.sp_ListarEspecialidades
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        IdEspecialidad, 
        Descripcion,
        Activo
    FROM 
        dbo.Especialidades
    WHERE 
        Activo = 1;
END
GO


-- == SPs para Medicos ==
-- =========================================================================

-- -- SP: Listar Medicos Activos --
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
    FROM 
        dbo.Personas P
    INNER JOIN 
        dbo.Medicos M ON P.IdPersona = M.IdPersona
    WHERE 
        P.Activo = 1;
END
GO
PRINT 'SP sp_ListarMedicosActivos creado.';
GO

PRINT '========================================';
PRINT 'Script de Stored Procedures completado.';
GO

-- == SPs para Colsultorios ==
-- =========================================================================

-- creacion de tabla consultorios

USE ClinicaDB;
GO

IF OBJECT_ID('dbo.CONSULTORIOS', 'U') IS NOT NULL
    DROP TABLE dbo.CONSULTORIOS;
GO

CREATE TABLE dbo.CONSULTORIOS (
    IdConsultorio INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_Consultorios PRIMARY KEY CLUSTERED (IdConsultorio ASC)
);
PRINT 'Tabla CONSULTORIOS creada.';
GO

--- STORED PROCEDURES

-- SP para Listar
IF OBJECT_ID('dbo.sp_ListarConsultorios', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarConsultorios;
GO
CREATE PROCEDURE dbo.sp_ListarConsultorios
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        IdConsultorio, 
        Nombre, 
        Activo 
    FROM 
        dbo.CONSULTORIOS;
END
GO
PRINT 'SP sp_ListarConsultorios creado.';
GO

-- SP para Alta
IF OBJECT_ID('dbo.sp_AgregarConsultorio', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarConsultorio;
GO
CREATE PROCEDURE dbo.sp_AgregarConsultorio
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.CONSULTORIOS (Nombre) 
    VALUES (@Nombre);
END
GO
PRINT 'SP sp_AgregarConsultorio creado.';
GO

-- SP para Modificación
IF OBJECT_ID('dbo.sp_ModificarConsultorio', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ModificarConsultorio;
GO
CREATE PROCEDURE dbo.sp_ModificarConsultorio
    @IdConsultorio INT,
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.CONSULTORIOS 
    SET Nombre = @Nombre 
    WHERE IdConsultorio = @IdConsultorio;
END
GO
PRINT 'SP sp_ModificarConsultorio creado.';
GO

-- SP para Baja Lógica
IF OBJECT_ID('dbo.sp_EliminarLogicoConsultorio', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarLogicoConsultorio;
GO
CREATE PROCEDURE dbo.sp_EliminarLogicoConsultorio
    @IdConsultorio INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.CONSULTORIOS 
    SET Activo = 0 
    WHERE IdConsultorio = @IdConsultorio;
END
GO
PRINT 'SP sp_EliminarLogicoConsultorio creado.';
GO

