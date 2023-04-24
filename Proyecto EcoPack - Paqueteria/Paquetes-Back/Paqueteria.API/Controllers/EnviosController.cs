using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Paqueteria.API.Models;
using Paqueteria.BusinessLogic.Services;
using Paqueteria.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Paqueteria.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EnviosController : ControllerBase
    {
        private readonly PaqueteriaServices _paqueteriaServices;
        private readonly IMapper _mapper;

        public EnviosController(PaqueteriaServices paqueteriaServices, IMapper mapper)
        {
            _paqueteriaServices = paqueteriaServices;
            _mapper = mapper;
        }


        [HttpGet("List")]
        public IEnumerable<WV_tblEnvios> List()
        {
            var list = _paqueteriaServices.ListarEnvios();
            return list;
        }

        [HttpPost("Insertar")]
        public IActionResult InsertarUsuario(EnviosViewModel enviosViewModel)
        {
            var item = _mapper.Map<tblEnvios>(enviosViewModel);
            var response = _paqueteriaServices.InsertarEnvio(item);
            return Ok(response);
        }

        [HttpPost("Eliminar")]
        public IActionResult EliminarUsuario(EnviosViewModel enviosViewModel)
        {
            var item = _mapper.Map<tblEnvios>(enviosViewModel);
            var response = _paqueteriaServices.EliminarEnvio(item);
            return Ok(response);
        }

        [HttpPost("Editar")]
        public IActionResult ActualizarUsuario(EnviosViewModel enviosViewModel)
        {
            var item = _mapper.Map<tblEnvios>(enviosViewModel);
            var response = _paqueteriaServices.EditarEnvio(item);
            return Ok(response);
        }


    }
}
