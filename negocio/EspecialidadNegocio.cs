using conexion;
using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
	public class EspecialidadNegocio
	{
		public List<Especialidad> Listar()
		{
			List<Especialidad> lista = new List<Especialidad>();
			AccesoDatos datos = new AccesoDatos();

			try
			{
				datos.setearProcedimiento("sp_ListarEspecialidades");

				datos.ejecutarLectura();

				while (datos.Lector.Read())
				{
					Especialidad aux = new Especialidad();

					aux.IdEspecialidad = (int)datos.Lector["IdEspecialidad"];
					if (!(datos.Lector["Descripcion"] is DBNull))
						aux.Descripcion = (string)datos.Lector["Descripcion"];

					lista.Add(aux);
				}

				return lista;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al listar especialidades desde la base de datos.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}
