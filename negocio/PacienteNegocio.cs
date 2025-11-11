using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using conexion;
using dominio;

namespace negocio
{
	public class PacienteNegocio
	{
		public List<Paciente> Listar()
		{
			List<Paciente> lista = new List<Paciente>();
			AccesoDatos datos = new AccesoDatos();

			try
			{
				datos.setearProcedimiento("sp_ListarPacientesActivos");
				datos.ejecutarLectura();

				while (datos.Lector.Read())
				{
					Paciente aux = new Paciente();
					aux.IdPersona = (int)datos.Lector["IdPersona"];
					aux.Dni = (string)datos.Lector["Dni"];
					aux.Nombre = (string)datos.Lector["Nombre"];
					aux.Apellido = (string)datos.Lector["Apellido"];
					aux.Activo = (bool)datos.Lector["Activo"];

					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Email")))
						aux.Email = (string)datos.Lector["Email"];
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Telefono")))
						aux.Telefono = (string)datos.Lector["Telefono"];
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("FechaNacimiento")))
						aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];

					aux.Domicilio = new Domicilio();
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Calle")))
						aux.Domicilio.Calle = (string)datos.Lector["Calle"];
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Altura")))
						aux.Domicilio.Altura = (string)datos.Lector["Altura"];
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Localidad")))
						aux.Domicilio.Localidad = (string)datos.Lector["Localidad"];

					aux.Cobertura = new CoberturaMedica();
					if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Cobertura")))
					{
						aux.Cobertura.Nombre = (string)datos.Lector["Cobertura"];
					}
					else
					{
						aux.Cobertura.Nombre = "Particular";
					}

					lista.Add(aux);
				}
				return lista;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al listar pacientes desde la capa de negocio.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}
