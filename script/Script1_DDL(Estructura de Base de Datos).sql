USE master;
GO

-- 1. CREACIÓN DE LA BASE DE DATOS
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'ClinicaDB')
BEGIN
    ALTER DATABASE ClinicaDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ClinicaDB;
END
GO

CREATE DATABASE ClinicaDB;
GO

USE ClinicaDB;
GO

-- 2. TABLAS (DDL)
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

CREATE TABLE dbo.Especialidades (
    IdEspecialidad INT IDENTITY(1,1) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_Especialidades PRIMARY KEY CLUSTERED (IdEspecialidad ASC)
);

CREATE TABLE dbo.COBERTURA(
	idCoberturaMedica INT IDENTITY(1,1) NOT NULL,
	Nombre VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Cobertura PRIMARY KEY CLUSTERED (idCoberturaMedica ASC)
);

CREATE TABLE dbo.CONSULTORIOS (
    IdConsultorio INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_Consultorios PRIMARY KEY CLUSTERED (IdConsultorio ASC)
);

CREATE TABLE dbo.Personas (
    IdPersona INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Dni VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NULL,
    Telefono VARCHAR(50) NULL,
    Activo BIT NOT NULL DEFAULT 1,
    IdDomicilio INT NULL,
    CONSTRAINT PK_Personas PRIMARY KEY CLUSTERED (IdPersona ASC),
    CONSTRAINT UQ_Personas_Dni UNIQUE (Dni),
    CONSTRAINT FK_Personas_Domicilios FOREIGN KEY (IdDomicilio) REFERENCES dbo.Domicilios(IdDomicilio)
);

CREATE TABLE dbo.Medicos (
    IdPersona INT NOT NULL,
    Matricula VARCHAR(50) NOT NULL,
    IdUsuario INT NULL DEFAULT -1,
    CONSTRAINT PK_Medicos PRIMARY KEY CLUSTERED (IdPersona ASC),
    CONSTRAINT FK_Medicos_Personas FOREIGN KEY (IdPersona) REFERENCES dbo.Personas(IdPersona)
);

CREATE TABLE dbo.PACIENTES(
	idPersona INT NOT NULL,
	FechaNacimiento DATE NULL,
	idCobertura INT NULL,
	CONSTRAINT PK_Pacientes PRIMARY KEY CLUSTERED (idPersona ASC),
	CONSTRAINT FK_Pacientes_Personas FOREIGN KEY (idPersona) REFERENCES dbo.Personas(IdPersona),
	CONSTRAINT FK_Pacientes_Cobertura FOREIGN KEY (idCobertura) REFERENCES dbo.COBERTURA(idCoberturaMedica)
);

CREATE TABLE dbo.Roles (
	IdRol INT IDENTITY(1,1) NOT NULL,
	Nombre VARCHAR(50) NOT NULL,
	Activo BIT NOT NULL DEFAULT 1,
	CONSTRAINT PK_Roles PRIMARY KEY CLUSTERED (IdRol ASC)
);

CREATE TABLE dbo.Usuarios (
        IdUsuario INT IDENTITY(1,1) NOT NULL,
        NombreUsuario VARCHAR(50) NOT NULL,
        Clave VARCHAR(50) NOT NULL,
        IdRol INT NOT NULL,
        IdPersona INT NOT NULL,
        Activo BIT NOT NULL DEFAULT 1,

        CONSTRAINT PK_Usuarios PRIMARY KEY CLUSTERED (IdUsuario ASC),
        CONSTRAINT UQ_Usuarios_NombreUsuario UNIQUE (NombreUsuario),
        CONSTRAINT FK_Usuarios_Roles FOREIGN KEY (IdRol) REFERENCES dbo.Roles(IdRol),
        CONSTRAINT FK_Usuarios_Personas FOREIGN KEY (IdPersona) REFERENCES dbo.Personas(IdPersona)
);
GO

-- DATOS INICIALES OBLIGATORIOS (Catálogos base)
INSERT INTO dbo.COBERTURA (Nombre) VALUES ('Particular'), ('OSDE'), ('Galeno'), ('PAMI');
INSERT INTO dbo.Especialidades (Descripcion) VALUES ('Clínica Médica'), ('Pediatría'), ('Cardiología');
INSERT INTO dbo.Roles (Nombre) VALUES ('Administrador'), ('Recepcionista'), ('Médico');