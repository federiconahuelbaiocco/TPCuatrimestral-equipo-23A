USE ClinicaDB;
GO

IF OBJECT_ID('dbo.sp_CrearHistorialMedico', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_CrearHistorialMedico;
GO
CREATE PROCEDURE dbo.sp_CrearHistorialMedico
    @IdPaciente INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM HistorialMedico WHERE IdPaciente = @IdPaciente)
    BEGIN
        INSERT INTO HistorialMedico (IdPaciente, Activo)
        VALUES (@IdPaciente, 1);
    END
END
GO

IF OBJECT_ID('dbo.sp_ObtenerIdHistorialPorPaciente', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ObtenerIdHistorialPorPaciente;
GO
CREATE PROCEDURE dbo.sp_ObtenerIdHistorialPorPaciente
    @IdPaciente INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdHistorialMedico 
    FROM HistorialMedico 
    WHERE IdPaciente = @IdPaciente AND Activo = 1;
END
GO

IF OBJECT_ID('dbo.sp_AgregarEntradaHistorial', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarEntradaHistorial;
GO
CREATE PROCEDURE dbo.sp_AgregarEntradaHistorial
    @IdPaciente INT,
    @IdMedico INT,
    @Diagnostico VARCHAR(MAX),
    @Observaciones VARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        
        DECLARE @IdHistorial INT;
        SELECT @IdHistorial = IdHistorialMedico FROM HistorialMedico WHERE IdPaciente = @IdPaciente;

        IF @IdHistorial IS NULL
        BEGIN
            INSERT INTO HistorialMedico (IdPaciente, Activo)
            VALUES (@IdPaciente, 1);
            SET @IdHistorial = SCOPE_IDENTITY();
        END

        INSERT INTO EntradaHistorial (IdHistorialMedico, IdMedico, Fecha, Diagnostico, Observaciones, Activo)
        VALUES (@IdHistorial, @IdMedico, GETDATE(), @Diagnostico, @Observaciones, 1);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ListarEntradasPorPaciente', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarEntradasPorPaciente;
GO
CREATE PROCEDURE dbo.sp_ListarEntradasPorPaciente
    @IdPaciente INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        E.IdEntradaHistorial,
        E.Fecha,
        E.Diagnostico,
        E.Observaciones,
        M.IdPersona AS IdMedico,
        P.Apellido AS ApellidoMedico,
        P.Nombre AS NombreMedico,
        M.Matricula
    FROM EntradaHistorial E
    INNER JOIN HistorialMedico H ON E.IdHistorialMedico = H.IdHistorialMedico
    INNER JOIN Medicos M ON E.IdMedico = M.IdPersona
    INNER JOIN Personas P ON M.IdPersona = P.IdPersona
    WHERE H.IdPaciente = @IdPaciente AND E.Activo = 1
    ORDER BY E.Fecha DESC;
END
GO