using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    internal class TurnoTrabajo
    {
        public int IdTurnoTrabajo { get; set; }
        public DayOfWeek Dia { get; set; }
        public TimeSpan Entrada { get; set; }
        public TimeSpan Salida { get; set; }
    }
}
