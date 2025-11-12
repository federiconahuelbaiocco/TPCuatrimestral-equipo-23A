using dominio;
using negocio;
using System;
using System.Collections.Generic;
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
				List<Rol> roles = negocio.Listar().FindAll(x => x.IdRol != 3);

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
					admin.Telefono = txtTelefono.Text;
					admin.Email = txtEmailContacto.Text;

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
					recep.Telefono = txtTelefono.Text;
					recep.Email = txtEmailContacto.Text;

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