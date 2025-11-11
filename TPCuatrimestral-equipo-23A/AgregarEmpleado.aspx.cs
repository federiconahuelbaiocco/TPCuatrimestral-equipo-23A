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
			}
		}

		private void CargarRoles()
		{
			RolNegocio negocio = new RolNegocio();
			try
			{
				List<Rol> roles = negocio.Listar().FindAll(x => x.Nombre != "Medico");

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

		protected void btnGuardar_Click(object sender, EventArgs e)
		{
			if (ddlRol.SelectedValue == "0")
			{
				return;
			}

			try
			{
				string rolSeleccionado = ddlRol.SelectedItem.Text;

				if (rolSeleccionado == "Administrador")
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
					admin.Usuario.Clave = txtContrasena.Text;

					negocio.Agregar(admin);
				}
				else if (rolSeleccionado == "Recepcionista")
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
					recep.Usuario.Clave = txtContrasena.Text;

					negocio.Agregar(recep);
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