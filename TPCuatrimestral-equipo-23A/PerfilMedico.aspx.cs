using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MedicoModel = dominio.Medico;

namespace TPCuatrimestral_equipo_23A
{
    public partial class PerfilMedico : System.Web.UI.Page
    {
        protected DropDownList ddlDiaSemana;
        protected DropDownList ddlHoraEntrada;
        protected DropDownList ddlHoraSalida;
        protected Repeater rptTurnosTrabajo;

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
            Usuario usuario = Session["usuario"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            MedicoNegocio medicoNegocio = new MedicoNegocio();
            MedicoModel medicoEnSession = usuario.Persona as MedicoModel;

            if (!IsPostBack)
            {
                MedicoModel medicoRefrescado = null;
                try
                {
                    if (medicoEnSession != null)
                        medicoRefrescado = medicoNegocio.ObtenerPorId(medicoEnSession.IdPersona);
                }
                catch
                {
                    medicoRefrescado = medicoEnSession;
                }

                if (medicoRefrescado != null)
                {
                    MedicoActual = medicoRefrescado;
                    usuario.Persona = medicoRefrescado;
                    Session["usuario"] = usuario;
                }
                else
                {
                    MedicoActual = medicoEnSession;
                }

                CargarEspecialidades();
                CargarDatosMedico();

                InicializarTurnosTrabajoUI();
                CargarTurnosTrabajo();
            }
        }

