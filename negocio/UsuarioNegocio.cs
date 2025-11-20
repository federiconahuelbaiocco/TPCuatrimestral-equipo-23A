using conexion;
using dominio;
using System;

namespace negocio
{
    public class UsuarioNegocio
    {
        public Usuario ValidarUsuario(string nombreUsuario, string clave)
        {
            AccesoDatos datos = new AccesoDatos();
            Usuario usuario = null;

            try
            {
                datos.setearProcedimiento("sp_ValidarUsuario");
                datos.setearParametro("@NombreUsuario", nombreUsuario);
                datos.setearParametro("@Clave", clave);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    usuario = new Usuario();
                    usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                    usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    usuario.IdRol = (int)datos.Lector["IdRol"];
                    usuario.IdPersona = (int)datos.Lector["IdPersona"];
                    
                    usuario.Rol = new Rol();
                    usuario.Rol.IdRol = usuario.IdRol;
                    usuario.Rol.Nombre = (string)datos.Lector["NombreRol"];

                    if (usuario.Rol.Nombre == "Medico")
                    {
                        Medico medico = new Medico();
						medico.IdPersona = usuario.IdPersona;
                        medico.Nombre = (string)datos.Lector["Nombre"];
                        medico.Apellido = (string)datos.Lector["Apellido"];
                        medico.Dni = (string)datos.Lector["Dni"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Email")))
                            medico.Email = (string)datos.Lector["Email"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Telefono")))
                            medico.Telefono = (string)datos.Lector["Telefono"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Sexo")))
                            medico.Sexo = (string)datos.Lector["Sexo"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Matricula")))
                            medico.Matricula = (string)datos.Lector["Matricula"];
                        
                        usuario.Medico = medico;
                        usuario.Persona = medico;
                    }
                    else
                    {
                        Administrador admin = new Administrador();
                        admin.IdPersona = usuario.IdPersona;
                        admin.Nombre = (string)datos.Lector["Nombre"];
                        admin.Apellido = (string)datos.Lector["Apellido"];
                        admin.Dni = (string)datos.Lector["Dni"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Email")))
                            admin.Email = (string)datos.Lector["Email"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Telefono")))
                            admin.Telefono = (string)datos.Lector["Telefono"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Sexo")))
                            admin.Sexo = (string)datos.Lector["Sexo"];

                        usuario.Persona = admin;
                    }
                }

                return usuario;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al validar usuario.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
