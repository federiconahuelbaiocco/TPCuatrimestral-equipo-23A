EXEC sp_ListarPacientesActivos

use ClinicaDB

EXEC dbo.sp_InsertarPaciente
    @Nombre = 'Pepe',
    @Apellido = 'Argento',
    @DNI = '1111',
    @Mail = 'pa@email.com',
    @Telefono = '22222222',
    @Calle = 'Av. Siempremuerta',
    @Altura = '1234',
    @Piso = NULL,
    @Departamento = NULL,
    @Localidad = 'Springfield',
    @Provincia = 'Buenos Aires',
    @CodigoPostal = '1234',
    @FechaNacimiento = '1994-11-20',
    @idCobertura = 1;  

SELECT * FROM PERSONAS;
SELECT * FROM PACIENTES;
SELECT * FROM DOMICILIOS;

SELECT TOP 10 IdPersona, Nombre, Apellido, Activo FROM PERSONAS;

