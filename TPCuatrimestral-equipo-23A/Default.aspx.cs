using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;
using MedicoModel = dominio.Medico;

namespace TPCuatrimestral_equipo_23A
{
	public partial class Default : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
		}

		protected void btnLogin_Click(object sender, EventArgs e)
		{
			try
			{
				UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
				Usuario usuario = usuarioNegocio.ValidarUsuario(txtUsuario.Text.Trim(), txtClave.Text);

				if (usuario != null)
				{
					Session["usuario"] = usuario;

					if (usuario.Rol.Nombre == "Medico" && usuario.Persona is MedicoModel)
					{
						Session["medicoActual"] = (MedicoModel)usuario.Persona;
					}

					RedirigirSegunRol(usuario);
				}
				else
				{
					lblError.Text = "Usuario o contraseña incorrectos";
					lblError.Visible = true;
				}
			}
			catch (Exception ex)
			{
				lblError.Text = "Error al iniciar sesión. Intente nuevamente.";
				lblError.Visible = true;
				Session["error"] = ex;
			}
		}

		private void RedirigirSegunRol(Usuario usuario)
		{
			switch (usuario.Rol.Nombre)
			{
				case "Administrador":
					Response.Redirect("Administradores.aspx", false);
					break;
				case "Recepcionista":
					Response.Redirect("Recepcionista.aspx", false);
					break;
				case "Medico":
					Response.Redirect("Medico.aspx", false);
					break;
				default:
					lblError.Text = "Rol de usuario no reconocido";
					lblError.Visible = true;
					break;
			}
		}
	}
}