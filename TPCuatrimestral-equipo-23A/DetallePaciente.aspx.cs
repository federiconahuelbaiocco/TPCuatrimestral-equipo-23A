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
    public partial class DetallePaciente : System.Web.UI.Page
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
                ddlCoberturas.Items.Insert(0, new ListItem("Seleccione", "0"));
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
                if (!int.TryParse(Request.QueryString["id"], out id))
                    return;
                    
                    PacienteNegocio negocio = new PacienteNegocio();
                    Paciente seleccionado = negocio.BuscarPorId(id);
                   
                        if (seleccionado == null)
                            return;

                            lblNombreCompleto.Text = seleccionado.Nombre + " " + seleccionado.Apellido;
                            lblEdad.Text = seleccionado.FechaNacimiento.HasValue ? CalularEdad(seleccionado.FechaNacimiento.Value).ToString() + " Años" : "No especificada";

                            txtNombre.Text = seleccionado.Nombre;
                            txtApellido.Text = seleccionado.Apellido;
                            txtDni.Text = seleccionado.Dni;
                            ddlSexo.Text = seleccionado.Sexo;
                            txtFechaNac.Text = seleccionado.FechaNacimiento.HasValue ? seleccionado.FechaNacimiento.Value.ToString("d") : "";
                            txtTelefono.Text = seleccionado.Telefono;
                            txtMail.Text = seleccionado.Email;
                            ddlCoberturas.SelectedValue = seleccionado.Cobertura.IdCoberturaMedica.ToString();
                            txtCalle.Text = seleccionado.Domicilio.Calle;
                            txtAltura.Text = seleccionado.Domicilio.Altura;
                            txtDepartamento.Text = seleccionado.Domicilio.Departamento;
                            txtLocalidad.Text = seleccionado.Domicilio.Localidad;
                            txtProvincia.Text = seleccionado.Domicilio.Provincia;
                            txtCodigoPostal.Text = seleccionado.Domicilio.CodigoPostal;
                            ddlSexo.SelectedValue = seleccionado.Sexo;
                        

                        int CalularEdad(DateTime fechaNac)
                        {
                            int edad = DateTime.Today.Year - fechaNac.Year;

                            if (fechaNac.Date > DateTime.Today.AddYears(-edad))
                            {
                                edad--;
                            }

                            return edad;
                        }
                    
                
            }

            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(Request.QueryString["id"]);
                PacienteNegocio negocio = new PacienteNegocio();
                Paciente seleccionado = negocio.BuscarPorId(id);

                seleccionado.Nombre = txtNombre.Text;
                seleccionado.Apellido = txtApellido.Text;
                seleccionado.Dni = txtDni.Text;
                seleccionado.Email = txtMail.Text;
                seleccionado.Telefono = txtTelefono.Text;
                seleccionado.Sexo = ddlSexo.SelectedValue;

                seleccionado.Domicilio.Calle = txtCalle.Text;
                seleccionado.Domicilio.Altura = txtAltura.Text;
                seleccionado.Domicilio.Piso = txtPiso.Text;
                seleccionado.Domicilio.Departamento = txtDepartamento.Text;
                seleccionado.Domicilio.Localidad = txtLocalidad.Text;
                seleccionado.Domicilio.Provincia = txtProvincia.Text;
                seleccionado.Domicilio.CodigoPostal = txtCodigoPostal.Text;

                seleccionado.FechaNacimiento = DateTime.Parse(txtFechaNac.Text);

                seleccionado.Cobertura.IdCoberturaMedica = int.Parse(ddlCoberturas.SelectedValue);


                negocio.ModificarPaciente(seleccionado);

                Response.Redirect("~/Gestion_de_Pacientes.aspx?toast=guardado", false);
            }
            catch (Exception ex)
            {
                string script = $"mostrarToastMensaje('Error', 'No se pudieron guardar los cambios: {ex.Message.Replace("'", "\\'")}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarErrorToast", script, true);
            }
            
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Recepcionista.aspx", false);
        }
    }
}