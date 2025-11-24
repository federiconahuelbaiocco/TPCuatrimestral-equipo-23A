using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace TPCuatrimestral_equipo_23A
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            var config = new HorarioConfig
            {
                HoraApertura = TimeSpan.FromHours(9),
                HoraCierre = TimeSpan.FromHours(18),
                DuracionTurno = 30,
                DiasLaborables = new List<DayOfWeek>
                {
                    DayOfWeek.Monday,
                    DayOfWeek.Tuesday,
                    DayOfWeek.Wednesday,
                    DayOfWeek.Thursday,
                    DayOfWeek.Friday
                }
            };
            Application["HorarioConfig"] = config;

            Application["MensajeInternoConfig"] = new MensajeInternoConfig();
        }
    }
}