        private void CargarDatosMedico()
        {
            try
            {
                MedicoModel medico = MedicoActual;

                if (medico != null)
                {
                    lblNombreCompleto.Text = $"Dr./Dra. {medico.Apellido}, {medico.Nombre}";
                    lblMatricula.Text = medico.Matricula;

                    string especialidades = "";
                    if (medico.Especialidades != null && medico.Especialidades.Count > 0)
                    {
                        especialidades = string.Join(", ", medico.Especialidades.Select(e => e.Descripcion));
                        ddlEspecialidad.SelectedValue = medico.Especialidades[0].IdEspecialidad.ToString();
                    }
                    else
                    {
                        especialidades = "Sin especialidad asignada";
                        ddlEspecialidad.SelectedIndex = 0;
                    }
                    lblEspecialidades.Text = especialidades;

                    txtNombre.Text = medico.Nombre;
                    txtApellido.Text = medico.Apellido;
                    txtDni.Text = medico.Dni;
                    txtSexo.Text = medico.Sexo ?? "No especificado";
                    txtFechaNacimiento.Text = medico.FechaNacimiento.HasValue ? medico.FechaNacimiento.Value.ToString("yyyy-MM-dd") : "No disponible";
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
                    txtUsuario.Text = medico.Usuario != null ? medico.Usuario.NombreUsuario : string.Empty;

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
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar especialidades: " + ex.Message, false);
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

                bool tieneDireccion = !string.IsNullOrWhiteSpace(txtCalle.Text) || !string.IsNullOrWhiteSpace(txtAltura.Text)
                                      || !string.IsNullOrWhiteSpace(txtLocalidad.Text);

                if (tieneDireccion)
                {
                    if (medico.Domicilio == null) medico.Domicilio = new Domicilio();
                    medico.Domicilio.Calle = txtCalle.Text.Trim();
                    medico.Domicilio.Altura = txtAltura.Text.Trim();
                    medico.Domicilio.Piso = txtPiso.Text.Trim();
                    medico.Domicilio.Departamento = txtDepartamento.Text.Trim();
                    medico.Domicilio.Localidad = txtLocalidad.Text.Trim();
                    medico.Domicilio.Provincia = txtProvincia.Text.Trim();
                    medico.Domicilio.CodigoPostal = txtCodigoPostal.Text.Trim();
                }
                else
                {
                    medico.Domicilio = null;
                }

                medicoNegocio.Modificar(medico);
                emailServiceNegocio emailService = new emailServiceNegocio();
                emailService.enviarCorreoModificacionEmpleado(medico.Email, medico.Nombre);
                emailService.enviarCorreo();

                var medicoActualizado = medicoNegocio.ObtenerPorId(medico.IdPersona);
                if (medicoActualizado != null)
                {
                    MedicoActual = medicoActualizado;
                    var usuario = Session["usuario"] as Usuario;
                    if (usuario != null)
                    {
                        usuario.Persona = medicoActualizado;
                        Session["usuario"] = usuario;
                    }
                }

                HabilitarEdicionPersonal(false);
                CargarDatosMedico();

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", "mostrarToastMensaje('Datos personales actualizados correctamente.','success');", true);
            }
            catch (Exception ex)
            {
                string mensajeError = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", $"mostrarToastMensaje('Error: {mensajeError.Replace("'", "\\'")}','danger');", true);
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

                int idEspecialidadPrincipal = int.Parse(ddlEspecialidad.SelectedValue);
                if (idEspecialidadPrincipal == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", "mostrarToastMensaje('Debe seleccionar una especialidad principal.','danger');", true);
                    return;
                }
                var especialidadesSeleccionadas = new List<int> { idEspecialidadPrincipal };

                medicoNegocio.ActualizarDatosProfesionales(medico.IdPersona, medico.Matricula, especialidadesSeleccionadas);

                var medicoActualizado = medicoNegocio.ObtenerPorId(medico.IdPersona);
                MedicoActual = medicoActualizado;

                var usuario = Session["usuario"] as Usuario;
                if (usuario != null && medicoActualizado != null)
                {
                    usuario.Persona = medicoActualizado;
                    Session["usuario"] = usuario;
                }

                HabilitarEdicionProfesional(false);
                CargarDatosMedico();

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", "mostrarToastMensaje('Datos profesionales actualizados correctamente.','success');", true);
            }
            catch (Exception ex)
            {
                string mensajeError = ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", $"mostrarToastMensaje('Error: {mensajeError.Replace("'", "\\'")}','danger');", true);
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
            pnlBotonesProfesional.Visible = habilitar;
            btnEditarProfesional.Visible = !habilitar;
        }

        private void MostrarMensaje(string mensaje, bool esExito)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.CssClass = esExito ? "alert alert-success d-block mb-2" : "alert alert-danger d-block mb-2";
            lblMensaje.Visible = true;
        }

        private void InicializarTurnosTrabajoUI()
        {
            TurnoTrabajoNegocio ttn = new TurnoTrabajoNegocio();

            ddlDiaSemana.Items.Clear();
            ddlDiaSemana.Items.Add(new ListItem("Lunes", ((int)DayOfWeek.Monday).ToString()));
            ddlDiaSemana.Items.Add(new ListItem("Martes", ((int)DayOfWeek.Tuesday).ToString()));
            ddlDiaSemana.Items.Add(new ListItem("Miércoles", ((int)DayOfWeek.Wednesday).ToString()));
            ddlDiaSemana.Items.Add(new ListItem("Jueves", ((int)DayOfWeek.Thursday).ToString()));
            ddlDiaSemana.Items.Add(new ListItem("Viernes", ((int)DayOfWeek.Friday).ToString()));
            ddlDiaSemana.Items.Add(new ListItem("Sábado", ((int)DayOfWeek.Saturday).ToString()));
            ddlDiaSemana.Items.Add(new ListItem("Domingo", ((int)DayOfWeek.Sunday).ToString()));

            ddlHoraEntrada.Items.Clear();
            ddlHoraSalida.Items.Clear();
            var horarios = ttn.GenerarOpcionesHorario();
            foreach (var h in horarios)
            {
                ddlHoraEntrada.Items.Add(new ListItem(h, h));
                ddlHoraSalida.Items.Add(new ListItem(h, h));
            }
        }

        private void CargarTurnosTrabajo()
        {
            try
            {
                var ttn = new TurnoTrabajoNegocio();
                var lista = ttn.ListarHorariosPorMedico(MedicoActual.IdPersona);
                rptTurnosTrabajo.DataSource = lista;
                rptTurnosTrabajo.DataBind();
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
            }
        }

        protected void btnAgregarTurno_Click(object sender, EventArgs e)
        {
            try
            {
                if (MedicoActual == null)
                {
                    MostrarMensaje("No se encontró médico en sesión.", false);
                    return;
                }

                var ttn = new TurnoTrabajoNegocio();

                int dia;
                TimeSpan entrada;
                TimeSpan salida;

                if (!int.TryParse(ddlDiaSemana.SelectedValue, out dia))
                {
                    MostrarMensaje("Día seleccionado inválido.", false);
                    return;
                }

                if (!TimeSpan.TryParse(ddlHoraEntrada.SelectedValue, out entrada) || !TimeSpan.TryParse(ddlHoraSalida.SelectedValue, out salida))
                {
                    MostrarMensaje("Formato de hora inválido.", false);
                    return;
                }

                if (salida <= entrada)
                {
                    MostrarMensaje("La hora de salida debe ser posterior a la de entrada.", false);
                    return;
                }

                var turnosMedico = ttn.ListarHorariosPorMedico(MedicoActual.IdPersona) ?? new List<TurnoTrabajo>();
                bool solapaConMedico = false;
                foreach (var t in turnosMedico)
                {
                    if ((int)t.DiaSemana == dia && (entrada < t.HoraSalida && salida > t.HoraEntrada))
                    {
                        solapaConMedico = true;
                        break;
                    }
                }
                if (solapaConMedico)
                {
                    MostrarMensaje("El médico ya posee un horario asignado que se superpone con este rango.", false);
                    return;
                }

                ttn.Agregar(MedicoActual.IdPersona, new TurnoTrabajo { DiaSemana = (DayOfWeek)dia, HoraEntrada = entrada, HoraSalida = salida });
                CargarTurnosTrabajo();
                MostrarMensaje("Turno de trabajo agregado.", true);
            }
            catch (Exception ex)
            {
                Session["error"] = ex;

                var detalle = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
                MostrarMensaje("Error al agregar turno: " + detalle, false);
            }
        }

        protected void rptTurnosTrabajo_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                try
                {
                    int id = int.Parse(e.CommandArgument.ToString());
                    var ttn = new TurnoTrabajoNegocio();
                    ttn.Eliminar(id);
                    CargarTurnosTrabajo();
                    MostrarMensaje("Turno eliminado.", true);
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al eliminar turno: " + ex.Message, false);
                }
            }
        }
    }
}
