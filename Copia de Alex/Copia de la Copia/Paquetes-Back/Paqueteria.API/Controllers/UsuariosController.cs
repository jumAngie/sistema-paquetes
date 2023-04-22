﻿using AutoMapper;

using Microsoft.AspNetCore.Mvc;
using Paqueteria.API.Models;
using Paqueteria.BusinessLogic.Services;
using Paqueteria.DataAccess;
using Paqueteria.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Paqueteria.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuariosController : ControllerBase
    {
        private readonly GeneralesService _generalServices;
        private readonly IMapper _mapper;
        public PaqueteriaConex db = new PaqueteriaConex();

        public UsuariosController(GeneralesService  generalesService, IMapper mapper)
        {
            _generalServices = generalesService;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IEnumerable<WV_tbLUsuarios> List()
        {
            var list = _generalServices.ListUsuarios();
            return list;
        }

        [HttpPost("Login")]
        public IActionResult Index(UsuariosViewModel usuariosViewModel)
        {          
            
                var item = _mapper.Map<tblUsuarios>(usuariosViewModel);
               
            var listado = _generalServices.IniciarSesion(item);

            listado.Data = _mapper.Map<UsuariosViewModel>(listado.Data);


            return Ok(listado);
            
           

        }

        [HttpPost("personas/{ID}")]
        public IActionResult GetPersona(int ID)
        {
            var persona = _generalServices.Perfil(ID);

            if (persona == null)
            {
                return NotFound();
            }

            var personaViewModel = _mapper.Map<PersonaViewModel>(persona);

            return Ok(personaViewModel);
        }





        [HttpPost("Update")]

        public IActionResult Update(UsuariosViewModel usuariosViewModel)
        {
            var item = _mapper.Map<tblUsuarios>(usuariosViewModel);
            var response = _generalServices.ActualizarUsuario(item);
            return Ok(response);
        }


        [HttpGet("ListarUsuarioEmpleads")]
        public IActionResult ListarUsuarioEmpleads()
        {
            var list = _generalServices.ListarUsuarioEmpleados();
            return Ok(list);
        }

        [HttpPost("InsertarUsuario")]

        public IActionResult InsertarUsuario(UsuariosViewModel usuariosViewModel)
        {
            var item = _mapper.Map<tblUsuarios>(usuariosViewModel);
            var response = _generalServices.InsertarUsuario(item);
            return Ok(response);
        }

        [HttpPost("DeleteUsuario")]

        public IActionResult DeleteUsuario(UsuariosViewModel usuariosViewModel)
        {
            var item = _mapper.Map<tblUsuarios>(usuariosViewModel);
            var response = _generalServices.EliminarUsuario(item);
            return Ok(response);
        }
       
        
        [HttpGet("Buscar/{id}")]
        public IActionResult BuscarEmpleadoPorId(int id)
        {
            var response = _generalServices.BuscarEmpleadoPorId(id);
            if (response.Success)
            {
                var empleado = (tblUsuarios)response.Data;
                var viewModel = _mapper.Map<UsuariosViewModel>(empleado);
                return Ok(viewModel);
            }
            else
            {
                return NotFound(response.Message);
            }
        }
    }
}
