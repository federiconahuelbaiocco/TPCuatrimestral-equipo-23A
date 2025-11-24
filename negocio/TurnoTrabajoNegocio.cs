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

                    int dbDia = Convert.ToInt32(datos.Lector["DiaSemana"]);
                    aux.DiaSemana = (DayOfWeek)(((dbDia - 1) + 7) % 7);

                    aux.HoraEntrada = TimeSpan.Parse((string)datos.Lector["HoraEntrada"]);
                    aux.HoraSalida = TimeSpan.Parse((string)datos.Lector["HoraSalida"]);

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
                datos.setearParametro("@DiaSemana", ((int)turno.DiaSemana) + 1);
                datos.setearParametro("@HoraEntrada", turno.HoraEntrada.ToString(@"hh\:mm"));
                datos.setearParametro("@HoraSalida", turno.HoraSalida.ToString(@"hh\:mm"));
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

        public int AgregarTurnoTrabajoAdmin(int idMedico, int diaSemana, TimeSpan horaEntrada, TimeSpan horaSalida)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_AgregarTurnoTrabajo");
                datos.setearParametro("@IdMedico", idMedico);
                datos.setearParametro("@DiaSemana", diaSemana);
                datos.setearParametro("@HoraEntrada", horaEntrada.ToString(@"hh\:mm"));
                datos.setearParametro("@HoraSalida", horaSalida.ToString(@"hh\:mm"));
                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    return Convert.ToInt32(datos.Lector["IdGenerado"]);
                return 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al agregar turno de trabajo (admin).", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<TurnoTrabajo> ListarHorariosPorMedico(int idMedico)
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
                    int dbDia = Convert.ToInt32(datos.Lector["DiaSemana"]);
                    var turno = new TurnoTrabajo
                    {
                        IdTurnoTrabajo = (int)datos.Lector["IdTurnoTrabajo"],
                        DiaSemana = (DayOfWeek)(((dbDia - 1) + 7) % 7),
                        HoraEntrada = TimeSpan.Parse((string)datos.Lector["HoraEntrada"]),
                        HoraSalida = TimeSpan.Parse((string)datos.Lector["HoraSalida"]),
                        NombreDia = datos.Lector["NombreDia"] as string
                    };
                    lista.Add(turno);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar horarios por médico (admin).", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void EliminarTurnoTrabajoAdmin(int idTurnoTrabajo)
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
                throw new Exception("Error al eliminar turno de trabajo (admin).", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<TurnoTrabajo> ObtenerHorarioGeneralClinica()
        {
            List<TurnoTrabajo> lista = new List<TurnoTrabajo>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ObtenerTurnosTrabajoPorMedico");
                datos.setearParametro("@IdMedico", 0);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    int dbDia = Convert.ToInt32(datos.Lector["DiaSemana"]);
                    var turno = new TurnoTrabajo
                    {
                        IdTurnoTrabajo = (int)datos.Lector["IdTurnoTrabajo"],
                        DiaSemana = (DayOfWeek)(((dbDia - 1) + 7) % 7),
                        HoraEntrada = TimeSpan.Parse((string)datos.Lector["HoraEntrada"]),
                        HoraSalida = TimeSpan.Parse((string)datos.Lector["HoraSalida"]),
                        NombreDia = datos.Lector["NombreDia"] as string
                    };
                    lista.Add(turno);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener horario general de la clínica.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}