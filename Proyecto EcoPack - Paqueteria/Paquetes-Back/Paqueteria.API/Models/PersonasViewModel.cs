using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Paqueteria.API.Models
{
    public class PersonasViewModel
    {
        public int pers_Id { get; set; }
        public string pers_Nombres { get; set; }
        public string pers_Apellidos { get; set; }
        public string pers_DNI { get; set; }
        public bool pers_Puesto { get; set; }
        public string pers_Sexo { get; set; }
        public int pers_EstadoCivil { get; set; }

    }
}
