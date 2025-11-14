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
    public partial class Recepcionista1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarContadores();
                CargarPacientes();
            }
        }

        private void CargarContadores()
        {
            try
            {
                PacienteNegocio pacienteNegocio = new PacienteNegocio();
                MedicoNegocio medicoNegocio = new MedicoNegocio();

                lblPacienteCount.Text = pacienteNegocio.Listar().Count.ToString();
                lblMedicoCount.Text = medicoNegocio.ListarActivos().Count.ToString();
                lblTurnosHoyCount.Text = "0";
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        private void CargarPacientes()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            try
            {
                List<Paciente> pacientes = negocio.Listar();
                gvPacientes.DataSource = pacientes;
                gvPacientes.DataBind();
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void gvPacientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                int idPaciente = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("~/AgregarPaciente.aspx?id=" + idPaciente, false);
            }
        }
    }
}