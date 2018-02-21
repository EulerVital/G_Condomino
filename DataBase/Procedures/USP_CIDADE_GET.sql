IF EXISTS(select * from sys.procedures where name = 'USP_CIDADE_GET')
BEGIN
	DROP PROC USP_CIDADE_GET
END
GO

/******    G_CONDOMINO - EVital TI - SP - 19/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: retornar dados de cidades da base de dados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE PROC USP_CIDADE_GET
(
	 @CidadeID INT = NULL
	,@EstadoID INT = NULL
	,@Nome VARCHAR(100) = NULL
)
AS 
BEGIN
	
	SELECT
		 Id
		,NomeCidade
		,EstadoID
		,NomeEstado
		,UF
	FROM
		UVW_CIDADE
	WHERE
		Id = COALESCE(@CidadeID, Id)
	AND
		EstadoID = COALESCE(@EstadoID, EstadoID)
	AND
		NomeCidade = COALESCE(@Nome, NomeCidade)

END
GO