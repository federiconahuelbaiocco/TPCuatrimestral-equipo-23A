using conexion;
using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
	public class MedicoNegocio
	{
		public List<Medico> ListarActivos()
		{
			List<Medico> lista = new List<Medico>();
			AccesoDatos datos = new AccesoDatos();

			try
			{
				datos.setearProcedimiento("sp_ListarMedicosActivos");
				datos.ejecutarLectura();

				while (datos.Lector.Read())
				{
					Medico aux = new Medico();
					aux.IdPersona = (int)datos.Lector["IdPersona"];
					aux.Dni = (string)datos.Lector["Dni"];
					aux.Nombre = (string)datos.Lector["Nombre"];
					aux.Apellido = (string)datos.Lector["Apellido"];

					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Email")))
						aux.Email = (string)datos.Lector["Email"];

					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Telefono")))
						aux.Telefono = (string)datos.Lector["Telefono"];

					aux.Matricula = (string)datos.Lector["Matricula"];

					lista.Add(aux);
				}
				return lista;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al listar médicos.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}
