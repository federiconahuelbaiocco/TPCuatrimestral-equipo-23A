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
            AccesoDatos datos = new AccesoDatos();
            Medico medico = null;
            try
            {
                datos.setearProcedimiento("sp_ObtenerMedicoPorId");
                datos.setearParametro("@IdPersona", idPersona);
                datos.ejecutarLectura();
                if (datos.Lector.Read())
                {
                    medico = new Medico();
                    medico.IdPersona = (int)datos.Lector["IdPersona"];
                    medico.Nombre = (string)datos.Lector["Nombre"];
                    medico.Apellido = (string)datos.Lector["Apellido"];
                    medico.Dni = (string)datos.Lector["Dni"];
                    medico.Email = datos.Lector["Email"] as string;
                    medico.Telefono = datos.Lector["Telefono"] as string;
                    medico.Sexo = datos.Lector["Sexo"] as string;
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("FechaNacimiento")))
                        medico.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    medico.Matricula = datos.Lector["Matricula"] as string;
                    medico.Activo = (bool)datos.Lector["Activo"];
                }
                datos.cerrarConexion();
                if (medico != null)
                {
                    medico.Especialidades = new List<Especialidad>();
                    datos = new AccesoDatos();
                    datos.setearProcedimiento("sp_ListarEspecialidadesPorMedico");
                    datos.setearParametro("@IdMedico", idPersona);
                    datos.ejecutarLectura();
                    while (datos.Lector.Read())
                    {
                        Especialidad esp = new Especialidad();
                        esp.IdEspecialidad = (int)datos.Lector["IdEspecialidad"];
                        esp.Descripcion = (string)datos.Lector["Descripcion"];
                        medico.Especialidades.Add(esp);
                    }
                }
                return medico;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener médico por ID.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
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
                datos.setearParametro("@Sexo", (object)nuevo.Sexo ?? DBNull.Value);
                datos.setearParametro("@FechaNacimiento", nuevo.FechaNacimiento.HasValue ? (object)nuevo.FechaNacimiento.Value : DBNull.Value);
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
                datos.setearParametro("@Sexo", (object)mod.Sexo ?? DBNull.Value);
                datos.setearParametro("@FechaNacimiento", mod.FechaNacimiento.HasValue ? (object)mod.FechaNacimiento.Value : DBNull.Value);
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

        public void ActualizarDatosPersonales(Medico medico)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ActualizarDatosPersonalesMedico");
                datos.setearParametro("@IdPersona", medico.IdPersona);
                datos.setearParametro("@Telefono", (object)medico.Telefono ?? DBNull.Value);
                datos.setearParametro("@Mail", (object)medico.Email ?? DBNull.Value);
                datos.ejecutarAccion();
                datos.cerrarConexion();
                if (medico.Domicilio != null)
                {
                    datos = new AccesoDatos();
                    datos.setearProcedimiento("sp_ActualizarOCrearDomicilioMedico");
                    datos.setearParametro("@IdPersona", medico.IdPersona);
                    datos.setearParametro("@Calle", (object)medico.Domicilio.Calle ?? DBNull.Value);
                    datos.setearParametro("@Altura", (object)medico.Domicilio.Altura ?? DBNull.Value);
                    datos.setearParametro("@Piso", (object)medico.Domicilio.Piso ?? DBNull.Value);
                    datos.setearParametro("@Departamento", (object)medico.Domicilio.Departamento ?? DBNull.Value);
                    datos.setearParametro("@Localidad", (object)medico.Domicilio.Localidad ?? DBNull.Value);
                    datos.setearParametro("@Provincia", (object)medico.Domicilio.Provincia ?? DBNull.Value);
                    datos.setearParametro("@CodigoPostal", (object)medico.Domicilio.CodigoPostal ?? DBNull.Value);
                    datos.ejecutarAccion();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar datos personales.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ActualizarDatosProfesionales(int idMedico, string matricula, List<int> especialidades)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ModificarMatriculaMedico");
                datos.setearParametro("@IdPersona", idMedico);
                datos.setearParametro("@Matricula", matricula);
                datos.ejecutarAccion();
                datos.cerrarConexion();

                datos = new AccesoDatos();
                datos.setearProcedimiento("sp_EliminarEspecialidadesDeMedico");
                datos.setearParametro("@IdMedico", idMedico);
                datos.ejecutarAccion();
                datos.cerrarConexion();

                foreach (int idEsp in especialidades)
                {
                    datos = new AccesoDatos();
                    datos.setearProcedimiento("sp_AgregarEspecialidadAMedico");
                    datos.setearParametro("@IdMedico", idMedico);
                    datos.setearParametro("@IdEspecialidad", idEsp);
                    datos.ejecutarAccion();
                    datos.cerrarConexion();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar datos profesionales.", ex);
            }
        }
    }
}