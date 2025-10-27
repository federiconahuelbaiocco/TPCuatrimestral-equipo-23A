using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    internal class Medico : Persona
    {
        public string Matricula { get; set; }
        public TurnoTrabajo HorarioAtencion { get; set; }
        public Especialidad Especialeidad { get; set; }

    }
}
