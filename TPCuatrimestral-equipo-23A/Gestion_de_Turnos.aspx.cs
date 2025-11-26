using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using dominio;
using negocio;
using System.Web.UI.WebControls;
using System.Linq;

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

                    ddlMedico.Items.Insert(0, new ListItem("-- Seleccione un médico --", "0"));
                }
            }
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

        protected void gvTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CancelarTurno")
            {
                int idTurno = Convert.ToInt32(e.CommandArgument);
                TurnoNegocio neg = new TurnoNegocio();
                int idEstadoCancelado = 3; // o el que corresponda en tu BD
                neg.ModificarEstadoTurno(idTurno, idEstadoCancelado, "Cancelado por recepcionista");

                CargarTurnos(); // refresca la grilla
            }

            if (e.CommandName == "Modificar")
            {

                int idTurno = Convert.ToInt32(e.CommandArgument);

                CargarDatosTurnoEnModal(idTurno);

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "AbrirModalModificar",
                    "abrirModalModificar();",
                    true
                );
            }
        }

        private void CargarDatosTurnoEnModal(int idTurno)
        {
            var negocio = new TurnoNegocio();

            // Obtenemos la lista completa y filtramos por ID
            Turno turno = negocio.ListarTurnos()
                                 .FirstOrDefault(t => t.IdTurno == idTurno);

            if (turno == null)
                throw new Exception("No se encontró el turno.");

            // Guardamos para el botón Guardar
            ViewState["IdTurno"] = turno.IdTurno;
            ViewState["IdMedico"] = turno.Medico.IdPersona;
            ViewState["FechaTurno"] = turno.FechaHora.Date;

            // Cargar datos en los labels / textbox readonly
            txtPacienteMod.Text = turno.Paciente.Apellido + ", " + turno.Paciente.Nombre;
            txtMedicoMod.Text = turno.Medico.Apellido + ", " + turno.Medico.Nombre;
            txtFechaMod.Text = turno.FechaHora.ToString("yyyy-MM-dd");

            // Cargar horarios disponibles
            CargarHorariosDisponiblesModificar(turno.Medico.IdPersona, turno.FechaHora.Date, turno.FechaHora.TimeOfDay);
        }


        private void CargarHorariosDisponiblesModificar(int idMedico, DateTime fecha, TimeSpan horarioActual)
        {
            var negocio = new TurnoNegocio();
            var horarios = negocio.ListarHorariosDisponibles(idMedico, fecha);

            // Agregar horario actual si no está (por ejemplo: cuando ya fue descartado de la lista)
            if (!horarios.Contains(horarioActual))
                horarios.Add(horarioActual);

            // Ordenar la lista de horarios
            horarios = horarios.OrderBy(h => h).ToList();

            ddlHorariosModificar.DataSource = horarios.Select(h => new
            {
                Texto = h.ToString(@"hh\:mm"),
                Valor = h.ToString()
            });

            ddlHorariosModificar.DataTextField = "Texto";
            ddlHorariosModificar.DataValueField = "Valor";
            ddlHorariosModificar.DataBind();

            // Selecciona el horario actual del turno
            ddlHorariosModificar.SelectedValue = horarioActual.ToString();
        }

        protected void btnGuardarModificacion_Click(object sender, EventArgs e)
        {
            int idTurno = (int)ViewState["IdTurno"];
            int idMedico = (int)ViewState["IdMedico"];
            DateTime fecha = (DateTime)ViewState["FechaTurno"];

            TimeSpan nuevoHorario = TimeSpan.Parse(ddlHorariosModificar.SelectedValue);

            DateTime nuevaFechaHora = fecha.Date + nuevoHorario;

            var negocio = new TurnoNegocio();
            negocio.ModificarHoraTurno(idTurno, nuevaFechaHora);

            // refrescamos la grilla
            CargarTurnos();

            // cerrar modal via JS
            ScriptManager.RegisterStartupScript(this, GetType(), "CerrarModalModificar", "cerrarModalModificar();", true);
        }


    }




}