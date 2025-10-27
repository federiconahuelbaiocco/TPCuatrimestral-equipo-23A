using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Medico : Persona
	{
		public string Matricula { get; set; }
		public List<Especialidad> Especialidades { get; set; } = new List<Especialidad>();
		public List<TurnoTrabajo> Horarios { get; set; } = new List<TurnoTrabajo>();

		public int IdUsuario { get; set; } = -1;
	}
}
