using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPCuatrimestral_equipo_23A
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["error"] != null)
                {
                    Exception ex = (Exception)Session["error"];

                    lblErrorTitulo.Text = "Detalle del error técnico:";
                    litErrorDetalle.Text = ex.ToString().Replace(Environment.NewLine, "<br />");
                    Session["error"] = null;
                }
                else
                {
                    lblErrorTitulo.Text = "No se ha especificado ningún error.";
                }
            }
        }
    }
}