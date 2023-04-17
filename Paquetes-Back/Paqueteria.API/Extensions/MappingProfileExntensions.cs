
using AutoMapper;
using Paqueteria.API.Models;
using Paqueteria.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Paqueteria.API.Extensions
{
    public class MappingProfileExntensions : Profile
    {
        public MappingProfileExntensions()
        {
            CreateMap<tblDepartamentos, DepartamentoViewModel>().ReverseMap();
            CreateMap<tblPaquetes, PaquetesViewModel>().ReverseMap();
            CreateMap<tblUsuarios, UsuariosViewModel>().ReverseMap();
            CreateMap<tblEnviosPorPaquetes, EnviosPorPaqueteViewModel>().ReverseMap();
            CreateMap<tblEnvios, EnviosViewModel>().ReverseMap();
        }
    }
}