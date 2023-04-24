using Dapper;
using Microsoft.Data.SqlClient;
using Paqueteria.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Paqueteria.DataAccess.Repositories.Gral
{
    public class EmpleadosRepository : IRepository<tblPersonas>
    {
        PaqueteriaConex con = new PaqueteriaConex();
        public IEnumerable<VW_Clientes> ClientesDDL()
        {
            return con.VW_Clientes.AsList();
        }

        public IEnumerable<tblCiudades> ListadoCiudadesPorDepto(tblCiudades item)
        {
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            var parametro = new DynamicParameters();
            parametro.Add("@deptoID", item.depa_ID, DbType.String, ParameterDirection.Input);

            return db.Query<tblCiudades>(ScriptsDatabase.ListarCiudadesPorDepto, parametro, commandType: CommandType.StoredProcedure);
        }
        // // // //
        public RequestStatus Delete(tblPersonas item)
        {
            throw new NotImplementedException();
        }

        public tblPersonas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tblPersonas item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tblPersonas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tblPersonas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
