using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace TPCuatrimestral_equipo_23A
{
    public partial class Configuraciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarConfiguracionHorarios();
                CargarUsuariosCredenciales();
                CargarConfiguracionMensaje();
                CargarUsuarios();
            }
        }

        private void CargarUsuarios()
        {
            try
            {
                UsuarioNegocio negocio = new UsuarioNegocio();
                List<Usuario> lista = negocio.ListarUsuariosCompletos();
                gvUsuarios.DataSource = lista;
                gvUsuarios.DataBind();
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void gvUsuarios_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Usuario usuario = (Usuario)e.Row.DataItem;
                CheckBox chkActivo = (CheckBox)e.Row.FindControl("chkActivo");
                if (chkActivo != null)
                {
                    chkActivo.Checked = usuario.Activo;
                }
            }
        }

        protected void btnGuardarEstadosUsuarios_Click(object sender, EventArgs e)
        {
            Page.Validate("Usuarios");
            if (!Page.IsValid) return;

            try
            {
                UsuarioNegocio negocio = new UsuarioNegocio();
                foreach (GridViewRow row in gvUsuarios.Rows)
                {
                    int idUsuario = (int)gvUsuarios.DataKeys[row.RowIndex].Value;
                    CheckBox chkActivo = (CheckBox)row.FindControl("chkActivo");
                    if (chkActivo != null)
                    {
                        bool nuevoEstado = chkActivo.Checked;
                        negocio.ActualizarEstadoUsuario(idUsuario, nuevoEstado);
                    }
                }

                CargarUsuarios();
                CargarUsuariosCredenciales();
                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", "mostrarToastMensaje('Estados de usuario actualizados correctamente.','success');", true);
            }
            catch (Exception ex)
            {
                Session["error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }

        private void CargarConfiguracionHorarios()
        {
            TurnoTrabajoNegocio turnoNegocio = new TurnoTrabajoNegocio();
            List<TurnoTrabajo> horariosDb = null;

            try
            {
                horariosDb = turnoNegocio.ListarHorariosPorMedico(0);
            }
            catch
            {
                horariosDb = new List<TurnoTrabajo>();
            }

            if (horariosDb != null && horariosDb.Count > 0)
            {
                TurnoTrabajo primerTurno = horariosDb[0];

                txtHoraApertura.Text = primerTurno.HoraEntrada.ToString(@"hh\:mm");
                txtHoraCierre.Text = primerTurno.HoraSalida.ToString(@"hh\:mm");

                if (string.IsNullOrEmpty(txtDuracionTurno.Text))
                    txtDuracionTurno.Text = "30";

                foreach (ListItem item in cblDiasLaborables.Items)
                {
                    item.Selected = false;
                }

                foreach (TurnoTrabajo turno in horariosDb)
                {
                    foreach (ListItem item in cblDiasLaborables.Items)
                    {
                        DayOfWeek diaItem = (DayOfWeek)Enum.Parse(typeof(DayOfWeek), item.Value);

                        if (diaItem == turno.DiaSemana)
                        {
                            item.Selected = true;
                            break; 
                        }
                    }
                }
            }
            else
            {
                var config = Application["HorarioConfig"] as HorarioConfig;
                if (config != null)
                {
                    txtHoraApertura.Text = config.HoraApertura.ToString(@"hh\:mm");
                    txtHoraCierre.Text = config.HoraCierre.ToString(@"hh\:mm");
                    txtDuracionTurno.Text = config.DuracionTurno.ToString();

                    foreach (ListItem item in cblDiasLaborables.Items)
                    {
                        item.Selected = config.DiasLaborables.Contains((DayOfWeek)Enum.Parse(typeof(DayOfWeek), item.Value));
                    }
                }
            }
        }
        protected void btnGuardarHorarios_Click(object sender, EventArgs e)
        {
            Page.Validate("Horarios");
            if (!Page.IsValid) return;

            try
            {
                TimeSpan horaApertura = TimeSpan.Parse(txtHoraApertura.Text);
                TimeSpan horaCierre = TimeSpan.Parse(txtHoraCierre.Text);
                int duracion = int.Parse(txtDuracionTurno.Text);

                List<DayOfWeek> diasSeleccionados = new List<DayOfWeek>();
                foreach (ListItem item in cblDiasLaborables.Items)
                {
                    if (item.Selected)
                    {
                        DayOfWeek dia = (DayOfWeek)Enum.Parse(typeof(DayOfWeek), item.Value);
                        diasSeleccionados.Add(dia);
                    }
                }

                HorarioConfig config = new HorarioConfig();
                config.HoraApertura = horaApertura;
                config.HoraCierre = horaCierre;
                config.DuracionTurno = duracion;
                config.DiasLaborables = diasSeleccionados;

                Application["HorarioConfig"] = config;

                TurnoTrabajoNegocio turnoNegocio = new TurnoTrabajoNegocio();
                int idClinicaGlobal = 0;

                List<TurnoTrabajo> horariosExistentes = turnoNegocio.ListarHorariosPorMedico(idClinicaGlobal);

                if (horariosExistentes != null)
                {
                    foreach (TurnoTrabajo turno in horariosExistentes)
                    {
                        turnoNegocio.Eliminar(turno.IdTurnoTrabajo);
                    }
                }

                foreach (DayOfWeek dia in diasSeleccionados)
                {
                    TurnoTrabajo nuevoTurno = new TurnoTrabajo();
                    nuevoTurno.DiaSemana = dia;
                    nuevoTurno.HoraEntrada = horaApertura;
                    nuevoTurno.HoraSalida = horaCierre;

                    turnoNegocio.Agregar(idClinicaGlobal, nuevoTurno);
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", "mostrarToastMensaje('Configuración de horarios guardada y sincronizada.','success');", true);
                CargarConfiguracionHorarios();
            }
            catch (Exception ex)
            {
                string mensajeError = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", $"mostrarToastMensaje('Error: {mensajeError}','danger');", true);
            }
        }

        private void CargarUsuariosCredenciales()
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            List<Usuario> usuarios = negocio.ListarUsuariosActivos();

            ddlUsuariosCred.Items.Clear();
            ddlUsuariosCred.Items.Add(new ListItem("Seleccione un usuario", "0"));

            foreach (var usuario in usuarios)
            {
                string texto;
                if (usuario.Persona != null && !string.IsNullOrEmpty(usuario.Persona.Nombre))
                {
                    texto = $"{usuario.Persona.Nombre} {usuario.Persona.Apellido} ({usuario.Rol.Nombre})";
                }
                else
                {
                    texto = $"{usuario.NombreUsuario} ({usuario.Rol.Nombre})";
                }
                ddlUsuariosCred.Items.Add(new ListItem(texto, usuario.IdUsuario.ToString()));
            }
        }

        protected void ddlUsuariosCred_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idUsuario = int.Parse(ddlUsuariosCred.SelectedValue);
            if (idUsuario > 0)
            {
                UsuarioNegocio negocio = new UsuarioNegocio();
                Usuario usuario = negocio.ObtenerUsuarioPorId(idUsuario);
                if (usuario != null)
                {
                    txtNombreUsuarioCred.Text = usuario.NombreUsuario;
                }
            }
            else
            {
                txtNombreUsuarioCred.Text = string.Empty;
            }
            txtClaveCred.Text = string.Empty;
        }

        protected void btnGuardarCredenciales_Click(object sender, EventArgs e)
        {
            Page.Validate("Credenciales");
            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                int idUsuario = int.Parse(ddlUsuariosCred.SelectedValue);
                if (idUsuario == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", "mostrarToastMensaje('Por favor, seleccione un usuario.','warning');", true);
                    return;
                }

                UsuarioNegocio negocio = new UsuarioNegocio();
                string nuevoNombreUsuario = txtNombreUsuarioCred.Text.Trim();
                string nuevaClave = txtClaveCred.Text;

                negocio.CambiarNombreUsuario(idUsuario, nuevoNombreUsuario);

                if (!string.IsNullOrWhiteSpace(nuevaClave))
                {
                    negocio.CambiarClaveUsuario(idUsuario, nuevaClave);
                }

                CargarUsuariosCredenciales();
                txtNombreUsuarioCred.Text = string.Empty;
                txtClaveCred.Text = string.Empty;

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", "mostrarToastMensaje('Credenciales actualizadas correctamente.','success');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", $"mostrarToastMensaje('Error: {ex.Message.Replace("'", "\\'")}','danger');", true);
            }
        }

        private void CargarConfiguracionMensaje()
        {
            var msgCfg = Application["MensajeInternoConfig"] as MensajeInternoConfig;
            if (msgCfg != null)
            {
                txtMensajeInterno.Text = msgCfg.Mensaje;
                ddlDestinatarioRol.SelectedValue = msgCfg.DestinatarioRol;
            }
        }

        protected void btnGuardarMensajeInterno_Click(object sender, EventArgs e)
        {
            Page.Validate("Mensaje");
            if (!Page.IsValid) return;

            try
            {
                var msgConfig = new MensajeInternoConfig
                {
                    Mensaje = txtMensajeInterno.Text,
                    DestinatarioRol = ddlDestinatarioRol.SelectedValue
                };

                Application["MensajeInternoConfig"] = msgConfig;

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", "mostrarToastMensaje('Mensaje interno guardado.','success');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarToastMensaje", $"mostrarToastMensaje('Error: {ex.Message.Replace("'", "\\'")}','danger');", true);
            }
        }
    }
}