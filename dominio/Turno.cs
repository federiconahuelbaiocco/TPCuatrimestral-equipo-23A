using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Turno
	{
		public int IdTurno { get; set; }
		public Paciente Paciente { get; set; }
		public Medico Medico { get; set; }
		public Especialidad Especialidad { get; set; }
		public Consultorio Consultorio { get; set; }
		public EstadoTurno Estado { get; set; }

		public DateTime FechaHora { get; set; }
		public string MotivoConsulta { get; set; }
		public string Observaciones { get; set; }

        public string PacienteNombreCompleto => $"{Paciente.Apellido}, {Paciente.Nombre}";
        public string MedicoNombreCompleto => $"{Medico.Apellido}, {Medico.Nombre}";
        public string EstadoTurno => Estado?.Descripcion;

    }
}
