IF EXISTS (select * from sys.views where name = 'UVW_ENDERECO')
BEGIN 
	DROP VIEW UVW_ENDERECO
END
GO

/******    G_CONDOMINO - EVital TI - SP - 18/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: View relacional de endereço
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE VIEW UVW_ENDERECO
AS
	
	SELECT
		 E.EnderecoID
		,E.Logradouro
		,E.Cep
		,ISNULL(E.Descricao, '') Descricao
		,E.Excluido
		,C.Id CidadeID
		,C.NomeCidade
		,C.EstadoID
		,C.PaisID
		,C.NomeEstado
		,C.UF
		,C.NomePais
	FROM
		Endereco E
	JOIN
		UVW_CIDADE C
	ON
		C.Id = E.CidadeID