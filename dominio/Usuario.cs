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
		public string Contrasena { get; set; }
		public string EmailLogin { get; set; }
		public bool Activo { get; set; }
		public int IdPersona { get; set; } = -1;
		public Rol Rol { get; set; }
	}
}
