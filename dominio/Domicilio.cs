using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Domicilio
	{
		public int IdDomicilio { get; set; }
		public string Calle { get; set; }
		public string Altura { get; set; }
		public string Piso { get; set; } 
		public string Departamento { get; set; }
		public string Localidad { get; set; }
		public string Provincia { get; set; }
		public string CodigoPostal { get; set; }
	}
}
