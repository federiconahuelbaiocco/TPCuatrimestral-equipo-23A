using conexion;
using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
	public class AdministradorNegocio
	{
        public List<Administrador> Listar()
        {
            List<Administrador> lista = new List<Administrador>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ListarAdministradores");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Administrador aux = new Administrador();
                    aux.IdPersona = (int)datos.Lector["IdPersona"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Activo = (bool)datos.Lector["UsuarioActivo"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Sexo")))
                        aux.Sexo = (string)datos.Lector["Sexo"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("FechaNacimiento")))
                        aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Email")))
                        aux.Email = (string)datos.Lector["Email"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Telefono")))
                        aux.Telefono = (string)datos.Lector["Telefono"];

                    aux.Usuario = new Usuario();
                    aux.Usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                    aux.Usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    aux.Usuario.Clave = (string)datos.Lector["Clave"];
                    aux.Usuario.Activo = (bool)datos.Lector["UsuarioActivo"];

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
                throw new Exception("Error al listar administradores.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Agregar(Administrador nuevo)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_AgregarAdministrador");
				datos.setearParametro("@Nombre", nuevo.Nombre);
				datos.setearParametro("@Apellido", nuevo.Apellido);
				datos.setearParametro("@DNI", nuevo.Dni);
				datos.setearParametro("@Sexo", (object)nuevo.Sexo ?? DBNull.Value);
				datos.setearParametro("@FechaNacimiento", nuevo.FechaNacimiento.HasValue ? (object)nuevo.FechaNacimiento.Value : DBNull.Value);
				datos.setearParametro("@Mail", nuevo.Email);
				datos.setearParametro("@Telefono", nuevo.Telefono);
				datos.setearParametro("@NombreUsuario", nuevo.Usuario.NombreUsuario);
				datos.setearParametro("@Clave", nuevo.Usuario.Clave);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al agregar administrador.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}

		public void Modificar(Administrador mod)
		{
			AccesoDatos datos = new AccesoDatos();
			try
			{
				datos.setearProcedimiento("sp_ModificarAdministrador");
				datos.setearParametro("@IdUsuario", mod.Usuario.IdUsuario);
				datos.setearParametro("@Nombre", mod.Nombre);
				datos.setearParametro("@Apellido", mod.Apellido);
				datos.setearParametro("@DNI", mod.Dni);
				datos.setearParametro("@Sexo", (object)mod.Sexo ?? DBNull.Value);
				datos.setearParametro("@FechaNacimiento", mod.FechaNacimiento.HasValue ? (object)mod.FechaNacimiento.Value : DBNull.Value);
				datos.setearParametro("@Mail", (object)mod.Email ?? DBNull.Value);
				datos.setearParametro("@Telefono", (object)mod.Telefono ?? DBNull.Value);
				datos.setearParametro("@NuevaClave", (object)mod.Usuario.Clave ?? DBNull.Value);

				if (mod.Domicilio != null)
				{
					datos.setearParametro("@Calle", (object)mod.Domicilio.Calle ?? DBNull.Value);
					datos.setearParametro("@Altura", (object)mod.Domicilio.Altura ?? DBNull.Value);
					datos.setearParametro("@Piso", (object)mod.Domicilio.Piso ?? DBNull.Value);
					datos.setearParametro("@Departamento", (object)mod.Domicilio.Departamento ?? DBNull.Value);
					datos.setearParametro("@Localidad", (object)mod.Domicilio.Localidad ?? DBNull.Value);
					datos.setearParametro("@Provincia", (object)mod.Domicilio.Provincia ?? DBNull.Value);
					datos.setearParametro("@CodigoPostal", (object)mod.Domicilio.CodigoPostal ?? DBNull.Value);
				}
				else
				{
					datos.setearParametro("@Calle", DBNull.Value);
					datos.setearParametro("@Altura", DBNull.Value);
					datos.setearParametro("@Piso", DBNull.Value);
					datos.setearParametro("@Departamento", DBNull.Value);
					datos.setearParametro("@Localidad", DBNull.Value);
					datos.setearParametro("@Provincia", DBNull.Value);
					datos.setearParametro("@CodigoPostal", DBNull.Value);
				}

				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al modificar administrador.", ex);
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
				datos.setearProcedimiento("sp_EliminarAdministrador");
				datos.setearParametro("@IdUsuario", idUsuario);
				datos.ejecutarAccion();
			}
			catch (Exception ex)
			{
				throw new Exception("Error al eliminar administrador.", ex);
			}
			finally
			{
				datos.cerrarConexion();
			}
		}
	}
}