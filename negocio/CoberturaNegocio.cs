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

        public List<CoberturaMedica> ListarTodas()
        {
            List<CoberturaMedica> lista = new List<CoberturaMedica>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ListarTodasCoberturas");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    CoberturaMedica cobertura = new CoberturaMedica();
                    cobertura.IdCoberturaMedica = (int)datos.Lector["idCoberturaMedica"];
                    cobertura.Nombre = (string)datos.Lector["Nombre"];
                    cobertura.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(cobertura);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar todas las coberturas.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Agregar(CoberturaMedica nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_AgregarCobertura");
                datos.setearParametro("@Nombre", nueva.Nombre);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al agregar cobertura.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Modificar(CoberturaMedica mod)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ModificarCobertura");
                datos.setearParametro("@IdCoberturaMedica", mod.IdCoberturaMedica);
                datos.setearParametro("@Nombre", mod.Nombre);
                datos.setearParametro("@Activo", mod.Activo);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al modificar cobertura.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void EliminarLogico(int idCoberturaMedica)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_EliminarLogicoCobertura");
                datos.setearParametro("@IdCoberturaMedica", idCoberturaMedica);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar lógicamente la cobertura.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
