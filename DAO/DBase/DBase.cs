using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace DAO.DBase
{
    public class DBase : IDisposable
    {
        #region Atributos
        protected string strConn = string.Empty;
        public DbTransaction sqlTrans;
        public bool isTransaction;
        protected SqlConnection cn = null;
        protected SqlCommand cmd = null;



        #endregion

        #region Construtor
        /// <summary>
        /// Contrutor padrão sem argumentos, seta a variável com o caminho do banco
        /// </summary>
        public DBase()
        {
            try
            {
                strConn = ("Data Source=DESKTOP-URPHR1B;" +
          "Initial catalog=G_CONDOMINO;" +
          "integrated security=true");
            }
            catch (Exception ex) { throw ex; }
        }
        #endregion

        #region Métodos

        /// <summary>
        /// Abre a conexão com o banco de dados
        /// </summary>
        protected void OpenConnection()
        {
            cn = new SqlConnection(strConn);
            cn.Open();
            cmd.Connection = cn;
        }

        /// <summary>
        /// Fecha a conexão com o banco de dados
        /// </summary>
        protected void CloseConnection()
        {
            if (cn != null)
            {
                if (cn.State == ConnectionState.Open && sqlTrans == null)
                {
                    cn.Close();
                    cn.Dispose();
                }
            }
            if (cmd != null) cmd.Dispose();
        }

        /// <summary>
        /// Abre a conexão ultilizando transação
        /// </summary>
        protected void OpenConnectionTrans()
        {
            if (isTransaction)
            {
                if (sqlTrans == null)
                {
                    OpenConnection();
                    cmd.Transaction = cmd.Connection.BeginTransaction();
                    sqlTrans = cmd.Transaction;
                }
                else
                {
                    cmd.Connection = (SqlConnection)sqlTrans.Connection;
                    cmd.Transaction = (SqlTransaction)sqlTrans;
                }
            }
            else OpenConnection();
        }

        /// <summary>
        /// Executa comando no banco de dados.
        /// </summary>
        /// <param name="commandText">Procedure a ser executada</param>
        /// <param name="cmd">Conexão com o banco de dados</param>
        /// <returns>Retorna as informações selecionadas</returns>
        protected IDataReader ExecReader(string cmdText, SqlCommand cmd)
        {
            return this.ExecReader(cmdText, cmd, null);
        }

        /// <summary>
        /// Executa comando no banco de dados.
        /// </summary>
        /// <param name="commandText">Procedure a ser executada</param>
        /// <param name="parameters">Parametros da procedures</param>
        /// <param name="cmd">Conexão com o banco de dados</param>
        /// <returns>Retorna as informações selecionadas</returns>
        protected IDataReader ExecReader(string cmdText, SqlCommand cmd, SqlParameter[] parameters)
        {
            try
            {
                cmd.Parameters.Clear();

                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = cmdText;

                OpenConnection();
                return cmd.ExecuteReader();
            }
            catch (Exception ex)
            {
                if (cmd.Transaction != null) cmd.Transaction.Rollback();
                throw ex;
            }
        }

        /// <summary>
        /// Executa comando no Banco de dados e retorna quantidade de linhas alteradas.
        /// </summary>
        /// <param name="commandText">Procedure a ser executada</param>
        /// <param name="cmd">Conexão com o banco de dados</param>
        /// <returns>Retorna as quantidades de linhas afetadas</returns>
        protected int ExecNonQuery(string cmdText, SqlCommand cmd)
        {
            return ExecNonQuery(cmdText, cmd, null);
        }

        /// <summary>
        /// Executa comando no Banco de dados e retorna as quantidades de linhas alteradas.
        /// </summary>
        /// <param name="commandText">Procedure a ser executada</param>
        /// <param name="parameters">Parametros da procedures</param>
        /// <param name="cmd">Conexão com o banco de dados</param>
        /// <returns>Retorna as quantidades de linhas afetadas</returns>
        protected int ExecNonQuery(string cmdText, SqlCommand cmd, SqlParameter[] parameters)
        {
            try
            {
                cmd.Parameters.Clear();

                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = cmdText;

                OpenConnection();
                return cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                if (cmd.Transaction != null)
                    cmd.Transaction.Rollback();

                throw ex;
            }
        }

        protected int ExecScalar(string cmdText, SqlCommand cmd, SqlParameter[] parameters)
        {
            //int ID = 0;

            try
            {
                cmd.Parameters.Clear();

                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = cmdText;

                OpenConnection();
                //ID = 
                return int.Parse(cmd.ExecuteScalar().ToString());
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Valida se a coluna existe no resultado da consulta SQL, evitando o erro quando adicionado nova coluna
        /// Adicionado por: Joabe e Nicolas em 11/04/2016
        /// </summary>
        public bool ColunaExiste(string nome, IDataReader dr)
        {
            var columns = Enumerable.Range(0, dr.FieldCount).Select(dr.GetName).ToList();

            return (columns.Count(c => c.ToLower().Equals(nome.ToLower())) > 0);
        }

        /// <summary>
        /// Converte o valor da coluna do DataReader para Byte 
        /// Usado para o tipo TinyInt do SQL
        /// </summary>
        /// <param name="nome">Nome da coluna</param>
        /// <param name="dr">DataReader carregado na Stored Procedure</param>
        /// <returns>Valor convertido para Byte ou null</returns>
        protected int? GetByteNullable(string nome, IDataReader dr)
        {
            int? valor = null;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = dr.GetByte(dr.GetOrdinal(nome));
            }

            return valor;
        }

        /// <summary>
        /// Converte o valor da coluna do DataReader para Int16
        /// Usado para o tipo SmallInt do SQL
        /// </summary>
        /// <param name="nome">Nome da coluna</param>
        /// <param name="dr">DataReader carregado na Stored Procedure</param>
        /// <returns>Valor convertido para Int16 ou null</returns>
        protected int? GetInt16Nullable(string nome, IDataReader dr)
        {
            int? valor = null;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = dr.GetInt16(dr.GetOrdinal(nome));
            }

            return valor;
        }

        protected int? GetInt32Nullable(string nome, IDataReader dr)
        {
            int? valor = null;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = dr.GetInt32(dr.GetOrdinal(nome));
            }

            return valor;
        }


        protected int GetInt32(string nome, IDataReader dr)
        {
            int valor = 0;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = dr.GetInt32(dr.GetOrdinal(nome));
            }

            return valor;
        }

        protected long? GetInt64Nullable(string nome, IDataReader dr)
        {
            long? valor = null;

            if (ColunaExiste(nome, dr))
            {
                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = dr.GetInt64(dr.GetOrdinal(nome));
            }

            return valor;
        }

        protected long GetInt64(string nome, IDataReader dr)
        {
            long valor = 0;

            if (ColunaExiste(nome, dr))
            {
                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = dr.GetInt64(dr.GetOrdinal(nome));
            }

            return valor;
        }

        protected string GetString(string nome, IDataReader dr)
        {
            string valor = null;

            if (ColunaExiste(nome, dr))
            {
                if (dr[nome] != DBNull.Value)
                {
                    if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                        valor = dr.GetString(dr.GetOrdinal(nome)).Trim();
                }
            }

            return valor;
        }

        protected bool GetBoolean(string nome, IDataReader /*DataTableReader*/ dr)
        {
            bool valor = false;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = Convert.ToBoolean(dr[nome]);
                //valor = dr.GetBoolean(dr.GetOrdinal(nome));
            }

            return valor;
        }

        protected bool GetBooleanNullable(string nome, IDataReader /*DataTableReader*/ dr)
        {
            bool valor = false;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = Convert.ToBoolean(dr[nome]);
                //valor = dr.GetBoolean(dr.GetOrdinal(nome));
            }

            return valor;
        }

        protected bool? GetBooleanNullableV(string nome, IDataReader /*DataTableReader*/ dr)
        {
            bool? valor = null;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = Convert.ToBoolean(dr[nome]);
                //valor = dr.GetBoolean(dr.GetOrdinal(nome));
            }

            return valor;
        }

        protected DateTime? GetDateTimeNullable(string nome, IDataReader dr)
        {
            DateTime? valor = null;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = dr.GetDateTime(dr.GetOrdinal(nome));
            }

            return valor;
        }

        protected decimal GetDecimal(string nome, IDataReader dr)
        {
            decimal valor = 0;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = dr.GetDecimal(dr.GetOrdinal(nome));
            }

            return valor;
        }

        protected decimal? GetDecimalNullable(string nome, IDataReader dr)
        {
            decimal? valor = null;

            if (ColunaExiste(nome, dr))
            {

                if (dr.IsDBNull(dr.GetOrdinal(nome)) == false)
                    valor = dr.GetDecimal(dr.GetOrdinal(nome));
            }

            return valor;
        }

        /// <summary>
        /// Monta os parâmetros para execução da Stored Procedure.
        /// </summary>
        /// <param name="item">Indice do parâmetro</param>
        /// <param name="parametros">array de parâmetro a ser montado</param>
        /// <param name="direction">Direção do parametro(input/output)</param>
        /// <param name="nome">Nome do parametro(@id)</param>
        /// <param name="valor">Valor do parametro</param>
        /// <param name="dbType">Tipo de dado do parametro</param>
        protected void MontarParametro
            (int item, SqlParameter[] parametros, ParameterDirection direction,
                string nome, object valor, SqlDbType dbType)
        {
            parametros[item] = new SqlParameter();
            parametros[item].Direction = direction;
            parametros[item].ParameterName = nome;
            parametros[item].SqlDbType = dbType;
            if (valor == null)
                valor = DBNull.Value;
            parametros[item].SqlValue = valor;
        }

        /// <summary>
        /// Converte um DataReader para um DataSet
        /// </summary>
        /// <param name="reader">DataReader que será convertido</param>
        /// <returns>DataSet preenchido com o conteúdo do DataReader</returns>
        public static DataSet ConverterDataReaderParaDataSet(IDataReader reader)
        {
            DataSet dataSet = new DataSet();

            do
            {
                ///Cria um novo data table
                DataTable schemaTable = reader.GetSchemaTable();
                DataTable dataTable = new DataTable();

                if (schemaTable != null)
                {
                    ///Varre os registos encontrados
                    for (int i = 0; i < schemaTable.Rows.Count; i++)
                    {
                        DataRow dataRow = schemaTable.Rows[i];
                        ///Cria o nome da coluna que é unico no data table
                        string columnName = (string)dataRow["ColumnName"]; //+ "<C" + i + "/>";
                        ///Adiciona a coluna para o data table
                        DataColumn column = new DataColumn(columnName, (Type)dataRow["DataType"]);
                        dataTable.Columns.Add(column);
                    }

                    dataSet.Tables.Add(dataTable);

                    ///Preenche o data table que foi criado
                    while (reader.Read())
                    {
                        DataRow dataRow = dataTable.NewRow();

                        for (int i = 0; i < reader.FieldCount; i++)
                            dataRow[i] = reader.GetValue(i);

                        dataTable.Rows.Add(dataRow);
                    }
                }
                else
                {
                    ///Nenhum registro encontrado
                    DataColumn column = new DataColumn("RowsAffected");
                    dataTable.Columns.Add(column);
                    dataSet.Tables.Add(dataTable);
                    DataRow dataRow = dataTable.NewRow();
                    dataRow[0] = reader.RecordsAffected;
                    dataTable.Rows.Add(dataRow);
                }
            }

            while (reader.NextResult());
            return dataSet;
        }

        /// <summary>
        /// Retorna o valor do parâmetro ou DBNull caso o objeto seja nulo
        /// </summary>
        /// <typeparam name="T">Tipo para o caso de parâmetros NULLABLE</typeparam>
        /// <param name="n">O parâmetro NULLABLE</param>
        /// <returns>O valor do parâmetro ou DBNull </returns>
        public static object ObterValorOuDBNull<T>(Nullable<T> n) where T : struct
        {
            if (n.HasValue)
                return n.Value;
            else
                return DBNull.Value;
        }

        #endregion

        #region IDisposable Members

        public void Dispose()
        {
            CloseConnection();
            GC.SuppressFinalize(this);
        }

        #endregion
    }
}
