using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace TPCuatrimestral_equipo_23A
{
       public partial class Consultorios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarConsultorios();
            }
        }

        private void CargarConsultorios()
        {
            ConsultorioNegocio negocio = new ConsultorioNegocio();
            try
            {
                List<dominio.Consultorio> listaConsultorios = negocio.Listar();
                gvConsultorios.DataSource = listaConsultorios;
                gvConsultorios.DataBind();
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnAgregarConsultorio_Click(object sender, EventArgs e)
        {
            ConsultorioNegocio negocio = new ConsultorioNegocio();
            try
            {
                dominio.Consultorio nuevo = new dominio.Consultorio();
                
                nuevo.Nombre = txtNombreConsultorio.Text;

                if (string.IsNullOrEmpty(nuevo.Nombre))
                {
                    return;
                }

                negocio.Agregar(nuevo);

                CargarConsultorios();
                txtNombreConsultorio.Text = "";
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void gvConsultorios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                try
                {
                    int idEliminar = Convert.ToInt32(e.CommandArgument);
                    ConsultorioNegocio negocio = new ConsultorioNegocio();
                    negocio.EliminarLogico(idEliminar);
                    CargarConsultorios();
                }
                catch (Exception ex)
                {
                    Session["error"] = ex;
                    Response.Redirect("Error.aspx", false);
                }
            }
            else if (e.CommandName == "Editar")
            {
                string idModificar = e.CommandArgument.ToString();
                Response.Redirect("ConsultorioForm.aspx?ID=" + idModificar, false);
            }
        }

        protected void gvConsultorios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }
    }
 }