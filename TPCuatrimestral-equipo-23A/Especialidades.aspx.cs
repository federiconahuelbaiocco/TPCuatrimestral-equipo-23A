using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPCuatrimestral_equipo_23A
{
	public partial class Especialidades : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				CargarEspecialidades();
			}
		}

		private void CargarEspecialidades()
		{
			EspecialidadNegocio negocio = new EspecialidadNegocio();
			try
			{
				List<dominio.Especialidad> listaEspecialidades = negocio.Listar();
				gvEspecialidades.DataSource = listaEspecialidades;
				gvEspecialidades.DataBind();
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		protected void btnAgregarEspecialidad_Click(object sender, EventArgs e)
		{
			EspecialidadNegocio negocio = new EspecialidadNegocio();
			try
			{
				dominio.Especialidad nueva = new dominio.Especialidad();
				nueva.Descripcion = txtNombreEspecialidad.Text;

				if (string.IsNullOrEmpty(nueva.Descripcion))
				{
					return;
				}

				negocio.Agregar(nueva);
				CargarEspecialidades();
				txtNombreEspecialidad.Text = "";
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		protected void btnGuardarEdicion_Click(object sender, EventArgs e)
		{
			EspecialidadNegocio negocio = new EspecialidadNegocio();
			try
			{
				dominio.Especialidad especialidad = new dominio.Especialidad();
				especialidad.IdEspecialidad = int.Parse(hfEspecialidadId.Value);
				especialidad.Descripcion = txtNombreEditar.Text;
				especialidad.Activo = chkActivoEditar.Checked;

				if (string.IsNullOrEmpty(especialidad.Descripcion))
				{
					return;
				}

				negocio.Modificar(especialidad);
				CargarEspecialidades();
				hfEspecialidadId.Value = "";
				txtNombreEditar.Text = "";
				chkActivoEditar.Checked = false;

				ScriptManager.RegisterStartupScript(this, GetType(), "limpiarFormulario",
					 "limpiarFormulario(); alert('? Especialidad actualizada correctamente');", true);
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		protected void gvEspecialidades_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			if (e.CommandName == "EliminarEsp")
			{
				try
				{
					int idEliminar = Convert.ToInt32(e.CommandArgument);
					EspecialidadNegocio negocio = new EspecialidadNegocio();
					negocio.EliminarLogico(idEliminar);
					CargarEspecialidades();

					if (hfEspecialidadId.Value == idEliminar.ToString())
					{
						ScriptManager.RegisterStartupScript(this, GetType(), "limpiarFormulario",
						   "limpiarFormulario();", true);
					}
				}
				catch (Exception ex)
				{
					Session["error"] = ex;
					Response.Redirect("~/Error.aspx", false);
				}
			}
			else if (e.CommandName == "EditarEsp")
			{
				try
				{
					int idEditar = Convert.ToInt32(e.CommandArgument);
					EspecialidadNegocio negocio = new EspecialidadNegocio();
					dominio.Especialidad seleccionada = negocio.Listar().Find(x => x.IdEspecialidad == idEditar);

					if (seleccionada != null)
					{
						hfEspecialidadId.Value = seleccionada.IdEspecialidad.ToString();
						txtNombreEditar.Text = seleccionada.Descripcion;
						chkActivoEditar.Checked = seleccionada.Activo;

						ScriptManager.RegisterStartupScript(this, GetType(), "mostrarFormulario", "mostrarFormularioEdicion();", true);
					}
				}
				catch (Exception ex)
				{
					Session["error"] = ex;
					Response.Redirect("~/Error.aspx", false);
				}
			}
		}

		protected void gvEspecialidades_RowDeleting(object sender, GridViewDeleteEventArgs e)
		{
		}
	}
}
