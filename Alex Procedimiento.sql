USE Paqueteria

GO


CREATE OR ALTER PROCEDURE UDP_Inicio_Login
@usua_Usuario	NVARCHAR(250),
@usua_Clave		VARCHAR(250)
AS
BEGIN

DECLARE @CLAVE2 VARBINARY (MAX) = HASHBYTES('SHA2_512',@usua_Clave)
DECLARE @INCRI2 VARCHAR(MAX) = CONVERT(VARCHAR(MAX),@CLAVE2,2)



 SELECT T1.usua_EsAdmin , T2.pers_Nombres FROM Gral.tblUsuarios T1 INNER JOIN Gral.tblPersonas T2 ON T1.usua_Empleado = T2.pers_Id WHERE 
 usua_Clave = @INCRI2 AND usua_Usuario = @usua_Usuario


END
GO

CREATE OR ALTER PROCEDURE Gral.UDP_Departamentos
AS
BEGIN



SELECT T1.depa_ID, T1.depa_Descri FROM Gral.tblDepartamentos T1

END

GO

CREATE OR ALTER PROCEDURE Gral.UDP_Municipios
@depa_ID INT
AS
BEGIN

SELECT T1.ciud_ID, T1.ciud_Descri, t1.depa_ID FROM Gral.tblCiudades T1 WHERE T1.depa_ID = @depa_ID

END

GO

CREATE OR ALTER PROCEDURE Gral.UDP_EstadoCivil
AS
BEGIN

SELECT T1.esci_ID, T1.esci_Descripcion FROM Gral.tblEstadoCiviles T1 

END


GO

CREATE OR ALTER VIEW WV_tbLUsuarios
AS
 SELECT usua.usua_Id, usua.usua_Usuario,
		CASE usua.usua_EsAdmin
		WHEN '1' THEN 'Si'
		WHEN '0' THEN 'No'
		END AS 'Es_Admin' 
		FROM Gral.tbLUsuarios usua 
GO

CREATE OR ALTER PROCEDURE UDP_Empleados_Sin_Usuario
		
AS
BEGIN
	SELECT t2.pers_Id, 
		   t2.pers_Nombres, 
		   t2.pers_Apellidos
	  FROM Gral.[tblUsuarios] t1 
 FULL JOIN [Gral].[tblPersonas] t2  
		ON t1.usua_Empleado = t2.pers_Id 
	 WHERE t1.usua_Id IS NULL 
	   --AND t2.[empl_Estado] = 1 
END

GO


CREATE OR ALTER PROCEDURE UDP_InsertUsuario
	@usua_Usuario	NVARCHAR(250),		
	@usua_Clave		VARCHAR(250),	
	@usua_Empleado	INT		,		
	@usua_EsAdmin	BIT	,			

	@status				INT OUTPUT
AS
BEGIN
BEGIN TRY
	
	DECLARE @CLAVE VARBINARY (MAX) = HASHBYTES('SHA2_512',@usua_Clave)
    DECLARE @INCRI VARCHAR(MAX) = CONVERT(VARCHAR(MAX),@CLAVE,2)

	INSERT Gral.tblUsuarios(usua_Usuario, usua_Clave, usua_Empleado, usua_EsAdmin)
	VALUES(@usua_Usuario, @usua_Clave, @usua_Empleado, @usua_EsAdmin);
	SET @status = 1;

END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 
END;

go


CREATE OR ALTER PROCEDURE UDP_ActualizarUsuario
	@usua_Id        INT,
	@usua_Usuario	NVARCHAR(250),		
	@usua_Clave		VARCHAR(250),	
	@usua_Empleado	INT		,		
	@usua_EsAdmin	BIT	,			

	@status				INT OUTPUT
AS
BEGIN
BEGIN TRY
	
	IF (@usua_Clave = 'a:>2a')
BEGIN

Set @usua_Clave = (SELECT usua_Clave FROM Gral.tblUsuarios WHERE usua_Id = @usua_Id )

END

	DECLARE @CLAVE VARBINARY (MAX) = HASHBYTES('SHA2_512',@usua_Clave)
    DECLARE @INCRI VARCHAR(MAX) = CONVERT(VARCHAR(MAX),@CLAVE,2)

UPDATE Gral.tblUsuarios
SET usua_Empleado = @usua_Empleado, 
    usua_Usuario = @usua_Usuario,
	usua_Clave = @INCRI,
	usua_EsAdmin = @usua_EsAdmin
	WHERE usua_Id = @usua_Id
	
	SET @status = 1;
END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 
END;

go


CREATE OR ALTER PROCEDURE UDP_EliminarUsuario
	@usua_Id        INT,
		
	@status				INT OUTPUT
AS
BEGIN
BEGIN TRY
	
	DELETE Gral.tblUsuarios where usua_Id = @usua_Id

	SET @status = 1;
END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 

END;

----------------------------------------------------------------------------------------------------------------------

--ENVIOS POR PAQUETE

GO
CREATE OR ALTER PROCEDURE Paq.UDP_Envios_Por_Paquete_Mostrar
@enpa_Envio				INT
AS
BEGIN

SELECT t2.paqu_Id,t2.paqu_EnCamino, t2.paqu_Ciudad, t2.paqu_DireccionExacta 
FROM Paq.tblEnviosPorPaquetes T1 INNER JOIN Paq.tblPaquetes t2 
ON t1.enpa_Id = t2.paqu_Id WHERE t1.enpa_Envio = @enpa_Envio


END

GO
CREATE OR ALTER PROCEDURE Paq.UDP_Envios_Mostrar
AS
BEGIN
SELECT T1.envi_Id, T1.envi_Camion FROM Paq.tblEnvios T1

