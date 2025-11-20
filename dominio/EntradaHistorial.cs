using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class EntradaHistorial
	{
		public int IdEntradaHistorial { get; set; }
		public DateTime Fecha { get; set; } 
		public string Diagnostico { get; set; }
		public string Observaciones { get; set; }
		public Medico MedicoTratante { get; set; }
		public Turno TurnoAsociado { get; set; }
	}
}
