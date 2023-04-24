﻿using AutoMapper;
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
    public class PaquetesController : ControllerBase
    {
        private readonly PaqueteriaServices _paqueteriaServices;
        private readonly IMapper _mapper;

        public PaquetesController(PaqueteriaServices paqueteriaServices, IMapper mapper)
        {
            _paqueteriaServices = paqueteriaServices;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IEnumerable<WV_tblPaquetes> List()
        {
            var list = _paqueteriaServices.ListarPaquetes();
            return list;
        }

        [HttpPost("Insertar")]
        public IActionResult InsertarPaquete(PaquetesViewModel paquetesViewModel)
        {
            var item = _mapper.Map<tblPaquetes>(paquetesViewModel);
            var response = _paqueteriaServices.InsertarPaquetes(item);
            return Ok(response);
        }

        [HttpPost("Eliminar")]
        public IActionResult EliminarPaquete(PaquetesViewModel paquetesViewModel)
        {
            var item = _mapper.Map<tblPaquetes>(paquetesViewModel);
            var response = _paqueteriaServices.EliminarPaquete(item);
            return Ok(response);
        }


        [HttpGet("PaquetesPorCodigo/{codigo}")]
        public IActionResult BuscarPaquetes(int codigo)
        {
            tblPaquetes paquetesViewModel = new tblPaquetes();
            paquetesViewModel.paqu_Codigo = codigo;

            var response = _paqueteriaServices.ListarPaquetesPorCodigo(paquetesViewModel);

            if (response.Success)
            {
                var paquetes = (List<tblPaquetes>)response.Data;
                var viewModel = _mapper.Map<List<PaquetesViewModel>>(paquetes);
                return Ok(viewModel);
            }
            else
            {
                return NotFound(response.Message);
            }
        }


        [HttpPost("Editar")]
        public IActionResult ActualizarPaquete(PaquetesViewModel paquetesViewModel)
        {
            var item = _mapper.Map<tblPaquetes>(paquetesViewModel);
            var response = _paqueteriaServices.EditarPaquete(item);
            return Ok(response);
        }
    }
}
