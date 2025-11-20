using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace TPCuatrimestral_equipo_23A
{
    public partial class Medico : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            Usuario usuario = (Usuario)Session["usuario"];

            if (usuario.Rol.Nombre != "Medico")
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            if (Session["medicoActual"] == null && usuario.Medico != null)
            {
                Session["medicoActual"] = usuario.Medico;
            }
        }
    }
}