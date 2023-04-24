using AutoMapper;
using Paqueteria.BusinessLogic.Services;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Paqueteria.API.Models;
using Paqueteria.Entities.Entities;

namespace Paqueteria.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DepartamentosController : Controller
    {
        private readonly GeneralesService _generalesServices;
        private readonly IMapper _mapper;

        public DepartamentosController(GeneralesService generalesService, IMapper mapper)
        {
            _generalesServices = generalesService;
            _mapper = mapper;
        }

        [HttpGet("ListarDepart")]
        public IEnumerable<tblDepartamentos> ListarDepartamentos()
        {
            tblDepartamentos depa = new tblDepartamentos();
            var list = _generalesServices.ListarDepartamentos();
            return list;
        }

        [HttpPost("CiudadesPorDepto")]
        public IActionResult PaquetesPorEnvio(CiudadesViewModel item)
        {

            var item2 = _mapper.Map<tblCiudades>(item);

            var response = _generalesServices.ListarCiudadesPorDepto(item2);

            return Ok(response);

        }

        [HttpGet("ClientesDDL")]
        public IEnumerable<VW_Clientes> ListarClientes()
        {
            var list = _generalesServices.ClientesDDL();
            return list;
        }

        [HttpGet("Departa")]
        public IEnumerable<WV_tblDepartamentos> depar()
        {
            var list = _generalesServices.departamentos();
            return list;
        }
    }
}
