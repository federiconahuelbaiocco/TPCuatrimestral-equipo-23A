using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace TPCuatrimestral_equipo_23A
{
    public partial class Recepcionista : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            Usuario usuario = (Usuario)Session["usuario"];

            if (usuario.Rol.Nombre != "Recepcionista")
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
        }
    }
}