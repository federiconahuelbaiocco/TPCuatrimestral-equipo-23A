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
            Medico medico = null;
            AccesoDatos datos = new AccesoDatos();
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
                    medico.Activo = !datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Activo")) && (bool)datos.Lector["Activo"];

                    medico.Domicilio = new Domicilio();
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Calle")))
                        medico.Domicilio.Calle = datos.Lector["Calle"].ToString();
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Altura")))
                        medico.Domicilio.Altura = datos.Lector["Altura"].ToString();
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Piso")))
                        medico.Domicilio.Piso = datos.Lector["Piso"].ToString();
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Departamento")))
                        medico.Domicilio.Departamento = datos.Lector["Departamento"].ToString();
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Localidad")))
                        medico.Domicilio.Localidad = datos.Lector["Localidad"].ToString();
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("Provincia")))
                        medico.Domicilio.Provincia = datos.Lector["Provincia"].ToString();
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("CodigoPostal")))
                        medico.Domicilio.CodigoPostal = datos.Lector["CodigoPostal"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener médico por ID.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }

            if (medico != null)
            {
                AccesoDatos datosEsp = new AccesoDatos();
                try
                {
                    medico.Especialidades = new List<Especialidad>();
                    datosEsp.setearProcedimiento("sp_ListarEspecialidadesPorMedico");
                    datosEsp.setearParametro("@IdMedico", idPersona);
                    datosEsp.ejecutarLectura();
                    while (datosEsp.Lector.Read())
                    {
                        Especialidad esp = new Especialidad();
                        esp.IdEspecialidad = (int)datosEsp.Lector["IdEspecialidad"];
                        esp.Descripcion = (string)datosEsp.Lector["Descripcion"];
                        medico.Especialidades.Add(esp);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al obtener especialidades del médico.", ex);
                }
                finally
                {
                    datosEsp.cerrarConexion();
                }
            }

            return medico;
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

        public int AgregarConUsuario(Medico nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_AgregarMedicoConUsuario");

                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Apellido", nuevo.Apellido);
                datos.setearParametro("@DNI", nuevo.Dni);
                datos.setearParametro("@Sexo", (object)nuevo.Sexo ?? DBNull.Value);
                datos.setearParametro("@FechaNacimiento", nuevo.FechaNacimiento.HasValue ? (object)nuevo.FechaNacimiento.Value : DBNull.Value);
                datos.setearParametro("@Matricula", nuevo.Matricula);
                datos.setearParametro("@Mail", (object)nuevo.Email ?? DBNull.Value);
                datos.setearParametro("@Telefono", (object)nuevo.Telefono ?? DBNull.Value);

                datos.setearParametro("@NombreUsuario", nuevo.Usuario != null && !string.IsNullOrWhiteSpace(nuevo.Usuario.NombreUsuario) ? nuevo.Usuario.NombreUsuario : (object)DBNull.Value);
                datos.setearParametro("@Clave", nuevo.Usuario != null && !string.IsNullOrWhiteSpace(nuevo.Usuario.Clave) ? nuevo.Usuario.Clave : (object)DBNull.Value);

                datos.setearParametro("@Calle", (object)(nuevo.Domicilio != null && !string.IsNullOrWhiteSpace(nuevo.Domicilio.Calle) ? nuevo.Domicilio.Calle : null) ?? DBNull.Value);
                datos.setearParametro("@Altura", (object)(nuevo.Domicilio != null && !string.IsNullOrWhiteSpace(nuevo.Domicilio.Altura) ? nuevo.Domicilio.Altura : null) ?? DBNull.Value);
                datos.setearParametro("@Piso", (object)(nuevo.Domicilio != null && !string.IsNullOrWhiteSpace(nuevo.Domicilio.Piso) ? nuevo.Domicilio.Piso : null) ?? DBNull.Value);
                datos.setearParametro("@Departamento", (object)(nuevo.Domicilio != null && !string.IsNullOrWhiteSpace(nuevo.Domicilio.Departamento) ? nuevo.Domicilio.Departamento : null) ?? DBNull.Value);
                datos.setearParametro("@Localidad", (object)(nuevo.Domicilio != null && !string.IsNullOrWhiteSpace(nuevo.Domicilio.Localidad) ? nuevo.Domicilio.Localidad : null) ?? DBNull.Value);
                datos.setearParametro("@Provincia", (object)(nuevo.Domicilio != null && !string.IsNullOrWhiteSpace(nuevo.Domicilio.Provincia) ? nuevo.Domicilio.Provincia : null) ?? DBNull.Value);
                datos.setearParametro("@CodigoPostal", (object)(nuevo.Domicilio != null && !string.IsNullOrWhiteSpace(nuevo.Domicilio.CodigoPostal) ? nuevo.Domicilio.CodigoPostal : null) ?? DBNull.Value);

                var result = datos.ejecutarScalar();
                if (result != null && result != DBNull.Value)
                    return Convert.ToInt32(result);
                return 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al agregar médico con usuario.", ex);
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

                datos.setearParametro("@Calle", (object)(mod.Domicilio != null && !string.IsNullOrWhiteSpace(mod.Domicilio.Calle) ? mod.Domicilio.Calle : null) ?? DBNull.Value);
                datos.setearParametro("@Altura", (object)(mod.Domicilio != null && !string.IsNullOrWhiteSpace(mod.Domicilio.Altura) ? mod.Domicilio.Altura : null) ?? DBNull.Value);
                datos.setearParametro("@Piso", (object)(mod.Domicilio != null && !string.IsNullOrWhiteSpace(mod.Domicilio.Piso) ? mod.Domicilio.Piso : null) ?? DBNull.Value);
                datos.setearParametro("@Departamento", (object)(mod.Domicilio != null && !string.IsNullOrWhiteSpace(mod.Domicilio.Departamento) ? mod.Domicilio.Departamento : null) ?? DBNull.Value);
                datos.setearParametro("@Localidad", (object)(mod.Domicilio != null && !string.IsNullOrWhiteSpace(mod.Domicilio.Localidad) ? mod.Domicilio.Localidad : null) ?? DBNull.Value);
                datos.setearParametro("@Provincia", (object)(mod.Domicilio != null && !string.IsNullOrWhiteSpace(mod.Domicilio.Provincia) ? mod.Domicilio.Provincia : null) ?? DBNull.Value);
                datos.setearParametro("@CodigoPostal", (object)(mod.Domicilio != null && !string.IsNullOrWhiteSpace(mod.Domicilio.CodigoPostal) ? mod.Domicilio.CodigoPostal : null) ?? DBNull.Value);

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
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar datos personales.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }

            if (medico.Domicilio != null)
            {
                AccesoDatos datosDom = new AccesoDatos();
                try
                {
                    datosDom.setearProcedimiento("sp_ActualizarOCrearDomicilioMedico");
                    datosDom.setearParametro("@IdPersona", medico.IdPersona);
                    datosDom.setearParametro("@Calle", (object)medico.Domicilio.Calle ?? DBNull.Value);
                    datosDom.setearParametro("@Altura", (object)medico.Domicilio.Altura ?? DBNull.Value);
                    datosDom.setearParametro("@Piso", (object)medico.Domicilio.Piso ?? DBNull.Value);
                    datosDom.setearParametro("@Departamento", (object)medico.Domicilio.Departamento ?? DBNull.Value);
                    datosDom.setearParametro("@Localidad", (object)medico.Domicilio.Localidad ?? DBNull.Value);
                    datosDom.setearParametro("@Provincia", (object)medico.Domicilio.Provincia ?? DBNull.Value);
                    datosDom.setearParametro("@CodigoPostal", (object)medico.Domicilio.CodigoPostal ?? DBNull.Value);
                    datosDom.ejecutarAccion();
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al actualizar/crear domicilio del médico.", ex);
                }
                finally
                {
                    datosDom.cerrarConexion();
                }
            }
        }

        public void ActualizarDatosProfesionales(int idMedico, string matricula, List<int> especialidades)
        {
            AccesoDatos datosMat = new AccesoDatos();
            try
            {
                datosMat.setearProcedimiento("sp_ModificarMatriculaMedico");
                datosMat.setearParametro("@IdPersona", idMedico);
                datosMat.setearParametro("@Matricula", matricula ?? (object)DBNull.Value);
                datosMat.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al modificar matrícula del médico.", ex);
            }
            finally
            {
                datosMat.cerrarConexion();
            }
            
            AccesoDatos datosDel = new AccesoDatos();
            try
            {
                datosDel.setearProcedimiento("sp_EliminarEspecialidadesDeMedico");
                datosDel.setearParametro("@IdMedico", idMedico);
                datosDel.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar especialidades del médico.", ex);
            }
            finally
            {
                datosDel.cerrarConexion();
            }

            if (especialidades != null)
            {
                foreach (int idEsp in especialidades)
                {
                    AccesoDatos datosAdd = new AccesoDatos();
                    try
                    {
                        datosAdd.setearProcedimiento("sp_AgregarEspecialidadAMedico");
                        datosAdd.setearParametro("@IdMedico", idMedico);
                        datosAdd.setearParametro("@IdEspecialidad", idEsp);
                        datosAdd.ejecutarAccion();
                    }
                    catch (Exception ex)
                    {
                        throw new Exception($"Error al agregar especialidad {idEsp} al médico.", ex);
                    }
                    finally
                    {
                        datosAdd.cerrarConexion();
                    }
                }
            }
        }
    }
}