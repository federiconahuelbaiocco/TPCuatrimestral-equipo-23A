USE ClinicaDB;
GO

SET XACT_ABORT ON;

BEGIN TRANSACTION;
BEGIN TRY

    IF NOT EXISTS (SELECT 1 FROM dbo.Roles)
        INSERT INTO dbo.Roles (Nombre) VALUES ('Administrador'), ('Recepcionista'), ('Medico');
        
    IF NOT EXISTS (SELECT 1 FROM dbo.COBERTURA)
        INSERT INTO dbo.COBERTURA (Nombre) VALUES ('Particular'), ('OSDE'), ('Galeno'), ('PAMI');
    
    IF NOT EXISTS (SELECT 1 FROM dbo.Especialidades)
        INSERT INTO dbo.Especialidades (Descripcion) VALUES ('Clínica Médica'), ('Pediatría'), ('Cardiología'), ('Dermatología'), ('Ginecología'), ('Traumatología');

    DECLARE @IdOSDE INT = (SELECT idCoberturaMedica FROM COBERTURA WHERE Nombre = 'OSDE');
    DECLARE @IdGaleno INT = (SELECT idCoberturaMedica FROM COBERTURA WHERE Nombre = 'Galeno');
    DECLARE @IdPAMI INT = (SELECT idCoberturaMedica FROM COBERTURA WHERE Nombre = 'PAMI');
    DECLARE @IdParticular INT = (SELECT idCoberturaMedica FROM COBERTURA WHERE Nombre = 'Particular');

    IF NOT EXISTS (SELECT 1 FROM CONSULTORIOS WHERE Nombre = 'Consultorio 101')
        EXEC dbo.sp_AgregarConsultorio @Nombre = 'Consultorio 101';
    IF NOT EXISTS (SELECT 1 FROM CONSULTORIOS WHERE Nombre = 'Consultorio 102')
        EXEC dbo.sp_AgregarConsultorio @Nombre = 'Consultorio 102';
    IF NOT EXISTS (SELECT 1 FROM CONSULTORIOS WHERE Nombre = 'Consultorio 201')
        EXEC dbo.sp_AgregarConsultorio @Nombre = 'Consultorio 201';
    IF NOT EXISTS (SELECT 1 FROM CONSULTORIOS WHERE Nombre = 'Sala de Rayos X')
        EXEC dbo.sp_AgregarConsultorio @Nombre = 'Sala de Rayos X';
    IF NOT EXISTS (SELECT 1 FROM CONSULTORIOS WHERE Nombre = 'Laboratorio')
        EXEC dbo.sp_AgregarConsultorio @Nombre = 'Laboratorio';

    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin_gonzalez')
        EXEC dbo.sp_AgregarAdministrador 'Carlos', 'González', '20111222', 'Masculino', NULL, 'cgonzalez@clinica.com', '1155550001', 'admin_gonzalez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin_rodriguez')
        EXEC dbo.sp_AgregarAdministrador 'Ana', 'Rodríguez', '21222333', 'Femenino', NULL, 'arodriguez@clinica.com', '1155550002', 'admin_rodriguez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin_lopez')
        EXEC dbo.sp_AgregarAdministrador 'Luis', 'López', '22333444', 'Masculino', NULL, 'llopez@clinica.com', '1155550003', 'admin_lopez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin_martinez')
        EXEC dbo.sp_AgregarAdministrador 'Maria', 'Martínez', '23444555', 'Femenino', NULL, 'mmartinez@clinica.com', '1155550004', 'admin_martinez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin_sanchez')
        EXEC dbo.sp_AgregarAdministrador 'Javier', 'Sánchez', '24555666', 'Masculino', NULL, 'jsanchez@clinica.com', '1155550005', 'admin_sanchez', 'clave123';

    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_diaz')
        EXEC dbo.sp_AgregarRecepcionista 'Lucía', 'Díaz', '30111222', 'Femenino', NULL, 'ldiaz@clinica.com', '1166660001', 'recep_diaz', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_perez')
        EXEC dbo.sp_AgregarRecepcionista 'Miguel', 'Pérez', '31222333', 'Masculino', NULL, 'mperez@clinica.com', '1166660002', 'recep_perez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_gomez')
        EXEC dbo.sp_AgregarRecepcionista 'Elena', 'Gómez', '32333444', 'Femenino', NULL, 'egomez@clinica.com', '1166660003', 'recep_gomez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_fernandez')
        EXEC dbo.sp_AgregarRecepcionista 'David', 'Fernández', '33444555', 'Masculino', NULL, 'dfernandez@clinica.com', '1166660004', 'recep_fernandez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_moreno')
        EXEC dbo.sp_AgregarRecepcionista 'Sofía', 'Moreno', '34555666', 'Femenino', NULL, 'smoreno@clinica.com', '1166660005', 'recep_moreno', 'clave123';

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '40111222')
        EXEC dbo.sp_InsertarPaciente 'Roberto', 'García', '40111222', 'Masculino', 'rgarcia@email.com', '1177770001', 'Calle Falsa', '123', NULL, NULL, 'Springfield', 'Buenos Aires', '1610', '1980-05-10', @IdOSDE;
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '41222333')
        EXEC dbo.sp_InsertarPaciente 'Carmen', 'Ruiz', '41222333', 'Femenino', 'cruiz@email.com', '1177770002', 'Av. Rivadavia', '2030', '1A', NULL, 'CABA', 'CABA', '1033', '1995-11-20', @IdGaleno;
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '42333444')
        EXEC dbo.sp_InsertarPaciente 'Pablo', 'Alonso', '42333444', 'Masculino', 'palonso@email.com', '1177770003', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2001-01-15', @IdParticular;
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '43444555')
        EXEC dbo.sp_InsertarPaciente 'Isabel', 'Gutiérrez', '43444555', 'Femenino', 'igutierrez@email.com', '1177770004', 'Calle Sol', '800', NULL, NULL, 'Quilmes', 'Buenos Aires', '1878', '1988-07-30', @IdPAMI;
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '44555666')
        EXEC dbo.sp_InsertarPaciente 'Marcos', 'Navarro', '44555666', 'Masculino', 'mnavarro@email.com', '1177770005', 'Av. Corrientes', '1500', '8B', NULL, 'CABA', 'CABA', '1042', '1999-03-05', @IdOSDE;

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '25111222')
        EXEC dbo.sp_AgregarMedicoConUsuario 'Laura', 'Torres', '25111222', 'Femenino', NULL, 'MN1001', 'ltorres@clinica.com', '1188880001', 'ltorres', 'clave123';
    
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '26222333')
        EXEC dbo.sp_AgregarMedicoConUsuario 'Diego', 'Ramírez', '26222333', 'Masculino', NULL, 'MN1002', 'dramirez@clinica.com', '1188880002', 'dramirez', 'clave123';

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '27333444')
        EXEC dbo.sp_AgregarMedicoConUsuario 'Valeria', 'Castro', '27333444', 'Femenino', NULL, 'MN1003', 'vcastro@clinica.com', '1188880003', 'vcastro', 'clave123';

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '28444555')
        EXEC dbo.sp_AgregarMedicoConUsuario 'Jorge', 'Ortega', '28444555', 'Masculino', NULL, 'MN1004', 'jortega@clinica.com', '1188880004', 'jortega', 'clave123';

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '29555666')
        EXEC dbo.sp_AgregarMedicoConUsuario 'Mariana', 'Silva', '29555666', 'Femenino', NULL, 'MN1005', 'msilva@clinica.com', '1188880005', 'msilva', 'clave123';

    DECLARE @IdPersonaLaura INT = (SELECT IdPersona FROM Personas WHERE Dni = '25111222');
    DECLARE @IdPaciente1 INT = (SELECT IdPersona FROM Personas WHERE Dni = '40111222');
    DECLARE @IdPaciente2 INT = (SELECT IdPersona FROM Personas WHERE Dni = '41222333');
    DECLARE @IdPaciente3 INT = (SELECT IdPersona FROM Personas WHERE Dni = '42333444');

    IF @IdPersonaLaura IS NOT NULL AND @IdPaciente1 IS NOT NULL
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Turnos WHERE IdMedico = @IdPersonaLaura AND CAST(FechaHora AS DATE) = CAST(GETDATE() AS DATE))
        BEGIN
            DECLARE @FechaBase DATETIME = CAST(CAST(GETDATE() AS DATE) AS DATETIME);
            
            INSERT INTO Turnos (IdPaciente, IdMedico, FechaHora, MotivoConsulta, IdEstadoTurno, Observaciones, Activo)
            VALUES 
                (@IdPaciente1, @IdPersonaLaura, DATEADD(HOUR, 9, @FechaBase), 'Control general', 1, 'Primera visita del año', 1),
                (@IdPaciente2, @IdPersonaLaura, DATEADD(MINUTE, 30, DATEADD(HOUR, 10, @FechaBase)), 'Primera consulta', 1, 'Paciente nuevo', 1),
                (@IdPaciente3, @IdPersonaLaura, DATEADD(HOUR, 14, @FechaBase), 'Seguimiento', 1, 'Continuar tratamiento', 1);
            
            PRINT 'Turnos de prueba creados para Laura Torres';
        END
    END

    COMMIT TRANSACTION;
    PRINT '--- Script de inserción de datos completado exitosamente ---';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END
    
    PRINT 'Error durante la inserción de datos. Se intentó revertir la transacción.';
    
    DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@Msg, 16, 1);
END CATCH
GO

PRINT '--- Verificación de Datos ---';
SELECT 'Especialidades' AS Tabla, COUNT(*) AS Total FROM Especialidades;
SELECT 'Consultorios' AS Tabla, COUNT(*) AS Total FROM CONSULTORIOS;
SELECT 'Cobertura' AS Tabla, COUNT(*) AS Total FROM COBERTURA;
SELECT 'Roles' AS Tabla, COUNT(*) AS Total FROM Roles;
SELECT 'Personas' AS Tabla, COUNT(*) AS Total FROM Personas;
SELECT 'Pacientes' AS Tabla, COUNT(*) AS Total FROM PACIENTES;
SELECT 'Medicos' AS Tabla, COUNT(*) AS Total FROM Medicos;
SELECT 'Usuarios' AS Tabla, COUNT(*) AS Total FROM Usuarios;
SELECT 'Turnos' AS Tabla, COUNT(*) AS Total FROM Turnos;

GO