END


GO


CREATE OR ALTER PROCEDURE Paq.UDP_Envios_Por_Paquete_Insertar

@enpa_Envio				INT,
@enpa_Paquete			INT,
@enpa_UsuarioCrea       INT,
@status				INT OUTPUT
AS
BEGIN

BEGIN TRY
	
	INSERT INTO Paq.tblEnviosPorPaquetes(enpa_Envio, enpa_Paquete, enpa_UsuarioCrea)
VALUES(@enpa_Envio,@enpa_Paquete,@enpa_UsuarioCrea)
	SET @status = 1;


UPDATE Paq.tblPaquetes
SET paqu_EnCamino = GETDATE()
WHERE paqu_Id = @enpa_Paquete



END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 


END

GO

CREATE OR ALTER PROCEDURE Paq.UDP_Envios_Por_Paquete_Eliminar

@enpa_Envio				INT,
@enpa_Paquete			INT,
@status				INT OUTPUT
AS
BEGIN

BEGIN TRY
	
	DELETE Paq.tblEnviosPorPaquetes 
	where enpa_Envio = @enpa_Envio AND 
	      enpa_Paquete = @enpa_Paquete

	UPDATE Paq.tblPaquetes
	SET paqu_EnCamino = null
	WHERE paqu_Id = @enpa_Paquete
	
	SET @status = 1;
END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 


END


------------------------------------------------------------------------------------------------
--------------------------------------ENVIOS---------------------------------------------------
GO
CREATE OR ALTER VIEW WV_tblEnvios
AS
 SELECT T1.envi_Id, 
        T1.envi_Camion,
		T3.pers_Nombres + ' ' + T3.pers_Apellidos AS Transportista,		
		T1.envi_FechaSalida 
		
	
		FROM Paq.tblEnvios T1 INNER JOIN Paq.tblCamiones T2
		ON T1.envi_Camion = T2.cami_Id INNER JOIN Gral.tblPersonas T3
		ON T2.cami_Empleado = T3.pers_Id
		Where t1.envi_Estado = 1


		GO
CREATE OR ALTER PROCEDURE Paq.UDP_tblEnvios_Insertar
@envi_Camion				INT	,	
@envi_FechaSalida		DATETIME,
@envi_UsuarioCrea        INT,
@status				INT OUTPUT
AS
BEGIN

BEGIN TRY
INSERT INTO tblEnvios (envi_Camion, envi_FechaSalida, envi_UsuarioCrea)
VALUES(@envi_Camion,@envi_FechaSalida,@envi_UsuarioCrea)
	SET @status = 1;
END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 
END;

GO

CREATE OR ALTER PROCEDURE Paq.UDP_tblEnvios_Editar
@envi_Id				     INT,
@envi_Camion				INT	,	
@envi_FechaSalida		NVARCHAR(100),

@envi_UsuarioModifica        INT,
@status				INT OUTPUT
AS
BEGIN

BEGIN TRY
UPDATE tblEnvios
    SET envi_Camion = @envi_Camion,
    envi_FechaSalida = @envi_FechaSalida,
	
	envi_UsuarioModifica = @envi_UsuarioModifica,
	envi_FechaModifica = GETDATE()
	WHERE envi_Id = @envi_Id
	SET @status = 1;
END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 
END;

GO

CREATE OR ALTER PROCEDURE Paq.UDP_tblEnvios_Eliminar
@envi_Id				     INT,	
@envi_UsuarioModifica        INT,
@status				INT OUTPUT
AS
BEGIN

BEGIN TRY
UPDATE tblEnvios
    SET envi_UsuarioModifica = @envi_UsuarioModifica,
		envi_FechaModifica = GETDATE(),
		envi_Estado = 0 
		WHERE envi_Id = @envi_Id
	
	DELETE Paq.tblEnviosPorPaquetes 
	where enpa_Envio = @envi_Id
	   

	SET @status = 1;
END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 
END;

exec Paq.UDP_tblEnvios_Eliminar 2,1,1

SELECT * FROM Paq.tblPaquetes

SELECT * FROM Paq.tblEnviosPorPaquetes

selec


GO

CREATE VIEW V_Grafico_Paquetes_Por_Cliente
AS
Select T3.pers_Nombres + ' '+ T3.pers_Apellidos AS Cliente, COUNT(t2.paqu_Id) AS Cantidad from Paq.tblEnviosPorPaquetes T1 INNER JOIN Paq.tblPaquetes T2
ON T1.enpa_Paquete = T2.paqu_Id INNER JOIN Gral.tblPersonas T3
ON T2.paqu_Cliente = T3.pers_Id
GROUP BY pers_Nombres, pers_Apellidos

GO

CREATE PROCEDURE UDP_Grafico_Paquetes_Por_Cliente
AS
BEGIN

Select T3.pers_Nombres + ' '+ T3.pers_Apellidos AS Cliente, COUNT(t2.paqu_Id) AS Cantidad from Paq.tblEnviosPorPaquetes T1 INNER JOIN Paq.tblPaquetes T2
ON T1.enpa_Paquete = T2.paqu_Id INNER JOIN Gral.tblPersonas T3
ON T2.paqu_Cliente = T3.pers_Id
GROUP BY pers_Nombres, pers_Apellidos


END

Go

CREATE OR ALTER VIEW V_ddl_Camiones
AS
SELECT T1.cami_Id, T2.pers_Nombres + ' ' + T2.pers_Apellidos AS Transportista FROM Paq.tblCamiones T1 INNER JOIN Gral.tblPersonas T2 ON  T1.cami_Empleado = T2.pers_Id

GO