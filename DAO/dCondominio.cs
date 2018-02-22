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
    public class dCondominio : DBase.DBase
    {
        #region Atributos
        IDataReader dr = null;
        SqlParameter[] param = null;
        #endregion

        public List<Condominio> Condominio_GET(Condominio obj)
        {
            List<Condominio> retorno = new List<Condominio>();
            cmd = new SqlCommand();
            param = new SqlParameter[6];

            try
            {

                MontarParametro(0, param, ParameterDirection.Input, "@CondominioID", obj.CondominioID, SqlDbType.Int);
                MontarParametro(1, param, ParameterDirection.Input, "@EnderecoID", obj.Endereco.EnderecoID, SqlDbType.Int);
                MontarParametro(2, param, ParameterDirection.Input, "@CidadeID", obj.Endereco.Cidade.CidadeID, SqlDbType.Int);
                MontarParametro(3, param, ParameterDirection.Input, "@EstadoID", obj.Endereco.Cidade.Estado.EstadoID, SqlDbType.Int);
                MontarParametro(4, param, ParameterDirection.Input, "@Nome", obj.Nome, SqlDbType.VarChar);
                MontarParametro(5, param, ParameterDirection.Input, "@Excluido", obj.Excluido, SqlDbType.Bit);

                dr = ExecReader("USP_CONDOMINIO_GET", cmd, param);

                if (dr != null)
                {
                    while (dr.Read())
                    {
                        retorno.Add(Condominio(dr));
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

        private Condominio Condominio(IDataReader dr)
        {
            Condominio obj = new Condominio();

            try
            {
                obj.CondominioID = GetInt32("CondominioID", dr).ToString();
                obj.Nome = GetString("Nome", dr);
                obj.TipoCondominio = GetString("TipoCondominio", dr);
                obj.Excluido = GetBoolean("Excluido", dr);
                obj.Endereco.EnderecoID = GetInt32("EnderecoID", dr).ToString();
                obj.Endereco.Logradouro = GetString("Logradouro", dr);
                obj.Endereco.Cep = GetString("Cep", dr);
                obj.Descricao = GetString("Descricao", dr);
                obj.Excluido = GetBoolean("Excluido", dr);
                obj.Endereco.Cidade.CidadeID = GetInt32("CidadeID", dr).ToString();
                obj.Endereco.Cidade.Estado.EstadoID = GetString("EstadoID", dr).ToString();

                return obj;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string Condominio_SET(Condominio obj)
        {
            string retorno = string.Empty;
            try
            {
                cmd = new SqlCommand();
                param = new SqlParameter[5];

                MontarParametro(0, param, ParameterDirection.Input, "@CondominioID", obj.CondominioID, SqlDbType.Int);
                MontarParametro(1, param, ParameterDirection.Input, "@Nome", obj.Nome, SqlDbType.VarChar);
                MontarParametro(2, param, ParameterDirection.Input, "@EnderecoID", obj.Endereco.EnderecoID, SqlDbType.Int);
                MontarParametro(3, param, ParameterDirection.Input, "@TipoCondominio", obj.TipoCondominio, SqlDbType.VarChar);
                MontarParametro(4, param, ParameterDirection.Input, "@Excluido", obj.Excluido, SqlDbType.Bit);

                retorno = Convert.ToString(ExecScalar("USP_CONDOMINIO_SET", cmd, param));
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
