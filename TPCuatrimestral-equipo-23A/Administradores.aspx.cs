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
						gvUsuariosRol.DataKeyNames = new string[] { "IdPersona" };
						break;
					case "Recepcionista":
						RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
						dataSource = recepNegocio.Listar();
						gvUsuariosRol.DataKeyNames = new string[] { "IdPersona" };
						break;
					case "Medico":
						MedicoNegocio medicoNegocio = new MedicoNegocio();
						dataSource = medicoNegocio.ListarActivos();
						gvUsuariosRol.DataKeyNames = new string[] { "IdPersona" };
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

			int idPersonaSeleccionado = Convert.ToInt32(e.CommandArgument);
			string nombreRol = ddlRoles.SelectedItem.Text;

			if (e.CommandName == "Eliminar")
			{
				try
				{
					int idUsuario = ObtenerIdUsuarioPorIdPersona(idPersonaSeleccionado, nombreRol);

					switch (nombreRol)
					{
						case "Administrador":
							AdministradorNegocio adminNegocio = new AdministradorNegocio();
							adminNegocio.EliminarLogico(idUsuario);
							break;
						case "Recepcionista":
							RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
							recepNegocio.EliminarLogico(idUsuario);
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
				int idUsuario = ObtenerIdUsuarioPorIdPersona(idPersonaSeleccionado, nombreRol);

				switch (nombreRol)
				{
					case "Administrador":
						Response.Redirect("~/AdministradorForm.aspx?ID=" + idUsuario, false);
						break;
					case "Recepcionista":
						Response.Redirect("~/RecepcionistaForm.aspx?ID=" + idUsuario, false);
						break;
					case "Medico":
						Response.Redirect("~/MedicoForm.aspx?ID=" + idUsuario, false);
						break;
				}
			}
		}

		private int ObtenerIdUsuarioPorIdPersona(int idPersona, string nombreRol)
		{
			switch (nombreRol)
			{
				case "Administrador":
					AdministradorNegocio adminNegocio = new AdministradorNegocio();
					List<DominioAdmin> admins = adminNegocio.Listar();
					DominioAdmin admin = admins.Find(a => a.IdPersona == idPersona);
					return admin != null ? admin.Usuario.IdUsuario : 0;

				case "Recepcionista":
					RecepcionistaNegocio recepNegocio = new RecepcionistaNegocio();
					List<DominioRecep> receps = recepNegocio.Listar();
					DominioRecep recep = receps.Find(r => r.IdPersona == idPersona);
					return recep != null ? recep.Usuario.IdUsuario : 0;

				case "Medico":
					MedicoNegocio medicoNegocio = new MedicoNegocio();
					List<DominioMedico> medicos = medicoNegocio.ListarActivos();
					DominioMedico medico = medicos.Find(m => m.IdPersona == idPersona);
					return medico != null ? medico.Usuario.IdUsuario : 0;

				default:
					return 0;
			}
		}
	}
}