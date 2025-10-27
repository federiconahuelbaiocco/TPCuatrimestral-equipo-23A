using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class FacturaItem
	{
		public int IdFacturaItem { get; set; }
		public int IdFactura { get; set; }
		public Prestacion Prestacion { get; set; }

		public int Cantidad { get; set; } = 1;
		public decimal PrecioUnitario { get; set; }
		public decimal Subtotal { get; set; }
	}
}
