using conexion;
using dominio;
using System;
using System.Collections.Generic;

namespace negocio
{
    public class TurnoTrabajoNegocio
    {
        public List<TurnoTrabajo> ListarPorMedico(int idMedico)
        {
            List<TurnoTrabajo> lista = new List<TurnoTrabajo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ObtenerTurnosTrabajoPorMedico");
                datos.setearParametro("@IdMedico", idMedico);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    TurnoTrabajo aux = new TurnoTrabajo();
                    aux.IdTurnoTrabajo = (int)datos.Lector["IdTurnoTrabajo"];
                    aux.DiaSemana = (DayOfWeek)Convert.ToInt32(datos.Lector["DiaSemana"]);
                    aux.HoraEntrada = (TimeSpan)datos.Lector["HoraEntrada"];
                    aux.HoraSalida = (TimeSpan)datos.Lector["HoraSalida"];
                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar turnos de trabajo.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Agregar(int idMedico, TurnoTrabajo turno)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_AgregarTurnoTrabajo");
                datos.setearParametro("@IdMedico", idMedico);
                datos.setearParametro("@DiaSemana", (int)turno.DiaSemana);
                datos.setearParametro("@HoraEntrada", turno.HoraEntrada);
                datos.setearParametro("@HoraSalida", turno.HoraSalida);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al agregar turno de trabajo.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Eliminar(int idTurnoTrabajo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_EliminarTurnoTrabajo");
                datos.setearParametro("@IdTurnoTrabajo", idTurnoTrabajo);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar turno de trabajo.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<string> GenerarOpcionesHorario()
        {
            List<string> opciones = new List<string>();
            for (int hora = 6; hora <= 22; hora++)
            {
                opciones.Add($"{hora:D2}:00");
                opciones.Add($"{hora:D2}:30");
            }
            return opciones;
        }
    }
}
