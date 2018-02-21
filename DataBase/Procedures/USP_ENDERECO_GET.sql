IF EXISTS(select * from sys.procedures where name = 'USP_ENDERECO_GET')
BEGIN
	DROP PROC USP_ENDERECO_GET
END
GO

/******    G_CONDOMINO - EVital TI - SP - 19/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: retornar dados de enderecos da base de dados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE PROC USP_ENDERECO_GET
(
	 @EnderecoID INT = NULL
	,@CidadeID INT = NULL
	,@EstadoID INT = NULL
	,@Cep VARCHAR(100) = NULL
	,@Excluido BIT = NULL
)
AS 
BEGIN
	
	SELECT
		 EnderecoID
		,Logradouro
		,Cep
		,Descricao
		,Excluido
		,CidadeID
		,NomeCidade
		,EstadoID
	FROM
		UVW_ENDERECO
	WHERE
		EnderecoID = COALESCE(@EnderecoID, EnderecoID)
	AND
		CidadeID = COALESCE(@CidadeID, CidadeID)
	AND
		EstadoID = COALESCE(@EstadoID, EstadoID)
	AND
		Cep = COALESCE(@Cep, Cep)
	AND
		Excluido = COALESCE(@Excluido, Excluido)

END
GO