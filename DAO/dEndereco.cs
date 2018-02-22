using G_Condomino.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class dEndereco : DBase.DBase
    {
        #region Atributos
        IDataReader dr = null;
        SqlParameter[] param = null;
        #endregion

        public List<Endereco> Endreco_GET(Endereco obj)
        {
            List<Endereco> retorno = new List<Endereco>();
            cmd = new SqlCommand();
            param = new SqlParameter[5];

            try
            {

                MontarParametro(0, param, ParameterDirection.Input, "@EnderecoID", obj.EnderecoID, SqlDbType.Int);
                MontarParametro(1, param, ParameterDirection.Input, "@CidadeID", obj.Cidade.CidadeID, SqlDbType.Int);
                MontarParametro(2, param, ParameterDirection.Input, "@EstadoID", obj.Cidade.Estado.EstadoID, SqlDbType.Int);
                MontarParametro(3, param, ParameterDirection.Input, "@EstadoID", obj.Cep, SqlDbType.VarChar);
                MontarParametro(4, param, ParameterDirection.Input, "@Excluido", obj.Excluido, SqlDbType.Bit);

                dr = ExecReader("USP_ENDERECO_GET", cmd, param);

                if (dr != null)
                {
                    while (dr.Read())
                    {
                        retorno.Add(Endereco(dr));
                    }
                }

                return retorno;
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally { CloseConnection(); }
        }

        private Endereco Endereco(IDataReader dr)
        {
            Endereco obj = new Endereco();

            try
            {
                obj.EnderecoID = GetInt32("EnderecoID", dr).ToString();
                obj.Logradouro = GetString("Logradouro", dr);
                obj.Cep = GetString("Cep", dr);
                obj.Descricao = GetString("Descricao", dr);
                obj.Excluido = GetBoolean("Excluido", dr);
                obj.Cidade.CidadeID = GetInt32("CidadeID", dr).ToString();
                obj.Cidade.Nome = GetString("NomeCidade", dr);
                obj.Cidade.Estado.EstadoID = GetInt32("EstadoID", dr).ToString();

                return obj;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string Endereco_SET(Endereco obj)
        {
            string retorno = string.Empty;
            try
            {
                cmd = new SqlCommand();
                param = new SqlParameter[6];

                MontarParametro(0, param, ParameterDirection.Input, "@Endereco", obj.EnderecoID, SqlDbType.Int);
                MontarParametro(1, param, ParameterDirection.Input, "@Logradourp", obj.Logradouro, SqlDbType.VarChar);
                MontarParametro(2, param, ParameterDirection.Input, "@Cep", obj.Cep, SqlDbType.VarChar);
                MontarParametro(3, param, ParameterDirection.Input, "@Descricao", obj.Descricao, SqlDbType.VarChar);
                MontarParametro(4, param, ParameterDirection.Input, "@CidadeID", obj.Cidade.CidadeID, SqlDbType.VarChar);
                MontarParametro(5, param, ParameterDirection.Input, "@Excluido", obj.Excluido, SqlDbType.Bit);

                retorno = Convert.ToString(ExecScalar("USP_ENDERECO_SET", cmd, param));
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally { CloseConnection(); }

            return retorno;
        }
    }
}
