using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;
using conexion;

namespace negocio
{
    public class CoberturaNegocio
    {
        public List<CoberturaMedica> listar()
        {
            List<CoberturaMedica> lista = new List<CoberturaMedica>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ListarCoberturasActivas");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    CoberturaMedica cobertura = new CoberturaMedica();
                    cobertura.IdCoberturaMedica = (int)datos.Lector["IdCoberturaMedica"];
                    cobertura.Nombre = (string)datos.Lector["Nombre"];

                    lista.Add(cobertura);
                }
                return lista;
            }
            catch (Exception ex)
            {

                throw new Exception("Error al listar las coberturas medicas", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }

        }
    }
}
