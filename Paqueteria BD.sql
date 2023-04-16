	-- USE model
	-- DROP DATABASE Paqueteria

CREATE DATABASE Paqueteria
GO

USE Paqueteria

GO
CREATE SCHEMA Gral
GO

CREATE SCHEMA Paq
GO


CREATE TABLE Gral.tblEstadoCiviles
(
esci_ID                 INT IDENTITY(1,1),
esci_Descripcion        NVARCHAR(150) NOT NULL,

esci_UsuarioCrea        INT NOT NULL,
esci_FechaCrea          DATETIME DEFAULT GETDATE(),
esci_UsuarioModifica    INT,
esci_FechaModifica      DATETIME,
esci_Estado             BIT DEFAULT 1,
           
CONSTRAINT PK_Gral_tbEstadoCiviles_esta_ID PRIMARY KEY (esci_ID)
);

INSERT INTO Gral.tblEstadoCiviles
VALUES('Soltero(a)',1,GETDATE(),NULL,NULL,1),
      ('Casado(a)',1,GETDATE(),NULL,NULL,1),
	  ('Divorciado(a)',1,GETDATE(),NULL,NULL,1),
      ('Union Libre',1,GETDATE(),NULL,NULL,1),
	  ('Viudo(a)',1,GETDATE(),NULL,NULL,1)


CREATE TABLE Gral.tblDepartamentos
(
depa_ID				   INT IDENTITY(1,1),
depa_Descri             NVARCHAR(150) NOT NULL,

depa_UsuarioCrea        INT NOT NULL,
depa_FechaCrea          DATETIME DEFAULT GETDATE(),
depa_UsuarioModifica    INT,
depa_FechaModifica      DATETIME,

CONSTRAINT PK_Gral_tbDepartamento_dep_ID PRIMARY KEY (depa_ID),
CONSTRAINT UQ_Gral_tbDepartamento_dep_Descri UNIQUE (depa_Descri)

);
INSERT INTO Gral.tblDepartamentos
VALUES	('Atlántida',1,GETDATE(),NULL,NULL),
		('Colón',1,GETDATE(),NULL,NULL),
		('Comayagua',1,GETDATE(),NULL,NULL),
		('Copán',1,GETDATE(),NULL,NULL),
		('Cortés',1,GETDATE(),NULL,NULL),
		('Choluteca',1,GETDATE(),NULL,NULL),
		('El Paraíso',1,GETDATE(),NULL,NULL),
		('Francisco Morazán',1,GETDATE(),NULL,NULL),
		('Gracias a Dios',1,GETDATE(),NULL,NULL),
		('Intibucá',1,GETDATE(),NULL,NULL),
		('Islas de la Bahía',1,GETDATE(),NULL,NULL),
		('La Paz',1,GETDATE(),NULL,NULL),
		('Lempira',1,GETDATE(),NULL,NULL),
		('Ocotepeque',1,GETDATE(),NULL,NULL),
		('Olancho',1,GETDATE(),NULL,NULL),
		('Santa Bárbara',1,GETDATE(),NULL,NULL),
		('Valle',1,GETDATE(),NULL,NULL),
		('Yoro',1,GETDATE(),NULL,NULL);    


CREATE TABLE Gral.tblCiudades
(
ciud_ID                 INT IDENTITY(1,1),
ciud_Descri             NVARCHAR(150) NOT NULL,
depa_ID                 INT NOT NULL,

ciud_UsuarioCrea        INT NOT NULL,
ciud_FechaCrea          DATETIME DEFAULT GETDATE(),
ciud_UsuarioModifica    INT,
ciud_FechaModifica      DATETIME,

CONSTRAINT PK_Gral_tbCiudad_ciu_ID PRIMARY KEY (ciud_ID),
CONSTRAINT FK_Gral_tbCiudad_Gral_tbDepartamento_dep_ID FOREIGN KEY (depa_ID) REFERENCES Gral.tblDepartamentos (depa_ID)
);

