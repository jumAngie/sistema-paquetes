﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Paqueteria.Entities.Entities
{
    public partial class tblEstadoCiviles
    {
        public tblEstadoCiviles()
        {
            tblPersonas = new HashSet<tblPersonas>();
        }

        public int esci_ID { get; set; }
        public string esci_Descripcion { get; set; }
        public int esci_UsuarioCrea { get; set; }
        public DateTime? esci_FechaCrea { get; set; }
        public int? esci_UsuarioModifica { get; set; }
        public DateTime? esci_FechaModifica { get; set; }
        public bool? esci_Estado { get; set; }

        public virtual ICollection<tblPersonas> tblPersonas { get; set; }
    }
}