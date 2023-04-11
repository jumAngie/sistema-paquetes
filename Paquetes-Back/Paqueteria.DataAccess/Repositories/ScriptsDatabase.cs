using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Paqueteria.DataAccess.Repositories
{
    public class ScriptsDatabase
    {


        //#region Usuarios
        //public static string EmpleadoNoTieneUser = "Acce.UDP_tbUsuarios_DDLempleadosTieneusuario";
        //public static string InsertarUsuario = "Acce.UDP_InsertUsuario";
        //#endregion

        public static string ListarDepartamentos = "Departamentos";

        #region Login

        public static string ValidarLogin = "UDP_Inicio_Login";

        #endregion


        #region Usuarios
        public static string InsertarUsuario = "UDP_InsertUsuario";

        public static string ActualizarUsuario = "UDP_ActualizarUsuario";

        public static string EliminarUsuario = "UDP_EliminarUsuario";

        public static string EmpleadoSin = "UDP_Empleados_Sin_Usuario";



        
        #endregion
    }
}