INSERT INTO Gral.tblCiudades
VALUES ('La Ceiba', 1,1,GETDATE(),NULL,NULL),
	   ('El Porvenir', 1,1,GETDATE(),NULL,NULL),
	   ('Esparta', 1,1,GETDATE(),NULL,NULL),
	   ('Jutiapa', 1,1,GETDATE(),NULL,NULL),
	   ('La Masica', 1,1,GETDATE(),NULL,NULL),
	   ('San Francisco', 1,1,GETDATE(),NULL,NULL),
	   ('Tela', 1,1,GETDATE(),NULL,NULL),
	   ('Arizona', 1,1,GETDATE(),NULL,NULL),
	   ('Trujillo', 2,1,GETDATE(),NULL,NULL),
	   ('Balfate', 2,1,GETDATE(),NULL,NULL),
	   ('Iriona', 2,1,GETDATE(),NULL,NULL),
	   ('Limón', 2,1,GETDATE(),NULL,NULL),
	   ('Sabá', 2,1,GETDATE(),NULL,NULL),
	   ('Santa Fe', 2,1,GETDATE(),NULL,NULL),
	   ('Sta. Rosa De Aguán', 2,1,GETDATE(),NULL,NULL),
	   ('Sonaguera', 2,1,GETDATE(),NULL,NULL),
	   ('Tocoa', 2,1,GETDATE(),NULL,NULL),
	   ('Bonito Oriental', 2,1,GETDATE(),NULL,NULL),
	   ('Comayagua', 3,1,GETDATE(),NULL,NULL),
	   ('Ajuterique', 3,1,GETDATE(),NULL,NULL),
	   ('El Rosario', 3,1,GETDATE(),NULL,NULL),
	   ('Esquías', 3,1,GETDATE(),NULL,NULL),
	   ('Sabá', 3,1,GETDATE(),NULL,NULL),
	   ('Santa Fe', 3,1,GETDATE(),NULL,NULL),
	   ('Sta. Rosa De Aguán', 3,1,GETDATE(),NULL,NULL),
	   ('Sonaguera', 3,1,GETDATE(),NULL,NULL),
	   ('Tocoa', 3,1,GETDATE(),NULL,NULL),
	   ('Bonito Oriental', 3,1,GETDATE(),NULL,NULL),
	   ('Minas De Oro', 3,1,GETDATE(),NULL,NULL),
	   ('Ojos De Agua', 3,1,GETDATE(),NULL,NULL),
	   ('San Jerónimo', 3,1,GETDATE(),NULL,NULL),
	   ('S. Jose De Comayagua', 3,1,GETDATE(),NULL,NULL),
	   ('S. Jose Del Potrero', 3,1,GETDATE(),NULL,NULL),
	   ('San Luis', 3,1,GETDATE(),NULL,NULL),
	   ('San Sebastián', 3,1,GETDATE(),NULL,NULL),
	   ('Siguatepeque', 3,1,GETDATE(),NULL,NULL),
	   ('Villa De S. Antonio', 3,1,GETDATE(),NULL,NULL),
	   ('Lajas', 3,1,GETDATE(),NULL,NULL),
	   ('Taulabé', 3,1,GETDATE(),NULL,NULL),
	   ('Sta. Rosa De Copán', 4,1,GETDATE(),NULL,NULL),
	   ('Cabañas', 4,1,GETDATE(),NULL,NULL),
	   ('Concepción', 4,1,GETDATE(),NULL,NULL),
	   ('Copán Ruinas', 4,1,GETDATE(),NULL,NULL),
	   ('Corquón', 4,1,GETDATE(),NULL,NULL),
	   ('Cucuyagua', 4,1,GETDATE(),NULL,NULL),
	   ('Dolores', 4,1,GETDATE(),NULL,NULL),
	   ('Dulce Nombre', 4,1,GETDATE(),NULL,NULL),
	   ('El Paraíso', 4,1,GETDATE(),NULL,NULL),
	   ('Florida', 4,1,GETDATE(),NULL,NULL),
	   ('La Jigua', 4,1,GETDATE(),NULL,NULL),
	   ('La Unión', 4,1,GETDATE(),NULL,NULL),
	   ('Nueva Arcadia', 4,1,GETDATE(),NULL,NULL),
	   ('San Agustín', 4,1,GETDATE(),NULL,NULL),
	   ('San Antonio', 4,1,GETDATE(),NULL,NULL),
	   ('San Jerónimo', 4,1,GETDATE(),NULL,NULL),
	   ('San José', 4,1,GETDATE(),NULL,NULL),
	   ('San Juan De Opoa', 4,1,GETDATE(),NULL,NULL),
	   ('San Nicolás', 4,1,GETDATE(),NULL,NULL),
	   ('San Pedro', 4,1,GETDATE(),NULL,NULL),
	   ('Santa Rita', 4,1,GETDATE(),NULL,NULL),
	   ('Trinidad', 4,1,GETDATE(),NULL,NULL),
	   ('Veracruz', 4,1,GETDATE(),NULL,NULL),
	   ('San Pedro Sula', 5,1,GETDATE(),NULL,NULL),
	   ('Choloma', 5,1,GETDATE(),NULL,NULL),
	   ('Omoa', 5,1,GETDATE(),NULL,NULL),
	   ('Pimienta', 5,1,GETDATE(),NULL,NULL),
	   ('Potrerillos', 5,1,GETDATE(),NULL,NULL),
	   ('Puerto Cortés', 5,1,GETDATE(),NULL,NULL),
	   ('S. Antonio De Cortés', 5,1,GETDATE(),NULL,NULL),
	   ('San Fco. De Yojoa', 5,1,GETDATE(),NULL,NULL),
	   ('San Manuel', 5,1,GETDATE(),NULL,NULL),
	   ('Sta. Cruz De Yojoa', 5,1,GETDATE(),NULL,NULL),
	   ('Villanueva', 5,1,GETDATE(),NULL,NULL),
	   ('La Lima', 5,1,GETDATE(),NULL,NULL),
	   ('Choluteca', 6,1,GETDATE(),NULL,NULL),
	   ('Apacilagua', 6,1,GETDATE(),NULL,NULL),
	   ('Concepción De Maráa', 6,1,GETDATE(),NULL,NULL),
	   ('Duyure', 6,1,GETDATE(),NULL,NULL),
	   ('El Corpus', 6,1,GETDATE(),NULL,NULL),
	   ('El Triunfo', 6,1,GETDATE(),NULL,NULL),
	   ('Marcovia', 6,1,GETDATE(),NULL,NULL),
	   ('Morolica', 6,1,GETDATE(),NULL,NULL),
	   ('Namasigue', 6,1,GETDATE(),NULL,NULL),
	   ('Orocuina', 6,1,GETDATE(),NULL,NULL),
	   ('Pespire', 6,1,GETDATE(),NULL,NULL),
	   ('San Antonio De Flores', 6,1,GETDATE(),NULL,NULL),
	   ('San Isidro', 6,1,GETDATE(),NULL,NULL),
	   ('San Jose', 6,1,GETDATE(),NULL,NULL),
	   ('San Marcos De Colón', 6,1,GETDATE(),NULL,NULL),
	   ('Santa Ana De Yusguare,', 6,1,GETDATE(),NULL,NULL),
	   ('Yuscarán', 7,1,GETDATE(),NULL,NULL),
	   ('Alauca', 7,1,GETDATE(),NULL,NULL),
	   ('Danlí', 7,1,GETDATE(),NULL,NULL),
	   ('El Paraíso', 7,1,GETDATE(),NULL,NULL),
	   ('"Guinope', 7,1,GETDATE(),NULL,NULL),
	   ('Jacaleapa', 7,1,GETDATE(),NULL,NULL),
	   ('Liure', 7,1,GETDATE(),NULL,NULL),
	   ('Morocelá', 7,1,GETDATE(),NULL,NULL),
	   ('Oropolá', 7,1,GETDATE(),NULL,NULL),
	   ('Potrerillos', 7,1,GETDATE(),NULL,NULL),
	   ('S. Antonio De Flores', 7,1,GETDATE(),NULL,NULL),
	   ('San Lucas', 7,1,GETDATE(),NULL,NULL),
	   ('San Matías', 7,1,GETDATE(),NULL,NULL),
	   ('Soledad', 7,1,GETDATE(),NULL,NULL),
	   ('Teupasenti', 7,1,GETDATE(),NULL,NULL),
	   ('Texiguat', 7,1,GETDATE(),NULL,NULL),
	   ('Vado Ancho', 7,1,GETDATE(),NULL,NULL),
	   ('Yauyupe', 7,1,GETDATE(),NULL,NULL),
	   ('Trojes', 7,1,GETDATE(),NULL,NULL),
	   ('Distrito Central', 8,1,GETDATE(),NULL,NULL),
	   ('Alubar?N', 8,1,GETDATE(),NULL,NULL),
	   ('Cedros', 8,1,GETDATE(),NULL,NULL),
	   ('Curarón', 8,1,GETDATE(),NULL,NULL),
	   ('El Provenir', 8,1,GETDATE(),NULL,NULL),
	   ('Guaimaca', 8,1,GETDATE(),NULL,NULL),
	   ('La Libertad', 8,1,GETDATE(),NULL,NULL),
	   ('La Venta', 8,1,GETDATE(),NULL,NULL),
	   ('Lepaterique', 8,1,GETDATE(),NULL,NULL),
	   ('Maraita', 8,1,GETDATE(),NULL,NULL),
	   ('Marale', 8,1,GETDATE(),NULL,NULL),
	   ('Nueva Aremnia', 8,1,GETDATE(),NULL,NULL),
	   ('Ojojona', 8,1,GETDATE(),NULL,NULL),
	   ('Orica', 8,1,GETDATE(),NULL,NULL),
	   ('Reitoca', 8,1,GETDATE(),NULL,NULL),
	   ('Sabana Grande', 8,1,GETDATE(),NULL,NULL),
	   ('S. Antonio De Oriente', 8,1,GETDATE(),NULL,NULL),
	   ('San Buenaventura', 8,1,GETDATE(),NULL,NULL),
	   ('San Ignacio', 8,1,GETDATE(),NULL,NULL),
	   ('San Juan De Flores', 8,1,GETDATE(),NULL,NULL),
	   ('San Miguelito', 8,1,GETDATE(),NULL,NULL),
	   ('Santa Ana', 8,1,GETDATE(),NULL,NULL),
	   ('Santa Lucía', 8,1,GETDATE(),NULL,NULL),
	   ('Talanga', 8,1,GETDATE(),NULL,NULL),
	   ('Tatumbla', 8,1,GETDATE(),NULL,NULL),
	   ('Valle De Ángeles', 8,1,GETDATE(),NULL,NULL),
	   ('Villa De San Francisco', 8,1,GETDATE(),NULL,NULL),
	   ('Vallecillo', 8,1,GETDATE(),NULL,NULL),
	   ('Puerto Lempira', 9,1,GETDATE(),NULL,NULL),
	   ('Brus Laguna', 9,1,GETDATE(),NULL,NULL),
	   ('Ahuas', 9,1,GETDATE(),NULL,NULL),
	   ('Juan Francisco Bulnes', 9,1,GETDATE(),NULL,NULL),
	   ('Villeda Morales', 9,1,GETDATE(),NULL,NULL),
	   ('Wampusirpe', 9,1,GETDATE(),NULL,NULL),
	   ('La Esperanza', 10,1,GETDATE(),NULL,NULL),
	   ('Camasca', 10,1,GETDATE(),NULL,NULL),
	   ('Colomoncagua', 10,1,GETDATE(),NULL,NULL),
	   ('Concepción', 10,1,GETDATE(),NULL,NULL),
	   ('Dolores', 10,1,GETDATE(),NULL,NULL),
	   ('Intibucá', 10,1,GETDATE(),NULL,NULL),
	   ('Jesús De Otoro', 10,1,GETDATE(),NULL,NULL),
	   ('Magdalena', 10,1,GETDATE(),NULL,NULL),
	   ('Masaguara', 10,1,GETDATE(),NULL,NULL),
	   ('San Antonio', 10,1,GETDATE(),NULL,NULL),
	   ('San Isidro', 10,1,GETDATE(),NULL,NULL),
	   ('San Juan De Flores', 10,1,GETDATE(),NULL,NULL),
	   ('San Marcos De La Sierra', 10,1,GETDATE(),NULL,NULL),
	   ('San Miguel Guancapla', 10,1,GETDATE(),NULL,NULL),
	   ('Santa Lucía', 10,1,GETDATE(),NULL,NULL),
	   ('Yamaranguila', 10,1,GETDATE(),NULL,NULL),
	   ('S. Francisco Opalaca', 10,1,GETDATE(),NULL,NULL),
	   ('Roatán', 11,1,GETDATE(),NULL,NULL),
	   ('Guanaja', 11,1,GETDATE(),NULL,NULL),
	   ('José Santo Guardiola', 11,1,GETDATE(),NULL,NULL),
	   ('Utila', 11,1,GETDATE(),NULL,NULL),
	   ('La Paz', 12,1,GETDATE(),NULL,NULL),
	   ('Aguanqueterique', 12,1,GETDATE(),NULL,NULL),
	   ('Cabañas', 12,1,GETDATE(),NULL,NULL),
	   ('Cane', 12,1,GETDATE(),NULL,NULL),
	   ('Chinacla', 12,1,GETDATE(),NULL,NULL),
	   ('Guajiquiro', 12,1,GETDATE(),NULL,NULL),
	   ('Lauterique', 12,1,GETDATE(),NULL,NULL),
	   ('Marcala', 12,1,GETDATE(),NULL,NULL),
	   ('Mercedes De Oriente', 12,1,GETDATE(),NULL,NULL),
	   ('Opatoro', 12,1,GETDATE(),NULL,NULL),
	   ('S. Antonio Del Norte', 12,1,GETDATE(),NULL,NULL),
	   ('San José', 12,1,GETDATE(),NULL,NULL),
	   ('San Juan', 12,1,GETDATE(),NULL,NULL),
	   ('San Pedro De Tutule', 12,1,GETDATE(),NULL,NULL),
	   ('Santa Ana', 12,1,GETDATE(),NULL,NULL),
	   ('Santa Elena', 12,1,GETDATE(),NULL,NULL),
	   ('Santa María', 12,1,GETDATE(),NULL,NULL),
	   ('Santia Puringla', 12,1,GETDATE(),NULL,NULL),
	   ('Yarula', 12,1,GETDATE(),NULL,NULL),
	   ('Gracias', 13,1,GETDATE(),NULL,NULL),
	   ('Belén', 13,1,GETDATE(),NULL,NULL),
	   ('Candelaria', 13,1,GETDATE(),NULL,NULL),
	   ('Cololaca', 13,1,GETDATE(),NULL,NULL),
	   ('Erandique', 13,1,GETDATE(),NULL,NULL),
	   ('Gualcinse', 13,1,GETDATE(),NULL,NULL),
	   ('Guarita', 13,1,GETDATE(),NULL,NULL),
	   ('La Campa', 13,1,GETDATE(),NULL,NULL),
	   ('La Iguala', 13,1,GETDATE(),NULL,NULL),
	   ('Las Flores', 13,1,GETDATE(),NULL,NULL),
	   ('La Unión', 13,1,GETDATE(),NULL,NULL),
	   ('La Virtud', 13,1,GETDATE(),NULL,NULL),
	   ('Lepaera', 13,1,GETDATE(),NULL,NULL),
	   ('Mapulaca', 13,1,GETDATE(),NULL,NULL),
	   ('Piraera', 13,1,GETDATE(),NULL,NULL),
	   ('San Andrés', 13,1,GETDATE(),NULL,NULL),
	   ('San Francisco', 13,1,GETDATE(),NULL,NULL),
	   ('San Juan Guarita', 13,1,GETDATE(),NULL,NULL),
	   ('San Manuel Colohete', 13,1,GETDATE(),NULL,NULL),
	   ('San Rafael', 13,1,GETDATE(),NULL,NULL),
	   ('San Sebastián', 13,1,GETDATE(),NULL,NULL),
	   ('Santa Cruz', 13,1,GETDATE(),NULL,NULL),
	   ('Talgua', 13,1,GETDATE(),NULL,NULL),
	   ('Tambla', 13,1,GETDATE(),NULL,NULL),
	   ('Tomala', 13,1,GETDATE(),NULL,NULL),
	   ('Valladolid', 13,1,GETDATE(),NULL,NULL),
	   ('Virginia', 13,1,GETDATE(),NULL,NULL),
	   ('S. Marcos De Caiquán', 13,1,GETDATE(),NULL,NULL),
	   ('Nueva Ocotepeque', 14,1,GETDATE(),NULL,NULL),
	   ('Belén Gualcho', 14,1,GETDATE(),NULL,NULL),
	   ('Concepción', 14,1,GETDATE(),NULL,NULL),
	   ('Dolores Merendón', 14,1,GETDATE(),NULL,NULL),
	   ('Fraternidad', 14,1,GETDATE(),NULL,NULL),
	   ('La Encarnación', 14,1,GETDATE(),NULL,NULL),
	   ('La Labor', 14,1,GETDATE(),NULL,NULL),
	   ('Lucerna', 14,1,GETDATE(),NULL,NULL),
	   ('Mercedes', 14,1,GETDATE(),NULL,NULL),
	   ('Mercedes', 14,1,GETDATE(),NULL,NULL),
	   ('S. Francisco Del Valle', 14,1,GETDATE(),NULL,NULL),
	   ('San Jorge', 14,1,GETDATE(),NULL,NULL),
	   ('San Marcos', 14,1,GETDATE(),NULL,NULL),
	   ('Santa Fe', 14,1,GETDATE(),NULL,NULL),
	   ('Sensenti', 14,1,GETDATE(),NULL,NULL),
	   ('Sinuapa', 14,1,GETDATE(),NULL,NULL),
	   ('Juticalpa', 15,1,GETDATE(),NULL,NULL),
	   ('Campamento', 15,1,GETDATE(),NULL,NULL),
	   ('Catacamas', 15,1,GETDATE(),NULL,NULL),
	   ('Concordia', 15,1,GETDATE(),NULL,NULL),
	   ('Dulce Nombre De Culmá', 15,1,GETDATE(),NULL,NULL),
	   ('El Rosario', 15,1,GETDATE(),NULL,NULL),
	   ('Esquipulas Del Norte', 15,1,GETDATE(),NULL,NULL),
	   ('Gualaco', 15,1,GETDATE(),NULL,NULL),
	   ('Guarizama', 15,1,GETDATE(),NULL,NULL),
	   ('Guata', 15,1,GETDATE(),NULL,NULL),
	   ('Guayape', 15,1,GETDATE(),NULL,NULL),
	   ('Jano', 15,1,GETDATE(),NULL,NULL),
	   ('La Unión', 15,1,GETDATE(),NULL,NULL),
	   ('Mangulile', 15,1,GETDATE(),NULL,NULL),
	   ('Manto', 15,1,GETDATE(),NULL,NULL),
	   ('Salamé', 15,1,GETDATE(),NULL,NULL),
	   ('San Esteban', 15,1,GETDATE(),NULL,NULL),
	   ('S. Francisco De Becerra', 15,1,GETDATE(),NULL,NULL),
	   ('S. Francisco De La Paz', 15,1,GETDATE(),NULL,NULL),
	   ('Santa María Del Real', 15,1,GETDATE(),NULL,NULL),
	   ('Silca', 15,1,GETDATE(),NULL,NULL),
	   ('Yocón', 15,1,GETDATE(),NULL,NULL),
	   ('Froylan Turcios', 15,1,GETDATE(),NULL,NULL),
	   ('Santa Bárbara', 16,1,GETDATE(),NULL,NULL),
	   ('Arada', 16,1,GETDATE(),NULL,NULL),
	   ('Atima', 16,1,GETDATE(),NULL,NULL),
	   ('Azacualpa', 16,1,GETDATE(),NULL,NULL),
	   ('Ceguaca', 16,1,GETDATE(),NULL,NULL),
	   ('Colinas', 16,1,GETDATE(),NULL,NULL),
	   ('Concepción Del Norte', 16,1,GETDATE(),NULL,NULL),
	   ('Concepción Del Sur', 16,1,GETDATE(),NULL,NULL),
	   ('Chinda', 16,1,GETDATE(),NULL,NULL),
	   ('El Nóspero', 16,1,GETDATE(),NULL,NULL),
	   ('Gualala', 16,1,GETDATE(),NULL,NULL),
	   ('Ilama', 16,1,GETDATE(),NULL,NULL),
	   ('Macuelizo', 16,1,GETDATE(),NULL,NULL),
	   ('Naranjito', 16,1,GETDATE(),NULL,NULL),
	   ('Nueva Celilac', 16,1,GETDATE(),NULL,NULL),
	   ('Petoa', 16,1,GETDATE(),NULL,NULL),
	   ('Protección', 16,1,GETDATE(),NULL,NULL),
	   ('Quimistán', 16,1,GETDATE(),NULL,NULL),
	   ('S. Francisco De Ojuera', 16,1,GETDATE(),NULL,NULL),
	   ('San Luis', 16,1,GETDATE(),NULL,NULL),
	   ('San Marcos', 16,1,GETDATE(),NULL,NULL),
	   ('San Nicolás', 16,1,GETDATE(),NULL,NULL),
	   ('San Pedro Zacapa', 16,1,GETDATE(),NULL,NULL),
	   ('Santa Rita', 16,1,GETDATE(),NULL,NULL),
	   ('San Vicente Sentenario', 16,1,GETDATE(),NULL,NULL),
	   ('Trinidad', 16,1,GETDATE(),NULL,NULL),
	   ('Las Vegas', 16,1,GETDATE(),NULL,NULL),
	   ('Nueva Frontera', 16,1,GETDATE(),NULL,NULL),
	   ('Nacaome', 17,1,GETDATE(),NULL,NULL),
	   ('Alianza', 17,1,GETDATE(),NULL,NULL),
	   ('Amapala', 17,1,GETDATE(),NULL,NULL),
	   ('Aramecina', 17,1,GETDATE(),NULL,NULL),
	   ('Caridad', 17,1,GETDATE(),NULL,NULL),
	   ('Ascorán', 17,1,GETDATE(),NULL,NULL),
	   ('Langue', 17,1,GETDATE(),NULL,NULL),
	   ('San Fco. De Coray', 17,1,GETDATE(),NULL,NULL),
	   ('San Lorenzo', 17,1,GETDATE(),NULL,NULL),
	   ('Yoro', 18,1,GETDATE(),NULL,NULL),
	   ('Arenal', 18,1,GETDATE(),NULL,NULL),
	   ('El Negrita', 18,1,GETDATE(),NULL,NULL),
	   ('El Progreso', 18,1,GETDATE(),NULL,NULL),
	   ('Jocón', 18,1,GETDATE(),NULL,NULL),
	   ('Morazán', 18,1,GETDATE(),NULL,NULL),
	   ('Olanchito', 18,1,GETDATE(),NULL,NULL),
	   ('Santa Rita', 18,1,GETDATE(),NULL,NULL),
	   ('Sulaco', 18,1,GETDATE(),NULL,NULL),
	   ('Victoria', 18,1,GETDATE(),NULL,NULL),
	   ('Yorito', 18,1,GETDATE(),NULL,NULL);

