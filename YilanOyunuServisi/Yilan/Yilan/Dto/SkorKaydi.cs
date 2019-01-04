using System.Runtime.Serialization;

namespace Yilan.Dto
{
    [DataContract]
    public class SkorKaydi
    {
        [DataMember]
        public string Kullanici { get; set; }
        [DataMember]
        public int Skor { get; set; }
    }

    [DataContract]
    public class YeniSkorKaydi
    {
        [DataMember]
        public string Kullanici { get; set; }
        [DataMember]
        public int Skor { get; set; }
        [DataMember]
        public string Key { get; set; }
    }
}