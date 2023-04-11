using Paqueteria.BusinessLogic.Services;

using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Paqueteria.DataAccess;
using Paqueteria.DataAccess.Repositories.Gral;

namespace Paqueteria.BusinessLogic
{
    public static class ServiceConfiguration
    {
        public static void DataAccess(this IServiceCollection services, string connection)
        {

            services.AddScoped<DepartamentosRepository>();
            services.AddScoped<UsuariosRepository>();

            PaqueteriaConex.BuildConnectionString(connection);

        }


        public static void BusinessLogic(this IServiceCollection services)
        {

            services.AddScoped<GeneralesService>();

        }
    }
}
