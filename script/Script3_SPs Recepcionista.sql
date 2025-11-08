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