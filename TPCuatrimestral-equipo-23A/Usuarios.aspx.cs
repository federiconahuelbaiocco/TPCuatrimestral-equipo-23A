using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using dominio;

namespace TPCuatrimestral_equipo_23A
{
	public partial class Usuarios : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				var adminActual = Session["adminActual"] as Administrador;
				if (adminActual == null)
				{
					Response.Redirect("Default.aspx", false);
					return;
				}
				// Título y resumen
				lblNombreCompletoTitulo.Text = $"{adminActual.Nombre} {adminActual.Apellido}";
				lblRolTitulo.Text = "Administrador";
				lblIdUsuarioTitulo.Text = adminActual.Usuario.IdUsuario.ToString();
				lblEmailLogin.Text = adminActual.Email;
				// Datos personales
				txtNombre.Text = adminActual.Nombre;
				txtApellido.Text = adminActual.Apellido;
				txtDni.Text = adminActual.Dni;
				txtTelefono.Text = adminActual.Telefono;
				txtDireccion.Text = adminActual.Domicilio != null ? adminActual.Domicilio.Calle + " " + adminActual.Domicilio.Altura : string.Empty;
				if (adminActual.FechaNacimiento.HasValue)
					txtFechaNac.Text = adminActual.FechaNacimiento.Value.ToString("yyyy-MM-dd");
				pnlInfoProfesional.Visible = false;
			}
		}
	}
}