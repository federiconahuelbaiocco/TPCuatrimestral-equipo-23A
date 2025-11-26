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
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var adminActual = Session["adminActual"] as Administrador;
                if (adminActual == null)
                {
                    Response.Redirect("Default.aspx", false);
                    return;
                }

                lblNombreCompletoTitulo.Text = $"{adminActual.Nombre} {adminActual.Apellido}";
                lblRolTitulo.Text = "Administrador";
                lblIdUsuarioTitulo.Text = adminActual.Usuario.IdUsuario.ToString();
                lblEmailLogin.Text = adminActual.Email;
                txtNombre.Text = adminActual.Nombre;
                txtApellido.Text = adminActual.Apellido;
                txtDni.Text = adminActual.Dni;
                txtTelefono.Text = adminActual.Telefono;
                if (adminActual.FechaNacimiento.HasValue)
                    txtFechaNac.Text = adminActual.FechaNacimiento.Value.ToString("yyyy-MM-dd");
                
                if (!string.IsNullOrEmpty(adminActual.Sexo))
                    ddlSexo.SelectedValue = adminActual.Sexo;

                if (adminActual.Domicilio != null)
                {
                    txtCalle.Text = adminActual.Domicilio.Calle;
                    txtAltura.Text = adminActual.Domicilio.Altura;
                    txtPiso.Text = adminActual.Domicilio.Piso;
                    txtDepartamento.Text = adminActual.Domicilio.Departamento;
                    txtLocalidad.Text = adminActual.Domicilio.Localidad;
                    txtProvincia.Text = adminActual.Domicilio.Provincia;
                    txtCodigoPostal.Text = adminActual.Domicilio.CodigoPostal;
                }

                pnlInfoProfesional.Visible = false;
            }
        }

        protected void btnGuardarInfoPersonal_Click(object sender, EventArgs e)
        {
            var adminActual = Session["adminActual"] as Administrador;
            if (adminActual == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err", "mostrarToastMensaje('No se encontró administrador en sesión','danger');", true);
                return;
            }

            adminActual.Nombre = txtNombre.Text.Trim();
            adminActual.Apellido = txtApellido.Text.Trim();
            adminActual.Dni = txtDni.Text.Trim();
            adminActual.Telefono = txtTelefono.Text.Trim();
            adminActual.Sexo = ddlSexo.SelectedValue;
            if (DateTime.TryParse(txtFechaNac.Text, out DateTime fechaNac))
            {
                adminActual.FechaNacimiento = fechaNac;
            }

            if (adminActual.Domicilio == null)
                adminActual.Domicilio = new Domicilio();

            adminActual.Domicilio.Calle = txtCalle.Text.Trim();
            adminActual.Domicilio.Altura = txtAltura.Text.Trim();
            adminActual.Domicilio.Piso = string.IsNullOrWhiteSpace(txtPiso.Text) ? null : txtPiso.Text.Trim();
            adminActual.Domicilio.Departamento = string.IsNullOrWhiteSpace(txtDepartamento.Text) ? null : txtDepartamento.Text.Trim();
            adminActual.Domicilio.Localidad = txtLocalidad.Text.Trim();
            adminActual.Domicilio.Provincia = string.IsNullOrWhiteSpace(txtProvincia.Text) ? null : txtProvincia.Text.Trim();
            adminActual.Domicilio.CodigoPostal = string.IsNullOrWhiteSpace(txtCodigoPostal.Text) ? null : txtCodigoPostal.Text.Trim();

            try
            {
                var adminNeg = new AdministradorNegocio();
                adminNeg.Modificar(adminActual);
                ScriptManager.RegisterStartupScript(this, GetType(), "ok", "mostrarToastMensaje('Datos personales actualizados','success');", true);
                emailServiceNegocio emailService = new emailServiceNegocio();
                emailService.enviarCorreoModificacionEmpleado(adminActual.Email, adminActual.Nombre);
                emailService.enviarCorreo();
            }
            catch (Exception ex)
            {
                var msg = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "err", "mostrarToastMensaje('Error: " + msg + "','danger');", true);
            }
        }
    }
}