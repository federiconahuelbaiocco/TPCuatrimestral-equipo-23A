using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MedicoModel = dominio.Medico;
using negocio;

namespace TPCuatrimestral_equipo_23A
{
    public partial class PerfilMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    MedicoModel medicoActual = (MedicoModel)Session["medicoActual"];
                    
                    if (medicoActual == null)
                    {
                        Response.Redirect("Default.aspx", false);
                        return;
                    }

                    CargarDatosMedico(medicoActual.IdPersona);
                }
                catch (Exception ex)
                {
                    Session["error"] = ex;
                    Response.Redirect("Error.aspx", false);
                }
            }
        }

        private void CargarDatosMedico(int idMedico)
        {
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            MedicoModel medico = medicoNegocio.ObtenerPorId(idMedico);

            if (medico != null)
            {
                lblNombreCompleto.Text = $"Dr./Dra. {medico.Nombre} {medico.Apellido}";
                lblEspecialidad.Text = "Médico Especialista";
                lblMatricula.Text = $"Matrícula: {medico.Matricula}";

                txtNombre.Text = medico.Nombre;
                txtApellido.Text = medico.Apellido;
                txtDni.Text = medico.Dni;
                txtSexo.Text = !string.IsNullOrEmpty(medico.Sexo) ? medico.Sexo : "No especificado";
                txtTelefono.Text = medico.Telefono ?? "Sin teléfono";
                txtEmail.Text = medico.Email ?? "Sin email";
                txtEmailSeguridad.Text = medico.Email ?? "Sin email";

                if (medico.Domicilio != null)
                {
                    string direccion = $"{medico.Domicilio.Calle} {medico.Domicilio.Altura}";
                    if (!string.IsNullOrEmpty(medico.Domicilio.Piso))
                        direccion += $", Piso {medico.Domicilio.Piso}";
                    if (!string.IsNullOrEmpty(medico.Domicilio.Departamento))
                        direccion += $" Depto {medico.Domicilio.Departamento}";
                    if (!string.IsNullOrEmpty(medico.Domicilio.Localidad))
                        direccion += $", {medico.Domicilio.Localidad}";
                    
                    txtDireccion.Text = direccion;
                }
                else
                {
                    txtDireccion.Text = "Sin dirección registrada";
                }

                txtEspecialidadProfesional.Text = "Clínica General";
                txtMatriculaProfesional.Text = medico.Matricula;
            }
        }
    }
}