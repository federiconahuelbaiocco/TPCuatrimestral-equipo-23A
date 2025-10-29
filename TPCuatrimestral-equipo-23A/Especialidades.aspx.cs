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
				Response.Redirect("Error.aspx", false);
			}
		}

		protected void btnAgregarEspecialidad_Click(object sender, EventArgs e)
		{
		}

		protected void gvEspecialidades_RowCommand(object sender, GridViewCommandEventArgs e)
		{
		}

		protected void gvEspecialidades_RowDeleting(object sender, GridViewDeleteEventArgs e)
		{
		}
	}
}