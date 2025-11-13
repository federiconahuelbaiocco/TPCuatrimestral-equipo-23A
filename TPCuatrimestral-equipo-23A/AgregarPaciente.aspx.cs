using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace TPCuatrimestral_equipo_23A
{
	public partial class AgregarPaciente : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				if (Request.QueryString["id"] != null)
				{
					int id;
					if (int.TryParse(Request.QueryString["id"], out id))
					{
						var temporal = Session["listaPacientes"] as List<Paciente>;
						if (temporal != null)
						{
							var seleccionado = temporal.Find(x => x.IdPersona == id);
							if (seleccionado != null)
							{
								txtApellido.Text = seleccionado.Apellido;
								txtNombre.Text = seleccionado.Nombre;
							}
						}
					}
				}
			}
		}
	}
}