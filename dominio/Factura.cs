using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Factura
	{
		public int IdFactura { get; set; }
		public DateTime FechaEmision { get; set; }
		public decimal MontoTotal { get; set; }
		public string NumeroFactura { get; set; }

		public Paciente Paciente { get; set; }

		
		public List<FacturaItem> Items { get; set; } = new List<FacturaItem>();

		public string Estado { get; set; } = "Pendiente";

	}
}
