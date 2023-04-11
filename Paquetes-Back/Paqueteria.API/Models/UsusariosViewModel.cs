using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Paqueteria.API.Models
{
    public class UsusariosViewModel
    {
        public int usua_Id { get; set; }
        public string usua_Usuario { get; set; }
        public string usua_Clave { get; set; }
        public int usua_Empleado { get; set; }
        public bool usua_EsAdmin { get; set; }

    }
}
