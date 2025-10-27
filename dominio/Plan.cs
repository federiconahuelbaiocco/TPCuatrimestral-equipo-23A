using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Plan
	{
		public int IdPlan { get; set; }
		public string Nombre { get; set; }
		public CoberturaMedica Cobertura { get; set; }
		public bool RequiereAutorizacion { get; set; } = false;
		public bool Activo { get; set; } = true;
		public string Observaciones { get; set; }

		public override string ToString()
		{
			string nombreCobertura = (Cobertura != null) ? Cobertura.Nombre : "Sin Cobertura";
			return $"{Nombre} ({nombreCobertura})";
		}
	}
}
