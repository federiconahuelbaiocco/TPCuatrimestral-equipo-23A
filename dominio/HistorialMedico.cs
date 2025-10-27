using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class HistorialMedico
	{
		public int IdHistorialMedico { get; set; }
		public int IdPaciente { get; set; }

		public List<EntradaHistorial> Entradas { get; set; } = new List<EntradaHistorial>();
	}
}
