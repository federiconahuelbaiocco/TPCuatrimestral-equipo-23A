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
                    MedicoModel medicoActual = (MedicoModel)Session["medicoActual"];
                    
                    if (medicoActual == null)
                    {
                        Response.Redirect("Default.aspx", false);
                        return;
                    }

                    lblBienvenida.Text = $"Bienvenido, Dr./Dra. {medicoActual.Nombre} {medicoActual.Apellido}. Aquí puedes gestionar tus consultas y pacientes.";

                    CargarEstadisticas(medicoActual.IdPersona);
                    CargarTurnosDelDia(medicoActual.IdPersona);
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
            
            List<Turno> turnosDelMedico = turnoNegocio.ListarTurnos(idMedico, null);
            
            List<Turno> turnosHoy = turnosDelMedico
                .Where(t => t.FechaHora.Date == DateTime.Today)
                .ToList();
            
            List<Turno> turnosPendientes = turnosDelMedico
                .Where(t => t.Estado.Descripcion == "Programado" && t.FechaHora >= DateTime.Now)
                .ToList();

            List<int> pacientesUnicos = turnosDelMedico
                .Select(t => t.Paciente.IdPersona)
                .Distinct()
                .ToList();

            lblTurnosHoy.Text = turnosHoy.Count.ToString();
            lblTotalPacientes.Text = pacientesUnicos.Count.ToString();
            lblTurnosPendientes.Text = turnosPendientes.Count.ToString();
        }

        private void CargarTurnosDelDia(int idMedico)
        {
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            
            List<Turno> turnosDelDia = turnoNegocio.ListarTurnos(idMedico, DateTime.Today);
            
            var turnosOrdenados = turnosDelDia
                .OrderBy(t => t.FechaHora)
                .Select(t => new
                {
                    IdTurno = t.IdTurno,
                    HoraFormateada = t.FechaHora.ToString("HH:mm"),
                    NombreCompletoPaciente = $"{t.Paciente.Nombre} {t.Paciente.Apellido}",
                    TipoConsulta = DeterminarTipoConsulta(t),
                    Estado = t.Estado.Descripcion,
                    IdPaciente = t.Paciente.IdPersona
                })
                .ToList();

            dgvTurnosDelDia.DataSource = turnosOrdenados;
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
    }
}