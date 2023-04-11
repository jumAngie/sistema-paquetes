
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

namespace Paqueteria.DataAccess.Repositories.Gral
{
    public class UsuariosRepository : IRepository<tblUsuarios>
    {
        PaqueteriaConex con = new PaqueteriaConex();

        public IEnumerable<WV_tbLUsuarios> List()
        {
            return con.WV_tbLUsuarios.AsList();
        }

        public IEnumerable<tblUsuarios> ListarUsuarioEmpleados()
        {
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            var parametro = new DynamicParameters();
          
            return db.Query<tblUsuarios>(ScriptsDatabase.EmpleadoSin, commandType: CommandType.StoredProcedure);
        }

        

        public RequestStatus InsertarUsuario(tblUsuarios item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@usua_Usuario", item.usua_Usuario, DbType.String, ParameterDirection.Input);
            parameters.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);
            parameters.Add("@usua_EsAdmin", item.usua_EsAdmin, DbType.Boolean, direction: ParameterDirection.Input);           
            parameters.Add("@usua_Empleado", item.usua_Empleado, DbType.Int32, direction: ParameterDirection.Input);
            parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.InsertarUsuario, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }

        public tblUsuarios Find(int? id)
        {
            using var db = new PaqueteriaConex();

            return db.tblUsuarios.FirstOrDefault(e => e.usua_Id == id);
        }


        public RequestStatus UpdateUsuario(tblUsuarios item)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@usua_Usuario", item.usua_Usuario, DbType.String, ParameterDirection.Input);
            parameters.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);
            parameters.Add("@usua_EsAdmin", item.usua_EsAdmin, DbType.Boolean, direction: ParameterDirection.Input);
            parameters.Add("@usua_Empleado", item.usua_Empleado, DbType.Int32, direction: ParameterDirection.Input);
            parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            db.Query<RequestStatus>(ScriptsDatabase.ActualizarUsuario, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
            var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
            return result;
        }

        public RequestStatus Delete(tblUsuarios item)
        {
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@usua_Id", item.usua_Id, DbType.String, ParameterDirection.Input);
           
            var lis = db.QueryFirst<int>(ScriptsDatabase.EliminarUsuario, parametros, commandType: CommandType.StoredProcedure);

            var resultado = new RequestStatus();
            resultado.CodeStatus = lis;

            return resultado;

        }



        public IEnumerable<tblUsuarios> IniciarSesion(tblUsuarios item)
        {
            using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
            var parametro = new DynamicParameters();
            parametro.Add("@usua_Usuario", item.usua_Usuario, DbType.String, ParameterDirection.Input);
            parametro.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);

            return db.Query<tblUsuarios>(ScriptsDatabase.ValidarLogin, parametro, commandType: CommandType.StoredProcedure);
        }

        //public RequestStatus RestablecerPassword(tblUsuarios item)
        //{
        //    var parameters = new DynamicParameters();
        //    parameters.Add("@usua_Usuario", item.usua_Usuario, DbType.String, ParameterDirection.Input);
        //    parameters.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);
        //    parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
        //    using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
        //    db.Query<RequestStatus>(ScriptsDatabase.RestablecerPassword, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
        //    var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
        //    return result;
        //}
        //***************************************************************************************************************************************

        //public IEnumerable<tblUsuarios> EvaluarUsuarios(tblUsuarios item)
        //{
        //    using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
        //    var parametro = new DynamicParameters();
        //    parametro.Add("@usua_Usuario", item.usua_Usuario, DbType.String, ParameterDirection.Input);
        //    return db.Query<tblUsuarios>(ScriptsDatabase.ValidarUsuario, parametro, commandType: CommandType.StoredProcedure);
        //}

        //public IEnumerable<tblUsuarios> ValidarUsuarioRestablecer(tblUsuarios item)
        //{
        //    using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
        //    var parametro = new DynamicParameters();
        //    parametro.Add("@usua_Usuario", item.usua_Usuario, DbType.String, ParameterDirection.Input);
        //    parametro.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);
        //    return db.Query<tblUsuarios>(ScriptsDatabase.ValidarRestablecerPassword, parametro, commandType: CommandType.StoredProcedure);
        //}

        //public RequestStatus UpdatePassword(tblUsuarios item)
        //{
        //    var parameters = new DynamicParameters();
        //    parameters.Add("@usua_Usuario", item.usua_Usuario, DbType.String, ParameterDirection.Input);
        //    parameters.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);
        //    parameters.Add("@status", DbType.Int32, direction: ParameterDirection.Output);
        //    using var db = new SqlConnection(PaqueteriaConex.ConnectionString);
        //    db.Query<RequestStatus>(ScriptsDatabase.CambiarPassword, parameters, commandType: CommandType.StoredProcedure).FirstOrDefault();
        //    var result = new RequestStatus { CodeStatus = parameters.Get<int>("@status") };
        //    return result;
        //}
        IEnumerable<tblUsuarios> IRepository<tblUsuarios>.List()
        {
            throw new NotImplementedException();
        }

      

        public RequestStatus Update(tblUsuarios item, int id)
        {
            throw new NotImplementedException();
        }

        

        public RequestStatus Insert(tblUsuarios item)
        {
            throw new NotImplementedException();
        }
    }
}
