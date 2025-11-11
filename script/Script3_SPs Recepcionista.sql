USE ClinicaDB;
GO

--PACIENTES
CREATE PROCEDURE dbo.sp_ListarPacientesActivos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        P.IdPersona, P.Dni, P.Nombre, P.Apellido, P.Email, P.Telefono, P.Activo,
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

CREATE PROCEDURE dbo.sp_InsertarPaciente
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
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
            RAISERROR('El DNI ya existe.', 16, 1); ROLLBACK TRANSACTION; RETURN;
        END

        IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO DOMICILIOS (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @NuevoIdDomicilio = SCOPE_IDENTITY();
        END

        INSERT INTO PERSONAS (Nombre, Apellido, DNI, Email, Telefono, IdDomicilio)
        VALUES (@Nombre, @Apellido, @DNI, @Mail, @Telefono, @NuevoIdDomicilio);
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

CREATE OR ALTER PROCEDURE dbo.sp_BuscarPacientes
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

CREATE OR ALTER PROCEDURE dbo.sp_EliminarPaciente
    @IdPaciente INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Personas
    SET Activo = 0
    WHERE IdPersona = @IdPaciente;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ObtenerPaciente
    @IdPaciente INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        P.IdPersona, P.Nombre, P.Apellido, P.Dni, P.Email, P.Telefono, P.IdDomicilio,
        D.Calle, D.Altura, D.Piso, D.Departamento, D.Localidad, D.Provincia, D.CodigoPostal,
        PAC.idCobertura, C.Nombre AS NombreCobertura, PAC.FechaNacimiento
    FROM Personas P
    INNER JOIN PACIENTES PAC ON P.IdPersona = PAC.IdPersona
    LEFT JOIN Domicilios D ON P.IdDomicilio = D.IdDomicilio
    LEFT JOIN COBERTURA C ON PAC.idCobertura = C.idCoberturaMedica
    WHERE P.IdPersona = @IdPaciente;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ModificarPaciente
    @IdPaciente INT,
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
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

        -- 1. Manejo de Domicilio
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

        -- 2. Actualizar datos personales básicos
        UPDATE Personas
        SET Nombre = @Nombre, Apellido = @Apellido, Dni = @DNI, Email = @Mail,
            Telefono = @Telefono, IdDomicilio = @IdDomicilio
        WHERE IdPersona = @IdPaciente;

        -- 3. Actualizar datos específicos de Paciente
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

-- LISTAR COBERTURAS
CREATE OR ALTER PROCEDURE dbo.sp_ListarCoberturas
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idCoberturaMedica, Nombre
    FROM dbo.COBERTURA
    ORDER BY Nombre ASC;
END
GO