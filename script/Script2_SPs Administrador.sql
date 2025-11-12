USE ClinicaDB;
GO

--ESPECIALIDADES
CREATE PROCEDURE dbo.sp_ListarEspecialidades
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdEspecialidad, Descripcion, Activo FROM dbo.Especialidades WHERE Activo = 1;
END
GO

CREATE PROCEDURE dbo.sp_AgregarEspecialidad
    @Descripcion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Especialidades (Descripcion) VALUES (@Descripcion);
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ModificarEspecialidad
    @IdEspecialidad INT,
    @NuevaDescripcion VARCHAR(100),
    @Activo BIT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE dbo.Especialidades
    SET 
        Descripcion = @NuevaDescripcion,
        Activo = @Activo
    WHERE 
        IdEspecialidad = @IdEspecialidad;
END
GO

CREATE PROCEDURE dbo.sp_EliminarLogicoEspecialidad
    @IdEspecialidad INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Especialidades SET Activo = 0 WHERE IdEspecialidad = @IdEspecialidad;
END
GO

--CONSULTORIOS
CREATE PROCEDURE dbo.sp_ListarConsultorios
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdConsultorio, Nombre, Activo FROM dbo.CONSULTORIOS;
END
GO

CREATE PROCEDURE dbo.sp_AgregarConsultorio
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.CONSULTORIOS (Nombre) VALUES (@Nombre);
END
GO

USE ClinicaDB;
GO

ALTER PROCEDURE dbo.sp_ModificarConsultorio
    @IdConsultorio INT,
    @Nombre VARCHAR(100),
    @Activo BIT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.CONSULTORIOS 
    SET 
        Nombre = @Nombre,
        Activo = @Activo
    WHERE 
        IdConsultorio = @IdConsultorio;
END
GO

CREATE PROCEDURE dbo.sp_EliminarLogicoConsultorio
    @IdConsultorio INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.CONSULTORIOS SET Activo = 0 WHERE IdConsultorio = @IdConsultorio;
END
GO

--MEDICOS (Gestión)

USE ClinicaDB;
GO

