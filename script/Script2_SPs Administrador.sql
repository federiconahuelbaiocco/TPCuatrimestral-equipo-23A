USE ClinicaDB;
GO

-- ESPECIALIDADES
IF OBJECT_ID('dbo.sp_ListarEspecialidades', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarEspecialidades;
GO
CREATE PROCEDURE dbo.sp_ListarEspecialidades
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdEspecialidad, Descripcion, Activo FROM dbo.Especialidades;
END
GO

IF OBJECT_ID('dbo.sp_AgregarEspecialidad', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarEspecialidad;
GO
CREATE PROCEDURE dbo.sp_AgregarEspecialidad
    @Descripcion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Especialidades (Descripcion) VALUES (@Descripcion);
END
GO

IF OBJECT_ID('dbo.sp_ModificarEspecialidad', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ModificarEspecialidad;
GO
CREATE PROCEDURE dbo.sp_ModificarEspecialidad
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

IF OBJECT_ID('dbo.sp_EliminarLogicoEspecialidad', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarLogicoEspecialidad;
GO
CREATE PROCEDURE dbo.sp_EliminarLogicoEspecialidad
    @IdEspecialidad INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Especialidades SET Activo = 0 WHERE IdEspecialidad = @IdEspecialidad;
END
GO

-- CONSULTORIOS
IF OBJECT_ID('dbo.sp_ListarConsultorios', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarConsultorios;
GO
CREATE PROCEDURE dbo.sp_ListarConsultorios
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdConsultorio, Nombre, Activo FROM dbo.CONSULTORIOS;
END
GO

IF OBJECT_ID('dbo.sp_AgregarConsultorio', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarConsultorio;
GO
CREATE PROCEDURE dbo.sp_AgregarConsultorio
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.CONSULTORIOS (Nombre) VALUES (@Nombre);
END
GO

IF OBJECT_ID('dbo.sp_ModificarConsultorio', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ModificarConsultorio;
GO
CREATE PROCEDURE dbo.sp_ModificarConsultorio
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

IF OBJECT_ID('dbo.sp_EliminarLogicoConsultorio', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarLogicoConsultorio;
GO
CREATE PROCEDURE dbo.sp_EliminarLogicoConsultorio
    @IdConsultorio INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.CONSULTORIOS SET Activo = 0 WHERE IdConsultorio = @IdConsultorio;
END
GO

-- MEDICOS
IF OBJECT_ID('dbo.sp_ListarMedicosActivos', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarMedicosActivos;
GO
CREATE PROCEDURE dbo.sp_ListarMedicosActivos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        P.IdPersona, P.Dni, P.Nombre, P.Apellido, P.Email, P.Telefono, 
        M.Matricula, M.IdUsuario
    FROM dbo.Personas P
    INNER JOIN dbo.Medicos M ON P.IdPersona = M.IdPersona
    WHERE P.Activo = 1;
END
GO

IF OBJECT_ID('dbo.sp_AgregarMedico', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarMedico;
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

IF OBJECT_ID('dbo.sp_ModificarMedico', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ModificarMedico;
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

IF OBJECT_ID('dbo.sp_EliminarLogicoMedico', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarLogicoMedico;
GO
CREATE PROCEDURE dbo.sp_EliminarLogicoMedico
    @IdPersona INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Personas SET Activo = 0 WHERE IdPersona = @IdPersona;
END
GO

-- RECEPCIONISTAS
IF OBJECT_ID('dbo.sp_ListarRecepcionistas', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarRecepcionistas;
GO
CREATE PROCEDURE dbo.sp_ListarRecepcionistas
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

IF OBJECT_ID('dbo.sp_AgregarRecepcionista', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarRecepcionista;
GO
CREATE PROCEDURE dbo.sp_AgregarRecepcionista
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
        
        INSERT INTO Usuarios (NombreUsuario, Clave, IdRol, IdPersona)
        VALUES (@NombreUsuario, @Clave, 2, @IdPersona);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ModificarRecepcionista', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ModificarRecepcionista;
GO
CREATE PROCEDURE dbo.sp_ModificarRecepcionista
    @IdUsuario INT,
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
    @Mail VARCHAR(255) = NULL, @Telefono VARCHAR(50) = NULL,
    @NuevaClave VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdPersona INT = (SELECT IdPersona FROM Usuarios WHERE IdUsuario = @IdUsuario);
        
        UPDATE Personas
        SET Nombre = @Nombre, Apellido = @Apellido, Dni = @DNI, Email = @Mail, Telefono = @Telefono
        WHERE IdPersona = @IdPersona;
        
        IF @NuevaClave IS NOT NULL AND LEN(@NuevaClave) > 0
            UPDATE Usuarios SET Clave = @NuevaClave WHERE IdUsuario = @IdUsuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_EliminarRecepcionista', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarRecepcionista;
GO
CREATE PROCEDURE dbo.sp_EliminarRecepcionista
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Usuarios SET Activo = 0 WHERE IdUsuario = @IdUsuario;
END
GO

-- ADMINISTRADORES
IF OBJECT_ID('dbo.sp_ListarAdministradores', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarAdministradores;
GO
CREATE PROCEDURE dbo.sp_ListarAdministradores
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

IF OBJECT_ID('dbo.sp_AgregarAdministrador', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarAdministrador;
GO
CREATE PROCEDURE dbo.sp_AgregarAdministrador
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
        IF EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = @NombreUsuario)
            THROW 50001, 'El nombre de usuario ya está en uso.', 1;

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Email, Telefono)
        VALUES (@Nombre, @Apellido, @DNI, @Mail, @Telefono);

        DECLARE @NuevoIdPersona INT = SCOPE_IDENTITY();

        INSERT INTO dbo.Usuarios (NombreUsuario, Clave, IdRol, IdPersona, Activo)
        VALUES (@NombreUsuario, @Clave, 1, @NuevoIdPersona, 1);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW; 
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ModificarAdministrador', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ModificarAdministrador;
GO
CREATE PROCEDURE dbo.sp_ModificarAdministrador
    @IdUsuario INT,
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
    @Mail VARCHAR(255) = NULL, @Telefono VARCHAR(50) = NULL,
    @NuevaClave VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdPersona INT = (SELECT IdPersona FROM dbo.Usuarios WHERE IdUsuario = @IdUsuario);

        UPDATE dbo.Personas
        SET Nombre = @Nombre,
            Apellido = @Apellido,
            Dni = @DNI,
            Email = @Mail,
            Telefono = @Telefono
        WHERE IdPersona = @IdPersona;

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

IF OBJECT_ID('dbo.sp_EliminarAdministrador', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarAdministrador;
GO
CREATE PROCEDURE dbo.sp_EliminarAdministrador
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Usuarios
    SET Activo = 0
    WHERE IdUsuario = @IdUsuario;
END
GO

-- ROLES
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

IF OBJECT_ID('dbo.sp_CambiarRolUsuario', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_CambiarRolUsuario;
GO
CREATE PROCEDURE dbo.sp_CambiarRolUsuario
    @IdUsuario INT,
    @IdNuevoRol INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM dbo.Roles WHERE IdRol = @IdNuevoRol)
    BEGIN
        RAISERROR('El rol de destino no existe.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE IdUsuario = @IdUsuario)
    BEGIN
        RAISERROR('El usuario no existe.', 16, 1);
        RETURN;
    END
    UPDATE dbo.Usuarios
    SET IdRol = @IdNuevoRol
    WHERE IdUsuario = @IdUsuario;
END
GO

-- COBERTURAS
IF OBJECT_ID('dbo.sp_ListarTodasCoberturas', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarTodasCoberturas;
GO
CREATE PROCEDURE dbo.sp_ListarTodasCoberturas
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idCoberturaMedica, Nombre, Activo
    FROM dbo.COBERTURA
    ORDER BY Nombre;
END
GO

IF OBJECT_ID('dbo.sp_AgregarCobertura', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarCobertura;
GO
CREATE PROCEDURE dbo.sp_AgregarCobertura
    @Nombre VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.COBERTURA (Nombre, Activo)
    VALUES (@Nombre, 1);
END
GO

IF OBJECT_ID('dbo.sp_ModificarCobertura', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ModificarCobertura;
GO
CREATE PROCEDURE dbo.sp_ModificarCobertura
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

IF OBJECT_ID('dbo.sp_EliminarLogicoCobertura', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarLogicoCobertura;
GO
CREATE PROCEDURE dbo.sp_EliminarLogicoCobertura
    @IdCoberturaMedica INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.COBERTURA
    SET Activo = 0
    WHERE idCoberturaMedica = @IdCoberturaMedica;
END
GO

-- turno trabajo 

IF OBJECT_ID('dbo.TurnosTrabajo', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TurnosTrabajo (
        IdTurnoTrabajo INT IDENTITY(1,1) NOT NULL,
        IdMedico INT NOT NULL,
        DiaSemana TINYINT NOT NULL,
        HoraEntrada TIME NOT NULL,
        HoraSalida TIME NOT NULL,
        Activo BIT NOT NULL DEFAULT 1,
        CONSTRAINT PK_TurnosTrabajo PRIMARY KEY CLUSTERED (IdTurnoTrabajo ASC),
        CONSTRAINT FK_TurnosTrabajo_Medicos FOREIGN KEY (IdMedico) REFERENCES dbo.Medicos(IdPersona)
    );
END
GO

IF OBJECT_ID('dbo.sp_AgregarTurnoTrabajo', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AgregarTurnoTrabajo;
GO

CREATE PROCEDURE dbo.sp_AgregarTurnoTrabajo
    @IdMedico INT,
    @DiaSemana TINYINT,
    @HoraEntrada TIME,
    @HoraSalida TIME
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO TurnosTrabajo (IdMedico, DiaSemana, HoraEntrada, HoraSalida, Activo)
    VALUES (@IdMedico, @DiaSemana, @HoraEntrada, @HoraSalida, 1);
END
GO

IF OBJECT_ID('dbo.sp_ObtenerTurnosTrabajoPorMedico', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ObtenerTurnosTrabajoPorMedico;
GO

CREATE PROCEDURE dbo.sp_ObtenerTurnosTrabajoPorMedico
    @IdMedico INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IdTurnoTrabajo, 
        IdMedico, 
        DiaSemana, 
        HoraEntrada, 
        HoraSalida, 
        Activo
    FROM TurnosTrabajo
    WHERE IdMedico = @IdMedico AND Activo = 1
    ORDER BY DiaSemana, HoraEntrada;
END
GO

IF OBJECT_ID('dbo.sp_EliminarTurnoTrabajo', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_EliminarTurnoTrabajo;
GO

CREATE PROCEDURE dbo.sp_EliminarTurnoTrabajo
    @IdTurnoTrabajo INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE TurnosTrabajo
    SET Activo = 0
    WHERE IdTurnoTrabajo = @IdTurnoTrabajo;
END
GO

PRINT 'Script de TurnosTrabajo ejecutado correctamente'
GO

