using System;
using System.IO;
using System.Xml.Serialization;

namespace dominio
{
    public class AppConfigData
    {
        public HorarioConfig Horario { get; set; }
        public MensajeInternoConfig Mensaje { get; set; }
    }

    public static class AppConfigStorage
    {
        private static string GetPath()
        {
            var baseDir = AppDomain.CurrentDomain.BaseDirectory ?? ".";
            var folder = Path.Combine(baseDir, "App_Data");
            Directory.CreateDirectory(folder);
            return Path.Combine(folder, "configuracion_app.xml");
        }

        public static void Save(AppConfigData data)
        {
            var serializer = new XmlSerializer(typeof(AppConfigData));
            using (var stream = File.Create(GetPath()))
            {
                serializer.Serialize(stream, data);
            }
        }

        public static AppConfigData Load()
        {
            var path = GetPath();
            if (!File.Exists(path))
                return null;
            try
            {
                var serializer = new XmlSerializer(typeof(AppConfigData));
                using (var stream = File.OpenRead(path))
                {
                    return serializer.Deserialize(stream) as AppConfigData;
                }
            }
            catch
            {
                return null;
            }
        }
    }
}