CREATE TABLE Gral.tblPersonas
(		pers_Id				INT IDENTITY(1,1),
		pers_Nombres		NVARCHAR(250)		NOT NULL,
		pers_Apellidos		NVARCHAR(250)		NOT NULL,
		pers_DNI			NVARCHAR(13)		NOT NULL,
		pers_Puesto			BIT					NOT NULL,
		pers_Sexo			CHAR(1)				NOT NULL,
		pers_EstadoCivil	INT					NOT NULL

		CONSTRAINT PK_Gral_tblPersonas_pers_Id		PRIMARY KEY(pers_Id),
		CONSTRAINT FK_Gral_tblPersonas_pers_EstadoCivil_Gral_tblEstadosCiviles_esci_Id FOREIGN KEY (pers_EstadoCivil) REFERENCES Gral.tblEstadoCiviles (esci_Id),
		CONSTRAINT CK_Gral_tblPersonas_pers_Sexo	CHECK(pers_Sexo IN('F','M')),
		CONSTRAINT UQ_Gral_tblPersonas_pers_DNI		UNIQUE(pers_DNI)
);

INSERT INTO Gral.tblPersonas
VALUES ('Angie','Caceres','0501200401519',1,'F',1)

INSERT INTO Gral.tblPersonas
VALUES ('Alex','Pineda','0501203401519',1,'M',1)

