IF EXISTS (select * from sys.views where name = 'UVW_ESTADO')
BEGIN 
	DROP VIEW UVW_ESTADO
END
GO

/******    G_CONDOMINO - EVital TI - SP - 18/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: View relacional de estados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE VIEW UVW_ESTADO
AS
	
	SELECT
		 E.Id
		,ISNULL(E.PaisID, 0) PaisID
		,ISNULL(E.Nome, 'ND') NomeEstado
		,ISNULL(E.UF, 'ND') UF
		,ISNULL(P.Nome, 'ND') NomePais
	FROM
		Estado E
	JOIN
		Pais P
	ON
		E.PaisID = P.Id