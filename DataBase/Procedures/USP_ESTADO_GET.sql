IF EXISTS(select * from sys.procedures where name = 'USP_ESTADO_GET')
BEGIN
	DROP PROC USP_ESTADO_GET
END
GO

/******    G_CONDOMINO - EVital TI - SP - 19/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: retornar dados de estados da base de dados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE PROC USP_ESTADO_GET
(
	 @EstadoID INT = NULL
	,@PaisID INT = NULL
	,@Nome VARCHAR(100) = NULL
)
AS 
BEGIN
	
	SELECT
		 Id
		,PaisID
		,NomeEstado
		,UF
		,NomePais
	FROM
		UVW_ESTADO E
	WHERE 
		E.Id = COALESCE(@EstadoID, E.Id)
	AND
		E.PaisID = COALESCE(@PaisID, E.PaisID)
	AND
		E.NomeEstado = COALESCE(@Nome, NomeEstado)

END
GO