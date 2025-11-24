using System;
using System.Collections.Generic;

namespace dominio
{
    [Serializable]
    public class HorarioConfig
    {
        public TimeSpan HoraApertura { get; set; }
        public TimeSpan HoraCierre { get; set; }
        public int DuracionTurno { get; set; }
        public List<DayOfWeek> DiasLaborables { get; set; }

        public HorarioConfig()
        {
            DiasLaborables = new List<DayOfWeek>();
        }
    }
}