INSERT INTO Gral.tblPersonas
VALUES	('Prueba1', 'Prueba1', '0512200300736', 1, 'F', 1)

INSERT INTO Gral.tblPersonas
VALUES	('Carlos', 'Pineda', '0512200300966', 0, 'M', 1),
        ('Marcos', 'Prez', '0512202300784', 0, 'M', 1)
		



CREATE TABLE Gral.tblUsuarios
(
		usua_Id			INT IDENTITY(1,1) PRIMARY KEY,
		usua_Usuario	NVARCHAR(250)	  NOT NULL,
		usua_Clave		VARCHAR(250)	  NOT NULL,
		usua_Empleado	INT				  NOT NULL,
		usua_EsAdmin	BIT				  NOT NULL

		CONSTRAINT FK_Gral_tblUsuarios_usua_Empleado_Gral_tblPersonas_pers_Id	FOREIGN KEY (usua_Empleado) REFERENCES Gral.tblPersonas (pers_Id),
		CONSTRAINT UQ_Gral_tblUsuarios_usua_Usuarios UNIQUE (usua_Usuario)
);

-- ****************************** AÑADIR LOS CONSTRAINTS LUEGO DE INSERTAR 1 USUARIO ******************************
--CONSTRAINT FK_Gral_tblUsuarios_usua_UsuarioCrea_Gral_tblUsuarios_usua_Id		FOREIGN KEY (usua_UsuarioCrea)		REFERENCES Gral.tblUsuarios	(usua_Id),
--CONSTRAINT FK_Gral_tblUsuarios_usua_UsuarioModifica_Gral_tblUsuarios_usua_Id FOREIGN KEY (paqu_UsuarioModifica)	REFERENCES Gral.tblUsuarios	(usua_Id)



