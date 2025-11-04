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