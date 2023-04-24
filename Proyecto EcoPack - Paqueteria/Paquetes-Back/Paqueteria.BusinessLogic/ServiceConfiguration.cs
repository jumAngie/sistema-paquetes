using Paqueteria.BusinessLogic.Services;

using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Paqueteria.DataAccess;
using Paqueteria.DataAccess.Repositories.Gral;
using Paqueteria.DataAccess.Repositories.Paq;

namespace Paqueteria.BusinessLogic
{
    public static class ServiceConfiguration
    {
        public static void DataAccess(this IServiceCollection services, string connection)
        {

            services.AddScoped<DepartamentosRepository>();
            services.AddScoped<UsuariosRepository>();
            services.AddScoped<EnviosPorPaqueteRepository>();
            services.AddScoped<PaquetesRepository>();
            services.AddScoped<EnviosRepository>();
            services.AddScoped<CamionesRepository>();

         
          
                   
            services.AddScoped<EmpleadosRepository>();


            PaqueteriaConex.BuildConnectionString(connection);

        }


        public static void BusinessLogic(this IServiceCollection services)
        {

            services.AddScoped<GeneralesService>();
            services.AddScoped<PaqueteriaServices>();

        }
    }
}
