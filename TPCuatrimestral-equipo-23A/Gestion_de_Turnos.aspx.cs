using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using dominio;
using negocio;
using System.Web.UI.WebControls;

namespace TPCuatrimestral_equipo_23A
{
    public partial class GestionDeTurnos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarEspecialidades();
                CargarTurnos();
            }
        }

        private void CargarEspecialidades()
        {
            EspecialidadNegocio neg = new EspecialidadNegocio();
            ddlEspecialidad.DataSource = neg.ListarActivos(); // Devuelve List<Especialidad>
            ddlEspecialidad.DataTextField = "Descripcion";
            ddlEspecialidad.DataValueField = "IdEspecialidad";
            ddlEspecialidad.DataBind();

            ddlEspecialidad.Items.Insert(0, new ListItem("-- Seleccione una especialidad --", "0"));
        }

        protected void btnBuscarPaciente_Click(object sender, EventArgs e)
        {
            string filtro = txtDniPaciente.Text.Trim();

            if (string.IsNullOrEmpty(filtro))
            {
                MostrarAlerta("Ingrese un DNI válido.");
                return;
            }

            PacienteNegocio neg = new PacienteNegocio();
            List<Paciente> lista = neg.BuscarPacientes(filtro);

            
            if (lista.Count == 1)
            {
                Paciente pac = lista[0];

                // Mostrar datos en el modal
                txtNombrePaciente.Text = $"{pac.Apellido}, {pac.Nombre}";
                ViewState["IdPaciente"] = pac.IdPersona;   

                // habilitar especialidad
                ddlEspecialidad.Enabled = true;
            }
            else
            {
                // No existe o devolvió muchos 
                txtNombrePaciente.Text = "";
                ViewState["IdPaciente"] = null;

                MostrarAlerta("El paciente no existe. Debe registrarse antes de asignar un turno.");
            }

        }
        private void MostrarAlerta(string mensaje)
        {
            string script = $"alert('{HttpUtility.JavaScriptStringEncode(mensaje)}');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), script, true);
        }



        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Limpiamos el ddlMedico por si acaso el usuario vuelve a seleccionar el item 0
            ddlMedico.Items.Clear();
            ddlMedico.Items.Insert(0, new ListItem("-- Seleccione un médico --", "0"));

            // 1. Intentamos obtener el ID y validamos que no sea 0 (el valor del item inicial)
            if (int.TryParse(ddlEspecialidad.SelectedValue, out int idEspecialidad) && idEspecialidad > 0)
            {
                // El ID es válido (mayor a 0), procedemos a cargar los médicos
                MedicoNegocio negocio = new MedicoNegocio();
                List<dominio.Medico> medicos = negocio.ListarPorEspecialidad(idEspecialidad);

                // Si la lista de médicos no es nula ni vacía, cargamos el DropDownList
                if (medicos != null && medicos.Count > 0)
                {
                    ddlMedico.DataSource = medicos;
                    ddlMedico.DataTextField = "NombreCompleto";
                    ddlMedico.DataValueField = "IdPersona";
                    ddlMedico.DataBind();

                    // Re-insertar el item inicial, que fue borrado al hacer DataBind
                    ddlMedico.Items.Insert(0, new ListItem("-- Seleccione un médico --", "0"));
                }
                // Si no hay médicos, el ddlMedico ya tiene el mensaje "-- Seleccione un médico --"
            }
            // Si la condición es falsa (es 0 o falló la conversión), el ddlMedico 
            // queda limpio con el mensaje inicial, que es el comportamiento deseado.
        }



        protected void ddlMedico_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlMedico.SelectedIndex > 0)
            {
                int idMedico = int.Parse(ddlMedico.SelectedValue);

                TurnoNegocio negocio = new TurnoNegocio();
                List<DateTime> fechas = negocio.ListarFechasDisponibles(idMedico);

                ddlFecha.Items.Clear();
                ddlFecha.Items.Add(new ListItem("Seleccione una fecha", ""));

                foreach (var fecha in fechas)
                {
                    ddlFecha.Items.Add(new ListItem(fecha.ToString("dddd dd/MM/yyyy"), fecha.ToString("yyyy-MM-dd")));
                }
            }
        }

        protected void ddlFecha_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFecha.SelectedIndex > 0)
            {
                int idMedico = int.Parse(ddlMedico.SelectedValue);
                DateTime fechaSeleccionada = DateTime.Parse(ddlFecha.SelectedValue);

                TurnoNegocio negocio = new TurnoNegocio();
                List<TimeSpan> horarios = negocio.ListarHorariosDisponibles(idMedico, fechaSeleccionada);

                ddlHorario.Items.Clear();
                ddlHorario.Items.Add(new ListItem("Seleccione un horario", ""));

                foreach (var hora in horarios)
                {
                    ddlHorario.Items.Add(new ListItem(hora.ToString(@"hh\:mm"), hora.ToString()));
                }
            }
        }

        protected void btnGuardarTurno_Click(object sender, EventArgs e)
        {
            try
            {
                int idPaciente = (int)ViewState["IdPaciente"];
                int idMedico = int.Parse(ddlMedico.SelectedValue);
                DateTime fechaSeleccionada = DateTime.Parse(ddlFecha.SelectedValue);
                TimeSpan horaSeleccionada = TimeSpan.Parse(ddlHorario.SelectedValue);
                DateTime fechaHora = fechaSeleccionada.Date + horaSeleccionada;

                string motivo = txtMotivo.Text;
                string observaciones = txtObservaciones.Text;

                TurnoNegocio negocio = new TurnoNegocio();
                negocio.AltaTurno(idPaciente, idMedico, fechaHora, motivo, observaciones);

                CargarTurnos();

                lblMensaje.Text = "Turno asignado exitosamente.";
                lblMensaje.CssClass = "text-success fw-bold";
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {

                lblMensaje.Text = ex.Message;
                lblMensaje.CssClass = "text-danger fw-bold";
                lblMensaje.Visible = true;
            }
        }

        private void CargarTurnos()
        {
            TurnoNegocio negocio = new TurnoNegocio();
            var lista = negocio.ListarTurnos();

            gvTurnos.DataSource = lista;
            gvTurnos.DataBind();
        }

    }
}