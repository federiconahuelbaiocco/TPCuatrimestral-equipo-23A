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

        public int AgregarPaciente(Paciente nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_InsertarPaciente");

                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Apellido", nuevo.Apellido);
                datos.setearParametro("@DNI", nuevo.Dni);

                datos.setearParametro("@Mail", nuevo.Email ?? (object)DBNull.Value);
                datos.setearParametro("@Telefono", nuevo.Telefono ?? (object)DBNull.Value);
                datos.setearParametro("@Sexo", nuevo.Sexo);

                datos.setearParametro("@Calle", nuevo.Domicilio.Calle ?? (object)DBNull.Value);
                datos.setearParametro("@Altura", nuevo.Domicilio.Altura ?? (object)DBNull.Value);
                datos.setearParametro("@Piso", nuevo.Domicilio.Piso ?? (object)DBNull.Value);
                datos.setearParametro("@Departamento", nuevo.Domicilio.Departamento ?? (object)DBNull.Value);
                datos.setearParametro("@Localidad", nuevo.Domicilio.Localidad ?? (object)DBNull.Value);
                datos.setearParametro("@Provincia", nuevo.Domicilio.Provincia ?? (object)DBNull.Value);
                datos.setearParametro("@CodigoPostal", nuevo.Domicilio.CodigoPostal ?? (object)DBNull.Value);

                datos.setearParametro("@FechaNacimiento", nuevo.FechaNacimiento);
                datos.setearParametro("@idCobertura", nuevo.Cobertura.IdCoberturaMedica);

                datos.ejecutarLectura();

                int idPersonaGenerado = 0;

                if (datos.Lector.Read())
                {
                    idPersonaGenerado = (int)datos.Lector["IdPersona"];
                }

                return idPersonaGenerado;
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

        public Paciente BuscarPorId(int IdPersona)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ObtenerPaciente");
                datos.setearParametro("@IdPaciente", IdPersona);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Paciente aux = new Paciente();

                    aux.IdPersona = (int)datos.Lector["IdPersona"];
                    aux.Nombre = datos.Lector["Nombre"].ToString();
                    aux.Apellido = datos.Lector["Apellido"].ToString();
                    aux.Dni = datos.Lector["Dni"].ToString();
                    aux.Email = datos.Lector["Email"].ToString();
                    aux.Telefono = datos.Lector["Telefono"].ToString();
                    aux.Sexo = datos.Lector["Sexo"] != DBNull.Value ? datos.Lector["Sexo"].ToString() : "";

                    aux.FechaNacimiento = datos.Lector["FechaNacimiento"] != DBNull.Value ? (DateTime)datos.Lector["FechaNacimiento"] : DateTime.MinValue;

                    aux.Domicilio = new Domicilio();
                    if (datos.Lector["IdDomicilio"] != DBNull.Value)
                    {
                        aux.Domicilio.Calle = datos.Lector["Calle"].ToString();
                        aux.Domicilio.Altura = datos.Lector["Altura"].ToString();
                        aux.Domicilio.Piso = datos.Lector["Piso"].ToString();
                        aux.Domicilio.Departamento = datos.Lector["Departamento"].ToString();
                        aux.Domicilio.Localidad = datos.Lector["Localidad"].ToString();
                        aux.Domicilio.Provincia = datos.Lector["Provincia"].ToString();
                        aux.Domicilio.CodigoPostal = datos.Lector["CodigoPostal"].ToString();
                    }

                    aux.Cobertura = new CoberturaMedica();
                    if (datos.Lector["idCobertura"] != DBNull.Value)
                        aux.Cobertura.IdCoberturaMedica = (int)datos.Lector["idCobertura"];
                    else
                        aux.Cobertura.IdCoberturaMedica = 0;

                    if (datos.Lector["NombreCobertura"] != DBNull.Value)
                        aux.Cobertura.Nombre = datos.Lector["NombreCobertura"].ToString();
                    else
                        aux.Cobertura.Nombre = "Particular";

                    return aux;
                }

                return null;
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

        public void ModificarPaciente(Paciente paciente)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_ModificarPaciente");
                datos.setearParametro("@IdPaciente", paciente.IdPersona);
                datos.setearParametro("@Nombre", paciente.Nombre);
                datos.setearParametro("@Apellido", paciente.Apellido);
                datos.setearParametro("@DNI", paciente.Dni);
                datos.setearParametro("@Mail", paciente.Email);
                datos.setearParametro("@Telefono", paciente.Telefono);
                datos.setearParametro("@Sexo", paciente.Sexo);
                datos.setearParametro("@Calle", paciente.Domicilio.Calle);
                datos.setearParametro("@Altura", paciente.Domicilio.Altura);
                datos.setearParametro("@Piso", paciente.Domicilio.Piso);
                datos.setearParametro("@Apartamento", paciente.Domicilio.Departamento);
                datos.setearParametro("@Localidad", paciente.Domicilio.Localidad);
                datos.setearParametro("@Provincia", paciente.Domicilio.Provincia);
                datos.setearParametro("@CodigoPostal", paciente.Domicilio.CodigoPostal);
                datos.setearParametro("@FechaNacimiento", paciente.FechaNacimiento);
                datos.setearParametro("@idCobertura", paciente.Cobertura.IdCoberturaMedica);

                datos.ejecutarAccion();
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

        public List<Paciente> BuscarPacientes(string dni = null, string apellido = null, string nombre = null)
        {
            List<Paciente> lista = new List<Paciente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_BuscarPacientes");
                datos.setearParametro("@DNI", (object)dni ?? DBNull.Value);
                datos.setearParametro("@Apellido", (object)apellido ?? DBNull.Value);
                datos.setearParametro("@Nombre", (object)nombre ?? DBNull.Value);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Paciente aux = new Paciente();
                    aux.IdPersona = (int)datos.Lector["IdPersona"];
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    
                    if (!datos.Lector.IsDBNull(datos.Lector.GetOrdinal("FechaNacimiento")))
                        aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];

                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al buscar pacientes.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void EliminarPaciente(int idPaciente)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_EliminarPaciente");
                datos.setearParametro("@IdPaciente", idPaciente);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar paciente.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
