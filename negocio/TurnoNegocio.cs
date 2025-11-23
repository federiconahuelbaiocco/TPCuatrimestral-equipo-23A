using conexion;
using dominio;
using System;
using System.Collections.Generic;

namespace negocio
{
	public class TurnoNegocio
	{
		public void AltaTurno(int idPaciente, int idMedico, DateTime fechaHora, string motivoConsulta = null, string observaciones = null)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_AltaTurno");
				datos.setearParametro("@IdPaciente", idPaciente);
				datos.setearParametro("@IdMedico", idMedico);
				datos.setearParametro("@FechaHora", fechaHora);
				datos.setearParametro("@MotivoConsulta", (object)motivoConsulta ?? DBNull.Value);
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

		public List<Paciente> ListarPacientesPorMedico(int idMedico)
		{
			List<Paciente> lista = new List<Paciente>();
			AccesoDatos datos = new AccesoDatos();

			try
			{
				datos.setearProcedimiento("sp_ListarPacientesPorMedico");
				datos.setearParametro("@IdMedico", idMedico);
				datos.ejecutarLectura();

				while (datos.Lector.Read())
				{
					Paciente paciente = new Paciente();
					paciente.IdPersona = (int)datos.Lector["IdPersona"];
					paciente.Nombre = (string)datos.Lector["Nombre"];
					paciente.Apellido = (string)datos.Lector["Apellido"];
					paciente.Dni = (string)datos.Lector["Dni"];
					paciente.Activo = (bool)datos.Lector["Activo"];

					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Email")))
						paciente.Email = (string)datos.Lector["Email"];
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Telefono")))
						paciente.Telefono = (string)datos.Lector["Telefono"];
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Sexo")))
						paciente.Sexo = (string)datos.Lector["Sexo"];
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("FechaNacimiento")))
						paciente.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];

					paciente.Domicilio = new Domicilio();
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("IdDomicilio")))
					{
						paciente.Domicilio.IdDomicilio = (int)datos.Lector["IdDomicilio"];
						if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Calle")))
							paciente.Domicilio.Calle = (string)datos.Lector["Calle"];
						if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Altura")))
							paciente.Domicilio.Altura = (string)datos.Lector["Altura"];
						if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Localidad")))
							paciente.Domicilio.Localidad = (string)datos.Lector["Localidad"];
					}

					paciente.Cobertura = new CoberturaMedica();
					paciente.Cobertura.IdCoberturaMedica = (int)datos.Lector["IdCoberturaMedica"];
					paciente.Cobertura.Nombre = (string)datos.Lector["NombreCobertura"];

					lista.Add(paciente);
				}

				return lista;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al listar pacientes por médico.", ex);
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
					
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("MotivoConsulta")))
						turno.MotivoConsulta = (string)datos.Lector["MotivoConsulta"];
					
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

		public int ContarTurnosDelDia(int idMedico)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_ContarTurnosDelDia");
				datos.setearParametro("@IdMedico", idMedico);
				datos.ejecutarLectura();

				if (datos.Lector.Read())
				{
					return (int)datos.Lector["TotalTurnos"];
				}
				return 0;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al contar turnos del día.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public int ContarTurnosPendientes(int idMedico)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_ContarTurnosPendientes");
				datos.setearParametro("@IdMedico", idMedico);
				datos.ejecutarLectura();

				if (datos.Lector.Read())
				{
					return (int)datos.Lector["TotalPendientes"];
				}
				return 0;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al contar turnos pendientes.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public int ContarPacientesPorMedico(int idMedico)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_ContarPacientesPorMedico");
				datos.setearParametro("@IdMedico", idMedico);
				datos.ejecutarLectura();

				if (datos.Lector.Read())
				{
					return (int)datos.Lector["TotalPacientes"];
				}
				return 0;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al contar pacientes del médico.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public List<Turno> ListarTurnosDelDia(int idMedico)
		{
			List<Turno> lista = new List<Turno>();
			AccesoDatos datos = new AccesoDatos();

			try
			{
				datos.setearProcedimiento("sp_ListarTurnosDelDia");
				datos.setearParametro("@IdMedico", idMedico);
				datos.ejecutarLectura();

				while (datos.Lector.Read())
				{
					Turno turno = new Turno();
					turno.IdTurno = (int)datos.Lector["IdTurno"];
					turno.FechaHora = (DateTime)datos.Lector["FechaHora"];
					
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("TipoConsulta")))
						turno.MotivoConsulta = (string)datos.Lector["TipoConsulta"];
					
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
				throw new Exception("Error al listar turnos del día.", ex);
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
