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

					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Descripcion")))
						aux.Descripcion = (string)datos.Lector["Descripcion"];

					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Activo")))
						aux.Activo = (bool)datos.Lector["Activo"];

					lista.Add(aux);
				}
				return lista;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al listar especialidades desde la capa de negocio.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public void Agregar(Especialidad nueva)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_AgregarEspecialidad");
				datos.setearParametro("@Descripcion", nueva.Descripcion);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al agregar especialidad.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public void Modificar(Especialidad mod)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_ModificarEspecialidad");
				datos.setearParametro("@IdEspecialidad", mod.IdEspecialidad);
				datos.setearParametro("@NuevaDescripcion", mod.Descripcion);
				datos.setearParametro("@Activo", mod.Activo);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al modificar especialidad.", ex);
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
				datos.setearProcedimiento("sp_EliminarLogicoEspecialidad");
				datos.setearParametro("@IdEspecialidad", id);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al eliminar lógicamente la especialidad.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}