IF EXISTS(select * from sys.procedures where name = 'USP_CONDOMINIO_GET')
BEGIN
	DROP PROC USP_CONDOMINIO_GET
END
GO

/******    G_CONDOMINO - EVital TI - SP - 19/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: retornar dados de condominios da base de dados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE PROC USP_CONDOMINIO_GET
(
	 @CondominioID INT = NULL
	,@EnderecoID INT = NULL
	,@CidadeID INT = NULL
	,@EstadoID INT = NULL
	,@Nome VARCHAR(100) = NULL
	,@Excluido BIT = NULL
)
AS 
BEGIN
	
	SELECT
		 CondominioID
		,Nome
		,TipoCondominio
		,Excluido
		,EnderecoID
		,Logradouro
		,Cep
		,Descricao
		,Excluido_Endereco
		,CidadeID
		,EstadoID
	FROM
		UVW_CONDOMINIO
	WHERE
		CondominioID = COALESCE(@CondominioID, CondominioID)
	AND
		CidadeID = COALESCE(@CidadeID, CidadeID)
	AND
		EstadoID = COALESCE(@EstadoID, EstadoID)
	AND
		Nome = COALESCE(@Nome, Nome)
	AND
		EnderecoID = COALESCE(@EnderecoID, EnderecoID)
	AND
		Excluido = COALESCE(@Excluido, Excluido)

END
GO