using conexion;
using dominio;
using System;
using System.Collections.Generic;

namespace negocio
{
	public class EstadoTurnoNegocio
	{
		public List<EstadoTurno> Listar()
		{
			List<EstadoTurno> lista = new List<EstadoTurno>();
			AccesoDatos datos = new AccesoDatos();

			try
			{
				datos.setearProcedimiento("sp_ListarEstadosTurno");
				datos.ejecutarLectura();

				while (datos.Lector.Read())
				{
					EstadoTurno estado = new EstadoTurno();
					estado.IdEstadoTurno = (int)datos.Lector["IdEstadoTurno"];
					estado.Descripcion = (string)datos.Lector["Descripcion"];

					lista.Add(estado);
				}
				return lista;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al listar estados de turno.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}
