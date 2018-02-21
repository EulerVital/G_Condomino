IF EXISTS(select * from sys.procedures where name = 'USP_CONDOMINIO_SET')
BEGIN
	DROP PROC USP_CONDOMINIO_SET
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Insere/Altera Condominio na base de dados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE PROC USP_CONDOMINIO_SET
(
	 @CondominioID INT = NULL
	,@Nome VARCHAR(150)
	,@EnderecoID INT
	,@TipoCondominio CHAR(2) = NULL
	,@Excluido BIT = 0
)
AS 
BEGIN
	
	IF @CondominioID IS NULL
	BEGIN
		
		INSERT INTO Condominio
		(
			 CondominioID
			,Nome
			,EnderecoID
			,TipoCondominio
		)SELECT
			 @CondominioID
			,@Nome
			,@EnderecoID
			,@TipoCondominio

		SET @CondominioID = @@IDENTITY
	END
	ELSE
	BEGIN	
		
		UPDATE Condominio SET 
			 Nome = @Nome
			,EnderecoID = @EnderecoID
			,TipoCondominio = @TipoCondominio
			,Excluido = @Excluido
			,DataAlteracao = GETDATE()
		WHERE
			CondominioID = @CondominioID
	END

	SELECT @CondominioID AS Id

END
GO