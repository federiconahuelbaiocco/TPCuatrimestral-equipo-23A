USE ClinicaDB;
GO

-- ESPECIALIDADES
CREATE OR ALTER PROCEDURE dbo.sp_ListarEspecialidades
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdEspecialidad, Descripcion, Activo FROM dbo.Especialidades;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_AgregarEspecialidad
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

CREATE OR ALTER PROCEDURE dbo.sp_EliminarLogicoEspecialidad
    @IdEspecialidad INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Especialidades SET Activo = 0 WHERE IdEspecialidad = @IdEspecialidad;
END
GO

-- CONSULTORIOS
CREATE OR ALTER PROCEDURE dbo.sp_ListarConsultorios
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdConsultorio, Nombre, Activo FROM dbo.CONSULTORIOS;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_AgregarConsultorio
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.CONSULTORIOS (Nombre) VALUES (@Nombre);
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ModificarConsultorio
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

CREATE OR ALTER PROCEDURE dbo.sp_EliminarLogicoConsultorio
    @IdConsultorio INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.CONSULTORIOS SET Activo = 0 WHERE IdConsultorio = @IdConsultorio;
END
GO

-- MEDICOS
CREATE OR ALTER PROCEDURE dbo.sp_ListarMedicosActivos
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

CREATE OR ALTER PROCEDURE dbo.sp_AgregarMedico
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado',
    @FechaNacimiento DATE = NULL,
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

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Sexo, FechaNacimiento, Email, Telefono, Activo)
        VALUES (@Nombre, @Apellido, @DNI, @Sexo, @FechaNacimiento, @Mail, @Telefono, 1);

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

CREATE OR ALTER PROCEDURE dbo.sp_AgregarMedicoConUsuario
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado',
    @FechaNacimiento DATE = NULL,
    @Matricula VARCHAR(50),
    @Mail VARCHAR(255) = NULL,
    @Telefono VARCHAR(50) = NULL,
    @NombreUsuario VARCHAR(50),
    @Clave VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = @NombreUsuario)
            THROW 50001, 'El nombre de usuario ya está en uso.', 1;

        IF EXISTS (SELECT 1 FROM PERSONAS WHERE DNI = @DNI)
            THROW 50003, 'El DNI ya existe.', 1;

        DECLARE @IdRolMedico INT;
        SELECT @IdRolMedico = IdRol FROM dbo.Roles WHERE Nombre = 'Medico';

        IF @IdRolMedico IS NULL
            THROW 50002, 'El rol "Medico" no existe en la base de datos.', 1;

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Sexo, FechaNacimiento, Email, Telefono, Activo)
        VALUES (@Nombre, @Apellido, @DNI, @Sexo, @FechaNacimiento, @Mail, @Telefono, 1);

        DECLARE @NuevoIdPersona INT = SCOPE_IDENTITY();

        INSERT INTO dbo.Usuarios (NombreUsuario, Clave, IdRol, IdPersona, Activo)
        VALUES (@NombreUsuario, @Clave, @IdRolMedico, @NuevoIdPersona, 1);

        DECLARE @NuevoIdUsuario INT = SCOPE_IDENTITY();

        INSERT INTO dbo.Medicos (IdPersona, Matricula, IdUsuario)
        VALUES (@NuevoIdPersona, @Matricula, @NuevoIdUsuario);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW; 
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ModificarMedico
    @IdPersona INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado',
    @FechaNacimiento DATE = NULL,
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
            Sexo = @Sexo,
            FechaNacimiento = @FechaNacimiento,
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

CREATE OR ALTER PROCEDURE dbo.sp_EliminarLogicoMedico
    @IdPersona INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Personas SET Activo = 0 WHERE IdPersona = @IdPersona;
END
GO

-- RECEPCIONISTAS
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

CREATE OR ALTER PROCEDURE dbo.sp_AgregarRecepcionista
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado', @FechaNacimiento DATE = NULL,
    @Mail VARCHAR(255), @Telefono VARCHAR(50),
    @NombreUsuario VARCHAR(50), @Clave VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdRolRecep INT;
        SELECT @IdRolRecep = IdRol FROM dbo.Roles WHERE Nombre = 'Recepcionista';

        IF @IdRolRecep IS NULL
            THROW 50002, 'El rol "Recepcionista" no existe en la base de datos.', 1;

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Sexo, FechaNacimiento, Email, Telefono, Activo)
        VALUES (@Nombre, @Apellido, @DNI, @Sexo, @FechaNacimiento, @Mail, @Telefono, 1);
        
        DECLARE @IdPersona INT = SCOPE_IDENTITY();
        
        INSERT INTO Usuarios (NombreUsuario, Clave, IdRol, IdPersona)
        VALUES (@NombreUsuario, @Clave, @IdRolRecep, @IdPersona);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; 
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ModificarRecepcionista
    @IdUsuario INT,
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado', @FechaNacimiento DATE = NULL,
    @Mail VARCHAR(255) = NULL, @Telefono VARCHAR(50) = NULL,
    @NuevaClave VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdPersona INT;
        SELECT @IdPersona = IdPersona FROM Usuarios WHERE IdUsuario = @IdUsuario;

        UPDATE dbo.Personas
        SET Nombre = @Nombre, Apellido = @Apellido, Dni = @DNI,
            Sexo = @Sexo, FechaNacimiento = @FechaNacimiento,
            Email = @Mail, Telefono = @Telefono
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

