using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using dominio;

namespace TPCuatrimestral_equipo_23A
{
    public partial class Recepcionista1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarContadores();
                CargarPacientes();
                MostrarMensajeInternoRecepcionista();
                MostrarHorarioTrabajoFijo();
            }
        }

        private void CargarContadores()
        {
            try
            {
                PacienteNegocio pacienteNegocio = new PacienteNegocio();
                MedicoNegocio medicoNegocio = new MedicoNegocio();

                lblPacienteCount.Text = pacienteNegocio.Listar().Count.ToString();
                lblMedicoCount.Text = medicoNegocio.ListarActivos().Count.ToString();
                lblTurnosHoyCount.Text = "0";
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        private void CargarPacientes()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            try
            {
                List<Paciente> pacientes = negocio.Listar();
                gvPacientes.DataSource = pacientes;
                gvPacientes.DataBind();
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void gvPacientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("~/DetallePaciente.aspx?id=" + id, false);
            }
        }

        protected void gvPacientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPacientes.PageIndex = e.NewPageIndex;

            List<Paciente> lista = (List<Paciente>)Session["listaPacientes"];
            gvPacientes.DataSource = lista;
            gvPacientes.DataBind();
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

        private void MostrarMensajeInternoRecepcionista()
        {
            var msgCfg = Application["MensajeInternoConfig"] as MensajeInternoConfig;
            if (msgCfg != null)
            {
                if (msgCfg.DestinatarioRol == "Todos" || msgCfg.DestinatarioRol == "Recepcionista")
                {
                    if (!string.IsNullOrWhiteSpace(msgCfg.Mensaje))
                        MostrarToast(msgCfg.Mensaje, "warning");
                }
            }
        }

        private void MostrarHorarioTrabajoFijo()
        {
            try
            {
                var turnoNegocio = new TurnoTrabajoNegocio();
                var horarios = turnoNegocio.ObtenerHorarioGeneralClinica();
                var diaHoy = DateTime.Now.DayOfWeek;
                var horarioHoy = horarios.FirstOrDefault(h => h.DiaSemana == diaHoy);
                if (horarioHoy != null)
                {
                    string mensaje = $"Hoy ({horarioHoy.NombreDia ?? diaHoy.ToString()}) la clínica atiende de {horarioHoy.HoraEntrada:hh\\:mm} a {horarioHoy.HoraSalida:hh\\:mm}.";
                    lblHorarioFijo.Text = mensaje;
                    panelHorarioFijo.Visible = true;
                }
                else
                {
                    lblHorarioFijo.Text = $"Hoy ({ObtenerNombreDia(diaHoy)}) la clínica permanece cerrada.";
                    panelHorarioFijo.Visible = true;
                }
            }
            catch
            {
                panelHorarioFijo.Visible = false;
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