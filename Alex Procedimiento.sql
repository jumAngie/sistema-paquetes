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

CREATE OR ALTER PROCEDURE Departametos
AS
BEGIN



SELECT * FROM Gral.tblDepartamentos

END


GO

CREATE OR ALTER VIEW WV_tbLUsuarios
AS
 SELECT usua.usua_Id, usua.usua_Usuario,
		CASE usua.usua_EsAdmin
		WHEN '1' THEN 'Sí'
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
	
	IF (@usua_Clave = '' OR @usua_Clave = NULL )
BEGIN

Set @usua_Clave = (SELECT usua_Clave FROM Gral.tblUsuarios WHERE usua_Id = @usua_Id )

	DECLARE @CLAVE VARBINARY (MAX) = HASHBYTES('SHA2_512',@usua_Clave)
    DECLARE @INCRI VARCHAR(MAX) = CONVERT(VARCHAR(MAX),@CLAVE,2)
END

UPDATE Gral.tblUsuarios
SET usua_Empleado = @usua_Empleado, 
    usua_Usuario = usua_Usuario,
	usua_Clave = @INCRI,
	usua_EsAdmin = @usua_EsAdmin
	WHERE usua_Id = @usua_Id

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

END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 
END;