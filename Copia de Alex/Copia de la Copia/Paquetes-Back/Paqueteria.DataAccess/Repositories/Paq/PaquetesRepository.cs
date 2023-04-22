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
    public class PaquetesRepository : IRepository<tblPaquetes>
    {
        PaqueteriaConex con = new PaqueteriaConex();

        public RequestStatus Insert(tblPaquetes item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@paqu_Cliente", item.paqu_Cliente, DbType.Int32, ParameterDirection.Input);
            parameters.Add("@paqu_Ciudad", item.paqu_Ciudad, DbType.Int32, direction: ParameterDirection.Input);
            parameters.Add("@paqu_Codigo", item.paqu_Codigo, DbType.Int32, direction: ParameterDirection.Input);
            parameters.Add("@paqu_DireccionExacta", item.paqu_DireccionExacta, DbType.String, direction: ParameterDirection.Input);
            parameters.Add("@paqu_UsuarioCrea", item.paqu_UsuarioCrea, DbType.Int32, direction: ParameterDirection.Input);

            parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.InsertarPaquete, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }

        public RequestStatus Update(tblPaquetes item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@paqu_Id",              item.paqu_Id,              DbType.Int32, ParameterDirection.Input);
            parameters.Add("@paqu_Cliente",         item.paqu_Cliente,         DbType.Int32, ParameterDirection.Input);
            parameters.Add("@paqu_Codigo",          item.paqu_Codigo,          DbType.Int32, ParameterDirection.Input);
            parameters.Add("@paqu_Ciudad",          item.paqu_Ciudad,          DbType.Int32, ParameterDirection.Input);
            parameters.Add("@paqu_DireccionExacta", item.paqu_DireccionExacta, DbType.String, ParameterDirection.Input);
            parameters.Add("@paqu_UsuarioModifica", item.paqu_UsuarioModifica, DbType.Int32, ParameterDirection.Input);


            parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.EditarPaquete, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }

        public RequestStatus Delete(tblPaquetes item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@paqu_Id", item.paqu_Id, DbType.Int32, ParameterDirection.Input);
            parameters.Add("@paqu_UsuarioModifica", item.paqu_UsuarioModifica, DbType.Int32, direction: ParameterDirection.Input);

            parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.EliminarPaquete, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }


        public IEnumerable<WV_tblPaquetes> List()
        {
            return con.WV_tblPaquetes.AsList();
        }
        // //  //// ///// /// // ///

        public IEnumerable<WV_tblPaquetes_Libres> Listaaa()
        {
            return con.WV_tblPaquetes_Libres.AsList();
        }

        public tblPaquetes Find(int? id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tblPaquetes> Lista()
        {
            throw new NotImplementedException();
        }

        IEnumerable<tblPaquetes> IRepository<tblPaquetes>.List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tblPaquetes item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
