using conexion;
using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class ConsultorioNegocio
    {
        public List<Consultorio> Listar()
        {
            List<Consultorio> lista = new List<Consultorio>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ListarConsultorios");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Consultorio aux = new Consultorio();
                    aux.IdConsultorio = (int)datos.Lector["IdConsultorio"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Nombre")))
                        aux.Nombre = (string)datos.Lector["Nombre"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Activo")))
                        aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar consultorios desde la capa de negocio.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Agregar(Consultorio nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_AgregarConsultorio");
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al agregar consultorio.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Modificar(Consultorio mod)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ModificarConsultorio");
                datos.setearParametro("@IdConsultorio", mod.IdConsultorio);
                datos.setearParametro("@Nombre", mod.Nombre);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al modificar consultorio.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void EliminarLogico(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_EliminarLogicoConsultorio");
                datos.setearParametro("@IdConsultorio", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar lógicamente el consultorio.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
