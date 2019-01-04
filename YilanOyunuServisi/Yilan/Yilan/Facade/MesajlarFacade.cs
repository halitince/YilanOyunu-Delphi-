using System.Collections.Generic;
using System.Linq;

namespace Yilan.Facade
{
    public class MesajlarFacade
    {
        public List<string> MesajListesiGetir()
        {
            using (var Db = new yilanEntities())
            {
                List<string> lMesajlar = Db.yilan_mesajlar.Where(m => m.aktif == 0).Select(m => m.mesaj).ToList();
                return lMesajlar;
            }
        }
    }
}