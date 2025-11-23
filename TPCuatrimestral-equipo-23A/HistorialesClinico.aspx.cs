using System;
using System.Collections.Generic;
using dominio;
using negocio;
using MedicoModel = dominio.Medico;

namespace TPCuatrimestral_equipo_23A
{
    public partial class HistorialesClinico : System.Web.UI.Page
    {
        private Paciente PacienteActual
        {
            get { return (Paciente)Session["pacienteHistorial"]; }
            set { Session["pacienteHistorial"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPacientes();

                string dniParametro = Request.QueryString["dni"];
                if (!string.IsNullOrEmpty(dniParametro))
                {
                    CargarPacientePorDni(dniParametro);
                    
                    string nuevoParametro = Request.QueryString["nuevo"];
                    if (!string.IsNullOrEmpty(nuevoParametro) && nuevoParametro.ToLower() == "true")
                    {
                        if (PacienteActual != null)
                        {
                            LimpiarFormulario();
                            pnlFormulario.Visible = true;
                            pnlHistorial.Visible = false;
                        }
                    }
                }
            }
        }

        private void CargarPacientes()
        {
            try
            {
                Usuario usuario = (Usuario)Session["usuario"];
                MedicoModel medico = (MedicoModel)usuario.Persona;

                TurnoNegocio turnoNegocio = new TurnoNegocio();
                List<Paciente> pacientes = turnoNegocio.ListarPacientesPorMedico(medico.IdPersona);

                if (pacientes != null && pacientes.Count > 0)
                {
                    rptPacientes.DataSource = pacientes;
                    rptPacientes.DataBind();
                    pnlSinPacientes.Visible = false;
                }
                else
                {
                    pnlSinPacientes.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                pnlSinPacientes.Visible = true;
            }
        }

        protected void rptPacientes_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarPaciente")
            {
                string dni = e.CommandArgument.ToString();
                CargarPacientePorDni(dni);
            }
        }

        private void CargarPacientePorDni(string dni)
        {
            try
            {
                PacienteNegocio pacienteNegocio = new PacienteNegocio();
                List<Paciente> pacientes = pacienteNegocio.BuscarPacientes(dni: dni);

                if (pacientes != null && pacientes.Count > 0)
                {
                    Paciente paciente = pacientes[0];
                    PacienteActual = paciente;
                    MostrarDatosPaciente(paciente);
                    CargarHistorial(paciente.IdPersona);
                    pnlBusqueda.Visible = false;
                }
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
            }
        }

        private void MostrarDatosPaciente(Paciente paciente)
        {
            lblNombrePaciente.Text = $"{paciente.Nombre} {paciente.Apellido}";
            lblDniPaciente.Text = paciente.Dni;
            lblEmailPaciente.Text = paciente.Email ?? "Sin email";
            pnlPacienteInfo.Visible = true;
        }

        private void CargarHistorial(int idPaciente)
        {
            try
            {
                HistorialMedicoNegocio historialNegocio = new HistorialMedicoNegocio();
                List<EntradaHistorial> entradas = historialNegocio.ListarEntradasPorPaciente(idPaciente);

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
            catch (Exception ex)
            {
                Session["error"] = ex;
                lblSinHistorial.Visible = true;
                pnlHistorial.Visible = true;
            }
        }

        protected void btnNuevaEntrada_Click(object sender, EventArgs e)
        {
            if (PacienteActual == null)
            {
                return;
            }

            LimpiarFormulario();
            pnlFormulario.Visible = true;
            pnlHistorial.Visible = false;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (PacienteActual == null)
                    return;

                Usuario usuario = (Usuario)Session["usuario"];
                MedicoModel medicoActual = (MedicoModel)usuario.Persona;

                HistorialMedicoNegocio historialNegocio = new HistorialMedicoNegocio();

                int idHistorial = historialNegocio.ObtenerIdHistorialPorPaciente(PacienteActual.IdPersona);
                if (idHistorial == 0)
                    historialNegocio.CrearHistorialMedico(PacienteActual.IdPersona);

                historialNegocio.AgregarEntradaHistorial(
                    PacienteActual.IdPersona,
                    medicoActual.IdPersona,
                    txtDiagnostico.Text.Trim(),
                    string.IsNullOrWhiteSpace(txtObservaciones.Text) ? null : txtObservaciones.Text.Trim()
                );

                pnlFormulario.Visible = false;
                CargarHistorial(PacienteActual.IdPersona);
                pnlHistorial.Visible = true;
            }
            catch (Exception ex)
            {
                lblSinHistorial.Text = "Error al guardar: " + ex.Message;
                lblSinHistorial.Visible = true;
                pnlHistorial.Visible = true;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            pnlFormulario.Visible = false;
            if (PacienteActual != null)
            {
                pnlHistorial.Visible = true;
            }
        }

        private void LimpiarFormulario()
        {
            txtDiagnostico.Text = string.Empty;
            txtObservaciones.Text = string.Empty;
        }

        protected void btnBuscarDni_Click(object sender, EventArgs e)
        {
            string dni = txtBuscarDni.Text.Trim();
            if (!string.IsNullOrEmpty(dni))
            {
                CargarPacientePorDni(dni);
            }
        }
    }
}
