using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace TPCuatrimestral_equipo_23A
{
    public partial class ListadoMedicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarListado();
            }
        }
        private void CargarListado()
        {
            MedicoNegocio negocio = new MedicoNegocio();
            var lista = negocio.ListarConEspecialidades();

            dgvMedicos.DataSource = lista.Select(x => new
            {
                Nombre = x.NombreCompleto,
                Especialidad = x.Especialidades[0].Descripcion


            }).ToList();

            dgvMedicos.DataBind();
        }
    }
}
