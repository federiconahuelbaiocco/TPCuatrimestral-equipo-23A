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

                rvFechaNac.MaximumValue = DateTime.Today.ToString("yyyy-MM-dd");

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
                            txtFechaNac.Text = seleccionado.FechaNacimiento.HasValue ? seleccionado.FechaNacimiento.Value.ToString("yyyy-MM-dd") : "";
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
                Page.Validate("EdicionPaciente");
                if (!Page.IsValid) return;

                int id = int.Parse(Request.QueryString["id"]);
                PacienteNegocio negocio = new PacienteNegocio();

                Paciente seleccionado = negocio.BuscarPorId(id);

                seleccionado.Nombre = txtNombre.Text.Trim();
                seleccionado.Apellido = txtApellido.Text.Trim();
                seleccionado.Dni = txtDni.Text.Trim();
                seleccionado.Email = txtMail.Text.Trim();
                seleccionado.Telefono = txtTelefono.Text.Trim();
                seleccionado.Sexo = ddlSexo.SelectedValue;
                seleccionado.FechaNacimiento = DateTime.Parse(txtFechaNac.Text);

                seleccionado.Domicilio.Calle = txtCalle.Text.Trim();
                seleccionado.Domicilio.Altura = txtAltura.Text.Trim();
                seleccionado.Domicilio.Piso = string.IsNullOrWhiteSpace(txtPiso.Text) ? null : txtPiso.Text.Trim();
                seleccionado.Domicilio.Departamento = string.IsNullOrWhiteSpace(txtDepartamento.Text) ? null : txtDepartamento.Text.Trim();
                seleccionado.Domicilio.Localidad = txtLocalidad.Text.Trim();
                seleccionado.Domicilio.Provincia = txtProvincia.Text.Trim();
                seleccionado.Domicilio.CodigoPostal = txtCodigoPostal.Text.Trim();

                if (seleccionado.Cobertura == null) seleccionado.Cobertura = new CoberturaMedica();
                seleccionado.Cobertura.IdCoberturaMedica = int.Parse(ddlCoberturas.SelectedValue);

                negocio.ModificarPaciente(seleccionado);

                Response.Redirect("~/Gestion_de_Pacientes.aspx?toast=guardado", false);
            }
            catch (Exception ex)
            {
                string errorMsg = ex.Message;
                if (ex.InnerException != null)
                    errorMsg += " " + ex.InnerException.Message;

                string mensajeToast = "No se pudieron guardar los cambios.";
                string tipoToast = "danger";

                if (errorMsg.Contains("UQ_Personas_Dni"))
                {
                    mensajeToast = "El DNI ingresado ya pertenece a otro paciente.";
                    tipoToast = "warning";
                }
                else if (errorMsg.Contains("UNIQUE KEY") || errorMsg.Contains("duplicate") || errorMsg.Contains("clave duplicada"))
                {
                    mensajeToast = "Ya existe un paciente con ese DNI.";
                    tipoToast = "warning";
                }

                string safeMsg = HttpUtility.JavaScriptStringEncode(mensajeToast);
                string script = $"console.log('Error servidor: {safeMsg}'); if(typeof mostrarToastMensaje === 'function') {{ mostrarToastMensaje('{safeMsg}', '{tipoToast}'); }} else {{ alert('{safeMsg}'); }}";

                ScriptManager.RegisterStartupScript(this, GetType(), "toastErrorDb", script, true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Recepcionista.aspx", false);
        }
    }
}