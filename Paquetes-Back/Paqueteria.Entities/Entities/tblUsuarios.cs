﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

#nullable disable

namespace Paqueteria.Entities.Entities
{
    public partial class tblUsuarios
    {
        public tblUsuarios()
        {
            tblEnviosPorPaquetesenpa_UsuarioCreaNavigation = new HashSet<tblEnviosPorPaquetes>();
            tblEnviosPorPaquetesenpa_UsuarioModificaNavigation = new HashSet<tblEnviosPorPaquetes>();
            tblEnviosenvi_UsuarioCreaNavigation = new HashSet<tblEnvios>();
            tblEnviosenvi_UsuarioModificaNavigation = new HashSet<tblEnvios>();
            tblPaquetespaqu_UsuarioCreaNavigation = new HashSet<tblPaquetes>();
            tblPaquetespaqu_UsuarioModificaNavigation = new HashSet<tblPaquetes>();
        }

        public int usua_Id { get; set; }
        public string usua_Usuario { get; set; }
        public string usua_Clave { get; set; }
        public int usua_Empleado { get; set; }
        public bool usua_EsAdmin { get; set; }


        [NotMapped]
        public string pers_Nombres { get; set; }
        public virtual tblPersonas usua_EmpleadoNavigation { get; set; }
        public virtual ICollection<tblEnviosPorPaquetes> tblEnviosPorPaquetesenpa_UsuarioCreaNavigation { get; set; }
        public virtual ICollection<tblEnviosPorPaquetes> tblEnviosPorPaquetesenpa_UsuarioModificaNavigation { get; set; }
        public virtual ICollection<tblEnvios> tblEnviosenvi_UsuarioCreaNavigation { get; set; }
        public virtual ICollection<tblEnvios> tblEnviosenvi_UsuarioModificaNavigation { get; set; }
        public virtual ICollection<tblPaquetes> tblPaquetespaqu_UsuarioCreaNavigation { get; set; }
        public virtual ICollection<tblPaquetes> tblPaquetespaqu_UsuarioModificaNavigation { get; set; }
    }
}