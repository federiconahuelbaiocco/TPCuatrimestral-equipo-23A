using conexion;
using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
	public class RolNegocio
	{
		public List<Rol> Listar()
		{
			List<Rol> lista = new List<Rol>();
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_ListarRoles");
				datos.ejecutarLectura();

				while (datos.Lector.Read())
				{
					Rol aux = new Rol();
					aux.IdRol = (int)datos.Lector["IdRol"];
					aux.Nombre = (string)datos.Lector["Nombre"];

					lista.Add(aux);
				}
				return lista;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al listar roles.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}
