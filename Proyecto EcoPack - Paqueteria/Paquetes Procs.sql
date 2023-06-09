USE Paqueteria


------------------------------------------------------------------------------------------------
--------------------------------------Paquetes---------------------------------------------------

GO
CREATE OR ALTER VIEW WV_tblPaquetes
AS
 SELECT T1.paqu_Id, 
        T1.paqu_Cliente,
		T1.paqu_Codigo,
		T2.pers_Nombres + ' '+ T2.pers_Apellidos AS Cliente,		
		T1.paqu_Ciudad,
		T3.ciud_Descri,
		T4.depa_Descri,
		T1.paqu_Bodega

		FROM Paq.tblPaquetes T1			INNER JOIN Gral.tblPersonas			T2
		ON T1.paqu_Cliente = T2.pers_Id INNER JOIN Gral.tblCiudades			T3
		ON T1.paqu_Ciudad = T3.ciud_ID  INNER JOIN Gral.tblDepartamentos	T4
		ON T3.depa_ID = T4.depa_ID
		WHERE T1.paqu_Estado = 1


GO

CREATE OR ALTER PROCEDURE Paq.UDP_tblPaquetes_Insertar
@paqu_Cliente			INT, 
@paqu_Ciudad			INT,
@paqu_Codigo			INT,
@paqu_DireccionExacta	NVARCHAR(150),
@paqu_Observaciones     NVARCHAR(MAX),
@paqu_UsuarioCrea		INT,
@status					INT OUTPUT
AS
BEGIN

BEGIN TRY
INSERT INTO [Paq].[tblPaquetes] ([paqu_Cliente], paqu_Codigo, [paqu_Ciudad], [paqu_DireccionExacta], paqu_Observaciones, [paqu_Bodega], [paqu_UsuarioCrea])
VALUES							(@paqu_Cliente, @paqu_Codigo, @paqu_Ciudad, @paqu_DireccionExacta, @paqu_Observaciones, GETDATE(), @paqu_UsuarioCrea)
	SET @status = 1;
END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 
END;

GO

GO
CREATE OR ALTER PROCEDURE Paq.UDP_tblPaquetes_Editar
@paqu_Id					INT,
@paqu_Cliente				INT, 
@paqu_Codigo				INT,
@paqu_Ciudad				INT, 
@paqu_DireccionExacta		NVARCHAR(150),  
@paqu_UsuarioModifica		INT,
@status						INT OUTPUT
AS
BEGIN

BEGIN TRY
UPDATE tblPaquetes
    SET		paqu_Cliente = @paqu_Cliente,
			paqu_Codigo = @paqu_Codigo,
			paqu_Ciudad =  @paqu_Ciudad,
			paqu_DireccionExacta = @paqu_DireccionExacta,
			paqu_UsuarioModifica = @paqu_UsuarioModifica,
			paqu_FechaModifica =   GETDATE()
	WHERE	paqu_Id = @paqu_Id
	SET @status = 1;
END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 
END;

GO

CREATE OR ALTER PROCEDURE Paq.UDP_tblPaquetes_Eliminar
@paqu_Id				     INT,	
@paqu_UsuarioModifica		 INT,
@status						 INT OUTPUT
AS
BEGIN

BEGIN TRY
UPDATE tblPaquetes
    SET paqu_UsuarioModifica = @paqu_UsuarioModifica,
		paqu_FechaModifica = GETDATE(),
		paqu_Estado = 0 
		WHERE paqu_Id = @paqu_Id
	
	SET @status = 1;
END TRY
BEGIN CATCH 
	SET @status = 0;
END CATCH 
END;

GO

-- A�ADIRLO A LA API 
CREATE OR ALTER PROC Paq.UDP_tblPaquetes_ListarPaquetePorCodigo
		@Codigo INT
AS
BEGIN
	SELECT	paqu_Id, paqu_Codigo, paqu_Cliente, paqu_Ciudad, ciudad.ciud_Descri, pers.pers_Nombres + ' ' +pers.pers_Apellidos AS cliente, depto.depa_Descri, paqu_DireccionExacta, paqu_Observaciones, paqu_Bodega, paqu_EnCamino, paqu_Entregado,
	CASE
	WHEN paqu_Entregado IS NULL AND paqu_EnCamino IS NULL THEN 'En Bodega'
	WHEN paqu_Entregado IS NULL AND paqu_EnCamino IS NOT NULL THEN 'En Camino'
	WHEN paqu_Entregado IS NOT NULL AND paqu_EnCamino IS NOT NULL THEN 'Entregado'
	
	END AS 'Estado'
	FROM	Paq.tblPaquetes paquetes INNER JOIN  [Gral].[tblCiudades] ciudad
	ON		paquetes.paqu_Ciudad = ciudad.ciud_ID INNER JOIN [Gral].[tblDepartamentos] depto
	ON		ciudad.depa_ID = depto.depa_ID INNER JOIN Gral.tblPersonas pers
	ON		paquetes.paqu_Cliente = pers.pers_Id
	WHERE	paqu_Codigo = @Codigo AND 
	paqu_Estado = 1

END;

GO

CREATE OR ALTER VIEW VW_Clientes
AS

SELECT pers_Id, pers_Nombres + ' ' + pers_Apellidos AS 'cliente' FROM Gral.tblPersonas perso
WHERE	perso.pers_Puesto = 0

GO

CREATE OR ALTER PROC Gral.UDP_tblCiudades_CiudadesPorDepto
	@deptoID	INT
AS
BEGIN
SELECT  ciud_ID, ciud_Descri, ciu.depa_ID FROM Gral.tblCiudades ciu INNER JOIN Gral.tblDepartamentos dep
ON		ciu.depa_ID = dep.depa_ID
WHERE	ciu.depa_ID = @deptoID
END