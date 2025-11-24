USE ClinicaDB;
GO

IF OBJECT_ID('dbo.sp_ListarEspecialidades', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarEspecialidades;
GO
CREATE PROCEDURE dbo.sp_ListarEspecialidades
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdEspecialidad, Descripcion, Activo FROM dbo.Especialidades;
END
GO

IF OBJECT_ID('dbo.sp_AgregarEspecialidad', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_AgregarEspecialidad;
GO
CREATE PROCEDURE dbo.sp_AgregarEspecialidad
    @Descripcion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Especialidades (Descripcion) VALUES (@Descripcion);
END
GO

IF OBJECT_ID('dbo.sp_ModificarEspecialidad', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ModificarEspecialidad;
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

IF OBJECT_ID('dbo.sp_EliminarLogicoEspecialidad', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_EliminarLogicoEspecialidad;
GO
CREATE PROCEDURE dbo.sp_EliminarLogicoEspecialidad
    @IdEspecialidad INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Especialidades SET Activo = 0 WHERE IdEspecialidad = @IdEspecialidad;
END
GO

IF OBJECT_ID('dbo.sp_EliminarEspecialidadesDeMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_EliminarEspecialidadesDeMedico;
GO
CREATE PROCEDURE dbo.sp_EliminarEspecialidadesDeMedico
    @IdMedico INT
AS
BEGIN
    DELETE FROM Medico_Especialidad WHERE IdMedico = @IdMedico;
END
GO

IF OBJECT_ID('dbo.sp_AgregarEspecialidadAMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_AgregarEspecialidadAMedico;
GO
CREATE PROCEDURE dbo.sp_AgregarEspecialidadAMedico
    @IdMedico INT,
    @IdEspecialidad INT
AS
BEGIN
    INSERT INTO Medico_Especialidad (IdMedico, IdEspecialidad) VALUES (@IdMedico, @IdEspecialidad);
END
GO

IF OBJECT_ID('dbo.sp_ListarEspecialidadesPorMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarEspecialidadesPorMedico;
GO
CREATE PROCEDURE sp_ListarEspecialidadesPorMedico
    @IdMedico INT
AS
BEGIN
    SELECT E.IdEspecialidad, E.Descripcion
    FROM Medico_Especialidad ME
    INNER JOIN Especialidades E ON ME.IdEspecialidad = E.IdEspecialidad
    WHERE ME.IdMedico = @IdMedico
END
GO

IF OBJECT_ID('dbo.sp_ListarConsultorios', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarConsultorios;
GO
CREATE PROCEDURE dbo.sp_ListarConsultorios
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdConsultorio, Nombre, Activo FROM dbo.CONSULTORIOS;
END
GO

IF OBJECT_ID('dbo.sp_AgregarConsultorio', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_AgregarConsultorio;
GO
CREATE PROCEDURE dbo.sp_AgregarConsultorio
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.CONSULTORIOS (Nombre) VALUES (@Nombre);
END
GO

IF OBJECT_ID('dbo.sp_ModificarMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ModificarMedico;
GO
CREATE PROCEDURE dbo.sp_ModificarMedico
    @IdPersona INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado',
    @FechaNacimiento DATE = NULL,
    @Matricula VARCHAR(50),
    @Mail VARCHAR(255) = NULL,
    @Telefono VARCHAR(50) = NULL,
    @Activo BIT,
    @Calle VARCHAR(200) = NULL,
    @Altura VARCHAR(20) = NULL,
    @Piso VARCHAR(10) = NULL,
    @Departamento VARCHAR(10) = NULL,
    @Localidad VARCHAR(100) = NULL,
    @Provincia VARCHAR(100) = NULL,
    @CodigoPostal VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdDomicilio INT;
        SELECT @IdDomicilio = IdDomicilio FROM Personas WHERE IdPersona = @IdPersona;

        IF @IdDomicilio IS NOT NULL
        BEGIN
            UPDATE Domicilios
            SET Calle = @Calle, Altura = @Altura, Piso = @Piso, 
                Departamento = @Departamento, Localidad = @Localidad, 
                Provincia = @Provincia, CodigoPostal = @CodigoPostal
            WHERE IdDomicilio = @IdDomicilio;
        END
        ELSE IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO Domicilios (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @IdDomicilio = SCOPE_IDENTITY();
        END

        UPDATE dbo.Personas
        SET 
            Nombre = @Nombre,
            Apellido = @Apellido,
            Dni = @DNI,
            Sexo = @Sexo,
            FechaNacimiento = @FechaNacimiento,
            Email = @Mail,
            Telefono = @Telefono,
            IdDomicilio = @IdDomicilio,
            Activo = @Activo
        WHERE 
            IdPersona = @IdPersona;

        UPDATE dbo.Medicos
        SET Matricula = @Matricula
        WHERE IdPersona = @IdPersona;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ModificarConsultorio', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ModificarConsultorio;
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

IF OBJECT_ID('dbo.sp_EliminarLogicoConsultorio', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_EliminarLogicoConsultorio;
GO
CREATE PROCEDURE dbo.sp_EliminarLogicoConsultorio
    @IdConsultorio INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.CONSULTORIOS SET Activo = 0 WHERE IdConsultorio = @IdConsultorio;
END
GO

IF OBJECT_ID('dbo.sp_ListarMedicosActivos', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarMedicosActivos;
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

IF OBJECT_ID('dbo.sp_AgregarMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_AgregarMedico;
GO
CREATE PROCEDURE dbo.sp_AgregarMedico
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado',
    @FechaNacimiento DATE = NULL,
    @Matricula VARCHAR(50),
    @Mail VARCHAR(255) = NULL,
    @Telefono VARCHAR(50) = NULL,
    @Calle VARCHAR(200) = NULL,
    @Altura VARCHAR(20) = NULL,
    @Piso VARCHAR(10) = NULL,
    @Departamento VARCHAR(10) = NULL,
    @Localidad VARCHAR(100) = NULL,
    @Provincia VARCHAR(100) = NULL,
    @CodigoPostal VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM PERSONAS WHERE DNI = @DNI)
        BEGIN
            RAISERROR('El DNI ya existe.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        DECLARE @IdDomicilio INT = NULL;
        IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO Domicilios (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @IdDomicilio = SCOPE_IDENTITY();
        END

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Sexo, FechaNacimiento, Email, Telefono, IdDomicilio, Activo)
        VALUES (@Nombre, @Apellido, @DNI, @Sexo, @FechaNacimiento, @Mail, @Telefono, @IdDomicilio, 1);

        DECLARE @NuevoIdPersona INT = SCOPE_IDENTITY();

        INSERT INTO dbo.Medicos (IdPersona, Matricula, IdUsuario)
        VALUES (@NuevoIdPersona, @Matricula, NULL);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; THROW; 
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_AgregarMedicoConUsuario', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_AgregarMedicoConUsuario;
GO
CREATE PROCEDURE dbo.sp_AgregarMedicoConUsuario
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado',
    @FechaNacimiento DATE = NULL,
    @Matricula VARCHAR(50),
    @Mail VARCHAR(255) = NULL,
    @Telefono VARCHAR(50) = NULL,
    @NombreUsuario VARCHAR(50),
    @Clave VARCHAR(50),
    @Calle VARCHAR(200) = NULL,
    @Altura VARCHAR(20) = NULL,
    @Piso VARCHAR(10) = NULL,
    @Departamento VARCHAR(10) = NULL,
    @Localidad VARCHAR(100) = NULL,
    @Provincia VARCHAR(100) = NULL,
    @CodigoPostal VARCHAR(20) = NULL
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
        IF @IdRolMedico IS NULL THROW 50002, 'El rol "Medico" no existe.', 1;

        DECLARE @IdDomicilio INT = NULL;
        IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO Domicilios (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @IdDomicilio = SCOPE_IDENTITY();
        END

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Sexo, FechaNacimiento, Email, Telefono, IdDomicilio, Activo)
        VALUES (@Nombre, @Apellido, @DNI, @Sexo, @FechaNacimiento, @Mail, @Telefono, @IdDomicilio, 1);

        DECLARE @NuevoIdPersona INT = SCOPE_IDENTITY();

        INSERT INTO dbo.Usuarios (NombreUsuario, Clave, IdRol, IdPersona, Activo)
        VALUES (@NombreUsuario, @Clave, @IdRolMedico, @NuevoIdPersona, 1);
        DECLARE @NuevoIdUsuario INT = SCOPE_IDENTITY();

        INSERT INTO dbo.Medicos (IdPersona, Matricula, IdUsuario)
        VALUES (@NuevoIdPersona, @Matricula, @NuevoIdUsuario);

        SELECT @NuevoIdPersona AS IdPersona;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; THROW; 
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_EliminarLogicoMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_EliminarLogicoMedico;
GO
CREATE PROCEDURE dbo.sp_EliminarLogicoMedico
    @IdPersona INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Personas SET Activo = 0 WHERE IdPersona = @IdPersona;
END
GO

IF OBJECT_ID('dbo.sp_ModificarMatriculaMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ModificarMatriculaMedico;
GO
CREATE PROCEDURE sp_ModificarMatriculaMedico
    @IdPersona INT,
    @Matricula VARCHAR(50)
AS
BEGIN
    UPDATE Medicos SET Matricula = @Matricula WHERE IdPersona = @IdPersona;
END
GO

IF OBJECT_ID('dbo.sp_ObtenerMedicoPorId', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ObtenerMedicoPorId;
GO
CREATE PROCEDURE sp_ObtenerMedicoPorId
    @IdPersona INT
AS
BEGIN
    SELECT 
        P.IdPersona, 
        P.Nombre, 
        P.Apellido, 
        P.Dni, 
        P.Sexo, 
        P.FechaNacimiento, 
        P.Email, 
        P.Telefono, 
        P.Activo, 
        P.IdDomicilio,
        M.Matricula,
        D.Calle,
        D.Altura,
        D.Piso,
        D.Departamento,
        D.Localidad,
        D.Provincia,
        D.CodigoPostal
    FROM Personas P
    INNER JOIN Medicos M ON P.IdPersona = M.IdPersona
    LEFT JOIN Domicilios D ON P.IdDomicilio = D.IdDomicilio
    WHERE P.IdPersona = @IdPersona;
END
GO

IF OBJECT_ID('dbo.sp_ListarRecepcionistas', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarRecepcionistas;
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

IF OBJECT_ID('dbo.sp_AgregarRecepcionista', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_AgregarRecepcionista;
GO
CREATE PROCEDURE dbo.sp_AgregarRecepcionista
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado', @FechaNacimiento DATE = NULL,
    @Mail VARCHAR(255), @Telefono VARCHAR(50),
    @NombreUsuario VARCHAR(50), @Clave VARCHAR(50),
    @Calle VARCHAR(200) = NULL, @Altura VARCHAR(20) = NULL, @Piso VARCHAR(10) = NULL,
    @Departamento VARCHAR(10) = NULL, @Localidad VARCHAR(100) = NULL,
    @Provincia VARCHAR(100) = NULL, @CodigoPostal VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdRolRecep INT;
        SELECT @IdRolRecep = IdRol FROM dbo.Roles WHERE Nombre = 'Recepcionista';
        IF @IdRolRecep IS NULL THROW 50002, 'El rol "Recepcionista" no existe.', 1;

        DECLARE @IdDomicilio INT = NULL;
        IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO Domicilios (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @IdDomicilio = SCOPE_IDENTITY();
        END

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Sexo, FechaNacimiento, Email, Telefono, IdDomicilio, Activo)
        VALUES (@Nombre, @Apellido, @DNI, @Sexo, @FechaNacimiento, @Mail, @Telefono, @IdDomicilio, 1);
        DECLARE @IdPersona INT = SCOPE_IDENTITY();
        
        INSERT INTO Usuarios (NombreUsuario, Clave, IdRol, IdPersona)
        VALUES (@NombreUsuario, @Clave, @IdRolRecep, @IdPersona);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ModificarRecepcionista', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ModificarRecepcionista;
GO
CREATE PROCEDURE dbo.sp_ModificarRecepcionista
    @IdUsuario INT,
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado', @FechaNacimiento DATE = NULL,
    @Mail VARCHAR(255) = NULL, @Telefono VARCHAR(50) = NULL,
    @NuevaClave VARCHAR(50) = NULL,
    @Calle VARCHAR(200) = NULL,
    @Altura VARCHAR(20) = NULL,
    @Piso VARCHAR(10) = NULL,
    @Departamento VARCHAR(10) = NULL,
    @Localidad VARCHAR(100) = NULL,
    @Provincia VARCHAR(100) = NULL,
    @CodigoPostal VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdPersona INT;
        SELECT @IdPersona = IdPersona FROM Usuarios WHERE IdUsuario = @IdUsuario;
        
        DECLARE @IdDomicilio INT;
        SELECT @IdDomicilio = IdDomicilio FROM Personas WHERE IdPersona = @IdPersona;

        IF @IdDomicilio IS NOT NULL
        BEGIN
            UPDATE Domicilios
            SET Calle = @Calle, Altura = @Altura, Piso = @Piso, 
                Departamento = @Departamento, Localidad = @Localidad, 
                Provincia = @Provincia, CodigoPostal = @CodigoPostal
            WHERE IdDomicilio = @IdDomicilio;
        END
        ELSE IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO Domicilios (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @IdDomicilio = SCOPE_IDENTITY();
        END

        UPDATE dbo.Personas
        SET Nombre = @Nombre, Apellido = @Apellido, Dni = @DNI,
            Sexo = @Sexo, FechaNacimiento = @FechaNacimiento,
            Email = @Mail, Telefono = @Telefono, IdDomicilio = @IdDomicilio
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

IF OBJECT_ID('dbo.sp_EliminarRecepcionista', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_EliminarRecepcionista;
GO
CREATE PROCEDURE dbo.sp_EliminarRecepcionista
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Usuarios SET Activo = 0 WHERE IdUsuario = @IdUsuario;
END
GO

IF OBJECT_ID('dbo.sp_ListarAdministradores', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarAdministradores;
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

IF OBJECT_ID('dbo.sp_AgregarAdministrador', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_AgregarAdministrador;
GO
CREATE PROCEDURE dbo.sp_AgregarAdministrador
    @Nombre VARCHAR(100), @Apellido VARCHAR(100), @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado', @FechaNacimiento DATE = NULL,
    @Mail VARCHAR(255), @Telefono VARCHAR(50),
    @NombreUsuario VARCHAR(50), @Clave VARCHAR(50),
    @Calle VARCHAR(200) = NULL, @Altura VARCHAR(20) = NULL, @Piso VARCHAR(10) = NULL,
    @Departamento VARCHAR(10) = NULL, @Localidad VARCHAR(100) = NULL,
    @Provincia VARCHAR(100) = NULL, @CodigoPostal VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = @NombreUsuario)
            THROW 50001, 'El nombre de usuario ya está en uso.', 1;

        DECLARE @IdRolAdmin INT;
        SELECT @IdRolAdmin = IdRol FROM dbo.Roles WHERE Nombre = 'Administrador';
        IF @IdRolAdmin IS NULL THROW 50002, 'El rol "Administrador" no existe.', 1;

        DECLARE @IdDomicilio INT = NULL;
        IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO Domicilios (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @IdDomicilio = SCOPE_IDENTITY();
        END

        INSERT INTO dbo.Personas (Nombre, Apellido, Dni, Sexo, FechaNacimiento, Email, Telefono, IdDomicilio, Activo)
        VALUES (@Nombre, @Apellido, @DNI, @Sexo, @FechaNacimiento, @Mail, @Telefono, @IdDomicilio, 1);
        DECLARE @NuevoIdPersona INT = SCOPE_IDENTITY();

        INSERT INTO dbo.Usuarios (NombreUsuario, Clave, IdRol, IdPersona, Activo)
        VALUES (@NombreUsuario, @Clave, @IdRolAdmin, @NuevoIdPersona, 1);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; THROW; 
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ModificarAdministrador', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ModificarAdministrador;
GO
CREATE PROCEDURE dbo.sp_ModificarAdministrador
    @IdUsuario INT,
    @Nombre VARCHAR(100), 
    @Apellido VARCHAR(100), 
    @DNI VARCHAR(20),
    @Sexo VARCHAR(20) = 'No especificado',
    @FechaNacimiento DATE = NULL,
    @Mail VARCHAR(255) = NULL, 
    @Telefono VARCHAR(50) = NULL,
    @NuevaClave VARCHAR(50) = NULL,
    @Calle VARCHAR(200) = NULL, 
    @Altura VARCHAR(20) = NULL, 
    @Piso VARCHAR(10) = NULL,
    @Departamento VARCHAR(10) = NULL, 
    @Localidad VARCHAR(100) = NULL,
    @Provincia VARCHAR(100) = NULL, 
    @CodigoPostal VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @IdPersona INT = (SELECT IdPersona FROM dbo.Usuarios WHERE IdUsuario = @IdUsuario);
        DECLARE @IdDomicilio INT;
        SELECT @IdDomicilio = IdDomicilio FROM Personas WHERE IdPersona = @IdPersona;

        IF @IdDomicilio IS NOT NULL
        BEGIN
            UPDATE Domicilios
            SET Calle = @Calle, Altura = @Altura, Piso = @Piso, 
                Departamento = @Departamento, Localidad = @Localidad, 
                Provincia = @Provincia, CodigoPostal = @CodigoPostal
            WHERE IdDomicilio = @IdDomicilio;
        END
        ELSE IF @Calle IS NOT NULL OR @Altura IS NOT NULL
        BEGIN
            INSERT INTO Domicilios (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal)
            VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
            SET @IdDomicilio = SCOPE_IDENTITY();
        END

        UPDATE dbo.Personas
        SET Nombre = @Nombre,
            Apellido = @Apellido,
            Dni = @DNI,
            Sexo = @Sexo,
            FechaNacimiento = @FechaNacimiento,
            Email = @Mail,
            Telefono = @Telefono,
            IdDomicilio = @IdDomicilio
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

IF OBJECT_ID('dbo.sp_EliminarAdministrador', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_EliminarAdministrador;
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

IF OBJECT_ID('dbo.sp_ListarRoles', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarRoles;
GO
CREATE PROCEDURE dbo.sp_ListarRoles
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdRol, Nombre FROM dbo.Roles;
END
GO

IF OBJECT_ID('dbo.sp_CambiarRolUsuario', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_CambiarRolUsuario;
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

IF OBJECT_ID('dbo.sp_ListarTodasCoberturas', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarTodasCoberturas;
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

IF OBJECT_ID('dbo.sp_AgregarCobertura', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_AgregarCobertura;
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

IF OBJECT_ID('dbo.sp_ModificarCobertura', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ModificarCobertura;
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

IF OBJECT_ID('dbo.sp_EliminarLogicoCobertura', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_EliminarLogicoCobertura;
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

IF OBJECT_ID('dbo.sp_AgregarTurnoTrabajo', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_AgregarTurnoTrabajo;
GO
CREATE PROCEDURE dbo.sp_AgregarTurnoTrabajo
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

IF OBJECT_ID('dbo.sp_ObtenerTurnosTrabajoPorMedico', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ObtenerTurnosTrabajoPorMedico;
GO
CREATE PROCEDURE dbo.sp_ObtenerTurnosTrabajoPorMedico
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

IF OBJECT_ID('dbo.sp_EliminarTurnoTrabajo', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_EliminarTurnoTrabajo;
GO
CREATE PROCEDURE dbo.sp_EliminarTurnoTrabajo
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

IF OBJECT_ID('dbo.sp_ValidarUsuario', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ValidarUsuario;
GO
CREATE PROCEDURE dbo.sp_ValidarUsuario
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

IF OBJECT_ID('dbo.sp_CambiarClaveUsuario', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_CambiarClaveUsuario;
GO
CREATE PROCEDURE dbo.sp_CambiarClaveUsuario
    @IdUsuario INT,
    @NuevaClave VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @NuevaClave IS NULL OR LTRIM(RTRIM(@NuevaClave)) = ''
        BEGIN
            RAISERROR('La nueva contraseña no puede estar vacía.', 16, 1);
            RETURN;
        END

        UPDATE dbo.Usuarios
        SET Clave = @NuevaClave
        WHERE IdUsuario = @IdUsuario AND Activo = 1;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No se encontró el usuario o no está activo.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Msg, 16, 1);
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_CambiarNombreUsuario', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_CambiarNombreUsuario;
GO
CREATE PROCEDURE dbo.sp_CambiarNombreUsuario
    @IdUsuario INT,
    @NuevoNombreUsuario VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @NuevoNombreUsuario IS NULL OR LTRIM(RTRIM(@NuevoNombreUsuario)) = ''
        BEGIN
            RAISERROR('El nombre de usuario no puede estar vacío.', 16, 1);
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM dbo.Usuarios WHERE NombreUsuario = @NuevoNombreUsuario AND IdUsuario <> @IdUsuario)
        BEGIN
            RAISERROR('El nombre de usuario ya está en uso por otra persona.', 16, 1);
            RETURN;
        END

        UPDATE dbo.Usuarios
        SET NombreUsuario = @NuevoNombreUsuario
        WHERE IdUsuario = @IdUsuario AND Activo = 1;
        
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No se encontró el usuario o no está activo.', 16, 1);
        END

    END TRY
    BEGIN CATCH
        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Msg, 16, 1);
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ListarUsuariosCompletos', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ListarUsuariosCompletos;
GO
CREATE PROCEDURE dbo.sp_ListarUsuariosCompletos
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        U.IdUsuario,
        U.NombreUsuario,
        R.IdRol,
        R.Nombre AS Rol,
        P.IdPersona,
        P.Nombre,
        P.Apellido,
        P.Dni,
        P.Email,
        U.Activo
    FROM dbo.Usuarios U
    INNER JOIN dbo.Roles R ON U.IdRol = R.IdRol
    INNER JOIN dbo.Personas P ON U.IdPersona = P.IdPersona
    ORDER BY U.Activo DESC, R.Nombre ASC, U.NombreUsuario ASC;
END
GO

IF OBJECT_ID('dbo.sp_ActualizarEstadoUsuario', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ActualizarEstadoUsuario;
GO
CREATE PROCEDURE dbo.sp_ActualizarEstadoUsuario
    @IdUsuario INT,
    @NuevoEstado BIT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE IdUsuario = @IdUsuario)
        BEGIN
            RAISERROR('El usuario indicado no existe.', 16, 1);
            RETURN;
        END

        UPDATE dbo.Usuarios
        SET Activo = @NuevoEstado
        WHERE IdUsuario = @IdUsuario;

    END TRY
    BEGIN CATCH
        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Msg, 16, 1);
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_ObtenerClaveUsuario', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_ObtenerClaveUsuario;
GO
CREATE PROCEDURE dbo.sp_ObtenerClaveUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Clave FROM dbo.Usuarios WHERE IdUsuario = @IdUsuario;
END
GO

USE ClinicaDB;
GO

SET IDENTITY_INSERT Personas ON;

IF NOT EXISTS (SELECT 1 FROM Personas WHERE IdPersona = 0)
BEGIN
    INSERT INTO Personas (IdPersona, Nombre, Apellido, Dni, Email, Telefono, Activo)
    VALUES (0, 'Horario', 'General', '00000000', 'sistema@clinica.com', '00000000', 1);
END

SET IDENTITY_INSERT Personas OFF;

IF NOT EXISTS (SELECT 1 FROM Medicos WHERE IdPersona = 0)
BEGIN
    INSERT INTO Medicos (IdPersona, Matricula)
    VALUES (0, 'CLINICA-GRAL');
END
GO