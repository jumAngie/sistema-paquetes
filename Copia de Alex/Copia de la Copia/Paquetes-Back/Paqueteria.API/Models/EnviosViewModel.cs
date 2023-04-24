using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Paqueteria.API.Models
{
    public class EnviosViewModel
    {

        public int envi_Id { get; set; }
        public int envi_Camion { get; set; }
        public string envi_FechaSalida { get; set; }
      
        public int envi_UsuarioCrea { get; set; }
        public DateTime? envi_FechaCrea { get; set; }
        public int? envi_UsuarioModifica { get; set; }
        public DateTime? envi_FechaModifica { get; set; }
        public bool? envi_Estado { get; set; }

    }
}
