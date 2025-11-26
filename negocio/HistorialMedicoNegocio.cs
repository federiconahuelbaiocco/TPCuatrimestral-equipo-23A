using conexion;
using dominio;
using System;
using System.Collections.Generic;

namespace negocio
{
	public class HistorialMedicoNegocio
	{
		public void CrearHistorialMedico(int idPaciente)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_CrearHistorialMedico");
				datos.setearParametro("@IdPaciente", idPaciente);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al crear historial médico.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public int ObtenerIdHistorialPorPaciente(int idPaciente)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_ObtenerIdHistorialPorPaciente");
				datos.setearParametro("@IdPaciente", idPaciente);
				datos.ejecutarLectura();

				if (datos.Lector.Read())
				{
					return (int)datos.Lector["IdHistorialMedico"];
				}
				return 0;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al obtener ID de historial médico.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public void AgregarEntradaHistorial(int idPaciente, int idMedico, string diagnostico, string observaciones = null)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_AgregarEntradaHistorial");
				datos.setearParametro("@IdPaciente", idPaciente);
				datos.setearParametro("@IdMedico", idMedico);
				datos.setearParametro("@Diagnostico", diagnostico);
				datos.setearParametro("@Observaciones", (object)observaciones ?? DBNull.Value);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al agregar entrada al historial.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

        public void ModificarEntrada(EntradaHistorial entrada)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ModificarEntradaHistorial");
                datos.setearParametro("@IdEntradaHistorial", entrada.IdEntradaHistorial);
                datos.setearParametro("@Diagnostico", entrada.Diagnostico);

                if (string.IsNullOrEmpty(entrada.Observaciones))
                    datos.setearParametro("@Observaciones", DBNull.Value);
                else
                    datos.setearParametro("@Observaciones", entrada.Observaciones);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al modificar la entrada del historial.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public EntradaHistorial BuscarEntrada(int idEntrada)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ObtenerEntradaHistorialPorId");
                datos.setearParametro("@Id", idEntrada);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    EntradaHistorial entrada = new EntradaHistorial();

                    entrada.IdEntradaHistorial = (int)datos.Lector["Id"];

                    if (!(datos.Lector["Diagnostico"] is DBNull))
                        entrada.Diagnostico = (string)datos.Lector["Diagnostico"];

                    if (!(datos.Lector["Observaciones"] is DBNull))
                        entrada.Observaciones = (string)datos.Lector["Observaciones"];

                    return entrada;
                }

                return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<EntradaHistorial> ListarEntradasPorPaciente(int idPaciente)
		{
			List<EntradaHistorial> lista = new List<EntradaHistorial>();
			AccesoDatos datos = new AccesoDatos();

			try
			{
				datos.setearProcedimiento("sp_ListarEntradasPorPaciente");
				datos.setearParametro("@IdPaciente", idPaciente);
				datos.ejecutarLectura();

				while (datos.Lector.Read())
				{
					EntradaHistorial entrada = new EntradaHistorial();
					entrada.IdEntradaHistorial = (int)datos.Lector["IdEntradaHistorial"];
					entrada.Fecha = (DateTime)datos.Lector["Fecha"];
					entrada.Diagnostico = (string)datos.Lector["Diagnostico"];

					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Observaciones")))
						entrada.Observaciones = (string)datos.Lector["Observaciones"];

					entrada.MedicoTratante = new Medico();
					entrada.MedicoTratante.IdPersona = (int)datos.Lector["IdMedico"];
					entrada.MedicoTratante.Apellido = (string)datos.Lector["ApellidoMedico"];
					entrada.MedicoTratante.Nombre = (string)datos.Lector["NombreMedico"];
					entrada.MedicoTratante.Matricula = (string)datos.Lector["Matricula"];

					lista.Add(entrada);
				}
				return lista;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al listar entradas del historial.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}
