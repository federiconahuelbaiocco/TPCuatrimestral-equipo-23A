using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPCuatrimestral_equipo_23A
{
	public partial class Administradores : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			CargarDesplegableRoles();

			if (!IsPostBack)
			{
				CargarContadores();
				CargarGrillaUsuarios();
			}
		}

		private void CargarContadores()
		{
			try
			{
				AdministradorNegocio adminNegocio = new AdministradorNegocio();
				RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
				MedicoNegocio medicoNegocio = new MedicoNegocio();

				lblAdminCount.Text = adminNegocio.Listar().Count.ToString();
				lblRecepCount.Text = recepNegocio.Listar().Count.ToString();
				lblMedicoCount.Text = medicoNegocio.ListarActivos().Count.ToString();
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		private void CargarDesplegableRoles()
		{
			RolNegocio negocioRol = new RolNegocio();
			try
			{
				if (!IsPostBack)
				{
					List<Rol> roles = negocioRol.Listar();

					ddlRoles.DataSource = roles;
					ddlRoles.DataValueField = "IdRol";
					ddlRoles.DataTextField = "Nombre";
					ddlRoles.DataBind();

					ListItem itemAdmin = ddlRoles.Items.FindByText("Administrador");
					if (itemAdmin != null)
					{
						itemAdmin.Selected = true;
					}
				}
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		private void CargarGrillaUsuarios()
		{
			if (ddlRoles.SelectedItem == null)
			{
				return;
			}

			string nombreRol = ddlRoles.SelectedItem.Text;

			try
			{
				object dataSource = null;

				switch (nombreRol)
				{
					case "Administrador":
						AdministradorNegocio adminNegocio = new AdministradorNegocio();
						dataSource = adminNegocio.Listar();
						gvUsuariosRol.DataKeyNames = new string[] { "Usuario.IdUsuario" };
						break;
					case "Recepcionista":
						RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
						dataSource = recepNegocio.Listar();
						gvUsuariosRol.DataKeyNames = new string[] { "Usuario.IdUsuario" };
						break;
					case "Medico":
						MedicoNegocio medicoNegocio = new MedicoNegocio();
						dataSource = medicoNegocio.ListarActivos();
						gvUsuariosRol.DataKeyNames = new string[] { "Usuario.IdUsuario" };
						break;
					default:
						break;
				}

				gvUsuariosRol.DataSource = dataSource;
				gvUsuariosRol.DataBind();
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		protected void ddlRoles_SelectedIndexChanged(object sender, EventArgs e)
		{
			CargarGrillaUsuarios();
		}

		protected void gvUsuariosRol_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			if (ddlRoles.SelectedItem == null)
			{
				return;
			}

			int idUsuarioSeleccionado = Convert.ToInt32(e.CommandArgument);
			string nombreRol = ddlRoles.SelectedItem.Text;

			if (e.CommandName == "Eliminar")
			{
				try
				{
					switch (nombreRol)
					{
						case "Administrador":
							AdministradorNegocio adminNegocio = new AdministradorNegocio();
							adminNegocio.EliminarLogico(idUsuarioSeleccionado);
							break;
						case "Recepcionista":
							RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
							recepNegocio.EliminarLogico(idUsuarioSeleccionado);
							break;
						case "Medico":
							break;
					}

					CargarContadores();
					CargarGrillaUsuarios();
				}
				catch (Exception ex)
				{
					Session["error"] = ex;
					Response.Redirect("~/Error.aspx", false);
				}
			}
			else if (e.CommandName == "Editar")
			{
				switch (nombreRol)
				{
					case "Administrador":
						Response.Redirect("~/AdministradorForm.aspx?ID=" + idUsuarioSeleccionado, false);
						break;
					case "Recepcionista":
						Response.Redirect("~/RecepcionistaForm.aspx?ID=" + idUsuarioSeleccionado, false);
						break;
					case "Medico":
						Response.Redirect("~/MedicoForm.aspx?ID=" + idUsuarioSeleccionado, false);
						break;
				}
			}
		}
	}
}