using System;
using System.Web.UI;
using dominio;

namespace TPCuatrimestral_equipo_23A
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            Usuario usuario = (Usuario)Session["usuario"];

            if (usuario.Rol.Nombre != "Administrador")
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
        }
    }
}
