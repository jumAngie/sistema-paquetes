﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Paqueteria.Entities.Entities
{
    public partial class tblCamiones
    {
        public tblCamiones()
        {
            tblEnvios = new HashSet<tblEnvios>();
        }

        public int cami_Id { get; set; }
        public int? cami_Empleado { get; set; }

        public virtual tblPersonas cami_EmpleadoNavigation { get; set; }
        public virtual ICollection<tblEnvios> tblEnvios { get; set; }
    }
}