﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Paqueteria.API.Models
{
    public class PaquetesViewModel
    {
        public int paqu_Id { get; set; }
        public int paqu_Codigo { get; set; }
        public int paqu_Cliente { get; set; }
        public int paqu_Ciudad { get; set; }

        [NotMapped]
        public string depa_Descri { get; set; }

        [NotMapped]
        public string ciud_Descri { get; set; }

        [NotMapped]
        public string Cliente { get; set; }
        public string paqu_DireccionExacta { get; set; }
        public string paqu_Observaciones { get; set; }
        public DateTime? paqu_Bodega { get; set; }
        public DateTime? paqu_EnCamino { get; set; }
        public DateTime? paqu_Entregado { get; set; }
        public int paqu_UsuarioCrea { get; set; }
        public DateTime? paqu_FechaCrea { get; set; }
        public int? paqu_UsuarioModifica { get; set; }
        public DateTime? paqu_FechaModifica { get; set; }
        public bool? paqu_Estado { get; set; }
    }
}
