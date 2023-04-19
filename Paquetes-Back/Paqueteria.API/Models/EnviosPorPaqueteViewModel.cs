using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Paqueteria.API.Models
{
    public class EnviosPorPaqueteViewModel
    {
        public int enpa_Id { get; set; }
        public int enpa_Envio { get; set; }
        public int enpa_Paquete { get; set; }
        public int enpa_UsuarioCrea { get; set; }
        public DateTime? enpa_FechaCrea { get; set; }
        public int? enpa_UsuarioModifica { get; set; }
        public DateTime? enpa_FechaModifica { get; set; }

        [NotMapped]
        public string Cliente { get; set; }

        [NotMapped]
        public string ciud_Descri { get; set; }

        [NotMapped]
        public string estadoViaje { get; set; }

        public bool? enpa_Estado { get; set; }


    }
}
