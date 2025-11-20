USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ClinicaDB')
BEGIN
    CREATE DATABASE ClinicaDB;
END
GO

USE ClinicaDB;
GO

IF OBJECT_ID('dbo.Domicilios', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Domicilios (
        IdDomicilio INT IDENTITY(1,1) NOT NULL,
        Calle VARCHAR(200) NULL,
        Altura VARCHAR(20) NULL,
        Piso VARCHAR(10) NULL,
        Departamento VARCHAR(10) NULL,
        Localidad VARCHAR(100) NULL,
        Provincia VARCHAR(100) NULL,
        CodigoPostal VARCHAR(20) NULL,
        CONSTRAINT PK_Domicilios PRIMARY KEY CLUSTERED (IdDomicilio ASC)
    );
    PRINT 'Tabla Domicilios creada.';
END
GO

IF OBJECT_ID('dbo.Especialidades', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Especialidades (
        IdEspecialidad INT IDENTITY(1,1) NOT NULL,
        Descripcion VARCHAR(100) NOT NULL,
        Activo BIT NOT NULL DEFAULT 1,
        CONSTRAINT PK_Especialidades PRIMARY KEY CLUSTERED (IdEspecialidad ASC)
    );
    PRINT 'Tabla Especialidades creada.';
END
GO

IF OBJECT_ID('dbo.COBERTURA', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.COBERTURA(
        idCoberturaMedica INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(50) NOT NULL,
        Activo BIT NOT NULL DEFAULT 1,
        CONSTRAINT PK_Cobertura PRIMARY KEY CLUSTERED (idCoberturaMedica ASC)
    );
    PRINT 'Tabla COBERTURA creada.';
END
GO

IF OBJECT_ID('dbo.CONSULTORIOS', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CONSULTORIOS (
        IdConsultorio INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(100) NOT NULL,
        Activo BIT NOT NULL DEFAULT 1,
        CONSTRAINT PK_Consultorios PRIMARY KEY CLUSTERED (IdConsultorio ASC)
    );
    PRINT 'Tabla CONSULTORIOS creada.';
END
GO

IF OBJECT_ID('dbo.Personas', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Personas (
        IdPersona INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(100) NOT NULL,
        Apellido VARCHAR(100) NOT NULL,
        Dni VARCHAR(20) NOT NULL,
        Sexo VARCHAR(20) NULL DEFAULT 'No especificado',
        Email VARCHAR(255) NULL,
        Telefono VARCHAR(50) NULL,
        Activo BIT NOT NULL DEFAULT 1,
        IdDomicilio INT NULL,
        CONSTRAINT PK_Personas PRIMARY KEY CLUSTERED (IdPersona ASC),
        CONSTRAINT UQ_Personas_Dni UNIQUE (Dni),
        CONSTRAINT FK_Personas_Domicilios FOREIGN KEY (IdDomicilio) REFERENCES dbo.Domicilios(IdDomicilio)
    );
    PRINT 'Tabla Personas creada.';
END
GO

IF OBJECT_ID('dbo.Medicos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Medicos (
        IdPersona INT NOT NULL,
        Matricula VARCHAR(50) NOT NULL,
        IdUsuario INT NULL DEFAULT -1,
        CONSTRAINT PK_Medicos PRIMARY KEY CLUSTERED (IdPersona ASC),
        CONSTRAINT FK_Medicos_Personas FOREIGN KEY (IdPersona) REFERENCES dbo.Personas(IdPersona)
    );
    PRINT 'Tabla Medicos creada.';
END
GO

IF OBJECT_ID('dbo.PACIENTES', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.PACIENTES(
        idPersona INT NOT NULL,
        FechaNacimiento DATE NULL,
        idCobertura INT NULL,
        CONSTRAINT PK_Pacientes PRIMARY KEY CLUSTERED (idPersona ASC),
        CONSTRAINT FK_Pacientes_Personas FOREIGN KEY (idPersona) REFERENCES dbo.Personas(IdPersona),
        CONSTRAINT FK_Pacientes_Cobertura FOREIGN KEY (idCobertura) REFERENCES dbo.COBERTURA(idCoberturaMedica)
    );
    PRINT 'Tabla PACIENTES creada.';
END
GO

IF OBJECT_ID('dbo.Roles', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Roles (
        IdRol INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(50) NOT NULL,
        Activo BIT NOT NULL DEFAULT 1,
        CONSTRAINT PK_Roles PRIMARY KEY CLUSTERED (IdRol ASC)
    );
    PRINT 'Tabla Roles creada.';
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
    PRINT 'Tabla Usuarios creada.';
END
GO

IF OBJECT_ID('dbo.HistorialMedico', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.HistorialMedico (
        IdHistorialMedico INT IDENTITY(1,1) NOT NULL,
        IdPaciente INT NOT NULL,
        FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
        Activo BIT NOT NULL DEFAULT 1,
        CONSTRAINT PK_HistorialMedico PRIMARY KEY CLUSTERED (IdHistorialMedico ASC),
        CONSTRAINT FK_HistorialMedico_Pacientes FOREIGN KEY (IdPaciente) REFERENCES dbo.PACIENTES(idPersona),
        CONSTRAINT UQ_HistorialMedico_Paciente UNIQUE (IdPaciente)
    );
    PRINT 'Tabla HistorialMedico creada.';
END
GO

IF OBJECT_ID('dbo.EntradaHistorial', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.EntradaHistorial (
        IdEntradaHistorial INT IDENTITY(1,1) NOT NULL,
        IdHistorialMedico INT NOT NULL,
        IdMedico INT NOT NULL,
        Fecha DATETIME NOT NULL DEFAULT GETDATE(),
        Diagnostico VARCHAR(MAX) NOT NULL,
        Observaciones VARCHAR(MAX) NULL,
        Activo BIT NOT NULL DEFAULT 1,
        CONSTRAINT PK_EntradaHistorial PRIMARY KEY CLUSTERED (IdEntradaHistorial ASC),
        CONSTRAINT FK_EntradaHistorial_Historial FOREIGN KEY (IdHistorialMedico) REFERENCES dbo.HistorialMedico(IdHistorialMedico),
        CONSTRAINT FK_EntradaHistorial_Medicos FOREIGN KEY (IdMedico) REFERENCES dbo.Medicos(IdPersona)
    );
    PRINT 'Tabla EntradaHistorial creada.';
END
GO

IF OBJECT_ID('dbo.EstadosTurno', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.EstadosTurno (
        IdEstadoTurno INT IDENTITY(1,1) NOT NULL,
        Descripcion VARCHAR(50) NOT NULL,
        CONSTRAINT PK_EstadosTurno PRIMARY KEY CLUSTERED (IdEstadoTurno ASC)
    );
    
    INSERT INTO EstadosTurno (Descripcion) VALUES ('Programado'), ('Asistió'), ('No Asistió'), ('Cancelado');
END
GO

IF OBJECT_ID('dbo.Turnos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Turnos (
        IdTurno INT IDENTITY(1,1) NOT NULL,
        IdPaciente INT NOT NULL,
        IdMedico INT NOT NULL,
        FechaHora DATETIME NOT NULL,
        IdEstadoTurno INT NOT NULL,
        Observaciones VARCHAR(255) NULL,
        Activo BIT NOT NULL DEFAULT 1,
        
        CONSTRAINT PK_Turnos PRIMARY KEY CLUSTERED (IdTurno ASC),
        CONSTRAINT FK_Turnos_Pacientes FOREIGN KEY (IdPaciente) REFERENCES dbo.PACIENTES(idPersona),
        CONSTRAINT FK_Turnos_Medicos FOREIGN KEY (IdMedico) REFERENCES dbo.Medicos(IdPersona),
        CONSTRAINT FK_Turnos_Estados FOREIGN KEY (IdEstadoTurno) REFERENCES dbo.EstadosTurno(IdEstadoTurno),
        
        CONSTRAINT UQ_Medico_Horario UNIQUE (IdMedico, FechaHora) 
    );
END
GO