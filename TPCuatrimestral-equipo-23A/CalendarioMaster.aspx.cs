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
        public class FilaHoraria
        {
            public TimeSpan Hora { get; set; }
            public string HoraLegible { get { return Hora.ToString(@"hh\:mm"); } }
            public List<DatosCelda> Celdas { get; set; } = new List<DatosCelda>();
        }

        public class DatosCelda
        {
            public DateTime Fecha { get; set; }
            public Turno TurnoAsignado { get; set; }
            public bool EsHoy { get; set; }
        }

        private DateTime FechaReferencia
        {
            get
            {
                if (ViewState["FechaReferencia"] == null)
                    ViewState["FechaReferencia"] = DateTime.Today;
                return (DateTime)ViewState["FechaReferencia"];
            }
            set { ViewState["FechaReferencia"] = value; }
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
                FechaReferencia = DateTime.Today;
                CargarCalendario();
            }
        }

        protected void btnAnterior_Click(object sender, EventArgs e)
        {
            FechaReferencia = FechaReferencia.AddDays(-7);
            CargarCalendario();
        }

        protected void btnSiguiente_Click(object sender, EventArgs e)
        {
            FechaReferencia = FechaReferencia.AddDays(7);
            CargarCalendario();
        }

        protected void btnHoy_Click(object sender, EventArgs e)
        {
            FechaReferencia = DateTime.Today;
            CargarCalendario();
        }

        private void CargarCalendario()
        {
            try
            {
                Usuario usuario = (Usuario)Session["usuario"];
                if (usuario == null || !(usuario.Persona is MedicoModel))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }
                MedicoModel medico = (MedicoModel)usuario.Persona;

                HorarioConfig config = ObtenerConfiguracionGlobal();

                if (config.DuracionTurno <= 0) config.DuracionTurno = 30;

                int delta = DayOfWeek.Monday - FechaReferencia.DayOfWeek;
                if (delta > 0) delta -= 7;

                DateTime lunesSemana = FechaReferencia.AddDays(delta);
                DateTime domingoSemana = lunesSemana.AddDays(6);

                lblRangoFechas.Text = $"{lunesSemana:dd MMM} - {domingoSemana:dd MMM yyyy}";

                TurnoNegocio turnoNegocio = new TurnoNegocio();
                List<Turno> turnosTodos = turnoNegocio.ListarTurnos(medico.IdPersona);

                var turnosDicc = new Dictionary<string, Turno>();
                foreach (var t in turnosTodos)
                {
                    if (t.FechaHora.Date >= lunesSemana.Date && t.FechaHora.Date <= domingoSemana.Date)
                    {
                        string key = $"{t.FechaHora:yyyyMMdd}-{t.FechaHora:HHmm}";
                        if (!turnosDicc.ContainsKey(key))
                            turnosDicc.Add(key, t);
                    }
                }

                List<FilaHoraria> filasCalendario = new List<FilaHoraria>();

                TimeSpan horaActual = config.HoraApertura;
                TimeSpan horaFin = config.HoraCierre;
                TimeSpan intervalo = TimeSpan.FromMinutes(config.DuracionTurno);

                while (horaActual < horaFin)
                {
                    FilaHoraria fila = new FilaHoraria { Hora = horaActual };

                    for (int d = 0; d < 7; d++)
                    {
                        DateTime fechaColumna = lunesSemana.AddDays(d);

                        string keyBusqueda = $"{fechaColumna:yyyyMMdd}-{horaActual.Hours:D2}{horaActual.Minutes:D2}";

                        DatosCelda celda = new DatosCelda
                        {
                            Fecha = fechaColumna,
                            EsHoy = (fechaColumna.Date == DateTime.Today),
                            TurnoAsignado = turnosDicc.ContainsKey(keyBusqueda) ? turnosDicc[keyBusqueda] : null
                        };

                        fila.Celdas.Add(celda);
                    }
                    filasCalendario.Add(fila);

                    horaActual = horaActual.Add(intervalo);
                }

                List<string> cabecerasDias = new List<string>();
                string[] nombresDias = { "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom" };
                for (int i = 0; i < 7; i++)
                {
                    DateTime f = lunesSemana.AddDays(i);
                    string claseHoy = (f.Date == DateTime.Today) ? "text-primary fw-bold" : "";
                    cabecerasDias.Add($"<div class='text-uppercase small {claseHoy}'>{nombresDias[i]}</div><div class='fs-5 {claseHoy}'>{f.Day}</div>");
                }

                rptCabeceraDias.DataSource = cabecerasDias;
                rptCabeceraDias.DataBind();

                rptCuerpoCalendario.DataSource = filasCalendario;
                rptCuerpoCalendario.DataBind();
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void lnkTurno_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "VerTurno")
            {
                int idTurno = Convert.ToInt32(e.CommandArgument);
                CargarDetallesTurno(idTurno);
            }
        }

        protected string ObtenerClaseCssTurno(Turno t)
        {
            if (t == null) return "";
            switch (t.Estado.Descripcion.ToLower())
            {
                case "programado": return "bg-primary text-white";
                case "confirmado": return "bg-success text-white";
                case "cancelado": return "bg-danger text-white";
                case "pendiente": return "bg-warning text-dark";
                case "atendido": return "bg-success text-white border border-dark";
                case "asistió": return "bg-info text-white";
                default: return "bg-secondary text-white";
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
                try
                {
                    TurnoNegocio turnoNegocio = new TurnoNegocio();

                    turnoNegocio.ModificarEstadoTurno(TurnoSeleccionado.IdTurno, 5, "");

                    Response.Redirect($"HistorialesClinico.aspx?dni={TurnoSeleccionado.Paciente.Dni}&nuevo=true", false);
                }
                catch (Exception ex)
                {
                    Session["error"] = ex;
                }
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

        private HorarioConfig ObtenerConfiguracionGlobal()
        {
            if (Application["HorarioConfig"] is HorarioConfig configMemoria)
            {
                return configMemoria;
            }

            TurnoTrabajoNegocio negocio = new TurnoTrabajoNegocio();
            List<TurnoTrabajo> horariosDb = null;
            try
            {
                horariosDb = negocio.ListarHorariosPorMedico(0);
            }
            catch { }

            if (horariosDb != null && horariosDb.Count > 0)
            {
                HorarioConfig configDb = new HorarioConfig();
                configDb.HoraApertura = horariosDb[0].HoraEntrada;
                configDb.HoraCierre = horariosDb[0].HoraSalida;

                configDb.DuracionTurno = 30;

                Application["HorarioConfig"] = configDb;
                return configDb;
            }

            return new HorarioConfig
            {
                HoraApertura = new TimeSpan(8, 0, 0),
                HoraCierre = new TimeSpan(20, 0, 0),
                DuracionTurno = 30
            };
        }
    }
}