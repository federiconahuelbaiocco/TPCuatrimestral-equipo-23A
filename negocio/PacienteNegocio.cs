using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using conexion;
using dominio;

namespace negocio
{
    public class PacienteNegocio
    {
        public List<Paciente> listar()
        {
            List<Paciente> lista = new List<Paciente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ListarPacientesActivos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Paciente aux = new Paciente();
                    aux.IdPersona = (int)datos.Lector["idPersona"];

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

                throw new Exception("Error al listar pacientes desde la capa de negocio.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
