using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class emailServiceNegocio
    {
        private MailMessage mail;
        private SmtpClient server;

        public emailServiceNegocio()
        {
            server = new SmtpClient();
            server.Credentials = new NetworkCredential("248860301b1bb5", "aa0f75ea020186");
            server.EnableSsl = true;
            server.Port = 587;
            server.Host = "sandbox.smtp.mailtrap.io";
            System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
        }

        public void armarCorreo(string destinatario, string asunto, string cuerpo)
        {
            mail = new MailMessage();
            mail.From = new MailAddress("noresponder@utnsalud.com");
            mail.To.Add(destinatario);
            mail.Subject = asunto;
            mail.IsBodyHtml = true;
            mail.Body = cuerpo;
        }

        public void enviarCorreoModificacionEmpleado(string destinatario, string nombre)
        {
            string cuerpo = "<h1>Modificación de datos en el sistema UTN Salud</h1>" +
                            "<br>" +
                            "<p>Hola " + nombre + ",</p>" +
                            "<p>Atentamente,</p>" +
                            "<p>El equipo de UTN Salud</p>";

            armarCorreo(destinatario, "Modificación de datos en UTN Salud", cuerpo);
        }

        public void enviarCorreoAltaEmpleado(string destinatario, string apellido, string nombre, string nombreU, string contrasena)
        {
            string cuerpo = "<h1>Alta en el sistema UTN Salud</h1>" +
                            "<br>" +
                            "<p>Hola " + nombre + " " + apellido + ",</p>" +
                            "<p>Su cuenta ha sido creada exitosamente. Su usuario es: " + nombreU + " Su contraseña es: <strong>" + contrasena + "</strong></p>" +
                            "<p>Por favor, cambie su contraseña en el primer inicio de sesión.</p>" +
                            "<p>Atentamente,</p>" +
                            "<p>El equipo de UTN Salud</p>";

            armarCorreo(destinatario, "Alta de Empleado en UTN Salud", cuerpo);
        }

        public void enviarCorreoRecuperacionContrasena(string destinatario, string nombreP, string nombreU, string contrasena)
        {
            string cuerpo = "<h1>Recuperación de Contraseña en el sistema UTN Salud</h1>" +
                            "<br>" +
                            "<p>Hola " + nombreP + ",</p>" +
                            "<p>Su usuario es: <strong>" + nombreU + "</strong></p>" +
                            "<p>Su contraseña es: <strong>" + contrasena + "</strong></p>" +
                            "<p>Por favor, solicite el cambio de su contraseña al administrador.</p>" +
                            "<p>Atentamente,</p>" +
                            "<p>El equipo de UTN Salud</p>";

            armarCorreo(destinatario, "Recuperación de Contraseña en UTN Salud", cuerpo);
        }

        public void enviarConfirmacionTurno(string destinatario, string nombre, string fecha, string hora, string especialidad)
        {
            string cuerpo = "<h1>Confirmación de Turno en el sistema UTN Salud</h1>" +
                            "<br>" +
                            "<p>Hola " + nombre + ",</p>" +
                            "<p>Su turno ha sido confirmado para la fecha: <strong>" + fecha + "</strong> a las <strong>" + hora + "</strong> en la especialidad de <strong>" + especialidad + "</strong>.</p>" +
                            "<p>Por favor, llegue 10 minutos antes de su turno.</p>" +
                            "<p>Atentamente,</p>" +
                            "<p>El equipo de UTN Salud</p>";

            armarCorreo(destinatario, "Confirmación de Turno en UTN Salud", cuerpo);
        }

        public void enviarCorreo()
        {
            try
            {
                server.Send(mail);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}