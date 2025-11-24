using conexion;
using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
                        
                        usuario.Persona = medico;
                    }
                    else if (usuario.Rol.Nombre == "Recepcionista")
                    {
                        Recepcionista recep = new Recepcionista();
                        recep.IdPersona = usuario.IdPersona;
                        recep.Nombre = (string)datos.Lector["Nombre"];
                        recep.Apellido = (string)datos.Lector["Apellido"];
                        recep.Dni = (string)datos.Lector["Dni"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Email")))
                            recep.Email = (string)datos.Lector["Email"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Telefono")))
                            recep.Telefono = (string)datos.Lector["Telefono"];

                        if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Sexo")))
                            recep.Sexo = (string)datos.Lector["Sexo"];

                        usuario.Persona = recep;
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

        public void CambiarClaveUsuario(int idUsuario, string nuevaClave)
        {
            if (string.IsNullOrWhiteSpace(nuevaClave))
                throw new ArgumentException("La nueva contraseña no puede estar vacía.", nameof(nuevaClave));

            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_CambiarClaveUsuario");
                datos.setearParametro("@IdUsuario", idUsuario);
                datos.setearParametro("@NuevaClave", nuevaClave);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cambiar la contraseña del usuario.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void CambiarNombreUsuario(int idUsuario, string nuevoNombreUsuario)
        {
            if (string.IsNullOrWhiteSpace(nuevoNombreUsuario))
                throw new ArgumentException("El nuevo nombre de usuario no puede estar vacío.", nameof(nuevoNombreUsuario));

            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_CambiarNombreUsuario");
                datos.setearParametro("@IdUsuario", idUsuario);
                datos.setearParametro("@NuevoNombreUsuario", nuevoNombreUsuario);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cambiar el nombre de usuario.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Usuario> ListarUsuariosActivos()
        {
            var todos = ListarUsuariosCompletos();
            return todos.Where(u => u != null && u.Activo).ToList();
        }

        public List<Usuario> ListarUsuariosCompletos()
        {
            var lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ListarUsuariosCompletos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    var u = new Usuario();
                    u.IdUsuario = (int)datos.Lector["IdUsuario"];
                    u.NombreUsuario = datos.Lector["NombreUsuario"] as string;
                    u.IdRol = (int)datos.Lector["IdRol"];
                    u.Rol = new Rol { IdRol = u.IdRol, Nombre = datos.Lector["Rol"] as string };
                    u.IdPersona = datos.Lector["IdPersona"] != DBNull.Value ? (int)datos.Lector["IdPersona"] : 0;
                    u.Activo = !datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Activo")) && (bool)datos.Lector["Activo"];

                    if (u.IdPersona != 0 && !string.IsNullOrWhiteSpace(u.Rol?.Nombre))
                    {
                        string nombre = datos.Lector["Nombre"] as string;
                        string apellido = datos.Lector["Apellido"] as string;
                        string dni = datos.Lector["Dni"] as string;
                        string email = datos.Lector["Email"] as string;
                        
                        switch (u.Rol.Nombre)
                        {
                            case "Medico":
                                u.Persona = new Medico { IdPersona = u.IdPersona, Nombre = nombre, Apellido = apellido, Dni = dni, Email = email };
                                break;
                            case "Recepcionista":
                                u.Persona = new Recepcionista { IdPersona = u.IdPersona, Nombre = nombre, Apellido = apellido, Dni = dni, Email = email };
                                break;
                            case "Administrador":
                                u.Persona = new Administrador { IdPersona = u.IdPersona, Nombre = nombre, Apellido = apellido, Dni = dni, Email = email };
                                break;
                            default:
                                 break;
                        }
                    }

                    lista.Add(u);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar usuarios completos (SP).", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ActualizarEstadoUsuario(int idUsuario, bool nuevoEstado)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ActualizarEstadoUsuario");
                datos.setearParametro("@IdUsuario", idUsuario);
                datos.setearParametro("@NuevoEstado", nuevoEstado);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar estado del usuario.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public Usuario ObtenerUsuarioPorId(int idUsuario)
        {
            if (idUsuario <= 0) return null;
            var usuarios = ListarUsuariosCompletos();
            return usuarios.FirstOrDefault(u => u.IdUsuario == idUsuario);
        }

        public string ObtenerClaveUsuario(int idUsuario)
        {
            if (idUsuario <= 0) return null;
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ObtenerClaveUsuario");
                datos.setearParametro("@IdUsuario", idUsuario);
                datos.ejecutarLectura();
                if (datos.Lector.Read())
                {
                    return datos.Lector[0] != DBNull.Value ? datos.Lector[0].ToString() : null;
                }
                return null;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener clave de usuario.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Usuario> Listar()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT U.IdUsuario, U.NombreUsuario, U.Clave, U.Activo, U.IdRol, R.Nombre as RolNombre, U.IdPersona FROM USUARIOS U INNER JOIN ROLES R ON U.IdRol = R.IdRol");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.IdUsuario = (int)datos.Lector["IdUsuario"];
                    aux.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    aux.Clave = (string)datos.Lector["Clave"];
                    aux.Activo = (bool)datos.Lector["Activo"];
                    aux.IdRol = (int)datos.Lector["IdRol"];
                    aux.Rol.IdRol = (int)datos.Lector["IdRol"];
                    aux.Rol.Nombre = (string)datos.Lector["RolNombre"];
                    if(datos.Lector["IdPersona"] != DBNull.Value)
                        aux.IdPersona = (int)datos.Lector["IdPersona"];

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
    }
}