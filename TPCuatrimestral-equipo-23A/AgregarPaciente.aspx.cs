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
                ddlCoberturas.Items.Insert(0, new ListItem("Seleccione", "0"));
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }



        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Paciente nuevo = new Paciente();
                PacienteNegocio negocio = new PacienteNegocio();

                nuevo.Nombre = txtNombre.Text;
                nuevo.Apellido = txtApellido.Text;
                nuevo.Dni = txtDni.Text;
                nuevo.Sexo = ddlSexo.SelectedValue;
                if (string.IsNullOrEmpty(nuevo.Sexo))
                    nuevo.Sexo = "No especificado";
                nuevo.FechaNacimiento = DateTime.Parse (txtFechaNac.Text);
                nuevo.Telefono = txtTelefono.Text;
                nuevo.Email = txtEmailContacto.Text;

                nuevo.Cobertura = new CoberturaMedica();
                nuevo.Cobertura.IdCoberturaMedica = int.Parse(ddlCoberturas.SelectedValue);

                nuevo.Domicilio = new Domicilio();
                nuevo.Domicilio.Calle = txtCalle.Text;
                nuevo.Domicilio.Altura = txtNumero.Text;
                nuevo.Domicilio.Piso = txtPiso.Text;
                nuevo.Domicilio.Departamento = txtDepartamento.Text;
                nuevo.Domicilio.Localidad = txtLocalidad.Text;
                nuevo.Domicilio.Provincia = txtProvincia.Text;
                nuevo.Domicilio.CodigoPostal = txtCP.Text;

                negocio.AgregarPaciente(nuevo);
                Response.Redirect("Gestion_de_Pacientes.aspx", false);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}