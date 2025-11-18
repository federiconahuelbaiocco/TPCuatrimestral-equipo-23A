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
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				CargarRoles();

				if (Request.QueryString["ID"] != null)
				{
					CargarDatosParaModificar();
				}
			}
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
				dominio.Administrador admin = adminNegocio.Listar().Find(x => x.Usuario.IdUsuario == idUsuario);

				if (admin != null)
				{
					CargarCampos(admin, 1);
					return;
				}

				RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
				dominio.Recepcionista recep = recepNegocio.Listar().Find(x => x.Usuario.IdUsuario == idUsuario);

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
					dominio.Administrador admin = adminNegocio.Listar().Find(x => x.Usuario.IdUsuario == idUsuario);
					if (admin != null) idRol = 1;

					if (idRol == 0)
					{
						RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
						dominio.Recepcionista recep = recepNegocio.Listar().Find(x => x.Usuario.IdUsuario == idUsuario);
						if (recep != null) idRol = 2;
					}
				}


				if (idRol == 1)
				{
					AdministradorNegocio negocio = new AdministradorNegocio();
					dominio.Administrador admin = new dominio.Administrador();
					admin.Nombre = txtNombre.Text;
					admin.Apellido = txtApellido.Text;
					admin.Dni = txtDni.Text;
                    admin.Sexo = ddlSexo.SelectedValue;
                    if (string.IsNullOrEmpty(admin.Sexo))
                        admin.Sexo = "No especificado";
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
					}
					else
					{
						negocio.Agregar(admin);
					}
				}
				else if (idRol == 2)
				{
					RecepcionistaNegocio negocio = new RecepcionistaNegocio();
					dominio.Recepcionista recep = new dominio.Recepcionista();
					recep.Nombre = txtNombre.Text;
					recep.Apellido = txtApellido.Text;
					recep.Dni = txtDni.Text;
                    recep.Sexo = ddlSexo.SelectedValue;
                    if (string.IsNullOrEmpty(recep.Sexo))
                        recep.Sexo = "No especificado";
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
					}
					else
					{
						negocio.Agregar(recep);
					}
				}

				else if(idRol == 3)
				{
					MedicoNegocio negocio = new MedicoNegocio();
					dominio.Medico nuevo = new dominio.Medico();

                    nuevo.Nombre = txtNombre.Text;
                    nuevo.Apellido = txtApellido.Text;
                    nuevo.Dni = txtDni.Text;
                    nuevo.Sexo = ddlSexo.SelectedValue;
                    if (string.IsNullOrEmpty(nuevo.Sexo))
                        nuevo.Sexo = "No especificado";
                    nuevo.Telefono = txtTelefono.Text;
                    nuevo.Email = txtEmailContacto.Text;

                   
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
                    }
                    else
                    {
                        negocio.Agregar(nuevo);
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

        protected void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
        {
			Panel1.Visible = true;
			CargarEspecialidades();
        }

        private void CargarEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            var lista = negocio.ListarActivos();

            chkEspecialidades.DataSource = lista;
            chkEspecialidades.DataTextField = "Descripcion";
            chkEspecialidades.DataValueField = "IdEspecialidad";
            chkEspecialidades.DataBind();
        }

    }
}