DECLARE @CLAVE VARBINARY (MAX) = HASHBYTES('SHA2_512','123')
DECLARE @INCRI VARCHAR(MAX) = CONVERT(VARCHAR(MAX),@CLAVE,2)

INSERT INTO Gral.tblUsuarios
VALUES('Admin',@INCRI,1,1)

DECLARE @CLAVE2 VARBINARY (MAX) = HASHBYTES('SHA2_512','1234')
DECLARE @INCRI2 VARCHAR(MAX) = CONVERT(VARCHAR(MAX),@CLAVE2,2)

INSERT INTO Gral.tblUsuarios
VALUES('No_Admin',@INCRI2,2,0)



CREATE TABLE Paq.tblPaquetes
(
		paqu_Id					INT IDENTITY(1,1),
		paqu_Codigo				INT					NOT NULL,
		paqu_Cliente			INT					NOT NULL,
		paqu_Ciudad				INT					NOT NULL,
		paqu_DireccionExacta	NVARCHAR(150)		NOT NULL,
		paqu_Observaciones		NVARCHAR(MAX)		NULL,

		-- ESTADO DE ENVIO --
		paqu_Bodega				DATETIME			DEFAULT GETDATE(),
		paqu_EnCamino			DATETIME			NULL,
		paqu_Entregado			DATETIME			NULL,

		-- AUDI --
		paqu_UsuarioCrea        INT					NOT NULL,
		paqu_FechaCrea          DATETIME			DEFAULT GETDATE(),
		paqu_UsuarioModifica    INT,
		paqu_FechaModifica      DATETIME,
		paqu_Estado				BIT NOT NULL		DEFAULT(1)

		CONSTRAINT PK_Paq_tblPaquetes_paqu_Id										PRIMARY KEY (paqu_Id),
		CONSTRAINT UQ_Paq_tblPaquetees_paqu_Codigo									UNIQUE	(paqu_Codigo),
		CONSTRAINT FK_Paq_tblPaquetes_paqu_Cliente_Gral_tblPersonas_pers_Id			FOREIGN KEY (paqu_Cliente)			REFERENCES Gral.tblPersonas (pers_Id),
		CONSTRAINT FK_Paq_tblPaquetes_paqu_Ciudad_Gral_tblCiudades_ciud_Id			FOREIGN KEY (paqu_Ciudad)			REFERENCES Gral.tblCiudades (ciud_Id),
		CONSTRAINT FK_Paq_tblPaquetes_paqu_UsuarioCrea_Gral_tblUsuarios_usua_Id		FOREIGN KEY (paqu_UsuarioCrea)		REFERENCES Gral.tblUsuarios	(usua_Id),
		CONSTRAINT FK_Paq_tblPaquetes_paqu_UsuarioModifica_Gral_tblUsuarios_usua_Id FOREIGN KEY (paqu_UsuarioModifica)	REFERENCES Gral.tblUsuarios	(usua_Id)
);


