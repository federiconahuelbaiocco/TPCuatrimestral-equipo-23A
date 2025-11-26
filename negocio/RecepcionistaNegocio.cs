using conexion;
using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
	public class RecepcionistaNegocio
	{
        public List<Recepcionista> Listar()
        {
            List<Recepcionista> lista = new List<Recepcionista>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ListarRecepcionistas");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
				{
					Recepcionista aux = new Recepcionista();
                    aux.Usuario = new Usuario();

                    aux.IdPersona = (int)datos.Lector["IdPersona"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Dni = (string)datos.Lector["Dni"];
					aux.Activo = (bool)datos.Lector["UsuarioActivo"];
                    
                    aux.Usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    aux.Usuario.Clave = (string)datos.Lector["Clave"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Email")))
                        aux.Email = (string)datos.Lector["Email"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Telefono")))
                        aux.Telefono = (string)datos.Lector["Telefono"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Sexo")))
                        aux.Sexo = (string)datos.Lector["Sexo"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("FechaNacimiento")))
                        aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("IdDomicilio")))
                    {
                        aux.Domicilio = new Domicilio();
                        aux.Domicilio.IdDomicilio = (int)datos.Lector["IdDomicilio"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Calle")))
                            aux.Domicilio.Calle = (string)datos.Lector["Calle"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Altura")))
                            aux.Domicilio.Altura = (string)datos.Lector["Altura"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Piso")))
                            aux.Domicilio.Piso = (string)datos.Lector["Piso"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Departamento")))
                            aux.Domicilio.Departamento = (string)datos.Lector["Departamento"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Localidad")))
                            aux.Domicilio.Localidad = (string)datos.Lector["Localidad"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Provincia")))
                            aux.Domicilio.Provincia = (string)datos.Lector["Provincia"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("CodigoPostal")))
                            aux.Domicilio.CodigoPostal = (string)datos.Lector["CodigoPostal"];
                    }
						

                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Agregar(Recepcionista nuevo)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_AgregarRecepcionista");
				datos.setearParametro("@Nombre", nuevo.Nombre);
				datos.setearParametro("@Apellido", nuevo.Apellido);
				datos.setearParametro("@DNI", nuevo.Dni);
				datos.setearParametro("@Sexo", (object)nuevo.Sexo ?? DBNull.Value);
				datos.setearParametro("@FechaNacimiento", nuevo.FechaNacimiento.HasValue ? (object)nuevo.FechaNacimiento.Value : DBNull.Value);
				datos.setearParametro("@Mail", (object)nuevo.Email ?? DBNull.Value);
				datos.setearParametro("@Telefono", (object)nuevo.Telefono ?? DBNull.Value);
				datos.setearParametro("@NombreUsuario", nuevo.Usuario.NombreUsuario);
				datos.setearParametro("@Clave", nuevo.Usuario.Clave);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al agregar recepcionista.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public void Modificar(Recepcionista mod)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_ModificarRecepcionista");

				datos.setearParametro("@IdUsuario", mod.Usuario.IdUsuario);
				datos.setearParametro("@Nombre", mod.Nombre);
				datos.setearParametro("@Apellido", mod.Apellido);
				datos.setearParametro("@DNI", mod.Dni);

				datos.setearParametro("@Sexo", (object)mod.Sexo ?? DBNull.Value);
				datos.setearParametro("@FechaNacimiento", mod.FechaNacimiento.HasValue ? (object)mod.FechaNacimiento.Value : DBNull.Value);
				datos.setearParametro("@Mail", (object)mod.Email ?? DBNull.Value);
				datos.setearParametro("@Telefono", (object)mod.Telefono ?? DBNull.Value);
				datos.setearParametro("@NuevaClave", (object)mod.Usuario.Clave ?? DBNull.Value);

				var domicilio = mod.Domicilio;
				datos.setearParametro("@Calle", (object)(domicilio != null && !string.IsNullOrWhiteSpace(domicilio.Calle) ? domicilio.Calle : null) ?? DBNull.Value);
				datos.setearParametro("@Altura", (object)(domicilio != null && !string.IsNullOrWhiteSpace(domicilio.Altura) ? domicilio.Altura : null) ?? DBNull.Value);
				datos.setearParametro("@Piso", (object)(domicilio != null && !string.IsNullOrWhiteSpace(domicilio.Piso) ? domicilio.Piso : null) ?? DBNull.Value);
				datos.setearParametro("@Departamento", (object)(domicilio != null && !string.IsNullOrWhiteSpace(domicilio.Departamento) ? domicilio.Departamento : null) ?? DBNull.Value);
				datos.setearParametro("@Localidad", (object)(domicilio != null && !string.IsNullOrWhiteSpace(domicilio.Localidad) ? domicilio.Localidad : null) ?? DBNull.Value);
				datos.setearParametro("@Provincia", (object)(domicilio != null && !string.IsNullOrWhiteSpace(domicilio.Provincia) ? domicilio.Provincia : null) ?? DBNull.Value);
				datos.setearParametro("@CodigoPostal", (object)(domicilio != null && !string.IsNullOrWhiteSpace(domicilio.CodigoPostal) ? domicilio.CodigoPostal : null) ?? DBNull.Value);

				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al modificar recepcionista.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public void EliminarLogico(int idUsuario)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_EliminarRecepcionista");
				datos.setearParametro("@IdUsuario", idUsuario);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al eliminar recepcionista.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}