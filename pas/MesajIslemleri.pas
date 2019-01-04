unit MesajIslemleri;

interface

uses Yilans, SysUtils;

type
  TMesajIslemleri = class(TObject)
  private
  public
    function MesajListesiGetir(): ArrayOfstring ;
  end;

implementation

{ TMesajIslemleri }

function TMesajIslemleri.MesajListesiGetir: ArrayOfstring;
var
  lServis: IYilans;
  lMesajlar: ArrayOfstring;
begin
  lServis := nil;
  try
    lServis := GetIYilans();
    Result := lServis.MesajListesiGetir;
  finally
//    if Assigned(lServis) then
//      FreeAndNil(lServis);
  end;
end;

end.

