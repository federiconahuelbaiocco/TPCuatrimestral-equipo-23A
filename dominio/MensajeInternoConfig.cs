using System;

namespace dominio
{
    [Serializable]
    public class MensajeInternoConfig
    {
        public string Mensaje { get; set; }
        public string DestinatarioRol { get; set; }
        public int? DestinatarioUsuarioId { get; set; }
    }
}
