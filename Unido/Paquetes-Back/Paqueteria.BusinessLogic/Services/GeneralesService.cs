


using Paqueteria.DataAccess.Repositories.Gral;
using Paqueteria.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Paqueteria.BusinessLogic.Services
{
    public class GeneralesService
    {
        private readonly DepartamentosRepository _departamentosRepository;
        private readonly UsuariosRepository _usuariosRepository;
        private readonly EmpleadosRepository _empleadosRepository;

        public GeneralesService(DepartamentosRepository departamentosRepository,
                                UsuariosRepository usuariosRepository,
                                EmpleadosRepository empleadosRepository)
        {
            _departamentosRepository = departamentosRepository;
            _usuariosRepository = usuariosRepository;
            _empleadosRepository = empleadosRepository;

        }


        #region Departamentos
        public IEnumerable<tblDepartamentos> ListarDepartamentos()
        {
           
                var list = _departamentosRepository.ListarDepartamentos();
                return list;
          
        }
        #endregion


        #region Login
        public ServiceResult IniciarSesion(tblUsuarios item)
        {
            var result = new ServiceResult();

            try
            {
                var list = _usuariosRepository.IniciarSesion(item);
                return result.Ok(list);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        #endregion


        #region Usuarios

        public ServiceResult BuscarEmpleadoPorId(int id)
        {
            var result = new ServiceResult();

            try
            {
                var empleado = _usuariosRepository.Find(id);
                if (empleado != null)
                {
                    return result.Ok(empleado);
                }
                else
                {
                    return result.Error($"No se encontró el usuario con ID {id}");
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public IEnumerable<WV_tbLUsuarios> ListUsuarios()
        {
            var result = new ServiceResult();

            
                var list = _usuariosRepository.List();
                return list;
           
        }


        public IEnumerable<WV_tblDepartamentos> departamentos()
        {
            var result = new ServiceResult();


            var list = _departamentosRepository.depar();
            return list;

        }

        public ServiceResult ListarUsuarioEmpleados()
        {
            var result = new ServiceResult();

            try
            {
                var list = _usuariosRepository.ListarUsuarioEmpleados();
                return result.Ok(list);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarUsuario(tblUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                if (item.usua_Clave != "")
                {
                    var map = _usuariosRepository.InsertarUsuario(item);
                    if (map.CodeStatus > 0)
                    {
                        return result.Ok(map);
                    }
                    else
                    {
                        map.MessageStatus = (map.CodeStatus == 0) ? "401 Error de Consulta" : map.MessageStatus;
                        return result.Error(map);
                    }
                }
                else
                {
                    return result.SetMessage("La solicitud contiene sintaxis erronea", ServiceResultType.BadRecuest);
                }
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult Cambiar(tblUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _usuariosRepository.CambiarContra(item);
                if (map.CodeStatus > 0)
                {
                    return result.Ok(map);
                }
                else
                {
                    map.MessageStatus = (map.CodeStatus == 0) ? "401 Error de Consulta" : map.MessageStatus;
                    return result.Error(map);
                }
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult EliminarUsuario(tblUsuarios item)
        {
            var result = new ServiceResult();

            try
            {
                if (item.usua_Id != 0)
                {
                    var map = _usuariosRepository.Delete(item);
                    if (map.CodeStatus > 0)
                    {
                        return result.Ok(map);
                    }
                    else
                    {
                        map.MessageStatus = (map.CodeStatus == 0) ? "401 Error de Consulta" : map.MessageStatus;
                        return result.Error(map);
                    }
                }
                else
                {
                    return result.SetMessage("La solicitud contiene sintaxis erronea", ServiceResultType.BadRecuest);
                }
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult ActualizarUsuario(tblUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
               
                    var map = _usuariosRepository.UpdateUsuario(item);
                    if (map.CodeStatus > 0)
                    {
                        return result.Ok(map);
                    }
                    else
                    {
                        map.MessageStatus = (map.CodeStatus == 0) ? "401 Error de Consulta" : map.MessageStatus;
                        return result.Error(map);
                    }
                
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }


        #endregion

        #region Empleado
        public IEnumerable<tblCiudades> ListarCiudadesPorDepto(tblCiudades item)
        {
            var result = new ServiceResult();

                var list = _empleadosRepository.ListadoCiudadesPorDepto(item);
                return list;
          
        }

        public IEnumerable<VW_Clientes> ClientesDDL()
        {
            var result = new ServiceResult();


            var list = _empleadosRepository.ClientesDDL();
            return list;

        }
        #endregion
       
        
        public tblPersonas Perfil(int ID)
        {
            var result = new ServiceResult();

          
                var list = _usuariosRepository.Perfil(ID);
                return list;
           
        }
    }


  



}
