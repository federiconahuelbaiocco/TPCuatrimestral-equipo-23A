using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;
using MedicoModel = dominio.Medico;

namespace TPCuatrimestral_equipo_23A
{
    public partial class HistorialesClinico : System.Web.UI.Page
    {
        public Paciente PacienteActual
        {
            get { return (Paciente)Session["pacienteHistorial"]; }
            set { Session["pacienteHistorial"] = value; }
        }

        public int? IdEntradaSeleccionada
        {
            get { return (int?)Session["idEntradaHistorialEdit"]; }
            set { Session["idEntradaHistorialEdit"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!ValidarSesionMedico()) return;

            if (!IsPostBack)
            {
                CargarPacientesSidebar();

                string dniParametro = Request.QueryString["dni"];
                if (!string.IsNullOrEmpty(dniParametro))
                {
                    CargarPacientePorDni(dniParametro);

                    string nuevoParametro = Request.QueryString["nuevo"];
                    if (!string.IsNullOrEmpty(nuevoParametro) && nuevoParametro.ToLower() == "true")
                    {
                        if (PacienteActual != null)
                        {
                            btnNuevaEntrada_Click(null, null);
                        }
                    }
                }
            }
        }

        private bool ValidarSesionMedico()
        {
            if (Session["usuario"] == null || !(Session["usuario"] is Usuario))
            {
                Response.Redirect("Default.aspx", false);
                return false;
            }
            Usuario usuario = (Usuario)Session["usuario"];
            if (!(usuario.Persona is MedicoModel))
            {
                Response.Redirect("Default.aspx", false);
                return false;
            }
            return true;
        }

        private void CargarPacientesSidebar()
        {
            try
            {
                Usuario usuario = (Usuario)Session["usuario"];
                MedicoModel medico = (MedicoModel)usuario.Persona;

                TurnoNegocio turnoNegocio = new TurnoNegocio();
                List<Paciente> pacientes = turnoNegocio.ListarPacientesPorMedico(medico.IdPersona);

                if (pacientes != null && pacientes.Count > 0)
                {
                    pacientes = pacientes.GroupBy(p => p.IdPersona).Select(g => g.First()).ToList();

                    rptPacientes.DataSource = pacientes;
                    rptPacientes.DataBind();
                    pnlSinPacientes.Visible = false;
                }
                else
                {
                    rptPacientes.DataSource = null;
                    rptPacientes.DataBind();
                    pnlSinPacientes.Visible = true;
                }
            }
            catch (Exception)
            {
                pnlSinPacientes.Visible = true;
            }
        }

        private void CargarPacientePorDni(string dni)
        {
            try
            {
                lblErrorBusqueda.Visible = false;

                PacienteNegocio negocio = new PacienteNegocio();
                List<Paciente> pacientes = negocio.BuscarPacientes(dni: dni);

                if (pacientes != null && pacientes.Count > 0)
                {
                    Paciente paciente = pacientes[0];
                    PacienteActual = paciente;
                    MostrarDatosPaciente(paciente);
                    CargarHistorial(paciente.IdPersona);

                    pnlBusqueda.Visible = false;
                    pnlFormulario.Visible = false;
                }
                else
                {
                    lblErrorBusqueda.Text = "No se encontró ningún paciente con ese DNI.";
                    lblErrorBusqueda.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }

        private void MostrarDatosPaciente(Paciente paciente)
        {
            lblNombrePaciente.Text = $"{paciente.Apellido}, {paciente.Nombre}";
            lblDniPaciente.Text = paciente.Dni;
            lblEmailPaciente.Text = !string.IsNullOrEmpty(paciente.Email) ? paciente.Email : "Sin email";
            pnlPacienteInfo.Visible = true;
        }

        private void CargarHistorial(int idPaciente)
        {
            try
            {
                HistorialMedicoNegocio historialNegocio = new HistorialMedicoNegocio();
                List<EntradaHistorial> entradas = historialNegocio.ListarEntradasPorPaciente(idPaciente);

                if (entradas != null)
                {
                    entradas = entradas.Where(e => e.MedicoTratante != null).ToList();
                }

                if (entradas != null && entradas.Count > 0)
                {
                    rptHistorial.DataSource = entradas;
                    rptHistorial.DataBind();
                    lblSinHistorial.Visible = false;
                }
                else
                {
                    rptHistorial.DataSource = null;
                    rptHistorial.DataBind();
                    lblSinHistorial.Visible = true;
                }

                pnlHistorial.Visible = true;
            }
            catch (Exception)
            {
                lblSinHistorial.Text = "No se pudo cargar el historial.";
                lblSinHistorial.Visible = true;
                pnlHistorial.Visible = true;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarSesionMedico()) return;
                if (PacienteActual == null) return;

                Page.Validate("NuevoHistorial");
                if (!Page.IsValid) return;

                Usuario usuario = (Usuario)Session["usuario"];
                MedicoModel medicoActual = (MedicoModel)usuario.Persona;
                HistorialMedicoNegocio historialNegocio = new HistorialMedicoNegocio();

                if (IdEntradaSeleccionada.HasValue)
                {
                    EntradaHistorial entrada = new EntradaHistorial();
                    entrada.IdEntradaHistorial = IdEntradaSeleccionada.Value;
                    entrada.Diagnostico = txtDiagnostico.Text.Trim();
                    entrada.Observaciones = string.IsNullOrWhiteSpace(txtObservaciones.Text) ? null : txtObservaciones.Text.Trim();

                    historialNegocio.ModificarEntrada(entrada);
                }
                else
                {
                    int idHistorial = historialNegocio.ObtenerIdHistorialPorPaciente(PacienteActual.IdPersona);
                    if (idHistorial == 0)
                        historialNegocio.CrearHistorialMedico(PacienteActual.IdPersona);

                    historialNegocio.AgregarEntradaHistorial(
                        PacienteActual.IdPersona,
                        medicoActual.IdPersona,
                        txtDiagnostico.Text.Trim(),
                        string.IsNullOrWhiteSpace(txtObservaciones.Text) ? null : txtObservaciones.Text.Trim()
                    );
                }

                LimpiarFormulario();
                IdEntradaSeleccionada = null;
                pnlFormulario.Visible = false;
                CargarHistorial(PacienteActual.IdPersona);
                pnlHistorial.Visible = true;
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnNuevaEntrada_Click(object sender, EventArgs e)
        {
            if (PacienteActual != null)
            {
                LimpiarFormulario();
                pnlFormulario.Visible = true;
                pnlHistorial.Visible = false;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            pnlFormulario.Visible = false;
            if (PacienteActual != null) pnlHistorial.Visible = true;
        }

        protected void btnBuscarDni_Click(object sender, EventArgs e)
        {
            Page.Validate("BuscarDni");
            if (!Page.IsValid) return;

            if (!string.IsNullOrWhiteSpace(txtBuscarDni.Text))
            {
                CargarPacientePorDni(txtBuscarDni.Text.Trim());
            }
        }

        protected void rptPacientes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarPaciente")
            {
                CargarPacientePorDni(e.CommandArgument.ToString());
            }
        }

        private void LimpiarFormulario()
        {
            txtDiagnostico.Text = string.Empty;
            txtObservaciones.Text = string.Empty;
        }

        protected void rptHistorial_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EditarEntrada")
            {
                int idEntrada = Convert.ToInt32(e.CommandArgument);
                CargarFormularioEdicion(idEntrada);
            }
        }

        private void CargarFormularioEdicion(int idEntrada)
        {

            try
            {
                HistorialMedicoNegocio negocio = new HistorialMedicoNegocio();
                EntradaHistorial entrada = negocio.BuscarEntrada(idEntrada);

                if (entrada != null)
                {
                    IdEntradaSeleccionada = entrada.IdEntradaHistorial;
                    txtDiagnostico.Text = entrada.Diagnostico;
                    txtObservaciones.Text = entrada.Observaciones;

                    pnlHistorial.Visible = false;
                    pnlFormulario.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }

    }
}