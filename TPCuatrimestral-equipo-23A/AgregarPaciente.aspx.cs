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
                CargarCoberturas();

                if (Request.QueryString["id"] != null)
                {
                    CargarDatosParaEditar();


                }
            }

        }


        private void CargarCoberturas()
        {
            CoberturaNegocio negocio = new CoberturaNegocio();

            try
            {
                List<CoberturaMedica> coberturas = negocio.listar();

                ddlCoberturas.DataSource = coberturas;
                ddlCoberturas.DataValueField = "IdCoberturaMedica";
                ddlCoberturas.DataTextField = "Nombre";
                ddlCoberturas.DataBind();
                ddlCoberturas.Items.Insert(0, new ListItem("--Seleccione Coberura--", "0"));
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        private void CargarDatosParaEditar()
        {
            try
            {
                int id;
                if (int.TryParse(Request.QueryString["id"], out id))
                {
                    var temporal = Session["listaPacientes"] as List<Paciente>;
                    if (temporal != null)
                    {
                        var seleccionado = temporal.Find(x => x.IdPersona == id);
                        if (seleccionado != null)
                        {
                            txtApellido.Text = seleccionado.Apellido;
                            txtNombre.Text = seleccionado.Nombre;
                            txtDni.Text = seleccionado.Dni;
                            ddlSexo.Text = seleccionado.Sexo;
                            txtFechaNac.Text = seleccionado.FechaNacimiento.ToString();
                            txtTelefono.Text = seleccionado.Telefono;
                            txtEmailContacto.Text = seleccionado.Email;
                            ddlCoberturas.SelectedValue = seleccionado.Cobertura.ToString();
                            txtCalle.Text = seleccionado.Domicilio.Calle;
                            txtNumero.Text = seleccionado.Domicilio.Altura;
                            txtDepartamento.Text = seleccionado.Domicilio.Departamento;
                            txtLocalidad.Text = seleccionado.Domicilio.Localidad;
                            txtProvincia.Text = seleccionado.Domicilio.Provincia;
                            txtCP.Text = seleccionado.Domicilio.CodigoPostal;
                        }
                    }
                }
            }

            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

        }
    }
}