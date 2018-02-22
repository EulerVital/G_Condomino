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
    public class dCidade : DBase.DBase
    {
        #region Atributos
        IDataReader dr = null;
        SqlParameter[] param = null;
        #endregion

        public List<Cidade> Cidade_GET(Cidade obj)
        {
            List<Cidade> retorno = new List<Cidade>();
            cmd = new SqlCommand();
            param = new SqlParameter[3];

            try
            {

                MontarParametro(0, param, ParameterDirection.Input, "@CidadeID", obj.CidadeID, SqlDbType.Int);
                MontarParametro(1, param, ParameterDirection.Input, "@EstadoID", obj.Estado.EstadoID, SqlDbType.Int);
                MontarParametro(2, param, ParameterDirection.Input, "@Nome", obj.Nome, SqlDbType.VarChar);

                dr = ExecReader("USP_CIDADE_GET", cmd, param);

                if (dr != null)
                {
                    while (dr.Read())
                    {
                        retorno.Add(Cidade(dr));
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

        private Cidade Cidade(IDataReader dr)
        {
            Cidade obj = new Cidade();

            try
            {
                obj.CidadeID = GetInt32("Id", dr).ToString();
                obj.Nome = GetString("NomeEstado", dr);
                obj.Estado.EstadoID = GetInt32("EstadoID", dr).ToString();
                obj.Estado.Nome = GetString("Nome", dr);
                obj.Estado.UF = GetString("UF", dr);

                return obj;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
