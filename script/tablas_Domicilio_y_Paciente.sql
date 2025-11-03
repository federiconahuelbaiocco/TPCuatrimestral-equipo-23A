use ClinicaDB
go

CREATE TABLE COBERTURA(
	idCoberturaMedica int identity (1,1) not null,
	Nombre varchar (50) not null,

	primary key (idCoberturaMedica)
	);
go

CREATE TABLE PACIENTES(
	idPersona int not null,
	FechaNacimiento date null,
	idCobertura int null,

	primary key(idPersona),
	foreign key(idCobertura) REFERENCES COBERTURA(idCoberturaMedica)
	);
GO

ALTER TABLE PACIENTES
ADD CONSTRAINT FK_Pacientes_Personas FOREIGN KEY (idPersona) REFERENCES Personas (idPersona)
GO


CREATE PROCEDURE sp_InsertarPaciente
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI  VARCHAR (20),
    @Mail VARCHAR(255),
    @Telefono VARCHAR(50),
    @Calle VARCHAR(200),
    @Altura VARCHAR(20),
    @Piso VARCHAR(10) ,
    @Departamento VARCHAR(10),
    @Localidad VARCHAR(100) ,
    @Provincia VARCHAR(100) ,
    @CodigoPostal VARCHAR(20),
    @FechaNacimiento DATE,
    @idCobertura INT 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NuevoIdDomicilio INT;
    DECLARE @NuevoIdPersona INT;

    INSERT INTO DOMICILIOS (Calle, Altura, Piso, Departamento,Localidad,Provincia,CodigoPostal)
    VALUES (@Calle, @Altura, @Piso,@Departamento,@Localidad, @Provincia,@CodigoPostal);

     SET @NuevoIdDomicilio = SCOPE_IDENTITY();

    -- 1️⃣ Insertar en PERSONAS (sin incluir idPersona)
    INSERT INTO PERSONAS (Nombre, Apellido, Dni, Email, Telefono)
    VALUES (@Nombre, @Apellido, @DNI, @Mail,@Telefono);

    -- 2️⃣ Obtener el último id generado
    SET @NuevoIdPersona = SCOPE_IDENTITY();

    -- 3️⃣ Insertar en PACIENTES usando ese id
    INSERT INTO PACIENTES (idPersona, FechaNacimiento, idCobertura)
    VALUES (@NuevoIdPersona, @FechaNacimiento, @idCobertura);
END;



EXEC sp_InsertarPaciente
    @Nombre = 'maxy',
    @Apellido = 'Fernandez',
    @DNI = 11992288,
    @Mail= 'mf@utn.com',
    @Telefono=23123445,
    @Calle = 'Av. Siempre Viva',
    @Altura= '123',
    @Piso=2,
    @Departamento='A',
    @Localidad= 'Springfield',
    @Provincia = 'Capital',
    @CodigoPostal= 1234,
    @FechaNacimiento = '1995-05-20'



    
