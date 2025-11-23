using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using dominio;
using negocio;
using MedicoModel = dominio.Medico;

namespace TPCuatrimestral_equipo_23A
{
    public partial class CalendarioMaster : System.Web.UI.Page
    {
        public class DiaCalendario
        {
            public DateTime Fecha { get; set; }
            public List<Turno> Turnos { get; set; } = new List<Turno>();
        }

        private Turno TurnoSeleccionado
        {
            get { return (Turno)Session["turnoSeleccionado"]; }
            set { Session["turnoSeleccionado"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCalendario();
            }
        }

        private void CargarCalendario()
        {
            try
            {
                Usuario usuario = (Usuario)Session["usuario"];
                MedicoModel medico = (MedicoModel)usuario.Persona;

                DateTime fechaActual = DateTime.Now;
                lblMesAnio.Text = fechaActual.ToString("MMMM yyyy");

                DateTime primerDiaMes = new DateTime(fechaActual.Year, fechaActual.Month, 1);
                DateTime ultimoDiaMes = primerDiaMes.AddMonths(1).AddDays(-1);

                DateTime inicioCalendario = primerDiaMes.AddDays(-(int)primerDiaMes.DayOfWeek);
                DateTime finCalendario = ultimoDiaMes.AddDays(6 - (int)ultimoDiaMes.DayOfWeek);

                TurnoNegocio turnoNegocio = new TurnoNegocio();
                List<Turno> turnosMes = turnoNegocio.ListarTurnos(medico.IdPersona);

                List<List<DiaCalendario>> semanas = new List<List<DiaCalendario>>();
                DateTime fechaActualCalendario = inicioCalendario;

                while (fechaActualCalendario <= finCalendario)
                {
                    List<DiaCalendario> semana = new List<DiaCalendario>();

                    for (int i = 0; i < 7; i++)
                    {
                        DiaCalendario dia = new DiaCalendario
                        {
                            Fecha = fechaActualCalendario,
                            Turnos = turnosMes.Where(t => t.FechaHora.Date == fechaActualCalendario.Date)
                                             .OrderBy(t => t.FechaHora)
                                             .ToList()
                        };

                        semana.Add(dia);
                        fechaActualCalendario = fechaActualCalendario.AddDays(1);
                    }

                    semanas.Add(semana);
                }

                rptSemanas.DataSource = semanas;
                rptSemanas.DataBind();
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void lnkTurno_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarTurno")
            {
                int idTurno = Convert.ToInt32(e.CommandArgument);
                CargarDetallesTurno(idTurno);
            }
        }

        private void CargarDetallesTurno(int idTurno)
        {
            try
            {
                Usuario usuario = (Usuario)Session["usuario"];
                MedicoModel medico = (MedicoModel)usuario.Persona;

                TurnoNegocio turnoNegocio = new TurnoNegocio();
                List<Turno> turnos = turnoNegocio.ListarTurnos(medico.IdPersona);
                Turno turno = turnos.FirstOrDefault(t => t.IdTurno == idTurno);

                if (turno != null)
                {
                    TurnoSeleccionado = turno;

                    if (turno.Paciente != null)
                    {
                        PacienteNegocio pacienteNegocio = new PacienteNegocio();
                        Paciente paciente = pacienteNegocio.BuscarPorId(turno.Paciente.IdPersona);

                        if (paciente != null)
                        {
                            lblPacienteNombre.Text = $"{paciente.Apellido}, {paciente.Nombre}";
                            lblPacienteDni.Text = paciente.Dni;
                            lblTurnoObraSocial.Text = paciente.Cobertura != null ? paciente.Cobertura.Nombre : "Particular";
                        }
                        else
                        {
                            lblPacienteNombre.Text = "Paciente no encontrado";
                            lblPacienteDni.Text = "-";
                            lblTurnoObraSocial.Text = "-";
                        }
                    }
                    else
                    {
                        lblPacienteNombre.Text = "Datos de paciente no disponibles";
                    }

                    lblTurnoFecha.Text = turno.FechaHora.ToString("dddd, dd 'de' MMMM 'de' yyyy");
                    lblTurnoHora.Text = turno.FechaHora.ToString("HH:mm");
                    lblTurnoTipo.Text = !string.IsNullOrEmpty(turno.MotivoConsulta) ? turno.MotivoConsulta : "Consulta General";

                    if (!string.IsNullOrWhiteSpace(turno.Observaciones))
                    {
                        lblTurnoObservaciones.Text = turno.Observaciones;
                        pnlObservaciones.Visible = true;
                    }
                    else
                    {
                        pnlObservaciones.Visible = false;
                    }

                    pnlDetallesTurno.Visible = true;
                    pnlSinSeleccion.Visible = false;
                }
            }
            catch (Exception ex)
            {
                pnlDetallesTurno.Visible = true;
                pnlSinSeleccion.Visible = false;
                lblPacienteNombre.Text = "Error al cargar: " + ex.Message;
            }
        }

        protected void lnkVerHistorial_Click(object sender, EventArgs e)
        {
            if (TurnoSeleccionado != null)
            {
                Response.Redirect($"HistorialesClinico.aspx?dni={TurnoSeleccionado.Paciente.Dni}");
            }
        }

        protected void lnkAtender_Click(object sender, EventArgs e)
        {
            if (TurnoSeleccionado != null)
            {
                Response.Redirect($"HistorialesClinico.aspx?dni={TurnoSeleccionado.Paciente.Dni}&nuevo=true");
            }
        }

        protected void lnkCancelar_Click(object sender, EventArgs e)
        {
            if (TurnoSeleccionado != null)
            {
                try
                {
                    TurnoNegocio turnoNegocio = new TurnoNegocio();
                    turnoNegocio.ModificarEstadoTurno(TurnoSeleccionado.IdTurno, 3, "Cancelado por el médico");
                    
                    TurnoSeleccionado = null;
                    pnlDetallesTurno.Visible = false;
                    pnlSinSeleccion.Visible = true;
                    
                    CargarCalendario();
                }
                catch (Exception ex)
                {
                    Session["error"] = ex;
                }
            }
        }

        protected bool EsHoy(DateTime fecha)
        {
            return fecha.Date == DateTime.Now.Date;
        }

        protected string ObtenerClaseTurno(string estado)
        {
            switch (estado?.ToLower())
            {
                case "cancelado":
                    return "turno-cancelado";
                case "pendiente":
                    return "turno-pendiente";
                case "confirmado":
                    return "turno-confirmado";
                case "primera consulta":
                    return "turno-consulta";
                default:
                    return "turno-confirmado";
            }
        }
    }
}