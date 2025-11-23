using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using dominio;

namespace TPCuatrimestral_equipo_23A
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            try
            {
                var data = AppConfigStorage.Load();
                if (data != null)
                {
                    if (data.Horario != null)
                        Application["HorarioConfig"] = data.Horario;
                    if (data.Mensaje != null)
                        Application["MensajeInternoConfig"] = data.Mensaje;
                }
            }
            catch
            {
            }
        }
    }
}