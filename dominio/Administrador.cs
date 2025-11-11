using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Administrador : Persona
	{
		public Usuario Usuario { get; set; }

		public Administrador()
		{
			Usuario = new Usuario();
		}
	}
}
