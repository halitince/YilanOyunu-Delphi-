using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Yilan.Dto;

namespace Yilan.Facade
{
    public class SkorlarFacade
    {
        public List<SkorKaydi> SkorListesiGetir()
        {
            using (var lDb = new yilanEntities())
            {
                return (from s in lDb.yilan_skorlar
                        orderby s.skor descending
                        select new SkorKaydi()
                        {
                            Kullanici = s.kullanici,
                            Skor = s.skor
                        }).Take(12).ToList();
            }
        }

        public bool SkorKaydiEkle(YeniSkorKaydi aKayit)
        {
            try
            {
                int lKey = Convert.ToInt32(aKayit.Key);
                lKey--;
                string lKeyS = (lKey - (aKayit.Skor * 2) - (DateTime.Now.Hour + 57) * 1000) + "";
                if (lKeyS.Substring(0, 3) != lKeyS.Substring(3, 3)) return false;

                using (var lDb = new yilanEntities())
                {
                    yilan_skorlar lKayit = lDb.yilan_skorlar.FirstOrDefault(s => s.kullanici == aKayit.Kullanici) ?? new yilan_skorlar();

                    if (lKayit.id == 0 || lKayit.skor < aKayit.Skor)
                    {
                        lKayit.kullanici = aKayit.Kullanici;
                        lKayit.skor = aKayit.Skor;
                        lKayit.zaman = DateTime.Now;
                        if (lKayit.id == 0)
                            lDb.yilan_skorlar.Add(lKayit);
                        lDb.SaveChanges();
                    }
                    return true;
                }
            }
            catch (Exception e)
            {
                return false;
            }
        }
    }
}