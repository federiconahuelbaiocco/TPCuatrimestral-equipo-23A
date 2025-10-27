using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Administrativo : Persona
	{
		public string Legajo { get; set; } 
		public int IdUsuario { get; set; } = -1;
	}
}