INSERT INTO Paq.tblPaquetes
VALUES(0101,4,12,'Casa Roja donde los olivos','Lo resibira una señora ingeniera','2023-12-03 8:15:00','2023-12-22 08:40:22', null,1,GETDATE(),null,null,1),
      (0102,4,120,'Calle 12, Bloque 3','Lo resibira una señora ingeniera','2023-12-03 8:25:25','2023-12-22 08:40:22', null,1,GETDATE(),null,null,1),
	  (0103,4,52,'Ave.16, NO, Calle 47, Casa 58, Bloque 25','Lo resibira una señora ingeniera','2023-12-03 8:55:59','2023-12-22 08:40:22', null,1,GETDATE(),null,null,1),
	  (0104,5,84,'Ave.25, NO, Calle 63, Casa 20, Bloque 63','Casa verde con un arbol de mango','2023-12-03 9:30:55','2023-12-22 15:12:44', null,1,GETDATE(),null,null,1),
	  (0105,5,96,'Ave.63, NO, Calle 32, Casa 51, Bloque 14','Casa Rosa con reja de metal','2023-12-03 12:55:25','2023-12-22 15:12:44', null,1,GETDATE(),null,null,1),
	  (0106,5,48,'Ave.45, NO, Calle 45, Casa 62, Bloque 32','Casa Morada con rojo','2023-12-03 15:25:45','2023-12-22 15:12:44', null,1,GETDATE(),null,null,1)



