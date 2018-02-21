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
    public class dEstado : DBase.DBase
    {
        #region Atributos
        IDataReader dr = null;
        SqlParameter[] param = null;
        #endregion

        public List<Estado> Apartamento_GET(Estado obj)
        {
            List<Estado> retorno = new List<Estado>();
            cmd = new SqlCommand();
            param = new SqlParameter[3];

            try
            {

                MontarParametro(0, param, ParameterDirection.Input, "@EstadoID", obj.EstadoID, SqlDbType.Int);
                MontarParametro(1, param, ParameterDirection.Input, "@PaisID", null, SqlDbType.Int);
                MontarParametro(2, param, ParameterDirection.Input, "@Nome", obj.Nome, SqlDbType.VarChar);

                dr = ExecReader("USP_ESTADO_GET", cmd, param);

                if (dr != null)
                {
                    while (dr.Read())
                    {
                        retorno.Add(Estado(dr));
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

        private Estado Estado(IDataReader dr)
        {
            Estado obj = new Estado();

            try
            {
                obj.EstadoID = GetInt32("Id", dr).ToString();
                obj.Nome = GetString("NomeEstado", dr);
                obj.UF = GetString("UF", dr);
                obj.Pais = GetString("NomePais", dr);

                return obj;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
