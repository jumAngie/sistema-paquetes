using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Paqueteria.API.Models
{
    public class PersonaViewModel
    {
        public int pers_Id { get; set; }
        public string pers_Nombres { get; set; }
        public string pers_Apellidos { get; set; }
        public string pers_DNI { get; set; }
        public bool pers_Puesto { get; set; }
        public string pers_Sexo { get; set; }
        
        [NotMapped]
        public string esci_Descripcion { get; set; }





    }
}
