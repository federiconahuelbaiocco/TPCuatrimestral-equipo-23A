USE ClinicaDB;
GO

-- PACIENTES
IF OBJECT_ID('dbo.sp_ListarPacientesActivos', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarPacientesActivos;
GO
CREATE PROCEDURE dbo.sp_ListarPacientesActivos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        P.IdPersona, P.Dni, P.Nombre, P.Apellido, P.Email,P.Sexo, P.Telefono, P.Activo,
        PAC.FechaNacimiento, C.Nombre as Cobertura,
        D.Calle, D.Altura, D.Localidad
    FROM Personas P
    INNER JOIN PACIENTES PAC ON P.IdPersona = PAC.IdPersona
    LEFT JOIN Domicilios D ON P.IdDomicilio = D.IdDomicilio
    LEFT JOIN COBERTURA C ON PAC.idCobertura = C.idCoberturaMedica
    WHERE P.Activo = 1
    ORDER BY P.Apellido, P.Nombre;
END
GO

IF OBJECT_ID('dbo.sp_InsertarPaciente', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_InsertarPaciente;
GO
CREATE PROCEDURE dbo.sp_InsertarPaciente
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),@Sexo VARCHAR(20),
    @Mail VARCHAR(255) = NULL, @Telefono VARCHAR(50)= NULL,
    @Calle VARCHAR(200)= NULL, @Altura VARCHAR(20)= NULL, @Piso VARCHAR(10)= NULL,
    @Departamento VARCHAR(10)= NULL, @Localidad VARCHAR(100)= NULL,
    @Provincia VARCHAR(100)= NULL, @CodigoPostal VARCHAR(20)= NULL,
    @FechaNacimiento DATE, @idCobertura INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @NuevoIdDomicilio INT;
    DECLARE @NuevoIdPersona INT;

    BEGIN TRY
        BEGIN TRANSACTION;
        IF EXISTS (SELECT 1 FROM PERSONAS WHERE DNI = @DNI)
        BEGIN
            RAISERROR('El DNI ya existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO DOMICILIOS (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @NuevoIdDomicilio = SCOPE_IDENTITY();
        END

        INSERT INTO PERSONAS (Nombre, Apellido, DNI,Sexo, Email, Telefono, IdDomicilio)
        VALUES (@Nombre, @Apellido, @DNI,@Sexo, @Mail, @Telefono, @NuevoIdDomicilio);
        SET @NuevoIdPersona = SCOPE_IDENTITY();

        INSERT INTO PACIENTES (idPersona, FechaNacimiento, idCobertura)
        VALUES (@NuevoIdPersona, @FechaNacimiento, @idCobertura);

        COMMIT TRANSACTION;
        SELECT @NuevoIdPersona AS IdPersona;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

IF OBJECT_ID('dbo.sp_BuscarPacientes', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_BuscarPacientes;
GO
CREATE PROCEDURE dbo.sp_BuscarPacientes
    @DNI VARCHAR(20) = NULL,
    @Apellido VARCHAR(100) = NULL,
    @Nombre VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT P.IdPersona, P.Dni, P.Nombre, P.Apellido, PAC.FechaNacimiento FROM Personas P
    INNER JOIN PACIENTES PAC ON P.IdPersona = PAC.IdPersona
    WHERE P.Activo = 1
        AND (@DNI IS NULL OR P.Dni LIKE '%' + @DNI + '%')
        AND (@Apellido IS NULL OR P.Apellido LIKE '%' + @Apellido + '%')
        AND (@Nombre IS NULL OR P.Nombre LIKE '%' + @Nombre + '%')
    ORDER BY P.Apellido, P.Nombre;
END
GO

IF OBJECT_ID('dbo.sp_EliminarPaciente', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarPaciente;
GO
CREATE PROCEDURE dbo.sp_EliminarPaciente
    @IdPaciente INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Personas
    SET Activo = 0
    WHERE IdPersona = @IdPaciente;
END
GO

IF OBJECT_ID('dbo.sp_ObtenerPaciente', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ObtenerPaciente;
GO
CREATE PROCEDURE dbo.sp_ObtenerPaciente
    @IdPaciente INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        P.IdPersona, P.Nombre, P.Apellido, P.Dni,P.Sexo, P.Email, P.Telefono, P.IdDomicilio,
        D.Calle, D.Altura, D.Piso, D.Departamento, D.Localidad, D.Provincia, D.CodigoPostal,
        PAC.idCobertura, C.Nombre AS NombreCobertura, PAC.FechaNacimiento
    FROM Personas P
    INNER JOIN PACIENTES PAC ON P.IdPersona = PAC.IdPersona
    LEFT JOIN Domicilios D ON P.IdDomicilio = D.IdDomicilio
    LEFT JOIN COBERTURA C ON PAC.idCobertura = C.idCoberturaMedica
    WHERE P.IdPersona = @IdPaciente;
END
GO

IF OBJECT_ID('dbo.sp_ModificarPaciente', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ModificarPaciente;
GO
CREATE PROCEDURE dbo.sp_ModificarPaciente
    @IdPaciente INT,
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20), @Sexo VARCHAR(20),
    @Mail VARCHAR(255) = NULL, @Telefono VARCHAR(50) = NULL,
    @Calle VARCHAR(200) = NULL, @Altura VARCHAR(20) = NULL, @Piso VARCHAR(10) = NULL,
    @Departamento VARCHAR(10) = NULL, @Localidad VARCHAR(100) = NULL,
    @Provincia VARCHAR(100) = NULL, @CodigoPostal VARCHAR(20) = NULL,
    @FechaNacimiento DATE, @idCobertura INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdDomicilio INT;
        SELECT @IdDomicilio = IdDomicilio FROM Personas WHERE IdPersona = @IdPaciente;

        IF @IdDomicilio IS NOT NULL
        BEGIN
            UPDATE Domicilios
            SET Calle = @Calle, Altura = @Altura, Piso = @Piso, Departamento = @Departamento,
                Localidad = @Localidad, Provincia = @Provincia, CodigoPostal = @CodigoPostal
            WHERE IdDomicilio = @IdDomicilio;
        END
        ELSE IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO Domicilios (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @IdDomicilio = SCOPE_IDENTITY();
        END

        UPDATE Personas
        SET Nombre = @Nombre, Apellido = @Apellido, Dni = @DNI, @Sexo = Sexo, Email = @Mail,
            Telefono = @Telefono, IdDomicilio = @IdDomicilio
        WHERE IdPersona = @IdPaciente;

        UPDATE PACIENTES
        SET FechaNacimiento = @FechaNacimiento, idCobertura = @idCobertura
        WHERE idPersona = @IdPaciente;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

-- LISTAR COBERTURAS ACTIVAS
IF OBJECT_ID('dbo.sp_ListarCoberturasActivas', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarCoberturasActivas;
GO
CREATE PROCEDURE dbo.sp_ListarCoberturasActivas
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idCoberturaMedica, Nombre
    FROM dbo.COBERTURA
    WHERE Activo = 1
    ORDER BY Nombre ASC;
END
GO

-- ALTA DE TURNO (ASIGNACIÓN)
CREATE OR ALTER PROCEDURE dbo.sp_AltaTurno
    @IdPaciente INT,
    @IdMedico INT,
    @FechaHora DATETIME,
    @Observaciones VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Turnos WHERE IdMedico = @IdMedico AND FechaHora = @FechaHora AND Activo = 1)
        BEGIN
            RAISERROR('El médico ya tiene un turno asignado en ese horario.', 16, 1);
        END

        IF EXISTS (SELECT 1 FROM Turnos WHERE IdPaciente = @IdPaciente AND FechaHora = @FechaHora AND Activo = 1)
        BEGIN
            RAISERROR('El paciente ya tiene un turno asignado en ese horario.', 16, 1);
        END

        INSERT INTO Turnos (IdPaciente, IdMedico, FechaHora, IdEstadoTurno, Observaciones, Activo)
        VALUES (@IdPaciente, @IdMedico, @FechaHora, 1, @Observaciones, 1);
        
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- LISTAR TURNOS

CREATE OR ALTER PROCEDURE dbo.sp_ListarTurnos
    @IdMedico INT = NULL,
    @Fecha DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        T.IdTurno,
        T.FechaHora,
        T.Observaciones,
        E.Descripcion AS Estado,
        -- Datos Paciente
        P.IdPersona AS IdPaciente,
        P.Nombre AS NombrePaciente,
        P.Apellido AS ApellidoPaciente,
        P.Dni AS DniPaciente,
        -- Datos Medico
        PM.IdPersona AS IdMedico,
        PM.Apellido AS ApellidoMedico,
        PM.Nombre AS NombreMedico
    FROM Turnos T
    INNER JOIN EstadosTurno E ON T.IdEstadoTurno = E.IdEstadoTurno
    INNER JOIN Personas P ON T.IdPaciente = P.IdPersona
    INNER JOIN Personas PM ON T.IdMedico = PM.IdPersona
    WHERE T.Activo = 1
      AND (@IdMedico IS NULL OR T.IdMedico = @IdMedico)
      AND (@Fecha IS NULL OR CAST(T.FechaHora AS DATE) = @Fecha)
    ORDER BY T.FechaHora ASC;
END
GO

-- MODIFICAR ESTADO (Cancelar/Reprogramar)
CREATE OR ALTER PROCEDURE dbo.sp_ModificarEstadoTurno
    @IdTurno INT,
    @IdNuevoEstado INT,
    @Observaciones VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Turnos
    SET 
        IdEstadoTurno = @IdNuevoEstado,
        Observaciones = ISNULL(@Observaciones, Observaciones)
    WHERE IdTurno = @IdTurno;
END
GO

-- LISTAR ESTADOS (Para cargar un DropDownList)
CREATE OR ALTER PROCEDURE dbo.sp_ListarEstadosTurno
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdEstadoTurno, Descripcion FROM EstadosTurno;
END
GO