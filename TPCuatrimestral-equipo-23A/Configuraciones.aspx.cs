using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPCuatrimestral_equipo_23A.Models;

namespace TPCuatrimestral_equipo_23A
{
	public partial class Configuraciones : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void btnGuardarHorarios_Click(object sender, EventArgs e)
		{
			var cph = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
			var cblDias = (CheckBoxList)cph.FindControl("cblDiasLaborables");
			var txtApertura = (TextBox)cph.FindControl("txtHoraApertura");
			var txtCierre = (TextBox)cph.FindControl("txtHoraCierre");
			var txtDuracion = (TextBox)cph.FindControl("txtDuracionTurno");

			var cfg = new HorarioConfig();
			foreach (ListItem item in cblDias.Items)
			{
				if (item.Selected && Enum.TryParse(item.Value, out DayOfWeek d))
					cfg.DiasLaborables.Add(d);
			}

			if (TimeSpan.TryParse(txtApertura.Text, CultureInfo.InvariantCulture, out var apertura))
				cfg.HoraApertura = apertura;
			if (TimeSpan.TryParse(txtCierre.Text, CultureInfo.InvariantCulture, out var cierre))
				cfg.HoraCierre = cierre;
			if (int.TryParse(txtDuracion.Text, out var min))
				cfg.DuracionTurnoMin = min;

			Application["HorarioConfig"] = cfg;
			ClientScript.RegisterStartupScript(GetType(), "ok1", "alert('Horarios guardados');", true);
		}

		protected void btnGuardarNotificaciones_Click(object sender, EventArgs e)
		{
			var cph = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
			var chkEmail = (CheckBox)cph.FindControl("chkNotifEmail");
			var chkSms = (CheckBox)cph.FindControl("chkNotifSms");

			var cfg = new NotificacionConfig
			{
				Email = chkEmail.Checked,
				Sms = chkSms.Checked
			};
			Application["NotificacionConfig"] = cfg;
			ClientScript.RegisterStartupScript(GetType(), "ok2", "alert('Notificaciones guardadas');", true);
		}

		protected void btnGuardarIntegraciones_Click(object sender, EventArgs e)
		{
			var cph = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
			var txtGoogle = (TextBox)cph.FindControl("txtGoogleApiKey");
			var txtStripe = (TextBox)cph.FindControl("txtStripeApiKey");

			var cfg = new IntegracionConfig
			{
				GoogleApiKey = txtGoogle.Text,
				StripeApiKey = txtStripe.Text
			};
			Application["IntegracionConfig"] = cfg;
			ClientScript.RegisterStartupScript(GetType(), "ok3", "alert('Integraciones guardadas');", true);
		}
	}
}