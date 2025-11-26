using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using DominioAdmin = dominio.Administrador;
using DominioRecep = dominio.Recepcionista;
using DominioMedico = dominio.Medico;

namespace TPCuatrimestral_equipo_23A
{
	public partial class Administradores : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				CargarContadores();
				CargarDesplegableRoles();
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

			int idRolSeleccionado = int.Parse(ddlRoles.SelectedValue);

			try
			{
				object dataSource = null;

				switch (idRolSeleccionado)
				{
					case 1:
						AdministradorNegocio adminNegocio = new AdministradorNegocio();
						dataSource = adminNegocio.Listar();
						break;
					case 2:
						RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
						dataSource = recepNegocio.Listar();
						break;
					case 3:
						MedicoNegocio medicoNegocio = new MedicoNegocio();
						dataSource = medicoNegocio.ListarActivos();
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
			int idRolSeleccionado = int.Parse(ddlRoles.SelectedValue);

			if (e.CommandName == "Eliminar")
			{
				try
				{
					switch (idRolSeleccionado)
					{
						case 1:
							AdministradorNegocio adminNegocio = new AdministradorNegocio();
							adminNegocio.EliminarLogico(idUsuarioSeleccionado);
							break;
						case 2:
							RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
							recepNegocio.EliminarLogico(idUsuarioSeleccionado);
							break;
						case 3:
							MedicoNegocio medicoNegocio = new MedicoNegocio();
							medicoNegocio.EliminarLogico(idUsuarioSeleccionado);
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
				switch (idRolSeleccionado)
				{
					case 1:
						Response.Redirect("~/AgregarEmpleado.aspx?ID=" + idUsuarioSeleccionado, false);
						break;
					case 2:
						Response.Redirect("~/AgregarEmpleado.aspx?ID=" + idUsuarioSeleccionado, false);
						break;
					case 3:
                        Response.Redirect("~/AgregarEmpleado.aspx?ID=" + idUsuarioSeleccionado, false);
                        break;
				}
			}
		}
	}
}