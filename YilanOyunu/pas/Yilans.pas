// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://yilan.bahayazilim.com/Yilans.svc?wsdl
//  >Import : http://yilan.bahayazilim.com/Yilans.svc?wsdl>0
//  >Import : http://yilan.bahayazilim.com/Yilans.svc?xsd=xsd0
//  >Import : http://yilan.bahayazilim.com/Yilans.svc?xsd=xsd2
//  >Import : http://yilan.bahayazilim.com/Yilans.svc?xsd=xsd3
//  >Import : http://yilan.bahayazilim.com/Yilans.svc?xsd=xsd1
// Encoding : utf-8
// Version  : 1.0
// (16.03.2014 20:38:51 - - $Rev: 25127 $)
// ************************************************************************ //

unit Yilans;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  SkorKaydi            = class;                 { "http://schemas.datacontract.org/2004/07/Yilan.Dto"[GblCplx] }
  YeniSkorKaydi        = class;                 { "http://schemas.datacontract.org/2004/07/Yilan.Dto"[GblCplx] }
  SkorKaydi2           = class;                 { "http://schemas.datacontract.org/2004/07/Yilan.Dto"[GblElm] }
  YeniSkorKaydi2       = class;                 { "http://schemas.datacontract.org/2004/07/Yilan.Dto"[GblElm] }

  ArrayOfSkorKaydi = array of SkorKaydi;        { "http://schemas.datacontract.org/2004/07/Yilan.Dto"[GblCplx] }


  // ************************************************************************ //
  // XML       : SkorKaydi, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/Yilan.Dto
  // ************************************************************************ //
  SkorKaydi = class(TRemotable)
  private
    FKullanici: string;
    FKullanici_Specified: boolean;
    FSkor: Integer;
    FSkor_Specified: boolean;
    procedure SetKullanici(Index: Integer; const Astring: string);
    function  Kullanici_Specified(Index: Integer): boolean;
    procedure SetSkor(Index: Integer; const AInteger: Integer);
    function  Skor_Specified(Index: Integer): boolean;
  published
    property Kullanici: string   Index (IS_OPTN or IS_NLBL) read FKullanici write SetKullanici stored Kullanici_Specified;
    property Skor:      Integer  Index (IS_OPTN) read FSkor write SetSkor stored Skor_Specified;
  end;



  // ************************************************************************ //
  // XML       : YeniSkorKaydi, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/Yilan.Dto
  // ************************************************************************ //
  YeniSkorKaydi = class(TRemotable)
  private
    FKey: string;
    FKey_Specified: boolean;
    FKullanici: string;
    FKullanici_Specified: boolean;
    FSkor: Integer;
    FSkor_Specified: boolean;
    procedure SetKey(Index: Integer; const Astring: string);
    function  Key_Specified(Index: Integer): boolean;
    procedure SetKullanici(Index: Integer; const Astring: string);
    function  Kullanici_Specified(Index: Integer): boolean;
    procedure SetSkor(Index: Integer; const AInteger: Integer);
    function  Skor_Specified(Index: Integer): boolean;
  published
    property Key:       string   Index (IS_OPTN or IS_NLBL) read FKey write SetKey stored Key_Specified;
    property Kullanici: string   Index (IS_OPTN or IS_NLBL) read FKullanici write SetKullanici stored Kullanici_Specified;
    property Skor:      Integer  Index (IS_OPTN) read FSkor write SetSkor stored Skor_Specified;
  end;



  // ************************************************************************ //
  // XML       : SkorKaydi, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/Yilan.Dto
  // ************************************************************************ //
  SkorKaydi2 = class(SkorKaydi)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : YeniSkorKaydi, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/Yilan.Dto
  // ************************************************************************ //
  YeniSkorKaydi2 = class(YeniSkorKaydi)
  private
  published
  end;

  ArrayOfstring = array of string;              { "http://schemas.microsoft.com/2003/10/Serialization/Arrays"[GblCplx] }

  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/IYilans/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : BasicHttpBinding_IYilans
  // service   : Yilans
  // port      : BasicHttpBinding_IYilans
  // URL       : http://yilan.bahayazilim.com/Yilans.svc
  // ************************************************************************ //
  IYilans = interface(IInvokable)
  ['{B56A2806-8F40-15FB-F390-61230E8BD66E}']
    function  SkorListesiGetir: ArrayOfSkorKaydi; stdcall;
    function  SkorKaydiEkle(const aKayit: YeniSkorKaydi): Boolean; stdcall;
    function  MesajListesiGetir: ArrayOfstring; stdcall;
  end;

function GetIYilans(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IYilans;


implementation
  uses SysUtils;

function GetIYilans(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IYilans;
const
  defWSDL = 'http://yilan.bahayazilim.com/Yilans.svc?wsdl';
  defURL  = 'http://yilan.bahayazilim.com/Yilans.svc';
  defSvc  = 'Yilans';
  defPrt  = 'BasicHttpBinding_IYilans';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IYilans);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure SkorKaydi.SetKullanici(Index: Integer; const Astring: string);
begin
  FKullanici := Astring;
  FKullanici_Specified := True;
end;

function SkorKaydi.Kullanici_Specified(Index: Integer): boolean;
begin
  Result := FKullanici_Specified;
end;

procedure SkorKaydi.SetSkor(Index: Integer; const AInteger: Integer);
begin
  FSkor := AInteger;
  FSkor_Specified := True;
end;

function SkorKaydi.Skor_Specified(Index: Integer): boolean;
begin
  Result := FSkor_Specified;
end;

procedure YeniSkorKaydi.SetKey(Index: Integer; const Astring: string);
begin
  FKey := Astring;
  FKey_Specified := True;
end;

function YeniSkorKaydi.Key_Specified(Index: Integer): boolean;
begin
  Result := FKey_Specified;
end;

procedure YeniSkorKaydi.SetKullanici(Index: Integer; const Astring: string);
begin
  FKullanici := Astring;
  FKullanici_Specified := True;
end;

function YeniSkorKaydi.Kullanici_Specified(Index: Integer): boolean;
begin
  Result := FKullanici_Specified;
end;

procedure YeniSkorKaydi.SetSkor(Index: Integer; const AInteger: Integer);
begin
  FSkor := AInteger;
  FSkor_Specified := True;
end;

function YeniSkorKaydi.Skor_Specified(Index: Integer): boolean;
begin
  Result := FSkor_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IYilans), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IYilans), 'http://tempuri.org/IYilans/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IYilans), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfSkorKaydi), 'http://schemas.datacontract.org/2004/07/Yilan.Dto', 'ArrayOfSkorKaydi');
  RemClassRegistry.RegisterXSClass(SkorKaydi, 'http://schemas.datacontract.org/2004/07/Yilan.Dto', 'SkorKaydi');
  RemClassRegistry.RegisterXSClass(YeniSkorKaydi, 'http://schemas.datacontract.org/2004/07/Yilan.Dto', 'YeniSkorKaydi');
  RemClassRegistry.RegisterXSClass(SkorKaydi2, 'http://schemas.datacontract.org/2004/07/Yilan.Dto', 'SkorKaydi2', 'SkorKaydi');
  RemClassRegistry.RegisterXSClass(YeniSkorKaydi2, 'http://schemas.datacontract.org/2004/07/Yilan.Dto', 'YeniSkorKaydi2', 'YeniSkorKaydi');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfstring), 'http://schemas.microsoft.com/2003/10/Serialization/Arrays', 'ArrayOfstring');

end.