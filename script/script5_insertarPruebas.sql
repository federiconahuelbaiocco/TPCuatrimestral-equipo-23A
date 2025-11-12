USE ClinicaDB;
GO

BEGIN TRANSACTION;
BEGIN TRY

    IF NOT EXISTS (SELECT 1 FROM Especialidades WHERE Descripcion = 'Ginecología')
        EXEC dbo.sp_AgregarEspecialidad @Descripcion = 'Ginecología';
    IF NOT EXISTS (SELECT 1 FROM Especialidades WHERE Descripcion = 'Traumatología')
        EXEC dbo.sp_AgregarEspecialidad @Descripcion = 'Traumatología';

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
        EXEC dbo.sp_AgregarAdministrador 'Carlos', 'González', '20111222', 'cgonzalez@clinica.com', '1155550001', 'admin_gonzalez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin_rodriguez')
        EXEC dbo.sp_AgregarAdministrador 'Ana', 'Rodríguez', '21222333', 'arodriguez@clinica.com', '1155550002', 'admin_rodriguez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin_lopez')
        EXEC dbo.sp_AgregarAdministrador 'Luis', 'López', '22333444', 'llopez@clinica.com', '1155550003', 'admin_lopez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin_martinez')
        EXEC dbo.sp_AgregarAdministrador 'Maria', 'Martínez', '23444555', 'mmartinez@clinica.com', '1155550004', 'admin_martinez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin_sanchez')
        EXEC dbo.sp_AgregarAdministrador 'Javier', 'Sánchez', '24555666', 'jsanchez@clinica.com', '1155550005', 'admin_sanchez', 'clave123';

    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_diaz')
        EXEC dbo.sp_AgregarRecepcionista 'Lucía', 'Díaz', '30111222', 'ldiaz@clinica.com', '1166660001', 'recep_diaz', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_perez')
        EXEC dbo.sp_AgregarRecepcionista 'Miguel', 'Pérez', '31222333', 'mperez@clinica.com', '1166660002', 'recep_perez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_gomez')
        EXEC dbo.sp_AgregarRecepcionista 'Elena', 'Gómez', '32333444', 'egomez@clinica.com', '1166660003', 'recep_gomez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_fernandez')
        EXEC dbo.sp_AgregarRecepcionista 'David', 'Fernández', '33444555', 'dfernandez@clinica.com', '1166660004', 'recep_fernandez', 'clave123';
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'recep_moreno')
        EXEC dbo.sp_AgregarRecepcionista 'Sofía', 'Moreno', '34555666', 'smoreno@clinica.com', '1166660005', 'recep_moreno', 'clave123';

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '40111222')
        EXEC dbo.sp_InsertarPaciente 'Roberto', 'García', '40111222', 'rgarcia@email.com', '1177770001', 'Calle Falsa', '123', NULL, NULL, 'Springfield', 'Buenos Aires', '1610', '1980-05-10', 2;
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '41222333')
        EXEC dbo.sp_InsertarPaciente 'Carmen', 'Ruiz', '41222333', 'cruiz@email.com', '1177770002', 'Av. Rivadavia', '2030', '1A', NULL, 'CABA', 'CABA', '1033', '1995-11-20', 3;
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '42333444')
        EXEC dbo.sp_InsertarPaciente 'Pablo', 'Alonso', '42333444', 'palonso@email.com', '1177770003', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2001-01-15', 1;
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '43444555')
        EXEC dbo.sp_InsertarPaciente 'Isabel', 'Gutiérrez', '43444555', 'igutierrez@email.com', '1177770004', 'Calle Sol', '800', NULL, NULL, 'Quilmes', 'Buenos Aires', '1878', '1988-07-30', 4;
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '44555666')
        EXEC dbo.sp_InsertarPaciente 'Marcos', 'Navarro', '44555666', 'mnavarro@email.com', '1177770005', 'Av. Corrientes', '1500', '8B', NULL, 'CABA', 'CABA', '1042', '1999-03-05', 2;

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '25111222')
    BEGIN
        EXEC dbo.sp_AgregarMedico 
            @Nombre = 'Laura', @Apellido = 'Torres', @DNI = '25111222', 
            @Matricula = 'MN1001', @Mail = 'ltorres@clinica.com', @Telefono = '1188880001';
    END
    
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '26222333')
    BEGIN
        EXEC dbo.sp_AgregarMedico 
            @Nombre = 'Diego', @Apellido = 'Ramírez', @DNI = '26222333', 
            @Matricula = 'MN1002', @Mail = 'dramirez@clinica.com', @Telefono = '1188880002';
    END

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '27333444')
    BEGIN
        EXEC dbo.sp_AgregarMedico 
            @Nombre = 'Valeria', @Apellido = 'Castro', @DNI = '27333444', 
            @Matricula = 'MN1003', @Mail = 'vcastro@clinica.com', @Telefono = '1188880003';
    END

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '28444555')
    BEGIN
        EXEC dbo.sp_AgregarMedico 
            @Nombre = 'Jorge', @Apellido = 'Ortega', @DNI = '28444555', 
            @Matricula = 'MN1004', @Mail = 'jortega@clinica.com', @Telefono = '1188880004';
    END

    IF NOT EXISTS (SELECT 1 FROM Personas WHERE Dni = '29555666')
    BEGIN
        EXEC dbo.sp_AgregarMedico 
            @Nombre = 'Clara', @Apellido = 'Molina', @DNI = '29555666', 
            @Matricula = 'MN1005', @Mail = 'cmolina@clinica.com', @Telefono = '1188880005';
    END

    COMMIT TRANSACTION;
    PRINT 'Script de inserción de datos completado.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error durante la inserción de datos. Se revirtió la transacción.';
    THROW;
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
GO