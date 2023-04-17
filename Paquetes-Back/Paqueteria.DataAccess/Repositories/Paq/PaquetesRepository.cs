using Dapper;
using Paqueteria.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Paqueteria.DataAccess.Repositories.Paq
{
    public class PaquetesRepository : IRepository<tblPaquetes>
    {
        PaqueteriaConex con = new PaqueteriaConex();






        public IEnumerable<WV_tblPaquetes> List()
        {
            return con.WV_tblPaquetes.AsList();
        }
        // //  //// ///// /// // ///
        public RequestStatus Delete(tblPaquetes item)
        {
            throw new NotImplementedException();
        }

        public tblPaquetes Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tblPaquetes item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tblPaquetes> Lista()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tblPaquetes item, int id)
        {
            throw new NotImplementedException();
        }

        IEnumerable<tblPaquetes> IRepository<tblPaquetes>.List()
        {
            throw new NotImplementedException();
        }
    }
}
