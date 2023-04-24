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
    public class DepartamentosRepository : IRepository<tblDepartamentos>
    {
        public RequestStatus Delete(tblDepartamentos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tblDepartamentos> ListarDepartamentos()
        {
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
      
            return db.Query<tblDepartamentos>(ScriptsDatabase.ListarDepartamentos, commandType: CommandType.StoredProcedure);

        }
        public tblDepartamentos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tblDepartamentos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tblDepartamentos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tblDepartamentos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
