using Dapper;
using Microsoft.Data.SqlClient;
using Paqueteria.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Paqueteria.DataAccess.Repositories.Paq
{
   public class EnviosPorPaqueteRepository : IRepository<tblEnviosPorPaquetes>
    {
       

        public tblEnviosPorPaquetes Find(int? id)
        {
            using var db = new PaqueteriaConex();

            return db.tblEnviosPorPaquetes.FirstOrDefault(e => e.enpa_Envio == id);
        }

        public RequestStatus Insert(tblEnviosPorPaquetes item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@enpa_Envio", item.enpa_Envio, DbType.String, ParameterDirection.Input);
            parameters.Add("@enpa_Paquete", item.enpa_Paquete, DbType.String, ParameterDirection.Input);
            parameters.Add("@enpa_UsuarioCrea", item.enpa_UsuarioCrea, DbType.Boolean, direction: ParameterDirection.Input);
         
            parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.EnviosPorPaqueteInsertar, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }

        public RequestStatus Delete(tblEnviosPorPaquetes item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@enpa_Envio", item.enpa_Envio, DbType.String, ParameterDirection.Input);
            parameters.Add("@enpa_Paquete", item.enpa_Paquete, DbType.String, ParameterDirection.Input);
          
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.EnviosPorPaqueteEliminar, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }

        public IEnumerable<tblEnviosPorPaquetes> PaquetesPorEnvio(tblEnviosPorPaquetes item)
        {
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            var parametro = new DynamicParameters();
            parametro.Add("@enpa_Envio", item.enpa_Envio, DbType.String, ParameterDirection.Input);

            return db.Query<tblEnviosPorPaquetes>(ScriptsDatabase.PaquetesPorEnvio, parametro, commandType: CommandType.StoredProcedure);
        }

        PaqueteriaConex con = new PaqueteriaConex();
        public IEnumerable<V_Grafico_Paquetes_Por_Cliente> Grafico()
        {
            return con.V_Grafico_Paquetes_Por_Cliente.AsList();
        }


        public RequestStatus Update(tblEnviosPorPaquetes item, int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tblEnviosPorPaquetes> List()
        {
            throw new NotImplementedException();
        }
    }
}
