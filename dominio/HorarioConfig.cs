using System;
using System.Collections.Generic;

namespace dominio
{
    [Serializable]
    public class HorarioConfig
    {
        public List<DayOfWeek> DiasLaborables { get; set; } = new List<DayOfWeek>();
        public TimeSpan HoraApertura { get; set; }
        public TimeSpan HoraCierre { get; set; }
        public int DuracionTurnoMin { get; set; }
    }
}
