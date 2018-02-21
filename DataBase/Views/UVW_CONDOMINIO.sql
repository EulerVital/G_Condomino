IF EXISTS (select * from sys.views where name = 'UVW_CONDOMINIO')
BEGIN 
	DROP VIEW UVW_CONDOMINIO
END
GO

/******    G_CONDOMINO - EVital TI - SP - 18/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: View relacional de condominio
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE VIEW UVW_CONDOMINIO
AS
	
	SELECT
		 C.CondominioID
		,C.Nome
		,C.TipoCondominio
		,C.Excluido
		,E.EnderecoID
		,E.Logradouro
		,E.Cep
		,E.Descricao
		,E.Excluido Excluido_Endereco
		,E.CidadeID
		,E.NomeCidade
		,E.EstadoID
		,E.PaisID
		,E.NomeEstado
		,E.UF
		,E.NomePais
	FROM
		Condominio C
	JOIN
		UVW_ENDERECO E
	ON
		C.EnderecoID = E.EnderecoID