unit ufrmSkorlar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxmdaset, DateUtils,
  cxCurrencyEdit, ExtCtrls, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmSkorlar = class(TFrame)
    Skorlar: TdxMemData;
    Skorlarkullanici: TStringField;
    SkorD: TDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1DBTableView1RecId: TcxGridDBColumn;
    cxGrid1DBTableView1kullanici: TcxGridDBColumn;
    cxGrid1DBTableView1skor: TcxGridDBColumn;
    Skorlarskor: TIntegerField;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet;
    tmrListeGuncelle: TTimer;
    procedure tmrListeGuncelleTimer(Sender: TObject);
  private
    procedure _ListeyiGuncelle();
    { Private declarations }
  public
    procedure ListeyiGuncelle();
    function YeniSkorKaydet(aKullanici: string; aSkor: integer): Boolean;
    { Public declarations }
  end;

implementation

uses Yilans;

{$R *.dfm}

{ TfrmSkorlar }

procedure TfrmSkorlar.ListeyiGuncelle;
begin
  _ListeyiGuncelle;
end;

procedure TfrmSkorlar.tmrListeGuncelleTimer(Sender: TObject);
begin
  tmrListeGuncelle.Enabled := False;
  _ListeyiGuncelle;
end;

procedure TfrmSkorlar._ListeyiGuncelle;
var
  lServis: IYilans;
  lSkorlar: ArrayOfSkorKaydi;
  I: Integer;
begin
  Exit; // SERVÝS DEVREDIÞI
  lServis := nil;
  try
    try
      Skorlar.Close;
      Skorlar.Open;
      Skorlar.Delete;
      lServis := GetIYilans();
      lSkorlar := lServis.SkorListesiGetir;

      Skorlar.DisableControls;
      for I := 0 to Length(lSkorlar) - 1 do
      begin
        Skorlar.Append;
        Skorlarkullanici.AsString := lSkorlar[i].Kullanici;
        Skorlarskor.AsInteger := lSkorlar[i].Skor;
        Skorlar.Post;
      end;
    except
    end;
  finally
    Skorlar.EnableControls;
  end;
end;

function TfrmSkorlar.YeniSkorKaydet(aKullanici: string; aSkor: integer): Boolean;
var
  lServis: IYilans;
  lSkor: YeniSkorKaydi;
  lSaniye, lSaat: Integer;
begin
  Result := true;
  Exit; // SERVÝS DEVREDIÞI

  lSkor := nil;
  Result := False;
  try
    try
      lSaat := HourOf(Now);
      lSaniye := SecondOf(Now);

      lSkor := YeniSkorKaydi.Create;
      lSkor.Kullanici := aKullanici;
      lSkor.Skor := aSkor;
      lSkor.Key := IntToStr(((((lSaniye + 100) + (lSaat + 57)) * 1000) + (lSaniye + 100) + (lSkor.Skor * 2)) + 1);

      lServis := GetIYilans();

      Result := lServis.SkorKaydiEkle(lSkor);
      if Result then
        ListeyiGuncelle;
    except
      ShowMessage('Ups! Bir Hata Oluþtu!');
    end;
  finally
    if Assigned(lSkor) then
      FreeAndNil(lSkor);
  end;
end;

end.

