﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Paqueteria.Entities.Entities
{
    public partial class WV_tblEnvios
    {
        public int envi_Id { get; set; }
        public int envi_Camion { get; set; }
        public string Transportista { get; set; }
        public DateTime envi_FechaSalida { get; set; }
        public DateTime envi_FechaEntrega { get; set; }
    }
}