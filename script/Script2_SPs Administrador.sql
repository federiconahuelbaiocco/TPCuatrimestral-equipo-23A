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

CREATE PROCEDURE dbo.sp_ModificarEspecialidad
    @IdEspecialidad INT,
    @NuevaDescripcion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Especialidades SET Descripcion = @NuevaDescripcion WHERE IdEspecialidad = @IdEspecialidad;
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

CREATE PROCEDURE dbo.sp_ModificarConsultorio
    @IdConsultorio INT,
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.CONSULTORIOS SET Nombre = @Nombre WHERE IdConsultorio = @IdConsultorio;
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
CREATE PROCEDURE dbo.sp_ListarMedicosActivos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT P.IdPersona, P.Dni, P.Nombre, P.Apellido, P.Email, P.Telefono, M.Matricula
    FROM dbo.Personas P
    INNER JOIN dbo.Medicos M ON P.IdPersona = M.IdPersona
    WHERE P.Activo = 1;
END
GO