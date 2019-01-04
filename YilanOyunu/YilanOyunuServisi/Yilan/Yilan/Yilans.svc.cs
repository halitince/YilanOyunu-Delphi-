using System.Collections.Generic;
using System.Net.Sockets;
using System.ServiceModel;
using System.ServiceModel.Channels;
using Yilan.Dto;
using Yilan.Facade;

namespace Yilan
{
    public class Yilans : IYilans
    {
        public List<SkorKaydi> SkorListesiGetir()
        {
            return new SkorlarFacade().SkorListesiGetir();
        }

        public bool SkorKaydiEkle(YeniSkorKaydi aKayit)
        {
            return new SkorlarFacade().SkorKaydiEkle(aKayit);
        }

        public List<string> MesajListesiGetir()
        {
            return new MesajlarFacade().MesajListesiGetir();
        }
    }
}
