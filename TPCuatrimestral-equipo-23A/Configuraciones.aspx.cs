using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

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

			var data = AppConfigStorage.Load() ?? new AppConfigData();
			data.Horario = cfg;
			AppConfigStorage.Save(data);

			var turnoNegocio = new TurnoTrabajoNegocio();
			var horariosPrevios = turnoNegocio.ListarHorariosPorMedico(0);
			foreach (var turno in horariosPrevios)
			{
				turnoNegocio.EliminarTurnoTrabajoAdmin(turno.IdTurnoTrabajo);
			}
			foreach (var dia in cfg.DiasLaborables)
			{
				try
				{
					turnoNegocio.AgregarTurnoTrabajoAdmin(
						0, 
						(int)dia,
						cfg.HoraApertura,
						cfg.HoraCierre
					);
				}
				catch (Exception)
				{
				}
			}

			ClientScript.RegisterStartupScript(GetType(), "ok1", "alert('Horarios guardados');", true);
		}

		protected void btnSubirLogo_Click(object sender, EventArgs e)
		{
			var cph = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
			var fu = (FileUpload)cph.FindControl("fuLogoClinica");
			var img = (Image)cph.FindControl("imgLogoActual");

			if (fu != null && fu.HasFile)
			{
				var folder = Server.MapPath("~/Content/Uploads");
				Directory.CreateDirectory(folder);
				var fileName = "logo_" + DateTime.Now.ToString("yyyyMMddHHmmss") + Path.GetExtension(fu.FileName);
				var path = Path.Combine(folder, fileName);
				fu.SaveAs(path);
				var url = "~/Content/Uploads/" + fileName;
				img.ImageUrl = url;
				ClientScript.RegisterStartupScript(GetType(), "ok4", "alert('Logo subido');", true);
			}
		}

		protected override void OnInit(EventArgs e)
		{
			base.OnInit(e);
			if (!IsPostBack)
			{
				CargarUsuariosMensajeInterno();
			}
		}

		private void CargarUsuariosMensajeInterno()
		{
		}

		protected void btnGuardarMensajeInterno_Click(object sender, EventArgs e)
		{
			var cph = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
			var txtMensaje = (TextBox)cph.FindControl("txtMensajeInterno");
			var ddlRol = (DropDownList)cph.FindControl("ddlDestinatarioRol");

			var cfg = new MensajeInternoConfig
			{
				Mensaje = txtMensaje.Text,
				DestinatarioRol = ddlRol.SelectedValue,
				DestinatarioUsuarioId = null
			};
			Application["MensajeInternoConfig"] = cfg;

			var data = AppConfigStorage.Load() ?? new AppConfigData();
			data.Mensaje = cfg;
			AppConfigStorage.Save(data);

			ClientScript.RegisterStartupScript(GetType(), "okMsg", "alert('Mensaje interno guardado');", true);
		}
	}
}