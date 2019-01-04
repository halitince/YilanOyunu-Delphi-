using System.Collections.Generic;
using System.ServiceModel;
using Yilan.Dto;

namespace Yilan
{
    [ServiceContract]
    public interface IYilans
    {
        [OperationContract]
        List<SkorKaydi> SkorListesiGetir();

        [OperationContract]
        bool SkorKaydiEkle(YeniSkorKaydi aKayit);

        [OperationContract]
        List<string> MesajListesiGetir();
    }
}
