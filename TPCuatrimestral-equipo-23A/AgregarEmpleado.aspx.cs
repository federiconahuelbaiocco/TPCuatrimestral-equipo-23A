using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPCuatrimestral_equipo_23A
{
	public partial class AgregarEmpleado : System.Web.UI.Page
	{
		private List<TurnoTrabajo> HorariosTemporales
		{
			get
			{
				if (ViewState["HorariosTemporales"] == null)
					ViewState["HorariosTemporales"] = new List<TurnoTrabajo>();
				return (List<TurnoTrabajo>)ViewState["HorariosTemporales"];
			}
			set
			{
				ViewState["HorariosTemporales"] = value;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				CargarRoles();
				CargarOpcionesHorario();

				if (Request.QueryString["ID"] != null)
				{
					CargarDatosParaModificar();
				}
			}
		}

		private void CargarOpcionesHorario()
		{
			TurnoTrabajoNegocio negocio = new TurnoTrabajoNegocio();
			List<string> opciones = negocio.GenerarOpcionesHorario();

			ddlDesde.DataSource = opciones;
			ddlDesde.DataBind();

			ddlHasta.DataSource = opciones;
			ddlHasta.DataBind();
		}

		private void CargarRoles()
		{
			RolNegocio negocio = new RolNegocio();
			try
			{
				List<Rol> roles = negocio.Listar();

				ddlRol.DataSource = roles;
				ddlRol.DataValueField = "IdRol";
				ddlRol.DataTextField = "Nombre";
				ddlRol.DataBind();
				ddlRol.Items.Insert(0, new ListItem("-- Seleccione Rol --", "0"));
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		private void CargarDatosParaModificar()
		{
			try
			{
				int idUsuario = int.Parse(Request.QueryString["ID"]);

				AdministradorNegocio adminNegocio = new AdministradorNegocio();
				List<dominio.Administrador> listaAdmin = adminNegocio.Listar();
				dominio.Administrador admin = null;
				foreach (dominio.Administrador a in listaAdmin)
				{
					if (a.Usuario.IdUsuario == idUsuario)
					{
						admin = a;
						break;
					}
				}

				if (admin != null)
				{
					CargarCampos(admin, 1);
					return;
				}

				RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
				List<dominio.Recepcionista> listaRecep = recepNegocio.Listar();
				dominio.Recepcionista recep = null;
				foreach (dominio.Recepcionista r in listaRecep)
				{
					if (r.Usuario.IdUsuario == idUsuario)
					{
						recep = r;
						break;
					}
				}

				if (recep != null)
				{
					CargarCampos(recep, 2);
					return;
				}
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		private void CargarCampos(dominio.Persona persona, int idRol)
		{
			txtNombre.Text = persona.Nombre;
			txtApellido.Text = persona.Apellido;
			txtDni.Text = persona.Dni;
			ddlSexo.SelectedValue = persona.Sexo.ToString();
			txtTelefono.Text = persona.Telefono;
			txtEmailContacto.Text = persona.Email;

			ddlRol.SelectedValue = idRol.ToString();
			ddlRol.Enabled = false;

			if (persona is dominio.Administrador)
			{
				txtNombreUsuario.Text = ((dominio.Administrador)persona).Usuario.NombreUsuario;
			}
			else if (persona is dominio.Recepcionista)
			{
				txtNombreUsuario.Text = ((dominio.Recepcionista)persona).Usuario.NombreUsuario;
			}

			txtNombreUsuario.Enabled = false;
			lblAvisoClave.Visible = true;
			btnGuardar.Text = "Modificar Empleado";
			litTitulo.Text = "Modificar Empleado";
		}

		protected void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
		{
			int idRol = int.Parse(ddlRol.SelectedValue);
			Panel1.Visible = (idRol == 3);
			
			if (idRol == 3)
			{
				CargarEspecialidades();
				ActualizarGridHorarios();
			}
		}

		private void CargarEspecialidades()
		{
			EspecialidadNegocio negocio = new EspecialidadNegocio();
			List<Especialidad> lista = negocio.Listar();
			List<Especialidad> listaActivos = new List<Especialidad>();
			
			foreach (Especialidad esp in lista)
			{
				if (esp.Activo)
					listaActivos.Add(esp);
			}

			chkEspecialidades.DataSource = listaActivos;
			chkEspecialidades.DataTextField = "Descripcion";
			chkEspecialidades.DataValueField = "IdEspecialidad";
			chkEspecialidades.DataBind();
		}

		protected void btnAgregarHorario_Click(object sender, EventArgs e)
		{
			try
			{
				lblErrorHorario.Text = "";

				TurnoTrabajo turno = new TurnoTrabajo();
				turno.DiaSemana = (DayOfWeek)int.Parse(ddlDia.SelectedValue);
				turno.HoraEntrada = TimeSpan.Parse(ddlDesde.SelectedValue);
				turno.HoraSalida = TimeSpan.Parse(ddlHasta.SelectedValue);

				if (turno.HoraSalida <= turno.HoraEntrada)
				{
					lblErrorHorario.Text = "La hora de salida debe ser mayor a la hora de entrada.";
					return;
				}

				List<TurnoTrabajo> horarios = HorariosTemporales;
				horarios.Add(turno);
				HorariosTemporales = horarios;

				ActualizarGridHorarios();
			}
			catch (Exception ex)
			{
				lblErrorHorario.Text = "Error al agregar horario: " + ex.Message;
			}
		}

		private void ActualizarGridHorarios()
		{
			List<TurnoTrabajo> horarios = HorariosTemporales;
			List<object> horariosParaGrid = new List<object>();
			
			foreach (TurnoTrabajo h in horarios)
			{
				horariosParaGrid.Add(new
				{
					Dia = ObtenerNombreDia(h.DiaSemana),
					Entrada = h.HoraEntrada.ToString(@"hh\:mm"),
					Salida = h.HoraSalida.ToString(@"hh\:mm")
				});
			}

			gvHorarios.DataSource = horariosParaGrid;
			gvHorarios.DataBind();
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
				default: return dia.ToString();
			}
		}

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (ddlRol.SelectedValue == "0" && Request.QueryString["ID"] == null)
            {
                return;
            }

            try
            {
                bool esModificacion = (Request.QueryString["ID"] != null);
                int idUsuario = esModificacion ? int.Parse(Request.QueryString["ID"]) : 0;
                int idRol = esModificacion ? 0 : int.Parse(ddlRol.SelectedValue);

                if (esModificacion)
                {
                    AdministradorNegocio adminNegocio = new AdministradorNegocio();
                    List<dominio.Administrador> listaAdmin = adminNegocio.Listar();
                    foreach (dominio.Administrador a in listaAdmin)
                    {
                        if (a.Usuario.IdUsuario == idUsuario)
                        {
                            idRol = 1;
                            break;
                        }
                    }

                    if (idRol == 0)
                    {
                        RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
                        List<dominio.Recepcionista> listaRecep = recepNegocio.Listar();
                        foreach (dominio.Recepcionista r in listaRecep)
                        {
                            if (r.Usuario.IdUsuario == idUsuario)
                            {
                                idRol = 2;
                                break;
                            }
                        }
                    }

                    if (idRol == 0) idRol = 3;
                }

                if (idRol == 1)
                {
                    AdministradorNegocio negocio = new AdministradorNegocio();
					dominio.Administrador admin = new dominio.Administrador();
					emailServiceNegocio emailService = new emailServiceNegocio();

                    admin.Nombre = txtNombre.Text;
                    admin.Apellido = txtApellido.Text;
                    admin.Dni = txtDni.Text;
                    admin.Sexo = ddlSexo.SelectedValue;
                    if (string.IsNullOrEmpty(admin.Sexo)) admin.Sexo = "No especificado";
                    admin.Telefono = txtTelefono.Text;
                    admin.Email = txtEmailContacto.Text;

                    admin.Domicilio = new Domicilio();
                    admin.Domicilio.Calle = txtCalle.Text;
                    admin.Domicilio.Altura = txtNumero.Text;
                    admin.Domicilio.Piso = txtPiso.Text;
                    admin.Domicilio.Departamento = txtDepartamento.Text;
                    admin.Domicilio.Localidad = txtLocalidad.Text;
                    admin.Domicilio.Provincia = txtProvincia.Text;
                    admin.Domicilio.CodigoPostal = txtCP.Text;

                    admin.Usuario = new dominio.Usuario();
                    admin.Usuario.NombreUsuario = txtNombreUsuario.Text;
                    admin.Usuario.Clave = string.IsNullOrEmpty(txtContrasena.Text) ? null : txtContrasena.Text;

                    if (esModificacion)
                    {
                        admin.Usuario.IdUsuario = idUsuario;
                        negocio.Modificar(admin);
						emailService.enviarCorreoModificacionEmpleado(admin.Email, admin.Nombre);
						emailService.enviarCorreo();

					}
					else
                    {
						negocio.Agregar(admin);
						emailService.enviarCorreoAltaEmpleado(admin.Email, admin.Apellido, admin.Nombre, admin.Usuario.NombreUsuario, admin.Usuario.Clave);
                        emailService.enviarCorreo();
                    }
				}
                else if (idRol == 2)
                {
                    RecepcionistaNegocio negocio = new RecepcionistaNegocio();
					dominio.Recepcionista recep = new dominio.Recepcionista();
                    emailServiceNegocio emailService = new emailServiceNegocio();

                    recep.Nombre = txtNombre.Text;
                    recep.Apellido = txtApellido.Text;
                    recep.Dni = txtDni.Text;
                    recep.Sexo = ddlSexo.SelectedValue;
                    if (string.IsNullOrEmpty(recep.Sexo)) recep.Sexo = "No especificado";
                    recep.Telefono = txtTelefono.Text;
                    recep.Email = txtEmailContacto.Text;

                    recep.Domicilio = new Domicilio();
                    recep.Domicilio.Calle = txtCalle.Text;
                    recep.Domicilio.Altura = txtNumero.Text;
                    recep.Domicilio.Piso = txtPiso.Text;
                    recep.Domicilio.Departamento = txtDepartamento.Text;
                    recep.Domicilio.Localidad = txtLocalidad.Text;
                    recep.Domicilio.Provincia = txtProvincia.Text;
                    recep.Domicilio.CodigoPostal = txtCP.Text;

                    recep.Usuario = new dominio.Usuario();
                    recep.Usuario.NombreUsuario = txtNombreUsuario.Text;
                    recep.Usuario.Clave = string.IsNullOrEmpty(txtContrasena.Text) ? null : txtContrasena.Text;

                    if (esModificacion)
					{
						recep.Usuario.IdUsuario = idUsuario;
						negocio.Modificar(recep);
						emailService.enviarCorreoModificacionEmpleado(recep.Email, recep.Nombre);
                        emailService.enviarCorreo();
                    }
					else
                    {
                        negocio.Agregar(recep);
						emailService.enviarCorreoAltaEmpleado(recep.Email, recep.Apellido, recep.Nombre, recep.Usuario.NombreUsuario, recep.Usuario.Clave);
                        emailService.enviarCorreo();
                    }
				}
                else if (idRol == 3)
                {
                    MedicoNegocio negocio = new MedicoNegocio();
                    dominio.Medico nuevo = new dominio.Medico();
					emailServiceNegocio emailService = new emailServiceNegocio();

                    nuevo.Nombre = txtNombre.Text;
                    nuevo.Apellido = txtApellido.Text;
                    nuevo.Dni = txtDni.Text;
                    nuevo.Sexo = ddlSexo.SelectedValue;
                    if (string.IsNullOrEmpty(nuevo.Sexo)) nuevo.Sexo = "No especificado";
                    nuevo.Telefono = txtTelefono.Text;
                    nuevo.Email = txtEmailContacto.Text;
                    nuevo.Matricula = txtMatricula.Text;

                    nuevo.Domicilio = new Domicilio();
                    nuevo.Domicilio.Calle = txtCalle.Text;
                    nuevo.Domicilio.Altura = txtNumero.Text;
                    nuevo.Domicilio.Piso = txtPiso.Text;
                    nuevo.Domicilio.Departamento = txtDepartamento.Text;
                    nuevo.Domicilio.Localidad = txtLocalidad.Text;
                    nuevo.Domicilio.Provincia = txtProvincia.Text;
                    nuevo.Domicilio.CodigoPostal = txtCP.Text;

                    nuevo.Usuario = new dominio.Usuario();
                    nuevo.Usuario.NombreUsuario = txtNombreUsuario.Text;
                    nuevo.Usuario.Clave = string.IsNullOrEmpty(txtContrasena.Text) ? null : txtContrasena.Text;

                    if (esModificacion)
                    {
                        nuevo.Usuario.IdUsuario = idUsuario;
                        negocio.Modificar(nuevo);
						emailService.enviarCorreoModificacionEmpleado(nuevo.Email, nuevo.Nombre);
                        emailService.enviarCorreo();
                    }
					else
                    {
                        int idNuevoMedico = negocio.AgregarConUsuario(nuevo);

						if (idNuevoMedico > 0)
						{
							List<TurnoTrabajo> horarios = HorariosTemporales;
							if (horarios != null && horarios.Count > 0)
							{
								TurnoTrabajoNegocio turnoNegocio = new TurnoTrabajoNegocio();
								foreach (TurnoTrabajo turno in horarios)
								{
									turnoNegocio.Agregar(idNuevoMedico, turno);
								}
							}

							List<int> especialidadesSeleccionadas = new List<int>();
							foreach (ListItem item in chkEspecialidades.Items)
							{
								if (item.Selected)
									especialidadesSeleccionadas.Add(int.Parse(item.Value));
							}
							if (especialidadesSeleccionadas.Count > 0)
							{
								EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
								foreach (int idEspecialidad in especialidadesSeleccionadas)
								{
									especialidadNegocio.AgregarEspecialidadAMedico(idNuevoMedico, idEspecialidad);
								}
							}
						}
						else
						{
							throw new Exception("No se pudo obtener el Id del médico insertado.");
						}
						emailService.enviarCorreoAltaEmpleado(nuevo.Email, nuevo.Apellido, nuevo.Nombre, nuevo.Usuario.NombreUsuario, nuevo.Usuario.Clave);
                        emailService.enviarCorreo();
                    }
				}

                Response.Redirect("~/Administradores.aspx", false);
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }
    }
}