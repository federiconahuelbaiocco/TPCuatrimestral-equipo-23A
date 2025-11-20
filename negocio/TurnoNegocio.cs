using conexion;
using dominio;
using System;
using System.Collections.Generic;

namespace negocio
{
	public class TurnoNegocio
	{
		public void AltaTurno(int idPaciente, int idMedico, DateTime fechaHora, string observaciones = null)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_AltaTurno");
				datos.setearParametro("@IdPaciente", idPaciente);
				datos.setearParametro("@IdMedico", idMedico);
				datos.setearParametro("@FechaHora", fechaHora);
				datos.setearParametro("@Observaciones", (object)observaciones ?? DBNull.Value);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al dar de alta el turno.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public List<Turno> ListarTurnos(int? idMedico = null, DateTime? fecha = null)
		{
			List<Turno> lista = new List<Turno>();
			AccesoDatos datos = new AccesoDatos();

			try
			{
				datos.setearProcedimiento("sp_ListarTurnos");
				datos.setearParametro("@IdMedico", (object)idMedico ?? DBNull.Value);
				datos.setearParametro("@Fecha", (object)fecha ?? DBNull.Value);
				datos.ejecutarLectura();

				while (datos.Lector.Read())
				{
					Turno turno = new Turno();
					turno.IdTurno = (int)datos.Lector["IdTurno"];
					turno.FechaHora = (DateTime)datos.Lector["FechaHora"];
					
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Observaciones")))
						turno.Observaciones = (string)datos.Lector["Observaciones"];

					turno.Estado = new EstadoTurno();
					turno.Estado.Descripcion = (string)datos.Lector["Estado"];

					turno.Paciente = new Paciente();
					turno.Paciente.IdPersona = (int)datos.Lector["IdPaciente"];
					turno.Paciente.Nombre = (string)datos.Lector["NombrePaciente"];
					turno.Paciente.Apellido = (string)datos.Lector["ApellidoPaciente"];
					turno.Paciente.Dni = (string)datos.Lector["DniPaciente"];

					turno.Medico = new Medico();
					turno.Medico.IdPersona = (int)datos.Lector["IdMedico"];
					turno.Medico.Apellido = (string)datos.Lector["ApellidoMedico"];
					turno.Medico.Nombre = (string)datos.Lector["NombreMedico"];

					lista.Add(turno);
				}
				return lista;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al listar turnos.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public void ModificarEstadoTurno(int idTurno, int idNuevoEstado, string observaciones = null)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_ModificarEstadoTurno");
				datos.setearParametro("@IdTurno", idTurno);
				datos.setearParametro("@IdNuevoEstado", idNuevoEstado);
				datos.setearParametro("@Observaciones", (object)observaciones ?? DBNull.Value);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al modificar el estado del turno.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}
