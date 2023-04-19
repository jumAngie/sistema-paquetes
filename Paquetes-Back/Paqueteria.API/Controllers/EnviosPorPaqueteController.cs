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
    public class EnviosPorPaqueteController : ControllerBase
    {
        private readonly PaqueteriaServices _paqueteriaServices;

        private readonly IMapper _mapper;

        public EnviosPorPaqueteController(PaqueteriaServices paqueteriaServices, IMapper mapper)
        {
            _paqueteriaServices = paqueteriaServices;
            _mapper = mapper;
        }

        [HttpGet("Buscar/{id}")]
        public IActionResult BuscarPaquetes(int id)
        {
            var response = _paqueteriaServices.BuscarPaquetes(id);
            if (response.Success)
            {
                var empleado = (tblEnviosPorPaquetes)response.Data;
                var viewModel = _mapper.Map<EnviosPorPaqueteViewModel>(empleado);
                return Ok(viewModel);
            }
            else
            {
                return NotFound(response.Message);
            }
        }

        [HttpPost("PaquetesPorEnvio")]
        public IActionResult PaquetesPorEnvio(EnviosPorPaqueteViewModel item)
        {

            var item2 = _mapper.Map<tblEnviosPorPaquetes>(item);
            
            var response = _paqueteriaServices.ListarPaquetesPorEnvio(item2);
          
            response.Data = _mapper.Map<EnviosPorPaqueteViewModel>(response.Data);

            return Ok(response);

        }

        [HttpGet("Grafico")]
        public IEnumerable<V_Grafico_Paquetes_Por_Cliente> Grafico()
        {
            var list = _paqueteriaServices.Grafico();
            return list;
        }

        [HttpPost("Delete")]
        public IActionResult Delete(EnviosPorPaqueteViewModel  enviosPorPaqueteViewModel)
        {
            var item = _mapper.Map<tblEnviosPorPaquetes>(enviosPorPaqueteViewModel);
            var response = _paqueteriaServices.EliminarEnvioPorPaquete(item);
            return Ok(response);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(EnviosPorPaqueteViewModel enviosPorPaqueteViewModel)
        {
            var item = _mapper.Map<tblEnviosPorPaquetes>(enviosPorPaqueteViewModel);
            var response = _paqueteriaServices.InsertarEnvioPorPaquete(item);
            return Ok(response);
        }


        


    }
}
