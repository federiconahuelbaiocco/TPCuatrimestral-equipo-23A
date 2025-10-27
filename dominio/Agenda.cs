using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Agenda
	{
		public int IdAgenda { get; set; }
		public Medico Medico { get; set; }
		public DateTime FechaHoraDesde { get; set; }
		public DateTime FechaHoraHasta { get; set; }
		public bool Disponible { get; set; } = false;

		public string MotivoBloqueo { get; set; }
	}
}
