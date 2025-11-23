using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using dominio;
using negocio;
using MedicoModel = dominio.Medico;

namespace TPCuatrimestral_equipo_23A
{
    public partial class PerfilMedico : System.Web.UI.Page
    {
        private MedicoModel MedicoActual
        {
            get { return (MedicoModel)Session["medicoActual"]; }
            set { Session["medicoActual"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["medicoActual"] == null)
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
            MedicoModel medicoActual = (MedicoModel)Session["medicoActual"];

            if (!IsPostBack)
            {
                Usuario usuario = (Usuario)Session["usuario"];
                MedicoModel medico = (MedicoModel)usuario.Persona;
                MedicoActual = medico;

                CargarEspecialidades();
                CargarDatosMedico();
                CargarEstadisticas();
            }
        }

        private void CargarDatosMedico()
        {
            try
            {
                MedicoNegocio medicoNegocio = new MedicoNegocio();
                MedicoModel medico = medicoNegocio.ObtenerPorId(MedicoActual.IdPersona);

                if (medico != null)
                {
                    lblNombreCompleto.Text = $"Dr./Dra. {medico.Apellido}, {medico.Nombre}";
                    lblMatricula.Text = medico.Matricula;

                    string especialidades = "";
                    if (medico.Especialidades != null && medico.Especialidades.Count > 0)
                    {
                        especialidades = string.Join(", ", medico.Especialidades.Select(e => e.Descripcion));
                    }
                    else
                    {
                        especialidades = "Sin especialidad asignada";
                    }
                    lblEspecialidades.Text = especialidades;

                    txtNombre.Text = medico.Nombre;
                    txtApellido.Text = medico.Apellido;
                    txtDni.Text = medico.Dni;
                    txtSexo.Text = medico.Sexo ?? "No especificado";
                    txtFechaNacimiento.Text = "No disponible";
                    txtTelefono.Text = medico.Telefono ?? "";
                    txtEmail.Text = medico.Email ?? "";

                    if (medico.Domicilio != null)
                    {
                        txtCalle.Text = medico.Domicilio.Calle ?? "";
                        txtAltura.Text = medico.Domicilio.Altura ?? "";
                        txtPiso.Text = medico.Domicilio.Piso ?? "";
                        txtDepartamento.Text = medico.Domicilio.Departamento ?? "";
                        txtLocalidad.Text = medico.Domicilio.Localidad ?? "";
                        txtProvincia.Text = medico.Domicilio.Provincia ?? "";
                        txtCodigoPostal.Text = medico.Domicilio.CodigoPostal ?? "";
                    }
                    else
                    {
                        txtCalle.Text = "";
                        txtAltura.Text = "";
                        txtPiso.Text = "";
                        txtDepartamento.Text = "";
                        txtLocalidad.Text = "";
                        txtProvincia.Text = "";
                        txtCodigoPostal.Text = "";
                    }

                    txtMatriculaProfesional.Text = medico.Matricula;

                    if (medico.Especialidades != null && medico.Especialidades.Count > 0)
                    {
                        ddlEspecialidad.SelectedValue = medico.Especialidades[0].IdEspecialidad.ToString();

                        foreach (var esp in medico.Especialidades)
                        {
                            foreach (ListItem item in cblEspecialidades.Items)
                            {
                                if (item.Value == esp.IdEspecialidad.ToString())
                                {
                                    item.Selected = true;
                                }
                            }
                        }
                    }

                    txtUsuario.Text = medico.Usuario.NombreUsuario;

                    MedicoActual = medico;
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar datos: " + ex.Message, false);
            }
        }

        private void CargarEspecialidades()
        {
            try
            {
                EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
                List<Especialidad> especialidades = especialidadNegocio.Listar();

                ddlEspecialidad.DataSource = especialidades;
                ddlEspecialidad.DataTextField = "Descripcion";
                ddlEspecialidad.DataValueField = "IdEspecialidad";
                ddlEspecialidad.DataBind();
                ddlEspecialidad.Items.Insert(0, new ListItem("-- Seleccionar --", "0"));

                cblEspecialidades.DataSource = especialidades;
                cblEspecialidades.DataTextField = "Descripcion";
                cblEspecialidades.DataValueField = "IdEspecialidad";
                cblEspecialidades.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar especialidades: " + ex.Message, false);
            }
        }

        private void CargarEstadisticas()
        {
            try
            {
                TurnoNegocio turnoNegocio = new TurnoNegocio();
                
                int turnosHoy = turnoNegocio.ContarTurnosDelDia(MedicoActual.IdPersona);
                int pendientes = turnoNegocio.ContarTurnosPendientes(MedicoActual.IdPersona);
                int totalPacientes = turnoNegocio.ContarPacientesPorMedico(MedicoActual.IdPersona);

                lblStatTurnosHoy.Text = turnosHoy.ToString();
                lblStatPendientes.Text = pendientes.ToString();
                lblStatPacientes.Text = totalPacientes.ToString();
            }
            catch (Exception)
            {
                lblStatTurnosHoy.Text = "-";
                lblStatPendientes.Text = "-";
                lblStatPacientes.Text = "-";
            }
        }

        protected void btnEditarPersonal_Click(object sender, EventArgs e)
        {
            HabilitarEdicionPersonal(true);
        }

        protected void btnCancelarPersonal_Click(object sender, EventArgs e)
        {
            HabilitarEdicionPersonal(false);
            CargarDatosMedico();
        }

        protected void btnGuardarPersonal_Click(object sender, EventArgs e)
        {
            try
            {
                MedicoNegocio medicoNegocio = new MedicoNegocio();
                MedicoModel medico = MedicoActual;

                medico.Telefono = txtTelefono.Text.Trim();
                medico.Email = txtEmail.Text.Trim();

                if (medico.Domicilio == null)
                    medico.Domicilio = new Domicilio();

                medico.Domicilio.Calle = txtCalle.Text.Trim();
                medico.Domicilio.Altura = txtAltura.Text.Trim();
                medico.Domicilio.Piso = string.IsNullOrWhiteSpace(txtPiso.Text) ? null : txtPiso.Text.Trim();
                medico.Domicilio.Departamento = string.IsNullOrWhiteSpace(txtDepartamento.Text) ? null : txtDepartamento.Text.Trim();
                medico.Domicilio.Localidad = txtLocalidad.Text.Trim();
                medico.Domicilio.Provincia = string.IsNullOrWhiteSpace(txtProvincia.Text) ? null : txtProvincia.Text.Trim();
                medico.Domicilio.CodigoPostal = string.IsNullOrWhiteSpace(txtCodigoPostal.Text) ? null : txtCodigoPostal.Text.Trim();

                medicoNegocio.ActualizarDatosPersonales(medico);

                HabilitarEdicionPersonal(false);
                CargarDatosMedico();
                MostrarMensaje("✓ Datos personales y dirección actualizados correctamente", true);
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar: " + ex.Message, false);
            }
        }

        protected void btnEditarProfesional_Click(object sender, EventArgs e)
        {
            HabilitarEdicionProfesional(true);
        }

        protected void btnCancelarProfesional_Click(object sender, EventArgs e)
        {
            HabilitarEdicionProfesional(false);
            CargarDatosMedico();
        }

        protected void btnGuardarProfesional_Click(object sender, EventArgs e)
        {
            try
            {
                MedicoNegocio medicoNegocio = new MedicoNegocio();
                MedicoModel medico = MedicoActual;

                medico.Matricula = txtMatriculaProfesional.Text.Trim();

                List<int> especialidadesSeleccionadas = new List<int>();
                foreach (ListItem item in cblEspecialidades.Items)
                {
                    if (item.Selected)
                    {
                        especialidadesSeleccionadas.Add(int.Parse(item.Value));
                    }
                }

                if (especialidadesSeleccionadas.Count == 0)
                {
                    MostrarMensaje("Debe seleccionar al menos una especialidad", false);
                    return;
                }

                medicoNegocio.ActualizarDatosProfesionales(medico.IdPersona, medico.Matricula, especialidadesSeleccionadas);

                HabilitarEdicionProfesional(false);
                CargarDatosMedico();
                MostrarMensaje("✓ Datos profesionales actualizados correctamente", true);
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar: " + ex.Message, false);
            }
        }

        private void HabilitarEdicionPersonal(bool habilitar)
        {
            txtTelefono.Enabled = habilitar;
            txtEmail.Enabled = habilitar;
            txtCalle.Enabled = habilitar;
            txtAltura.Enabled = habilitar;
            txtPiso.Enabled = habilitar;
            txtDepartamento.Enabled = habilitar;
            txtLocalidad.Enabled = habilitar;
            txtProvincia.Enabled = habilitar;
            txtCodigoPostal.Enabled = habilitar;
            pnlBotonesPersonal.Visible = habilitar;
            btnEditarPersonal.Visible = !habilitar;
        }

        private void HabilitarEdicionProfesional(bool habilitar)
        {
            txtMatriculaProfesional.Enabled = habilitar;
            ddlEspecialidad.Enabled = habilitar;
            cblEspecialidades.Enabled = habilitar;
            pnlBotonesProfesional.Visible = habilitar;
            btnEditarProfesional.Visible = !habilitar;
        }

        private void MostrarMensaje(string mensaje, bool esExito)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.CssClass = esExito ? "alert alert-success d-block mb-2" : "alert alert-danger d-block mb-2";
            lblMensaje.Visible = true;
        }
    }
}
