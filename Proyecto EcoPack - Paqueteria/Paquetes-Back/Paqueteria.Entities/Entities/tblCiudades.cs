﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Paqueteria.Entities.Entities
{
    public partial class tblCiudades
    {
        public tblCiudades()
        {
            tblPaquetes = new HashSet<tblPaquetes>();
        }

        public int ciud_ID { get; set; }
        public string ciud_Descri { get; set; }
        public int depa_ID { get; set; }
        public int ciud_UsuarioCrea { get; set; }
        public DateTime? ciud_FechaCrea { get; set; }
        public int? ciud_UsuarioModifica { get; set; }
        public DateTime? ciud_FechaModifica { get; set; }

        public virtual tblDepartamentos depa { get; set; }
        public virtual ICollection<tblPaquetes> tblPaquetes { get; set; }
    }
}