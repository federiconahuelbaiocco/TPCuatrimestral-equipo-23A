using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPCuatrimestral_equipo_23A
{
    public partial class Especialidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarEspecialidades();
            }
        }

        private void CargarEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            try
            {
                List<dominio.Especialidad> listaEspecialidades = negocio.Listar();
                gvEspecialidades.DataSource = listaEspecialidades;
                gvEspecialidades.DataBind();
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void btnAgregarEspecialidad_Click(object sender, EventArgs e)
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            try
            {
                dominio.Especialidad nueva = new dominio.Especialidad();

                nueva.Descripcion = txtNombreEspecialidad.Text;

                if (string.IsNullOrEmpty(nueva.Descripcion))
                {
                    return;
                }

                negocio.Agregar(nueva);

                CargarEspecialidades();
                txtNombreEspecialidad.Text = "";
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void gvEspecialidades_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EliminarEsp")
            {
                try
                {
                    int idEliminar = Convert.ToInt32(e.CommandArgument);
                    EspecialidadNegocio negocio = new EspecialidadNegocio();
                    negocio.EliminarLogico(idEliminar);
                    CargarEspecialidades();
                }
                catch (Exception ex)
                {
                    Session["error"] = ex;
                    Response.Redirect("~/Error.aspx", false);
                }
            }
            else if (e.CommandName == "EditarEsp")
            {
                string idModificar = e.CommandArgument.ToString();
                Response.Redirect("~/EspecialidadForm.aspx?ID=" + idModificar, false);
            }
        }

        protected void gvEspecialidades_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }
    }
}