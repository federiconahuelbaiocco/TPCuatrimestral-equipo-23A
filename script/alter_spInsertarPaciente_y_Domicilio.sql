use ClinicaDB
go

ALTER PROCEDURE sp_InsertarPaciente
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI  VARCHAR (20),
    @Mail VARCHAR(255) = Null,
    @Telefono VARCHAR(50)= Null,
    @Calle VARCHAR(200)= Null,
    @Altura VARCHAR(20)= Null,
    @Piso VARCHAR(10)= Null ,
    @Departamento VARCHAR(10)= Null,
    @Localidad VARCHAR(100)= Null ,
    @Provincia VARCHAR(100)= Null ,
    @CodigoPostal VARCHAR(20)= Null,
    @FechaNacimiento DATE,
    @idCobertura INT = Null
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NuevoIdDomicilio INT;
    DECLARE @NuevoIdPersona INT;

    BEGIN TRY
        -- Iniciar transacción
        BEGIN TRANSACTION;

        -- 1️⃣ Validar DNI único
        IF EXISTS (SELECT 1 FROM PERSONAS WHERE DNI = @DNI)
        BEGIN
            RAISERROR('El DNI ya existe en la tabla Personas.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END


        -- 3️⃣ Insertar domicilio si se pasó alguno de los datos
        IF @Calle IS NOT NULL OR @Altura IS NOT NULL OR @Localidad IS NOT NULL OR @Provincia IS NOT NULL
        BEGIN
            INSERT INTO DOMICILIOS (Calle, Altura, Piso,Departamento, Localidad, Provincia)
            VALUES (@Calle, @Altura,@Piso,@Departamento, @Localidad, @Provincia);

            SET @NuevoIdDomicilio = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            SET @NuevoIdDomicilio = NULL;  -- si no hay domicilio, queda NULL
        END

        -- 2️⃣ Validar cobertura si se pasó
        IF @idCobertura IS NOT NULL AND NOT EXISTS (
            SELECT 1 FROM COBERTURA WHERE idCoberturaMedica = @idCobertura
        )
        BEGIN
            RAISERROR('La cobertura médica indicada no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 4️⃣ Insertar persona
        INSERT INTO PERSONAS (Nombre, Apellido, DNI,Email,Telefono, idDomicilio)
        VALUES (@Nombre, @Apellido, @DNI,@Mail,@Telefono, @NuevoIdDomicilio);

        SET @NuevoIdPersona = SCOPE_IDENTITY();

        -- 5️⃣ Insertar paciente
        INSERT INTO PACIENTES (idPersona, FechaNacimiento, idCobertura)
        VALUES (@NuevoIdPersona, @FechaNacimiento, @idCobertura);

        -- Confirmar transacción
        COMMIT TRANSACTION;

        -- 6️⃣ Devolver IDs generados
        SELECT @NuevoIdPersona AS IdPersona, @NuevoIdDomicilio AS IdDomicilio;

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE();
        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
    END CATCH
END;


EXEC sp_InsertarPaciente
    @Nombre = 'Pepe',
    @Apellido = 'Argento',
    @DNI = 90111111,
    @Mail= 'pa@utn.com',
    @Telefono=22334455,
    @Calle = 'Av. Siempre Muerta',
    @Altura= '1234',
    @Localidad= 'Springfield',
    @Provincia = 'Capital',
    @CodigoPostal= '1234',
    @FechaNacimiento = '1995-05-20'


ALTER TABLE Domicilios
ALTER COLUMN CodigoPostal VARCHAR(20) NULL;

EXEC sp_InsertarPaciente
    @Nombre = 'Moni',
    @Apellido = 'Argento',
    @DNI = 40232241,
    @FechaNacimiento = '1995-05-20'
