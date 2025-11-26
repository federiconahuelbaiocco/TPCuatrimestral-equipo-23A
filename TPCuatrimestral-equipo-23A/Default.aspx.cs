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
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
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

                    // --- AQUI ESTABA EL PROBLEMA ---
                    // Faltaba asignar el objeto 'usuario' (que tiene la clave) 
                    // a la propiedad .Usuario del Administrador antes de guardarlo en Session.

                    if (usuario.Rol.Nombre == "Medico" && usuario.Persona is MedicoModel)
                    {
                        var medico = (MedicoModel)usuario.Persona;
                        medico.Usuario = usuario;
                        Session["medicoActual"] = medico;
                    }
                    else if (usuario.Rol.Nombre == "Recepcionista" && usuario.Persona is dominio.Recepcionista)
                    {
                        // Usamos "dominio.Recepcionista" para evitar la confusión con la MasterPage
                        var recep = (dominio.Recepcionista)usuario.Persona;
                        recep.Usuario = usuario;
                        Session["recepcionistaActual"] = recep;
                    }
                    else if (usuario.Rol.Nombre == "Administrador" && usuario.Persona is Administrador)
                    {
                        var admin = (Administrador)usuario.Persona;
                        admin.Usuario = usuario; // <--- ESTO ES LO QUE TE SOLUCIONA EL PROBLEMA
                        Session["adminActual"] = admin;
                    }

                    RedirigirSegunRol(usuario);
                }
                else
                {
                    lblError.Text = "Usuario o contraseña incorrectos";
                    lblError.Visible = true;
                }
            }
            catch (Exception ex) // Agregué 'ex' para ver errores reales si pasan
            {
                lblError.Text = "Error al iniciar sesión: " + ex.Message;
                lblError.Visible = true;
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
        protected void btnRecuperar_Click(object sender, EventArgs e)
        {
            try
            {
                UsuarioNegocio negocio = new UsuarioNegocio();
                emailServiceNegocio emailService = new emailServiceNegocio();
                Usuario usuario = negocio.RecuperarUsuarioPorEmail(txtEmail.Text);

                if (usuario != null)
                {
                    emailService.enviarCorreoRecuperacionContrasena(txtEmail.Text,usuario.Persona.Nombre,usuario.NombreUsuario,usuario.Clave);
                    emailService.enviarCorreo();

                    lblRecuperarMensaje.Text = "Se ha enviado un correo con tus datos.";
                    lblRecuperarMensaje.ForeColor = System.Drawing.Color.Green;
                    lblRecuperarMensaje.Visible = true;
                }
                else
                {
                    lblRecuperarMensaje.Text = "El correo ingresado no existe en el sistema.";
                    lblRecuperarMensaje.ForeColor = System.Drawing.Color.Red;
                    lblRecuperarMensaje.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }
    }
}