using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
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
    public class CamionesController : ControllerBase
    {
        private readonly PaqueteriaServices _paqueteriaServices;
        private readonly IMapper _mapper;

        public CamionesController(PaqueteriaServices paqueteriaServices, IMapper mapper)
        {
            _paqueteriaServices = paqueteriaServices;
            _mapper = mapper;
        }

        [HttpGet("DDLCamiones")]
        public IEnumerable<V_ddl_Camiones> List()
        {
            var list = _paqueteriaServices.Camionesddl();
            return list;
        }

    }
}
