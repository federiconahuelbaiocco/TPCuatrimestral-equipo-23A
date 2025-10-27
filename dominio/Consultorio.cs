using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Consultorio
	{
		public int IdConsultorio { get; set; }
		public string Nombre { get; set; }
		public bool Activo { get; set; } = true;
		public List<Especialidad> EspecialidadesAptas { get; set; } = new List<Especialidad>();

		public override string ToString()
		{
			return Nombre;
		}
	}
}
