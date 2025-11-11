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
			try
			{
				ddlRoles.Items.Clear();
				ddlRoles.Items.Add(new ListItem("Administrador", "Administrador"));
				ddlRoles.Items.Add(new ListItem("Recepcionista", "Recepcionista"));
				ddlRoles.Items.Add(new ListItem("Médico", "Medico"));
				
				ddlRoles.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		private void CargarGrillaUsuarios()
		{
			string nombreRol = ddlRoles.SelectedValue;

			try
			{
				object dataSource = null;

				switch (nombreRol)
				{
					case "Administrador":
						AdministradorNegocio adminNegocio = new AdministradorNegocio();
						dataSource = adminNegocio.Listar();
						break;
					case "Recepcionista":
						RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
						dataSource = recepNegocio.Listar();
						break;
					case "Medico":
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
			int idSeleccionado = Convert.ToInt32(e.CommandArgument);
			string nombreRol = ddlRoles.SelectedValue;

			if (e.CommandName == "Eliminar")
			{
				try
				{
					switch (nombreRol)
					{
						case "Administrador":
							AdministradorNegocio adminNegocio = new AdministradorNegocio();
							adminNegocio.EliminarLogico(idSeleccionado);
							break;
						case "Recepcionista":
							RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
							recepNegocio.EliminarLogico(idSeleccionado);
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
						Response.Redirect("~/AdministradorForm.aspx?ID=" + idSeleccionado, false);
						break;
					case "Recepcionista":
						Response.Redirect("~/RecepcionistaForm.aspx?ID=" + idSeleccionado, false);
						break;
					case "Medico":
						Response.Redirect("~/MedicoForm.aspx?ID=" + idSeleccionado, false);
						break;
				}
			}
		}
	}
}