CREATE PROCEDURE dbo.sp_AgregarMedico
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Matricula VARCHAR(50),
    @Mail VARCHAR(255) = NULL,
    @Telefono VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        
        IF EXISTS (SELECT 1 FROM PERSONAS WHERE DNI = @DNI)
        BEGIN
            RAISERROR('El DNI ya existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Email, Telefono, Activo)
        VALUES (@Nombre, @Apellido, @DNI, @Mail, @Telefono, 1);

        DECLARE @NuevoIdPersona INT = SCOPE_IDENTITY();

        INSERT INTO dbo.Medicos (IdPersona, Matricula, IdUsuario)
        VALUES (@NuevoIdPersona, @Matricula, NULL);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW; 
    END CATCH
END
GO

USE ClinicaDB;
GO

CREATE OR ALTER PROCEDURE dbo.sp_ListarMedicosActivos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        P.IdPersona, 
        P.Dni, 
        P.Nombre, 
        P.Apellido, 
        P.Email, 
        P.Telefono, 
        M.Matricula,
        M.IdUsuario
    FROM dbo.Personas P
    INNER JOIN dbo.Medicos M ON P.IdPersona = M.IdPersona
    WHERE P.Activo = 1;
END
GO

USE ClinicaDB;
GO

CREATE PROCEDURE dbo.sp_ModificarMedico
    @IdPersona INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Matricula VARCHAR(50),
    @Mail VARCHAR(255) = NULL,
    @Telefono VARCHAR(50) = NULL,
    @Activo BIT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        
        UPDATE dbo.Personas
        SET 
            Nombre = @Nombre,
            Apellido = @Apellido,
            Dni = @DNI,
            Email = @Mail,
            Telefono = @Telefono,
            Activo = @Activo
        WHERE 
            IdPersona = @IdPersona;

        UPDATE dbo.Medicos
        SET 
            Matricula = @Matricula
        WHERE 
            IdPersona = @IdPersona;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

USE ClinicaDB;
GO

CREATE PROCEDURE dbo.sp_EliminarLogicoMedico
    @IdPersona INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE dbo.Personas
    SET 
        Activo = 0
    WHERE 
        IdPersona = @IdPersona;
END
GO

-- RECEPCIONISTAS
CREATE OR ALTER PROCEDURE dbo.sp_AgregarRecepcionista
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
    @Mail VARCHAR(255), @Telefono VARCHAR(50),
    @NombreUsuario VARCHAR(50), @Clave VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO Personas (Nombre, Apellido, Dni, Email, Telefono)
        VALUES (@Nombre, @Apellido, @DNI, @Mail, @Telefono);
        DECLARE @IdPersona INT = SCOPE_IDENTITY();
        -- IdRol 2 = Recepcionista
        INSERT INTO Usuarios (NombreUsuario, Clave, IdRol, IdPersona)
        VALUES (@NombreUsuario, @Clave, 2, @IdPersona);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_EliminarRecepcionista
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Usuarios SET Activo = 0 WHERE IdUsuario = @IdUsuario;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ModificarRecepcionista
    @IdUsuario INT,
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
    @Mail VARCHAR(255) = NULL, @Telefono VARCHAR(50) = NULL,
    @NuevaClave VARCHAR(50) = NULL -- Opcional
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdPersona INT = (SELECT IdPersona FROM Usuarios WHERE IdUsuario = @IdUsuario);
        -- Actualiza datos personales
        UPDATE Personas
        SET Nombre = @Nombre, Apellido = @Apellido, Dni = @DNI, Email = @Mail, Telefono = @Telefono
        WHERE IdPersona = @IdPersona;
        -- Si hay nueva clave, la actualiza
        IF @NuevaClave IS NOT NULL AND LEN(@NuevaClave) > 0
            UPDATE Usuarios SET Clave = @NuevaClave WHERE IdUsuario = @IdUsuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; THROW;
    END CATCH
END
GO

USE ClinicaDB;
GO

CREATE OR ALTER PROCEDURE dbo.sp_ListarRecepcionistas
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        U.IdUsuario, 
        U.NombreUsuario, 
        P.IdPersona,
        P.Nombre, 
        P.Apellido, 
        P.Dni, 
        U.Activo
    FROM Usuarios U 
    INNER JOIN Personas P ON U.IdPersona = P.IdPersona
    INNER JOIN Roles R ON U.IdRol = R.IdRol
    WHERE R.Nombre = 'Recepcionista' AND U.Activo = 1;
END
GO

-- ADMINISTRADORES
CREATE OR ALTER PROCEDURE dbo.sp_AgregarAdministrador
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Mail VARCHAR(255),
    @Telefono VARCHAR(50),
    @NombreUsuario VARCHAR(50),
    @Clave VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        -- 1. Validar que el nombre de usuario no exista ya
        IF EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = @NombreUsuario)
            THROW 50001, 'El nombre de usuario ya está en uso.', 1;

        -- 2. Insertar los datos personales
        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Email, Telefono)
        VALUES (@Nombre, @Apellido, @DNI, @Mail, @Telefono);

        -- Guardamos el ID de la persona recién creada
        DECLARE @NuevoIdPersona INT = SCOPE_IDENTITY();

        -- 3. Crear el Usuario vinculado a esa persona con Rol de Administrador (IdRol = 1)
        -- Asumimos que el IdRol 1 corresponde a 'Administrador' según tu script inicial
        INSERT INTO dbo.Usuarios (NombreUsuario, Clave, IdRol, IdPersona, Activo)
        VALUES (@NombreUsuario, @Clave, 1, @NuevoIdPersona, 1);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si algo falla (ej. DNI duplicado), deshacemos todo
        ROLLBACK TRANSACTION;
        THROW; -- Re-lanzamos el error para que C# lo pueda capturar y mostrar
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_EliminarAdministrador
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Usuarios
    SET Activo = 0
    WHERE IdUsuario = @IdUsuario;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ModificarAdministrador
    @IdUsuario INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Mail VARCHAR(255) = NULL,
    @Telefono VARCHAR(50) = NULL,
    @NuevaClave VARCHAR(50) = NULL -- Opcional: si viene vacío o NULL, no se cambia la clave actual
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        -- 1. Recuperar el IdPersona asociado al usuario que estamos modificando
        DECLARE @IdPersona INT = (SELECT IdPersona FROM dbo.Usuarios WHERE IdUsuario = @IdUsuario);

        -- 2. Actualizar los datos personales en la tabla Personas
        UPDATE dbo.Personas
        SET Nombre = @Nombre,
            Apellido = @Apellido,
            Dni = @DNI,
            Email = @Mail,
            Telefono = @Telefono
        WHERE IdPersona = @IdPersona;

        -- 3. Si se proporcionó una nueva clave, actualizarla en la tabla Usuarios
        IF @NuevaClave IS NOT NULL AND LTRIM(RTRIM(@NuevaClave)) <> ''
        BEGIN
            UPDATE dbo.Usuarios
            SET Clave = @NuevaClave
            WHERE IdUsuario = @IdUsuario;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ListarAdministradores
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        U.IdUsuario,
        U.NombreUsuario,
        P.IdPersona,
        P.Nombre,
        P.Apellido,
        P.Dni,
        P.Email,
        U.Activo
    FROM dbo.Usuarios U
    INNER JOIN dbo.Roles R ON U.IdRol = R.IdRol
    INNER JOIN dbo.Personas P ON U.IdPersona = P.IdPersona
    WHERE R.Nombre = 'Administrador' AND U.Activo = 1;
