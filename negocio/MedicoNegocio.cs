using conexion;
using dominio;
using System;
using System.Collections.Generic;

namespace negocio
{
    public class MedicoNegocio
    {
        public List<Medico> ListarActivos()
        {
            List<Medico> lista = new List<Medico>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ListarMedicosActivos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.IdPersona = (int)datos.Lector["IdPersona"];
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Email")))
                        aux.Email = (string)datos.Lector["Email"];

                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Telefono")))
                        aux.Telefono = (string)datos.Lector["Telefono"];

                    aux.Matricula = (string)datos.Lector["Matricula"];

                    aux.Usuario = new Usuario();
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("IdUsuario")))
                        aux.Usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                    else
                        aux.Usuario.IdUsuario = 0;

                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar médicos.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public Medico ObtenerPorId(int idPersona)
        {
            List<Medico> listaMedicos = ListarActivos();
            return listaMedicos.Find(m => m.IdPersona == idPersona);
        }

        public int Agregar(Medico nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_AgregarMedico");
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Apellido", nuevo.Apellido);
                datos.setearParametro("@DNI", nuevo.Dni);
                datos.setearParametro("@Matricula", nuevo.Matricula);
                datos.setearParametro("@Mail", (object)nuevo.Email ?? DBNull.Value);
                datos.setearParametro("@Telefono", (object)nuevo.Telefono ?? DBNull.Value);

                return (int)datos.ejecutarScalar();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al agregar médico.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Modificar(Medico mod)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ModificarMedico");
                datos.setearParametro("@IdPersona", mod.IdPersona);
                datos.setearParametro("@Nombre", mod.Nombre);
                datos.setearParametro("@Apellido", mod.Apellido);
                datos.setearParametro("@DNI", mod.Dni);
                datos.setearParametro("@Matricula", mod.Matricula);
                datos.setearParametro("@Mail", (object)mod.Email ?? DBNull.Value);
                datos.setearParametro("@Telefono", (object)mod.Telefono ?? DBNull.Value);
                datos.setearParametro("@Activo", mod.Activo);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al modificar médico.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void EliminarLogico(int idPersona)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_EliminarLogicoMedico");
                datos.setearParametro("@IdPersona", idPersona);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar lógicamente al médico.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}