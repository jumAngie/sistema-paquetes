
using Dapper;
using Microsoft.Data.SqlClient;
using Paqueteria.DataAccess;
using Paqueteria.DataAccess.Repositories;
using Paqueteria.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Paqueteria.DataAccess.Repositories.Paq
{
    public class EnviosRepository : IRepository<tblEnvios>
    {

       
        public RequestStatus Deletes(tblEnvios item)
        {
            throw new NotImplementedException();
        }

        PaqueteriaConex con = new PaqueteriaConex();

        public IEnumerable<WV_tblEnvios> List()
        {
            return con.WV_tblEnvios.AsList();
        }
        public RequestStatus Insert(tblEnvios item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@envi_Camion", item.envi_Camion, DbType.String, ParameterDirection.Input);            
            parameters.Add("@envi_FechaSalida", item.envi_FechaSalida, DbType.String, direction: ParameterDirection.Input);
            parameters.Add("@envi_UsuarioCrea", item.envi_UsuarioCrea, DbType.String, direction: ParameterDirection.Input);

            parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.EnviosInsertar, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }


        public tblEnvios Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Inserts(tblEnvios item)
        {
           
            
            throw new NotImplementedException();
        }

       

        public RequestStatus Update(tblEnvios item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@envi_Id", item.envi_Id, DbType.String, ParameterDirection.Input);
            parameters.Add("@envi_Camion", item.envi_Camion, DbType.String, ParameterDirection.Input);
            
            parameters.Add("@envi_FechaSalida", item.envi_FechaSalida, DbType.String, direction: ParameterDirection.Input);
            parameters.Add("@envi_UsuarioModifica", item.envi_UsuarioModifica, DbType.String, direction: ParameterDirection.Input);

            parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.EnviosEditar, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }

        public RequestStatus Delete(tblEnvios item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@envi_Id", item.envi_Id, DbType.String, ParameterDirection.Input);           
            parameters.Add("@envi_UsuarioModifica", item.envi_UsuarioModifica, DbType.Boolean, direction: ParameterDirection.Input);

            parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.EnviosEliminar, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }

        IEnumerable<tblEnvios> IRepository<tblEnvios>.List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tblEnvios item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
