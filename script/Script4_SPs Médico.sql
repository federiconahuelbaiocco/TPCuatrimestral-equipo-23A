
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


IF OBJECT_ID('dbo.sp_ModificarEntradaHistorial', 'P') IS NOT NULL 
    DROP PROCEDURE dbo.sp_ModificarEntradaHistorial;
GO

CREATE PROCEDURE dbo.sp_ModificarEntradaHistorial
    @IdEntradaHistorial INT,
    @Diagnostico VARCHAR(MAX),
    @Observaciones VARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM EntradaHistorial WHERE IdEntradaHistorial = @IdEntradaHistorial AND Activo = 1)
        BEGIN
            RAISERROR('La entrada de historial no existe o ha sido eliminada.', 16, 1);
            RETURN;
        END

        UPDATE EntradaHistorial
        SET 
            Diagnostico = @Diagnostico,
            Observaciones = @Observaciones
        WHERE IdEntradaHistorial = @IdEntradaHistorial;

    END TRY
    BEGIN CATCH
        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Msg, 16, 1);
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

IF OBJECT_ID('dbo.sp_ListarPacientesPorMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarPacientesPorMedico;
GO
CREATE OR ALTER PROCEDURE dbo.sp_ListarPacientesPorMedico
    @IdMedico INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        SELECT DISTINCT
            P.IdPersona,
            P.Nombre,
            P.Apellido,
            P.Dni,
            P.Email,
            P.Telefono,
            P.Sexo,
            P.Activo,
            D.IdDomicilio,
            D.Calle,
            D.Altura,
            D.Piso,
            D.Departamento,
            D.Localidad,
            D.Provincia,
            D.CodigoPostal,
            ISNULL(CM.IdCoberturaMedica, 0) AS IdCoberturaMedica,
            ISNULL(CM.Nombre, 'Particular') AS NombreCobertura
        FROM Turnos T
        INNER JOIN Personas P ON T.IdPaciente = P.IdPersona
        LEFT JOIN Domicilios D ON P.IdDomicilio = D.IdDomicilio
        LEFT JOIN PACIENTES PA ON P.IdPersona = PA.idPersona
        LEFT JOIN COBERTURA CM ON PA.IdCoberturaMedica = CM.idCoberturaMedica
        WHERE T.IdMedico = @IdMedico
          AND T.Activo = 1
          AND P.Activo = 1
        ORDER BY P.Apellido, P.Nombre;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ListarTurnosDelDia', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarTurnosDelDia;
GO
CREATE OR ALTER PROCEDURE dbo.sp_ListarTurnosDelDia
    @IdMedico INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        DECLARE @FechaHoy DATE = CAST(GETDATE() AS DATE);
        
        SELECT 
            T.IdTurno,
            T.FechaHora,
            FORMAT(T.FechaHora, 'HH:mm') AS HoraFormateada,
            T.MotivoConsulta AS TipoConsulta,
            T.Observaciones,
            E.Descripcion AS Estado,
            P.IdPersona AS IdPaciente,
            P.Nombre AS NombrePaciente,
            P.Apellido AS ApellidoPaciente,
            P.Dni AS DniPaciente,
            (P.Apellido + ', ' + P.Nombre) AS NombreCompletoPaciente,
            PM.IdPersona AS IdMedico,
            PM.Apellido AS ApellidoMedico,
            PM.Nombre AS NombreMedico
        FROM Turnos T
        INNER JOIN EstadosTurno E ON T.IdEstadoTurno = E.IdEstadoTurno
        INNER JOIN Personas P ON T.IdPaciente = P.IdPersona
        INNER JOIN Personas PM ON T.IdMedico = PM.IdPersona
        WHERE T.Activo = 1
          AND T.IdMedico = @IdMedico
          AND CAST(T.FechaHora AS DATE) = @FechaHoy
        ORDER BY T.FechaHora ASC;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ContarTurnosDelDia', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ContarTurnosDelDia;
GO
CREATE OR ALTER PROCEDURE dbo.sp_ContarTurnosDelDia
    @IdMedico INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        DECLARE @FechaHoy DATE = CAST(GETDATE() AS DATE);
        
        SELECT COUNT(*) AS TotalTurnos
        FROM Turnos
        WHERE IdMedico = @IdMedico
          AND CAST(FechaHora AS DATE) = @FechaHoy
          AND Activo = 1;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ContarTurnosPendientes', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ContarTurnosPendientes;
GO
CREATE OR ALTER PROCEDURE dbo.sp_ContarTurnosPendientes
    @IdMedico INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        SELECT COUNT(*) AS TotalPendientes
        FROM Turnos T
        INNER JOIN EstadosTurno E ON T.IdEstadoTurno = E.IdEstadoTurno
        WHERE T.IdMedico = @IdMedico
          AND E.Descripcion = 'Pendiente'
          AND T.Activo = 1
          AND T.FechaHora >= GETDATE();
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO


IF OBJECT_ID('dbo.sp_ContarPacientesPorMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ContarPacientesPorMedico;
GO
CREATE OR ALTER PROCEDURE dbo.sp_ContarPacientesPorMedico
    @IdMedico INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        SELECT COUNT(DISTINCT IdPaciente) AS TotalPacientes
        FROM Turnos
        WHERE IdMedico = @IdMedico
          AND Activo = 1;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

PRINT '✓ Script 4: Stored Procedures para Médico creados exitosamente';
GO
