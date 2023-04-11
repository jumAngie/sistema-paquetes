
using Paqueteria.DataAccess.Repositories.Gral;
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
        
        public GeneralesService(DepartamentosRepository departamentosRepository)
        {
            _departamentosRepository = departamentosRepository;
           
        }

   
        #region Departamentos
        public ServiceResult ListarDepartamentos()
        {
            var result = new ServiceResult();

            try
            {
                var list = _departamentosRepository.ListarDepartamentos();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        #endregion

      
    }

}
