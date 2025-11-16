using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using dominio;

namespace TPCuatrimestral_equipo_23A
{
    public partial class Gestion_de_Pacientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPacientes();
            }
        }

        private void CargarPacientes()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            try
            {
                Session.Add("listaPacientes", negocio.Listar());
                //Session["listaPacientes"] = listaPacientes;
                //List<Paciente> listaPacientes = 
                dgvPacientes.DataSource = Session["listaPacientes"];
                dgvPacientes.DataBind();
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void btnNuevoPaciente_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AgregarPaciente.aspx", false);
        }

        protected void dgvPacientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            var id = dgvPacientes.SelectedDataKey.Value.ToString();
            Response.Redirect("DetallePaciente.aspx?id=" + id, false);
        }

        protected void Filtro_TextChanged(object sender, EventArgs e)
        {
            List<Paciente> lista = (List<Paciente>)Session["listaPacientes"];
            List<Paciente> listaFiltrada = lista.FindAll(x => x.Nombre.ToUpper().Contains(txtFiltro.Text.ToUpper())
                                                        || x.Dni.Contains(txtFiltro.Text)
                                                        || x.Apellido.ToUpper().Contains(txtFiltro.Text.ToUpper()));
            dgvPacientes.DataSource = listaFiltrada;
            dgvPacientes.DataBind();
        }

        protected void dgvPacientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvPacientes.PageIndex = e.NewPageIndex;

            List<Paciente> lista = (List<Paciente>)Session["listaPacientes"];
            dgvPacientes.DataSource = lista;
            dgvPacientes.DataBind();
        }
    }
}