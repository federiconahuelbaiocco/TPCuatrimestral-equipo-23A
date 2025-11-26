using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;
using MedicoModel = dominio.Medico;

namespace TPCuatrimestral_equipo_23A
{
    public partial class Medico1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (Session["medicoActual"] == null)
                    {
                        Response.Redirect("Default.aspx", false);
                        return;
                    }
                    MedicoModel medicoActual = (MedicoModel)Session["medicoActual"];

                    lblBienvenida.Text = $"Bienvenido, Dr./Dra. {medicoActual.Nombre} {medicoActual.Apellido}. Aquí puedes gestionar tus consultas y pacientes.";

                    CargarEstadisticas(medicoActual.IdPersona);
                    CargarTurnosDelDia(medicoActual.IdPersona);
                    MostrarHorarioTrabajo();

                    if (Session["MensajeInternoMedicoMostrado"] == null)
                    {
                        MostrarMensajeInternoMedico();
                        Session["MensajeInternoMedicoMostrado"] = true;
                    }
                }
                catch (Exception ex)
                {
                    Session["error"] = ex;
                    Response.Redirect("Error.aspx", false);
                }
            }
        }

        private void CargarEstadisticas(int idMedico)
        {
            TurnoNegocio turnoNegocio = new TurnoNegocio();

            int turnosHoy = turnoNegocio.ContarTurnosDelDia(idMedico);
            int turnosPendientes = turnoNegocio.ContarTurnosPendientes(idMedico);
            int totalPacientes = turnoNegocio.ContarPacientesPorMedico(idMedico);

            lblTurnosHoy.Text = turnosHoy.ToString();
            lblTotalPacientes.Text = totalPacientes.ToString();
            lblTurnosPendientes.Text = turnosPendientes.ToString();
        }

        private void CargarTurnosDelDia(int idMedico)
        {
            TurnoNegocio turnoNegocio = new TurnoNegocio();

            List<Turno> turnosDelDia = turnoNegocio.ListarTurnosDelDia(idMedico);

            var turnosParaGrid = new List<dynamic>();
            foreach (var turno in turnosDelDia)
            {
                turnosParaGrid.Add(new
                {
                    IdTurno = turno.IdTurno,
                    HoraFormateada = turno.FechaHora.ToString("HH:mm"),
                    NombreCompletoPaciente = $"{turno.Paciente.Apellido}, {turno.Paciente.Nombre}",

                    TipoConsulta = DeterminarTipoConsulta(turno),

                    Estado = turno.Estado.Descripcion,
                    IdPaciente = turno.Paciente.IdPersona,
                    Dni = turno.Paciente.Dni
                });
            }

            dgvTurnosDelDia.DataSource = turnosParaGrid;
            dgvTurnosDelDia.DataBind();
        }

        private string DeterminarTipoConsulta(Turno turno)
        {
            if (!string.IsNullOrEmpty(turno.Observaciones))
            {
                string obs = turno.Observaciones.ToLower();
                if (obs.Contains("primera")) return "Primera Consulta";
                if (obs.Contains("control")) return "Control";
                if (obs.Contains("seguimiento")) return "Seguimiento";
            }

            if (!string.IsNullOrEmpty(turno.MotivoConsulta))
            {
                return turno.MotivoConsulta;
            }

            return "Consulta General";
        }

        protected void dgvTurnosDelDia_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Atender")
            {
                try
                {
                    int idTurno = Convert.ToInt32(e.CommandArgument);
                    TurnoNegocio turnoNegocio = new TurnoNegocio();

                    turnoNegocio.ModificarEstadoTurno(idTurno, 5, "");
                    Usuario usuario = (Usuario)Session["usuario"];
                    MedicoModel medico = (MedicoModel)usuario.Persona;
                    List<Turno> turnos = turnoNegocio.ListarTurnos(medico.IdPersona);
                    Turno turnoSeleccionado = turnos.FirstOrDefault(t => t.IdTurno == idTurno);

                    if (turnoSeleccionado != null)
                    {
                        Session["turnoSeleccionado"] = turnoSeleccionado;
                        Response.Redirect($"HistorialesClinico.aspx?dni={turnoSeleccionado.Paciente.Dni}&nuevo=true", false);
                        Context.ApplicationInstance.CompleteRequest();
                    }
                }
                catch (Exception ex)
                {
                    Session["error"] = ex;
                    MostrarToast("Error al atender turno: " + ex.Message, "danger");
                }
            }
        }

        protected string GetEstadoBadgeClass(string estado)
        {
            switch (estado)
            {
                case "Programado": return "badge rounded-pill text-bg-primary";
                case "Asistió": return "badge rounded-pill text-bg-info text-white";
                case "Atendido": return "badge rounded-pill text-bg-success";
                case "No Asistió": return "badge rounded-pill text-bg-danger";
                case "Cancelado": return "badge rounded-pill text-bg-warning";
                default: return "badge rounded-pill text-bg-secondary";
            }
        }

        private void MostrarHorarioTrabajo()
        {
            try
            {
                TurnoTrabajoNegocio turnoNegocio = new TurnoTrabajoNegocio();
                List<TurnoTrabajo> horarios = turnoNegocio.ObtenerHorarioGeneralClinica();

                DayOfWeek hoy = DateTime.Now.DayOfWeek;
                TurnoTrabajo horarioHoy = null;

                foreach (var h in horarios)
                {
                    if (h.DiaSemana == hoy)
                    {
                        horarioHoy = h;
                        break;
                    }
                }

                if (horarioHoy != null)
                {
                    string nombreDia = horarioHoy.NombreDia ?? ObtenerNombreDia(hoy);
                    string mensaje = $"Hoy {nombreDia}, la clínica atiende de {horarioHoy.HoraEntrada:hh\\:mm} a {horarioHoy.HoraSalida:hh\\:mm}.";

                    lblHorarioFijo.Text = mensaje;
                    lblHorarioFijo.CssClass = "alert alert-info d-block";
                    panelHorarioFijo.Visible = true;
                }
                else
                {
                    TurnoTrabajo proximoHorario = null;
                    for (int i = 1; i <= 7; i++)
                    {
                        DayOfWeek diaFuturo = DateTime.Now.AddDays(i).DayOfWeek;
                        foreach (var h in horarios)
                        {
                            if (h.DiaSemana == diaFuturo) { proximoHorario = h; break; }
                        }
                        if (proximoHorario != null) break;
                    }

                    if (proximoHorario != null)
                    {
                        string nombreDia = proximoHorario.NombreDia ?? ObtenerNombreDia(proximoHorario.DiaSemana);
                        string horaAbre = proximoHorario.HoraEntrada.ToString(@"hh\:mm");
                        string horaCierra = proximoHorario.HoraSalida.ToString(@"hh\:mm");
                        lblHorarioFijo.Text = $"La clínica permanece cerrada por hoy. Reanudamos la atención el {nombreDia} de {horaAbre} a {horaCierra} hs.";
                    }
                    else
                    {
                        lblHorarioFijo.Text = "La clínica permanece cerrada temporalmente.";
                    }

                    lblHorarioFijo.CssClass = "alert alert-warning d-block";
                    panelHorarioFijo.Visible = true;
                }
            }
            catch
            {
                panelHorarioFijo.Visible = false;
            }
        }

        private void MostrarMensajeInternoMedico()
        {
            var msgCfg = Application["MensajeInternoConfig"] as MensajeInternoConfig;
            if (msgCfg != null)
            {
                if (msgCfg.DestinatarioRol == "Todos" || msgCfg.DestinatarioRol == "Medico")
                {
                    if (!string.IsNullOrWhiteSpace(msgCfg.Mensaje))
                        MostrarToast(msgCfg.Mensaje, "warning");
                }
            }
        }

        private void MostrarToast(string mensaje, string tipo = "info")
        {
            string safeMensaje = HttpUtility.JavaScriptStringEncode(mensaje);
            string toastScript = $@"<script>if(window.mostrarToastMensaje) window.mostrarToastMensaje('{safeMensaje}', '{tipo}');</script>";
            litToast.Text = toastScript;
        }

        private string ObtenerNombreDia(DayOfWeek dia)
        {
            switch (dia)
            {
                case DayOfWeek.Monday: return "Lunes";
                case DayOfWeek.Tuesday: return "Martes";
                case DayOfWeek.Wednesday: return "Miércoles";
                case DayOfWeek.Thursday: return "Jueves";
                case DayOfWeek.Friday: return "Viernes";
                case DayOfWeek.Saturday: return "Sábado";
                case DayOfWeek.Sunday: return "Domingo";
                default: return dia.ToString();
            }
        }
    }
}