END
GO

USE ClinicaDB;
GO

IF OBJECT_ID('dbo.Roles', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Roles (
        IdRol INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(50) NOT NULL,
        CONSTRAINT PK_Roles PRIMARY KEY CLUSTERED (IdRol ASC)
    );
    
    INSERT INTO dbo.Roles (Nombre) VALUES ('Administrador'), ('Recepcionista'), ('Medico');
END
GO

IF OBJECT_ID('dbo.Usuarios', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Usuarios (
        IdUsuario INT IDENTITY(1,1) NOT NULL,
        NombreUsuario VARCHAR(50) NOT NULL,
        Clave VARCHAR(50) NOT NULL,
        IdRol INT NOT NULL,
        IdPersona INT NOT NULL,
        Activo BIT NOT NULL DEFAULT 1,
        FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
        CONSTRAINT PK_Usuarios PRIMARY KEY CLUSTERED (IdUsuario ASC),
        CONSTRAINT UQ_Usuarios_NombreUsuario UNIQUE (NombreUsuario),
        CONSTRAINT FK_Usuarios_Roles FOREIGN KEY (IdRol) REFERENCES dbo.Roles(IdRol),
        CONSTRAINT FK_Usuarios_PersonAS FOREIGN KEY (IdPersona) REFERENCES dbo.Personas(IdPersona)
    );
END
GO

IF OBJECT_ID('dbo.sp_ListarRoles', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarRoles;
GO

CREATE PROCEDURE dbo.sp_ListarRoles
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdRol, Nombre FROM dbo.Roles;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_CambiarRolUsuario
    @IdUsuario INT,
    @IdNuevoRol INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validamos que el rol nuevo exista
    IF NOT EXISTS (SELECT 1 FROM dbo.Roles WHERE IdRol = @IdNuevoRol)
    BEGIN
        RAISERROR('El rol de destino no existe.', 16, 1);
        RETURN;
    END

    -- Validamos que el usuario exista
    IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE IdUsuario = @IdUsuario)
    BEGIN
        RAISERROR('El usuario no existe.', 16, 1);
        RETURN;
    END

    -- Actualizamos el rol del usuario
    UPDATE dbo.Usuarios
    SET IdRol = @IdNuevoRol
    WHERE IdUsuario = @IdUsuario;
END
GO

-- === ABM COBERTURAS ===

CREATE OR ALTER PROCEDURE dbo.sp_ListarTodasCoberturas
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idCoberturaMedica, Nombre, Activo
    FROM dbo.COBERTURA
    ORDER BY Nombre;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_AgregarCobertura
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.COBERTURA (Nombre, Activo)
    VALUES (@Nombre, 1);
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ModificarCobertura
    @IdCoberturaMedica INT,
    @Nombre VARCHAR(50),
    @Activo BIT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.COBERTURA
    SET Nombre = @Nombre,
        Activo = @Activo
    WHERE idCoberturaMedica = @IdCoberturaMedica;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_EliminarLogicoCobertura
    @IdCoberturaMedica INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.COBERTURA
    SET Activo = 0
    WHERE idCoberturaMedica = @IdCoberturaMedica;
END
GO