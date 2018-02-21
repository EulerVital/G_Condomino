IF EXISTS(select * from sys.procedures where name = 'USP_ENDERECO_SET')
BEGIN
	DROP PROC USP_ENDERECO_SET
END
GO

/******    G_CONDOMINO - EVital TI - SP - 19/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Insere/Altera endereço na base de dados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/

CREATE PROC USP_ENDERECO_SET
(
	 @EnderecoID INT = NULL
	,@Logradouro VARCHAR(300)
	,@Cep VARCHAR(20)
	,@Descricao VARCHAR(200) = NULL
	,@CidadeID INT 
	,@Excluido BIT = 0
)
AS 
BEGIN
	
	DECLARE @End_id INT = (select top 1 enderecoid from Endereco where Cep = @Cep AND CidadeID = @CidadeID)

	IF @Cep IS NOT NULL AND @End_id IS NULL
	BEGIN

		IF @EnderecoID IS NULL
		BEGIN
		
			INSERT INTO Endereco
			(
				 Logradouro
				,Cep
				,Descricao
				,CidadeID
			)SELECT
				 @Logradouro
				,@Cep
				,@Descricao
				,@CidadeID

			SET @EnderecoID = @@IDENTITY
		END
		ELSE
		BEGIN	
		
			UPDATE Endereco SET 
				 Logradouro = @Logradouro
				,Cep = @Cep
				,Descricao = @Descricao
				,Excluido = @Excluido
				,DataAlteracao = GETDATE()
			WHERE
				EnderecoID = @EnderecoID
		END

		SELECT @EnderecoID AS Id

	END
	ELSE
	BEGIN
		
		IF @End_id IS NULL
			SELECT 0
		ELSE
			SELECT @End_id AS Id
	END
END
GO