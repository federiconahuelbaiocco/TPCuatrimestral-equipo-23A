using System;
using dominio;
using System.Web.UI;
using negocio;
using RecepcionistaModel = dominio.Recepcionista;

namespace TPCuatrimestral_equipo_23A
{
    public partial class PerfilRecepcionista : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var recepActual = Session["recepcionistaActual"] as RecepcionistaModel;
                if (recepActual == null)
                {
                    Response.Redirect("Default.aspx", false);
                    return;
                }
                lblNombreCompletoTitulo.Text = $"{recepActual.Nombre} {recepActual.Apellido}";
                lblRolTitulo.Text = "Recepcionista";
                lblIdUsuarioTitulo.Text = recepActual.Usuario != null ? recepActual.Usuario.IdUsuario.ToString() : "";
                lblEmailLogin.Text = recepActual.Email;
                txtNombre.Text = recepActual.Nombre;
                txtApellido.Text = recepActual.Apellido;
                txtDni.Text = recepActual.Dni;
                txtTelefono.Text = recepActual.Telefono;
                txtDireccion.Text = recepActual.Domicilio != null ? recepActual.Domicilio.Calle + " " + recepActual.Domicilio.Altura : string.Empty;
                if (recepActual.FechaNacimiento.HasValue)
                    txtFechaNac.Text = recepActual.FechaNacimiento.Value.ToString("yyyy-MM-dd");
            }
        }
    }
}
