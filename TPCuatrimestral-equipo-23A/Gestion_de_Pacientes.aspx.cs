using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace TPCuatrimestral_equipo_23A
{
	public partial class Gestion_de_Pacientes : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				CargarPacientes();
			}
		}

		private void CargarPacientes()
		{
			PacienteNegocio negocio = new PacienteNegocio();
			try
			{
				List<dominio.Paciente> listaPacientes = negocio.Listar();
				dgvPacientes.DataSource = listaPacientes;
				dgvPacientes.DataBind();
			}
			catch (Exception ex)
			{
				Session["error"] = ex;
				Response.Redirect("~/Error.aspx", false);
			}
		}

		protected void btnNuevoPaciente_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/AgregarPaciente.aspx", false);
		}
	}
}