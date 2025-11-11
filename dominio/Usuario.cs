using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
	public class Usuario
	{
		public int IdUsuario { get; set; }
		public string NombreUsuario { get; set; }
		public string Clave { get; set; }
		public bool Activo { get; set; }
		public Rol Rol { get; set; }
		public int IdPersona { get; set; }

		public Usuario()
		{
			Rol = new Rol();
		}
	}
}
