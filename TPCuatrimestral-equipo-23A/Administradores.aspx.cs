using negocio;
using System;
using System.Web.UI;

namespace TPCuatrimestral_equipo_23A
{
	public partial class Administradores : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				CargarContadores();
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
	}
}