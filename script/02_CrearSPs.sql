-- Script para crear los Procedimientos Almacenados para ClinicaDB
-- =========================================================================

USE ClinicaDB;
GO

-- SPs para Especialidades 
-- =========================================================================

-- SP: Listar Especialidades
PRINT 'Creando SP sp_ListarEspecialidades...';
IF OBJECT_ID('dbo.sp_ListarEspecialidades', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarEspecialidades;
GO

CREATE PROCEDURE dbo.sp_ListarEspecialidades
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdEspecialidad, Descripcion 
    FROM dbo.Especialidades;
END
GO
PRINT 'SP sp_ListarEspecialidades creado.';
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