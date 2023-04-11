using Paqueteria.Entities.Entities;
using Dapper;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Paqueteria.DataAccess;

namespace Paqueteria.DataAccess.Repositories.Gral
{
    public class DepartamentosRepository : IRepository<tbDepartamentos>
    {
        public RequestStatus Delete(tbDepartamentos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbDepartamentos> ListarDepartamentos()
        {
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
      
            return db.Query<tbDepartamentos>(ScriptsDatabase.ListarDepartamentos, commandType: CommandType.StoredProcedure);

        }
        public tbDepartamentos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbDepartamentos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbDepartamentos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbDepartamentos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
