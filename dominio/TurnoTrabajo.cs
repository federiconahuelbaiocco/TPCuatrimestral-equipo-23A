using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	[Serializable]
	public class TurnoTrabajo
	{
		public int IdTurnoTrabajo { get; set; }
		public DayOfWeek DiaSemana { get; set; }
		public TimeSpan HoraEntrada { get; set; }
		public TimeSpan HoraSalida { get; set; }
		public string NombreDia { get; set; }
	}
}