CREATE TABLE Paq.tblCamiones(
		
		cami_Id			INT IDENTITY (1,1) PRIMARY KEY,
		cami_Empleado	INT					NOT NULL,

		CONSTRAINT FK_Paq_Camiones_cami_Empleado_Gral_tblPersonas_pers_Id FOREIGN KEY (cami_Empleado) REFERENCES Gral.tblPersonas (pers_Id)
);

INSERT INTO Paq.tblCamiones
VALUES (1),
	   (2),
	   (3)

CREATE TABLE Paq.tblEnvios
(
		envi_Id					INT IDENTITY (1,1) PRIMARY KEY,
		envi_Camion				INT			NOT NULL,
		envi_FechaSalida		DATETIME	NOT NULL,
		
		envi_UsuarioCrea        INT					NOT NULL,
		envi_FechaCrea          DATETIME			DEFAULT GETDATE(),
		envi_UsuarioModifica    INT,
		envi_FechaModifica      DATETIME,
		envi_Estado				BIT NOT NULL		DEFAULT(1)

		CONSTRAINT FK_Paq_tblEnvios_envi_Camion_Paq_tblCamiones_cami_Id			  FOREIGN KEY (envi_Camion)				REFERENCES Paq.tblCamiones (cami_Id),
		CONSTRAINT FK_Paq_tblEnvios_envi_UsuarioCrea_Gral_tblUsuarios_usua_Id	  FOREIGN KEY (envi_UsuarioCrea)		REFERENCES Gral.tblUsuarios	(usua_Id),
		CONSTRAINT FK_Paq_tblEnvios_envi_UsuarioModifica_Gral_tblUsuarios_usua_Id FOREIGN KEY (envi_UsuarioModifica)	REFERENCES Gral.tblUsuarios	(usua_Id)
);

