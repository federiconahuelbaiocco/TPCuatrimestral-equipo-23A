using System;
using conexion;

namespace negocio
{
    public class IntegracionNegocio
    {
        public void Guardar(string googleApiKey, string stripeApiKey)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_GuardarIntegraciones");
                datos.setearParametro("@GoogleApiKey", googleApiKey);
                datos.setearParametro("@StripeApiKey", stripeApiKey);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al guardar integraciones.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public (string GoogleApiKey, string StripeApiKey) Obtener()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_ObtenerIntegraciones");
                datos.ejecutarLectura();
                if (datos.Lector.Read())
                {
                    return (
                        datos.Lector["GoogleApiKey"].ToString(),
                        datos.Lector["StripeApiKey"].ToString()
                    );
                }
                return (null, null);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener integraciones.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
