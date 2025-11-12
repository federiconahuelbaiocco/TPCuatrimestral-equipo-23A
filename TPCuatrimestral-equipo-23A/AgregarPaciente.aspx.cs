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
                if (Request.QueryString["IdPersona"] != null)
                {
                    int id = int.Parse(Request.QueryString["IdPersona"].ToString());
                    List<Paciente> temporal = (List<Paciente>)Session["listaPacientes"];
                    Paciente seleccionado = temporal.Find(x => x.IdPersona == id);

                    txtApellido.Text = seleccionado.Apellido;
                    txtNombre.Text = seleccionado.Nombre;
                }
            }
        }



    }
}