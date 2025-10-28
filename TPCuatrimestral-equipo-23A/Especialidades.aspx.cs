using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using conexion;

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
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ListarEspecialidades");
                datos.ejecutarLectura();

                List<object> lista = new List<object>();

                while (datos.Lector.Read())
                {
                    lista.Add(new
                    {
                        IdEspecialidad = datos.Lector["IdEspecialidad"],
                        Descripcion = datos.Lector["Descripcion"].ToString()
                    });
                }

                gvEspecialidades.DataSource = lista;
                gvEspecialidades.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar las especialidades: " + ex.Message + "');</script>");
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}