use ClinicaDB
go

CREATE PROCEDURE ListarMedicosPorEspecialidad
    @IdEspecialidad INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        M.IdPersona AS IdMedico,                          -- seguimos usando IdPersona como PK
        (P.Nombre + ' ' + P.Apellido) AS NombreCompleto
    FROM Medicos M
    INNER JOIN Medico_Especialidad ME
        ON ME.IdMedico = M.IdPersona
    INNER JOIN Personas P
        ON P.IdPersona = M.IdPersona
    WHERE 
        ME.IdEspecialidad = @IdEspecialidad
      
    ORDER BY P.Apellido, P.Nombre;
END
go

CREATE OR ALTER PROCEDURE sp_ListarMedicosConEspecialidades
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        M.IdPersona AS IdMedico,
        P.Nombre,
        P.Apellido,     
        E.Descripcion AS Especialidad
    FROM Medicos M
    INNER JOIN Personas P
        ON P.IdPersona = M.IdPersona
    INNER JOIN Medico_Especialidad ME
        ON ME.IdMedico = M.IdPersona
    INNER JOIN Especialidades E
        ON E.IdEspecialidad = ME.IdEspecialidad
   
    ORDER BY P.Apellido, P.Nombre, E.Descripcion;
END
GO

EXEC sp_ListarMedicosConEspecialidades;
