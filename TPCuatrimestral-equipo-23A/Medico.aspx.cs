using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MedicoModel = dominio.Medico;
using negocio;
using dominio;

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

        private void MostrarToast(string mensaje, string tipo = "info")
        {
            string safeMensaje = HttpUtility.JavaScriptStringEncode(mensaje);
            string toastScript = $@"
            <script>
                if (window.mostrarToastMensaje) {{
                    window.mostrarToastMensaje('{safeMensaje}', '{tipo}');
                }} else {{
                    window.addEventListener('load', function() {{
                        window.mostrarToastMensaje('{safeMensaje}', '{tipo}');
                    }});
                }}
            </script>";
            litToast.Text = toastScript;
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
                            if (h.DiaSemana == diaFuturo)
                            {
                                proximoHorario = h;
                                break; 
                            }
                        }

                        if (proximoHorario != null)
                        {
                            break;
                        }
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
                    TipoConsulta = turno.MotivoConsulta ?? "Consulta General",
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
                if (turno.Observaciones.ToLower().Contains("primera"))
                    return "Primera Consulta";
                if (turno.Observaciones.ToLower().Contains("control"))
                    return "Control";
                if (turno.Observaciones.ToLower().Contains("seguimiento"))
                    return "Seguimiento";
            }
            
            return "Consulta General";
        }

        protected string GetEstadoBadgeClass(string estado)
        {
            switch (estado)
            {
                case "Programado":
                    return "badge rounded-pill text-bg-primary";
                case "Asistió":
                    return "badge rounded-pill text-bg-success";
                case "No Asistió":
                    return "badge rounded-pill text-bg-danger";
                case "Cancelado":
                    return "badge rounded-pill text-bg-warning";
                default:
                    return "badge rounded-pill text-bg-secondary";
            }
        }
        
        protected void MostrarMensajeInterno(string mensaje)
        {
            MostrarToast(mensaje, "warning");
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