use ClinicaDB
go



CREATE PROCEDURE sp_ListarPacientesActivos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
            P.IdPersona, P.Dni, P.Nombre, P.Apellido, P.Email, P.Telefono, P.Activo,P.IdDomicilio,
            PAC.FechaNacimiento,
            C.idCoberturaMedica, C.Nombre as Cobertura,
            D.Calle, D.Altura,D.Piso,D.Departamento,D.CodigoPostal, D.Localidad, D.Provincia
        FROM 
            Personas P
        INNER JOIN 
            PACIENTES PAC ON P.IdPersona = PAC.IdPersona
    
        LEFT JOIN 
            Domicilios D ON P.IdDomicilio = D.IdDomicilio

        LEFT JOIN
            COBERTURA C ON PAC.idCobertura = C.idCoberturaMedica
        WHERE 
            P.Activo = 1
        ORDER BY 
        P.Apellido, P.Nombre;  

    END
    GO