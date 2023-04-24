using Dapper;
using Paqueteria.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Paqueteria.DataAccess.Repositories.Paq
{
    public class CamionesRepository : IRepository<tblCamiones>
    {
        public RequestStatus Delete(tblCamiones item)
        {
            throw new NotImplementedException();
        }
       
        PaqueteriaConex con = new PaqueteriaConex();
        public IEnumerable<V_ddl_Camiones> Camionesddl()
        {
            return con.V_ddl_Camiones.AsList();
        }

        public tblCamiones Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tblCamiones item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tblCamiones> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tblCamiones item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
