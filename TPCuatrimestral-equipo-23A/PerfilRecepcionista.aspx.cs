using System;
using dominio;
using System.Web.UI;
using negocio;
using RecepcionistaModel = dominio.Recepcionista;

namespace TPCuatrimestral_equipo_23A
{
    public partial class PerfilRecepcionista : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var recepActual = Session["recepcionistaActual"] as RecepcionistaModel;
                if (recepActual == null)
                {
                    Response.Redirect("Default.aspx", false);
                    return;
                }
                lblNombreCompletoTitulo.Text = $"{recepActual.Nombre} {recepActual.Apellido}";
                lblRolTitulo.Text = "Recepcionista";
                lblIdUsuarioTitulo.Text = recepActual.Usuario != null ? recepActual.Usuario.IdUsuario.ToString() : "";
                lblEmailLogin.Text = recepActual.Email;
                txtNombre.Text = recepActual.Nombre;
                txtApellido.Text = recepActual.Apellido;
                txtDni.Text = recepActual.Dni;
                txtTelefono.Text = recepActual.Telefono;
                if (recepActual.Domicilio != null)
                {
                    txtCalle.Text = recepActual.Domicilio.Calle;
                    txtAltura.Text = recepActual.Domicilio.Altura;
                    txtPiso.Text = recepActual.Domicilio.Piso;
                    txtDepartamento.Text = recepActual.Domicilio.Departamento;
                    txtLocalidad.Text = recepActual.Domicilio.Localidad;
                    txtProvincia.Text = recepActual.Domicilio.Provincia;
                    txtCodigoPostal.Text = recepActual.Domicilio.CodigoPostal;
                }
                else
                {
                    txtCalle.Text = string.Empty;
                    txtAltura.Text = string.Empty;
                    txtPiso.Text = string.Empty;
                    txtDepartamento.Text = string.Empty;
                    txtLocalidad.Text = string.Empty;
                    txtProvincia.Text = string.Empty;
                    txtCodigoPostal.Text = string.Empty;
                }

                if (recepActual.FechaNacimiento.HasValue)
                    txtFechaNac.Text = recepActual.FechaNacimiento.Value.ToString("yyyy-MM-dd");
            }
        }

        protected void btnGuardarInfoPersonal_Click(object sender, EventArgs e)
        {
            try
            {
                var recepActual = Session["recepcionistaActual"] as RecepcionistaModel;
                if (recepActual == null)
                {
                    Response.Redirect("Default.aspx", false);
                    return;
                }

                recepActual.Nombre = txtNombre.Text.Trim();
                recepActual.Apellido = txtApellido.Text.Trim();
                recepActual.Dni = txtDni.Text.Trim();
                recepActual.Telefono = txtTelefono.Text.Trim();

                DateTime fecha;
                if (DateTime.TryParse(txtFechaNac.Text, out fecha))
                    recepActual.FechaNacimiento = fecha;
                else
                    recepActual.FechaNacimiento = null;

                if (recepActual.Domicilio == null)
                    recepActual.Domicilio = new Domicilio();

                recepActual.Domicilio.Calle = txtCalle.Text.Trim();
                recepActual.Domicilio.Altura = txtAltura.Text.Trim();
                recepActual.Domicilio.Piso = txtPiso.Text.Trim();
                recepActual.Domicilio.Departamento = txtDepartamento.Text.Trim();
                recepActual.Domicilio.Localidad = txtLocalidad.Text.Trim();
                recepActual.Domicilio.Provincia = txtProvincia.Text.Trim();
                recepActual.Domicilio.CodigoPostal = txtCodigoPostal.Text.Trim();

                RecepcionistaNegocio negocio = new RecepcionistaNegocio();
                negocio.Modificar(recepActual);

                Session["recepcionistaActual"] = recepActual;

                string script = "mostrarToastMensaje('¡Guardado! Los datos se actualizaron correctamente.', 'success');";
                ScriptManager.RegisterStartupScript(this, GetType(), "toastGuardarRecep", script, true);
            }
            catch (Exception ex)
            {
                var safe = ex.Message.Replace("'", "\\'");
                string script = $"mostrarToastMensaje('Error: {safe}', 'danger');";
                ScriptManager.RegisterStartupScript(this, GetType(), "toastErrorRecep", script, true);
            }
        }
    }
}
