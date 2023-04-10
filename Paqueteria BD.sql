CREATE DATABASE Paqueteria
GO
USE Paqueteria

GO
CREATE SCHEMA Gral
GO

CREATE SCHEMA Paq
GO




CREATE TABLE Gral.tblPersonas
(		pers_Id				INT IDENTITY(1,1),
		pers_Nombres		NVARCHAR(250)		NOT NULL,
		pers_Apellidos		NVARCHAR(250)		NOT NULL,
		pers_DNI			NVARCHAR(13)		NOT NULL,
		pers_Puesto			BIT					NOT NULL,
		pers_Sexo			CHAR(1)				NOT NULL,
		pers_EstadoCivil	INT					NOT NULL

);