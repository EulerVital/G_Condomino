/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Pais
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Pais')
BEGIN
	CREATE TABLE Pais
	(
		 Id INT PRIMARY KEY IDENTITY(1,1)
		,Nome VARCHAR(100)
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Estado
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Estado')
BEGIN
	CREATE TABLE Estado
	(
		 Id INT PRIMARY KEY IDENTITY(1,1)
		,PaisID INT FOREIGN KEY (PaisID) REFERENCES Pais
		,Nome VARCHAR(150)
		,UF CHAR(2)
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Cidade
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Cidade')
BEGIN
	CREATE TABLE Cidade
	(
		 Id INT PRIMARY KEY IDENTITY(1,1)
		,Nome VARCHAR(150)
		,EstadoID INT FOREIGN KEY (EstadoID) REFERENCES Estado
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Enderecos cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Endereco')
BEGIN
	CREATE TABLE Endereco
	(
		 EnderecoID INT PRIMARY KEY IDENTITY(1,1)
		,Logradouro VARCHAR(300) NOT NULL
		,Cep VARCHAR(300) NOT NULL
		,Descricao VARCHAR(200)
		,CidadeID INT FOREIGN KEY (CidadeID) REFERENCES Cidade NOT NULL
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO


/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Conominios cadastrados
** OBS: O campo TipoCondominio indica se o condominio será de Predio (P), 
**      Bloco/Predio (BP), Bloco/Casa (BC), Casa (C),
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Condominio')
BEGIN
	CREATE TABLE Condominio
	(
		 CondominioID INT PRIMARY KEY IDENTITY(1,1)
		,Nome VARCHAR(150) NOT NULL
		,EnderecoID INT FOREIGN KEY (EnderecoID) REFERENCES Endereco NOT NULL
		,TipoCondominio CHAR(2)  DEFAULT('BP')
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Blocos cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Bloco')
BEGIN
	CREATE TABLE Bloco
	(
		 BlocoID INT PRIMARY KEY IDENTITY(1,1)
		,NomeIndentifcacao VARCHAR(150) NOT NULL
		,CondominioID INT FOREIGN KEY (CondominioID) REFERENCES Condominio NOT NULL
		,Descricao VARCHAR(200)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Casas cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Casa')
BEGIN
	CREATE TABLE Casa
	(
		 CasaID INT PRIMARY KEY IDENTITY(1,1)
		,NomeIndentifcacao VARCHAR(150) NOT NULL
		,CondominioID INT FOREIGN KEY (CondominioID) REFERENCES Condominio
		,BlocoID INT FOREIGN KEY (BlocoID) REFERENCES Bloco
		,QtdComodos INT
		,ValorInicial DECIMAL(10,2) DEFAULT(0.00)
		,ValorRealcado DECIMAL(10,2) DEFAULT(0.00)
		,DescricaoGeral VARCHAR(MAX)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Predios cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Predio')
BEGIN
	CREATE TABLE Predio
	(
		 PredioID INT PRIMARY KEY IDENTITY(1,1)
		,NomeIndentifcacao VARCHAR(150) NOT NULL
		,CondominioID INT FOREIGN KEY (CondominioID) REFERENCES Condominio
		,BlocoID INT FOREIGN KEY (BlocoID) REFERENCES Bloco
		,QtdApt INT
		,DescricaoGeral VARCHAR(MAX)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Apartamentos cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Apartamento')
BEGIN
	CREATE TABLE Apartamento
	(
		 ApartamentoID INT PRIMARY KEY IDENTITY(1,1)
		,NomeIndentifcacao VARCHAR(150) NOT NULL
		,PredioID INT FOREIGN KEY (PredioID) REFERENCES Predio NOT NULL
		,QtdComodos INT
		,Andar INT NOT NULL
		,DescricaoGeral VARCHAR(MAX)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Moradores cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Morador')
BEGIN
	CREATE TABLE Morador
	(
		 MoradorID INT PRIMARY KEY IDENTITY(1,1)
		,Nome VARCHAR(50) NOT NULL
		,SobrenomeCompleto VARCHAR(100) NOT NULL
		,Cpf VARCHAR(12) UNIQUE NOT NULL
		,Rg VARCHAR(14) 
		,DataNascimento DATE NOT NULL
		,CasaID INT FOREIGN KEY (CasaID) REFERENCES Casa
		,ApartamentoID INT FOREIGN KEY (ApartamentoID) REFERENCES Apartamento
		,MoradorResposavelID INT FOREIGN KEY (MoradorResposavelID) REFERENCES Morador
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Tipo de contatos cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'TipoContato')
BEGIN
	CREATE TABLE TipoContato
	(
		 TipoContatoID INT PRIMARY KEY IDENTITY(1,1)
		,NomeTipo VARCHAR(50) NOT NULL
		,Descricao VARCHAR(100)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Tipo de contatos cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Contato')
BEGIN
	CREATE TABLE Contato
	(
		 ContatoID INT PRIMARY KEY IDENTITY(1,1)
		,Valor VARCHAR(200) NOT NULL
		,TipoContatoID INT  FOREIGN KEY (TipoContatoID) REFERENCES TipoContato
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Usuarios cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'UsuarioAdmin')
BEGIN
	CREATE TABLE UsuarioAdmin
	(
		 UsuarioID INT PRIMARY KEY IDENTITY(1,1)
		,NomeUser VARCHAR(20) NOT NULL
		,Email VARCHAR(100) NOT NULL
		,Senha VARCHAR(50) NOT NULL
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Usuarios de Moradores cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'UsuarioMorador')
BEGIN
	CREATE TABLE UsuarioMorador
	(
		 UsuarioMoradorID INT PRIMARY KEY IDENTITY(1,1)
		,NomeUser VARCHAR(20) NOT NULL
		,Senha VARCHAR(50) NOT NULL
		,MoradorID INT FOREIGN KEY (MoradorID) REFERENCES Morador
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Departamentos cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Departamento')
BEGIN
	CREATE TABLE Departamento
	(
		 DepartamentoID INT PRIMARY KEY IDENTITY(1,1)
		,Nome VARCHAR(20) NOT NULL
		,DescricaoGeral VARCHAR(200)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Profissões cadastradas
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Profissao')
BEGIN
	CREATE TABLE Profissao
	(
		 ProfissaoID INT PRIMARY KEY IDENTITY(1,1)
		,Nome VARCHAR(20) NOT NULL
		,DescricaoGeral VARCHAR(200)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Funcionarios cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Funcionario')
BEGIN
	CREATE TABLE Funcionario
	(
		 FuncionarioID INT PRIMARY KEY IDENTITY(1,1)
		,Nome VARCHAR(20) NOT NULL
		,Sobrenome VARCHAR(150) NOT NULL
		,Cpf VARCHAR(15) UNIQUE
		,Rg VARCHAR(20)
		,Nun_Carteira VARCHAR(40)
		,DescricaoGeral VARCHAR(200)
		,DepartamentoID INT FOREIGN KEY (DepartamentoID) REFERENCES Departamento
		,ProfissaoID INT FOREIGN KEY (ProfissaoID) REFERENCES Profissao
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Associativa de Contatos cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Contato_Ass')
BEGIN
	CREATE TABLE Contato_Ass
	(
		 Contato_AssID INT PRIMARY KEY IDENTITY(1,1)
		,ContatoID INT FOREIGN KEY (ContatoID) REFERENCES Contato NOT NULL
		,MoradorID INT  FOREIGN KEY (MoradorID) REFERENCES Morador
		,FuncionarioID INT  FOREIGN KEY (FuncionarioID) REFERENCES Funcionario
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Grupo de usuarios publicos cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'GrupoUsuarioPublico')
BEGIN
	CREATE TABLE GrupoUsuarioPublico
	(
		 GrupoUsuarioPublicoID INT PRIMARY KEY IDENTITY(1,1)
		,NomeGrupo VARCHAR(20) NOT NULL
		,CodigoGrupo INT
		,DescricaoGeral VARCHAR(200)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Usuarios publicos (Funcionarios) cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'UsuarioPublico')
BEGIN
	CREATE TABLE UsuarioPublico
	(
		 UsuarioPublicoID INT PRIMARY KEY IDENTITY(1,1)
		,NomeUser VARCHAR(20) NOT NULL
		,Senha VARCHAR(50) NOT NULL
		,FuncionarioID INT FOREIGN KEY (FuncionarioID) REFERENCES Funcionario NOT NULL
		,GrupoUsuarioPublicoID INT FOREIGN KEY (GrupoUsuarioPublicoID) REFERENCES GrupoUsuarioPublico
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Tipo de Areas do condominio cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'TipoArea')
BEGIN
	CREATE TABLE TipoArea
	(
		 TipoAreaID INT PRIMARY KEY IDENTITY(1,1)
		,NomeTipo VARCHAR(100) NOT NULL
		,Descricao VARCHAR(200)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Areas do condominio cadastrados
** OBS: O campo HorariosIds amazenas os ids dos horarios diponiveis separados por virgula
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Area')
BEGIN
	CREATE TABLE Area
	(
		 AreaID INT PRIMARY KEY IDENTITY(1,1)
		,NomeArea VARCHAR(MAX) NOT NULL
		,Regras VARCHAR(200)
		,TipoAreaID INT FOREIGN KEY (TipoAreaID) REFERENCES TipoArea
		,HorariosIds VARCHAR(MAX) NOT NULL
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Imagens cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Imagem')
BEGIN
	CREATE TABLE Imagem
	(
		 ImagemID INT PRIMARY KEY IDENTITY(1,1)
		,Caminho VARCHAR(MAX) NOT NULL
		,Extensao VARCHAR(5)
		,Descricao VARCHAR(200)
		,UsuarioPublicoID INT FOREIGN KEY (UsuarioPublicoID) REFERENCES UsuarioPublico
		,UsuarioAdminID INT FOREIGN KEY (UsuarioAdminID) REFERENCES UsuarioAdmin
		,UsuarioMoradorID INT FOREIGN KEY (UsuarioMoradorID) REFERENCES UsuarioMorador
		,ApartamentoID INT FOREIGN KEY (ApartamentoID) REFERENCES Apartamento
		,CondominioID INT FOREIGN KEY (CondominioID) REFERENCES Condominio
		,AreaID INT FOREIGN KEY (AreaID) REFERENCES Area
		,CasaID INT FOREIGN KEY (CasaID) REFERENCES Casa
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Horarios cadastradas
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Horario')
BEGIN
	CREATE TABLE Horario
	(
		 HorarioID INT PRIMARY KEY IDENTITY(1,1)
		,HorarioValor VARCHAR(50)
		,HoraInicio TIME
		,HoraFinal TIME
		,IsReservado BIT DEFAULT(0)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 17/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Reserva de Area cadastradas
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'ReservarArea')
BEGIN
	CREATE TABLE ReservarArea
	(
		 ReservarAreaID INT PRIMARY KEY IDENTITY(1,1)
		,AreaID INT FOREIGN KEY (AreaID) REFERENCES Area
		,MoradorID INT FOREIGN KEY (MoradorID) REFERENCES Morador
		,HorarioID INT FOREIGN KEY (HorarioID) REFERENCES Horario
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 18/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Tipo de Correspondência cadastradas
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'TipoCorrespondencia')
BEGIN
	CREATE TABLE TipoCorrespondencia
	(
		 TipoCorrespondenciaID INT PRIMARY KEY IDENTITY(1,1)
		,NomeTipo VARCHAR(100) NOT NULL
		,DescricaoGeral VARCHAR(200)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 18/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Correspondência cadastradas
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Correspondencia')
BEGIN
	CREATE TABLE Correspondencia
	(
		 CorrespondenciaID INT PRIMARY KEY IDENTITY(1,1)
		,DataRecebida DATETIME NOT NULL
		,Anotacoes VARCHAR(MAX)
		,UsuarioPublicoID INT FOREIGN KEY(UsuarioPublicoID) REFERENCES UsuarioPublico
		,TipoCorrespondenciaID INT FOREIGN KEY(TipoCorrespondenciaID) REFERENCES TipoCorrespondencia NOT NULL
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 18/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena log de usuario admin cadastrados
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'LogUsuario')
BEGIN
	CREATE TABLE LogUsuario
	(
		 LogUsuarioID INT PRIMARY KEY IDENTITY(1,1)
		,DescricaoLog VARCHAR(MAX) NOT NULL
		,UsuarioPublicoID INT FOREIGN KEY(UsuarioPublicoID) REFERENCES UsuarioPublico
		,UsuarioAdminID INT FOREIGN KEY(UsuarioAdminID) REFERENCES UsuarioAdmin
		,UsuarioMoradorID INT FOREIGN KEY(UsuarioMoradorID) REFERENCES UsuarioMorador
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 18/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Pessoas que utilizaram as areas reservadas cadastradas
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Pessoa')
BEGIN
	CREATE TABLE Pessoa
	(
		 PessoaID INT PRIMARY KEY IDENTITY(1,1)
		,Nome VARCHAR(100) NOT NULL
		,TipoDocumento VARCHAR(50)
		,Documento VARCHAR(100)
		,DataNascimento DATE
		,IsMenorIdade BIT DEFAULT(0)
		,ReservarAreaID INT FOREIGN KEY(ReservarAreaID) REFERENCES ReservarArea NOT NULL
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO

/******    G_CONDOMINO - EVital TI - SP - 18/02/2018   *******/
/*
** Autor: Euler Vital
** Motivo: Armazena dados de Visitantes cadastradas
************ ALTERARÇÕES ******************
** Autor:
** Motivo: 
** Data Alteração: 
*/


IF NOT EXISTS(select * from sys.tables where name = 'Visitante')
BEGIN
	CREATE TABLE Visitante
	(
		 VisitanteID INT PRIMARY KEY IDENTITY(1,1)
		,Nome VARCHAR(100) NOT NULL
		,TipoDocumento VARCHAR(50)
		,Documento VARCHAR(100)
		,TempoPermanencia VARCHAR(100)
		,DataNascimento DATE
		,IsMenorIdade BIT DEFAULT(0)
		,MoradorID INT FOREIGN KEY(MoradorID) REFERENCES Morador NOT NULL
		,UsuarioPublicoID INT FOREIGN KEY(UsuarioPublicoID) REFERENCES UsuarioPublico
		,DescricaoGeral VARCHAR(200)
		,Excluido BIT DEFAULT(0)
		,DataCriacao DATETIME DEFAULT(GETDATE())
		,DataAlteracao DATETIME DEFAULT(GETDATE())
	)
END
GO