IF EXISTS (select * from sys.views where name = 'UVW_CIDADE')
BEGIN 
	DROP VIEW UVW_CIDADE
END
GO

/******    G_CONDOMINO - EVital TI - SP - 18/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: View relacional de cidades
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE VIEW UVW_CIDADE
AS
	
	SELECT
		 C.Id
		,ISNULL(C.Nome, 'ND') NomeCidade
		,E.Id EstadoID
		,E.PaisID
		,E.NomeEstado
		,E.UF
		,E.NomePais
	FROM
		Cidade C
	JOIN
		UVW_ESTADO E
	ON
		C.EstadoID = E.Id