INSERT INTO  Paq.tblEnvios(envi_Camion, envi_FechaSalida, envi_UsuarioCrea, envi_FechaCrea, envi_UsuarioModifica, envi_FechaModifica, envi_Estado)
VALUES(1,'2023-12-22 08:40:22',1,Getdate(),null,null,1),
      (2,'2023-12-22 15:12:44',1,Getdate(),null,null,1)


CREATE TABLE Paq.tblEnviosPorPaquetes
(
		enpa_Id					INT IDENTITY (1,1) PRIMARY KEY,
		enpa_Envio				INT					NOT NULL,
		enpa_Paquete			INT					NOT NULL,

		enpa_UsuarioCrea        INT					NOT NULL,
		enpa_FechaCrea          DATETIME			DEFAULT GETDATE(),
		enpa_UsuarioModifica    INT,
		enpa_FechaModifica      DATETIME,
		enpa_Estado				BIT NOT NULL		DEFAULT(1)

		CONSTRAINT FK_Paq_tblEnviosPorPaquetes_enpa_Envio_Paq_tblEnvios_envi_Id	 FOREIGN KEY (enpa_Envio)   REFERENCES Paq.tblEnvios (envi_Id),
		CONSTRAINT FK_Paq_tblEnviosPorPaquetes_enpa_Paquete_Paq_tblPaquetes_paqu_Id FOREIGN KEY (enpa_Paquete) REFERENCES Paq.tblPaquetes (paqu_Id),
		CONSTRAINT FK_Paq_tblEnviosPorPaquetes_enpa_UsuarioCrea_Gral_tblUsuarios_usua_Id	  FOREIGN KEY (enpa_UsuarioCrea)		REFERENCES Gral.tblUsuarios	(usua_Id),
		CONSTRAINT FK_Paq_tblEnviosPorPaquetes_enpa_UsuarioModifica_Gral_tblUsuarios_usua_Id FOREIGN KEY (enpa_UsuarioModifica)	REFERENCES Gral.tblUsuarios	(usua_Id)
);

INSERT INTO Paq.tblEnviosPorPaquetes(enpa_Envio, enpa_Paquete, enpa_UsuarioCrea)
VALUES(1,1,1),
      (1,2,1),
	  (1,3,1),
	  (2,4,1),
	  (2,5,1),
	  (2,6,1)