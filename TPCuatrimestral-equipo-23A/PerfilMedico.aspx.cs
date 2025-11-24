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

                // Sólo crear/actualizar domicilio si al menos un campo tiene valor
                bool tieneDireccion = !string.IsNullOrWhiteSpace(txtCalle.Text)
                    || !string.IsNullOrWhiteSpace(txtAltura.Text)
                    || !string.IsNullOrWhiteSpace(txtPiso.Text)
                    || !string.IsNullOrWhiteSpace(txtDepartamento.Text)
                    || !string.IsNullOrWhiteSpace(txtLocalidad.Text)
                    || !string.IsNullOrWhiteSpace(txtProvincia.Text)
                    || !string.IsNullOrWhiteSpace(txtCodigoPostal.Text);

                if (tieneDireccion)
                {
                    if (medico.Domicilio == null)
                        medico.Domicilio = new Domicilio();

                    medico.Domicilio.Calle = txtCalle.Text.Trim();
                    medico.Domicilio.Altura = txtAltura.Text.Trim();
                    medico.Domicilio.Piso = string.IsNullOrWhiteSpace(txtPiso.Text) ? null : txtPiso.Text.Trim();
                    medico.Domicilio.Departamento = string.IsNullOrWhiteSpace(txtDepartamento.Text) ? null : txtDepartamento.Text.Trim();
                    medico.Domicilio.Localidad = txtLocalidad.Text.Trim();
                    medico.Domicilio.Provincia = string.IsNullOrWhiteSpace(txtProvincia.Text) ? null : txtProvincia.Text.Trim();
                    medico.Domicilio.CodigoPostal = string.IsNullOrWhiteSpace(txtCodigoPostal.Text) ? null : txtCodigoPostal.Text.Trim();
                }
                else
                {
                    // Si no hay dirección, asegurarse de no enviar un Domicilio vacío al negocio
                    medico.Domicilio = null;
                }

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

                int idEspecialidadPrincipal = int.Parse(ddlEspecialidad.SelectedValue);
                if (idEspecialidadPrincipal == 0)
                {
                    MostrarMensaje("Debe seleccionar una especialidad principal", false);
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
                MostrarMensaje("✓ Datos profesionales actualizados correctamente", true);
            }
             catch (Exception ex)
            {
                throw new Exception("Error al actualizar datos profesionales: " + ex.Message, ex);
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
                bool solapaConMedico = turnosMedico.Any(t => (int)t.DiaSemana == dia && (entrada < t.HoraSalida && salida > t.HoraEntrada));
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
