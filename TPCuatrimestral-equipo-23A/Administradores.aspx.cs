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
                lblAdminCount.Text = "0";
                lblRecepCount.Text = "0";
                lblMedicoCount.Text = "0";
            }
        }
    }
}