CREATE OR ALTER PROCEDURE dbo.sp_EliminarRecepcionista
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Usuarios SET Activo = 0 WHERE IdUsuario = @IdUsuario;
END
GO

-- ADMINISTRADORES
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

CREATE OR ALTER PROCEDURE dbo.sp_AgregarAdministrador
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado',
    @FechaNacimiento DATE = NULL,
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

        DECLARE @IdRolAdmin INT;
        SELECT @IdRolAdmin = IdRol FROM dbo.Roles WHERE Nombre = 'Administrador';
        
        IF @IdRolAdmin IS NULL
            THROW 50002, 'El rol "Administrador" no existe en la base de datos.', 1;

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Sexo, FechaNacimiento, Email, Telefono, Activo)
        VALUES (@Nombre, @Apellido, @DNI, @Sexo, @FechaNacimiento, @Mail, @Telefono, 1);

        DECLARE @NuevoIdPersona INT = SCOPE_IDENTITY();

        INSERT INTO dbo.Usuarios (NombreUsuario, Clave, IdRol, IdPersona, Activo)
        VALUES (@NombreUsuario, @Clave, @IdRolAdmin, @NuevoIdPersona, 1);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW; 
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ModificarAdministrador
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

-- ROLES
CREATE OR ALTER PROCEDURE dbo.sp_ListarRoles
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

-- TURNOS DE TRABAJO (HORARIOS MEDICOS)
CREATE OR ALTER PROCEDURE dbo.sp_AgregarTurnoTrabajo
    @IdMedico INT,
    @DiaSemana TINYINT,
    @HoraEntrada TIME,
    @HoraSalida TIME
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @HoraEntrada >= @HoraSalida
        BEGIN
            RAISERROR('La hora de salida debe ser posterior a la hora de entrada.', 16, 1);
            RETURN;
        END

        IF EXISTS (
            SELECT 1 FROM TurnosTrabajo 
            WHERE IdMedico = @IdMedico 
            AND DiaSemana = @DiaSemana
            AND Activo = 1
            AND (
                (@HoraEntrada >= HoraEntrada AND @HoraEntrada < HoraSalida) OR
                (@HoraSalida > HoraEntrada AND @HoraSalida <= HoraSalida) OR
                (@HoraEntrada <= HoraEntrada AND @HoraSalida >= HoraSalida)
            )
        )
        BEGIN
            RAISERROR('El médico ya posee un horario asignado que se superpone con este rango.', 16, 1);
            RETURN;
        END

        INSERT INTO TurnosTrabajo (IdMedico, DiaSemana, HoraEntrada, HoraSalida, Activo)
        VALUES (@IdMedico, @DiaSemana, @HoraEntrada, @HoraSalida, 1);

        SELECT SCOPE_IDENTITY() as IdGenerado;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ObtenerTurnosTrabajoPorMedico
    @IdMedico INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        TT.IdTurnoTrabajo,
        TT.IdMedico,
        TT.DiaSemana,
        CASE TT.DiaSemana
            WHEN 1 THEN 'Domingo'
            WHEN 2 THEN 'Lunes'
            WHEN 3 THEN 'Martes'
            WHEN 4 THEN 'Miércoles'
            WHEN 5 THEN 'Jueves'
            WHEN 6 THEN 'Viernes'
            WHEN 7 THEN 'Sábado'
        END AS NombreDia,
        CONVERT(VARCHAR(5), TT.HoraEntrada, 108) AS HoraEntrada,
        CONVERT(VARCHAR(5), TT.HoraSalida, 108) AS HoraSalida,
        TT.Activo
    FROM TurnosTrabajo TT
    WHERE TT.IdMedico = @IdMedico AND TT.Activo = 1
    ORDER BY TT.DiaSemana, TT.HoraEntrada;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_EliminarTurnoTrabajo
    @IdTurnoTrabajo INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        UPDATE TurnosTrabajo
        SET Activo = 0
        WHERE IdTurnoTrabajo = @IdTurnoTrabajo;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO

-- LOGIN
CREATE OR ALTER PROCEDURE dbo.sp_ValidarUsuario
    @NombreUsuario VARCHAR(50),
    @Clave VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        U.IdUsuario,
        U.NombreUsuario,
        U.IdRol,
        R.Nombre AS NombreRol,
        U.IdPersona,
        P.Nombre,
        P.Apellido,
        P.Email,
        P.Dni,
        P.Telefono,
        P.Sexo,
        M.Matricula
    FROM Usuarios U
    INNER JOIN Roles R ON U.IdRol = R.IdRol
    INNER JOIN Personas P ON U.IdPersona = P.IdPersona
    LEFT JOIN Medicos M ON U.IdPersona = M.IdPersona
    WHERE U.NombreUsuario = @NombreUsuario 
        AND U.Clave = @Clave 
        AND U.Activo = 1 
        AND P.Activo = 1;
END
GO

PRINT 'Script 2: SPs Administrador ejecutados correctamente'
GO