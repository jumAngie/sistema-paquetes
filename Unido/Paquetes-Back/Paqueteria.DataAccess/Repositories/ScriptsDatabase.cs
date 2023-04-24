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

        public static string ListarDepartamentos = "Gral.UDP_Departamentos";

        public static string ListarMunicipios = "Gral.UDP_Municipios";

        public static string ListarEstadoCiviles = "Gral.UDP_EstadoCivil";

        #region Login

        public static string ValidarLogin = "UDP_Inicio_Login";

        #endregion

        #region Ciudad
        public static string ListarCiudadesPorDepto = "Gral.UDP_tblCiudades_CiudadesPorDepto";
        #endregion


        #region Usuarios
        public static string InsertarUsuario = "UDP_InsertUsuario";

        public static string ActualizarUsuario = "UDP_ActualizarUsuario";

        public static string EliminarUsuario = "UDP_EliminarUsuario";

        public static string EmpleadoSin = "UDP_Empleados_Sin_Usuario";

        #endregion

        #region Paquetes
        public static string InsertarPaquete = "Paq.UDP_tblPaquetes_Insertar";
        public static string EditarPaquete = "Paq.UDP_tblPaquetes_Editar";
        public static string EliminarPaquete = "Paq.UDP_tblPaquetes_Eliminar";
        public static string PaquetePorCodigo = "Paq.UDP_tblPaquetes_ListarPaquetePorCodigo";
        #endregion

        #region Envios Por Paquetes

        public static string PaquetesPorEnvio = "Paq.UDP_Envios_Por_Paquete_Mostrar";
    
        public static string EnviosPorPaqueteInsertar = "Paq.UDP_Envios_Por_Paquete_Insertar";

        public static string EnviosPorPaqueteEliminar = "Paq.UDP_Envios_Por_Paquete_Eliminar";


        #endregion

        #region Envios 

        public static string EnviosInsertar = "Paq.UDP_tblEnvios_Insertar";

        public static string EnviosEditar = "Paq.UDP_tblEnvios_Editar";

        public static string EnviosEliminar = "Paq.UDP_tblEnvios_Eliminar";

        #endregion

        public static string Grafico = "UDP_Grafico_Paquetes_Por_Cliente";//Para el grafico

        public static string EnviosTodos = "Paq.UDP_Envios_Mostrar";//Para ddl de Envios

        public static string Perfil = "PerfilPersona";//Para el PERFIL

        public static string Entregado = "Paq.UDP_Envios_Por_Paquete_Entregado";//Para el PERFIL

        public static string CambiarClave = "UDP_Inicio_Login_Cambiar_Clave";
        
    }
}
