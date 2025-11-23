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
                // Actualizar datos personales
                datos.setearConsulta("UPDATE Personas SET Telefono = @Telefono, Mail = @Mail WHERE IdPersona = @IdPersona");
                datos.setearParametro("@IdPersona", medico.IdPersona);
                datos.setearParametro("@Telefono", (object)medico.Telefono ?? DBNull.Value);
                datos.setearParametro("@Mail", (object)medico.Email ?? DBNull.Value);
                datos.ejecutarAccion();
                datos.cerrarConexion();

                // Actualizar o crear domicilio
                if (medico.Domicilio != null)
                {
                    datos = new AccesoDatos();
                    
                    // Verificar si ya tiene un domicilio
                    datos.setearConsulta("SELECT IdDomicilio FROM Personas WHERE IdPersona = @IdPersona");
                    datos.setearParametro("@IdPersona", medico.IdPersona);
                    datos.ejecutarLectura();
                    
                    int? idDomicilio = null;
                    if (datos.Lector.Read() && !datos.Lector.IsDBNull(0))
                    {
                        idDomicilio = (int)datos.Lector["IdDomicilio"];
                    }
                    datos.cerrarConexion();

                    if (idDomicilio.HasValue)
                    {
                        // Actualizar domicilio existente
                        datos = new AccesoDatos();
                        datos.setearConsulta(@"UPDATE Domicilios 
                                             SET Calle = @Calle, 
                                                 Altura = @Altura, 
                                                 Piso = @Piso, 
                                                 Departamento = @Departamento, 
                                                 Localidad = @Localidad, 
                                                 Provincia = @Provincia, 
                                                 CodigoPostal = @CodigoPostal 
                                             WHERE IdDomicilio = @IdDomicilio");
                        datos.setearParametro("@IdDomicilio", idDomicilio.Value);
                    }
                    else
                    {
                        // Crear nuevo domicilio
                        datos = new AccesoDatos();
                        datos.setearConsulta(@"INSERT INTO Domicilios (Calle, Altura, Piso, Departamento, Localidad, Provincia, CodigoPostal) 
                                             VALUES (@Calle, @Altura, @Piso, @Departamento, @Localidad, @Provincia, @CodigoPostal);
                                             SELECT SCOPE_IDENTITY();");
                    }
                    
                    datos.setearParametro("@Calle", (object)medico.Domicilio.Calle ?? DBNull.Value);
                    datos.setearParametro("@Altura", (object)medico.Domicilio.Altura ?? DBNull.Value);
                    datos.setearParametro("@Piso", (object)medico.Domicilio.Piso ?? DBNull.Value);
                    datos.setearParametro("@Departamento", (object)medico.Domicilio.Departamento ?? DBNull.Value);
                    datos.setearParametro("@Localidad", (object)medico.Domicilio.Localidad ?? DBNull.Value);
                    datos.setearParametro("@Provincia", (object)medico.Domicilio.Provincia ?? DBNull.Value);
                    datos.setearParametro("@CodigoPostal", (object)medico.Domicilio.CodigoPostal ?? DBNull.Value);
                    
                    if (!idDomicilio.HasValue)
                    {
                        // Si es nuevo, obtener el ID y actualizarlo en Personas
                        int nuevoIdDomicilio = Convert.ToInt32(datos.ejecutarScalar());
                        datos.cerrarConexion();
                        
                        datos = new AccesoDatos();
                        datos.setearConsulta("UPDATE Personas SET IdDomicilio = @IdDomicilio WHERE IdPersona = @IdPersona");
                        datos.setearParametro("@IdDomicilio", nuevoIdDomicilio);
                        datos.setearParametro("@IdPersona", medico.IdPersona);
                        datos.ejecutarAccion();
                    }
                    else
                    {
                        datos.ejecutarAccion();
                    }
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
                datos.setearConsulta("UPDATE Medicos SET Matricula = @Matricula WHERE IdPersona = @IdPersona");
                datos.setearParametro("@IdPersona", idMedico);
                datos.setearParametro("@Matricula", matricula);
                datos.ejecutarAccion();
                datos.cerrarConexion();

                datos = new AccesoDatos();
                datos.setearConsulta("DELETE FROM Medico_Especialidad WHERE IdMedico = @IdMedico");
                datos.setearParametro("@IdMedico", idMedico);
                datos.ejecutarAccion();
                datos.cerrarConexion();

                foreach (int idEsp in especialidades)
                {
                    datos = new AccesoDatos();
                    datos.setearConsulta("INSERT INTO Medico_Especialidad (IdMedico, IdEspecialidad) VALUES (@IdMedico, @IdEspecialidad)");
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