unit FrmAna;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ImgList, ExtCtrls, ComCtrls, OleCtrls, SHDocVw,
  Buttons, dxGDIPlusClasses, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, Generics.Collections, Generics.Defaults,
  cxGridDBTableView, cxGrid, dxmdaset, ufrmSkorlar, MesajIslemleri, Yilans, System.ImageList;

const
  FGenislik = 30;
  FYukseklik = 30;

type
  TYon = (top, rigth, bottom, left);
  TOzellikler = record
    kalan: SmallInt;
    yon: TYon;
    oncekiyon: TYon;
  end;
  TAlan = record
    x: SmallInt;
    y: SmallInt;
    yon: TYon;
  end;
  TKordinat = record
    x: SmallInt;
    y: SmallInt;
  end;
  TfrmAnaEkran = class(TForm)
    ImageList: TImageList;
    tmrHareket: TTimer;
    lblYem: TLabel;
    DrawGrid: TDrawGrid;
    Label3: TLabel;
    Label4: TLabel;
    lblPuan: TLabel;
    pnlMesaj: TPanel;
    prgOdul: TProgressBar;
    lblOdul: TLabel;
    Label1: TLabel;
    frmSkorlar1: TfrmSkorlar;
    Image1: TImage;
    Image2: TImage;
    lblMesaj: TLabel;
    tmrMesajlar: TTimer;
    Image3: TImage;
    procedure tmrHareketTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frmSkorlar1tmrListeGuncelleTimer(Sender: TObject);
    procedure tmrMesajlarTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FKafa: TAlan;
    FBOyun: TAlan;
    fAktifMEsaj: SmallInt;
    FAktifYon: TYon;
    FYem: TKordinat;
    FOdul: TKordinat;
    lMesajlar: ArrayOfstring;
    FUzunluk: Integer;
    Grid: array[1..30, 1..30] of TOzellikler;
    Ekran: array[1..30, 1..30] of Integer;
    FEkraniTemizle: SmallInt;
    FFYenilen: Integer;
    FFYenilenOdul: Integer;
    procedure EkranCiz2;
    function Ilerlet: Boolean;
    procedure YemOlustur;
    procedure YemekKontrol;
    function AlanBosMu(x, y: Integer): Boolean;
    procedure Yonlendir(aYon: TYon);
    procedure Baslat;
    procedure DuraklatDevamEt;
    procedure OyunBitti;
    function PuanHesapla: Integer;
    function YilanGrafikHesapla(aAlan: TOzellikler; x, y: Integer): Integer;
    function ifthen(aSart: Boolean; aTrueValue, aFalseValue: Variant): Variant;
    procedure SetFYenilen(const Value: Integer);
    function GetFYenilen(): Integer;
    procedure SetFYenilenOdul(const Value: Integer);
    function GetFYenilenOdul(): Integer;
    property FYenilen: Integer read GetFYenilen write SetFYenilen;
    property FYenilenOdul: Integer read GetFYenilenOdul write SetFYenilenOdul;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAnaEkran: TfrmAnaEkran;

implementation

{$R *.dfm}

function TfrmAnaEkran.AlanBosMu(x, y: Integer): Boolean;
begin
  Result := grid[x, y].kalan = 0;
end;

procedure TfrmAnaEkran.Baslat;
var
  I: Integer;
  j: Integer;
begin
  FEkraniTemizle := 2;
  for I := 1 to FGenislik do
    for j := 1 to FYukseklik do
      grid[i, j].kalan := 0;
  FKafa.x := 1;
  FKafa.y := 1;
  FKafa.yon := TYon.rigth;
  FBOyun := FKafa;
  FAktifYon := TYon.rigth;
  YemOlustur;
  FUzunluk := 5;
  FYenilen := 0;
  FYenilenOdul := 0;
  tmrHareket.Tag := 0;
  prgOdul.Visible := False;
  tmrHareket.Interval := 200;
  tmrHareket.Enabled := True;
end;

function TfrmAnaEkran.Ilerlet: Boolean;
var
  lYon: TYon;
begin
  Result := True;
  pnlMesaj.Visible := False;
  lYon := Grid[FKafa.x, FKafa.y].yon;
  case FKafa.yon of
    TYon.top: FKafa.y := FKafa.y - 1;
    TYon.rigth: FKafa.x := FKafa.x + 1;
    TYon.bottom: FKafa.y := FKafa.y + 1;
    TYon.left: FKafa.x := FKafa.x - 1;
  end;
  FKafa.x := FKafa.x + FGenislik;
  FKafa.y := FKafa.y + FYukseklik;
  FKafa.x := ((FKafa.x - 1) mod FGenislik) + 1;
  FKafa.y := ((FKafa.y - 1) mod FYukseklik) + 1;
  Result := AlanBosMu(FKafa.x, FKafa.y);
  Grid[FKafa.x, FKafa.y].kalan := FUzunluk;
  Grid[FKafa.x, FKafa.y].yon := FKafa.yon;
  Grid[FKafa.x, FKafa.y].oncekiyon := FKafa.yon;
  Grid[FBOyun.x, FBOyun.y].yon := FKafa.yon;
  YemekKontrol;
  if prgOdul.Visible then
  begin
    prgOdul.Position := prgOdul.Position + 1;
    if prgOdul.Position >= prgOdul.Max then
      prgOdul.Visible := False;
  end;
  FBOyun := FKafa;
end;

procedure TfrmAnaEkran.EkranCiz2;
var
  I, j, lImageId: Integer;
  lOyunDevam: Boolean;
begin
  lOyunDevam := Ilerlet;
  for I := 1 to FGenislik do
    for j := 1 to FYukseklik do
    begin
      lImageId := 0;
      if (FOdul.x = i) and (FOdul.y = j) and (prgOdul.Visible) then
        lImageId := 2
      else if (FYem.x <> i) or (FYem.y <> j) then
        if grid[i, j].kalan > 0 then
        begin
          lImageId := YilanGrafikHesapla(grid[i, j], i, j);
          grid[i, j].kalan := grid[i, j].kalan - 1;
        end;

      if (Ekran[i, j] <> lImageId) or (FEkraniTemizle > 0) then
      begin
        ImageList.Draw(DrawGrid.Canvas, i * 16 - 16, j * 16 - 16, lImageId, True);
        Ekran[i, j] := lImageId
      end;
    end;
  if FEkraniTemizle > 0 then
    FEkraniTemizle := FEkraniTemizle - 1;
  ImageList.Draw(DrawGrid.Canvas, FYem.x * 16 - 16, FYem.y * 16 - 16, 1, True);
  lblYem.Caption := IntToStr(FYenilen);
  lblOdul.Caption := IntToStr(FYenilenOdul);
  lblPuan.Caption := IntToStr(PuanHesapla);
  if not lOyunDevam then
    OyunBitti;
end;

function TfrmAnaEkran.YilanGrafikHesapla(aAlan: TOzellikler; x, y: Integer): Integer;
begin
  if aAlan.kalan = 1 then
    Result := 7 + Ord(aAlan.yon)
  else if (FKafa.x = x) and (FKafa.y = y) then
    Result := 3 + Ord(aAlan.yon)
  else if aAlan.oncekiyon = aAlan.yon then
    Result := ifthen(aAlan.yon in [tyon.top, TYon.bottom], 11, 12)
  else
    case aAlan.yon of
      TYon.top: Result := ifthen(aAlan.oncekiyon = TYon.left, 14, 13);
      TYon.rigth: Result := ifthen(aAlan.oncekiyon = TYon.top, 15, 14);
      TYon.bottom: Result := ifthen(aAlan.oncekiyon = TYon.left, 15, 16);
      TYon.left: Result := ifthen(aAlan.oncekiyon = TYon.top, 16, 13);
    end;
end;

procedure TfrmAnaEkran.FormCreate(Sender: TObject);
begin
  fAktifMEsaj := 0;
end;

procedure TfrmAnaEkran.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_LEFT: Yonlendir(tyon.left);
    VK_UP: Yonlendir(tyon.top);
    VK_RIGHT: Yonlendir(tyon.rigth);
    VK_DOWN: Yonlendir(tyon.bottom);
    Ord('B'): Baslat;
    Ord('D'), VK_SPACE: DuraklatDevamEt;
    VK_ESCAPE:
      begin
        DuraklatDevamEt;
        Application.Minimize;
      end;
  end;
end;

procedure TfrmAnaEkran.frmSkorlar1tmrListeGuncelleTimer(Sender: TObject);
begin
  frmSkorlar1.tmrListeGuncelleTimer(Sender);
end;

procedure TfrmAnaEkran.OyunBitti;
var
  lSkor, lSkor2: Integer;
  lKullanici: string;
  function KullaniciAdi: string;
  var
    memor: array[0..255] of char;
    memSize: DWORD;
  begin
    memSize := sizeOf(memor);
    GetUserName(@memor, memSize);
    Result := memor;
  end;
begin
  tmrHareket.Enabled := False;
  tmrMesajlar.Enabled := False;
  tmrHareket.Tag := 1;
  pnlMesaj.Caption := 'Oyun Bitti';
  pnlMesaj.Visible := True;
  lSkor := PuanHesapla;
  lSkor2 := (lSkor + 4) * 2;
  lKullanici := InputBox('Kullanici Adýný Giriniz', 'Skorunuz: ' + IntToStr(lSkor), KullaniciAdi);
  if lSkor2 = ((lSkor + 4) * 2) then
    if not TfrmSkorlar(frmSkorlar1).YeniSkorKaydet(lKullanici, lSkor) then
      TfrmSkorlar(frmSkorlar1).YeniSkorKaydet(lKullanici, lSkor);
end;

function TfrmAnaEkran.PuanHesapla: Integer;
begin
  Result := FYenilen * 3 + FYenilenOdul * 12;
end;

procedure TfrmAnaEkran.SetFYenilen(const Value: Integer);
begin
  FFYenilen := Value + 7;
end;

function TfrmAnaEkran.GetFYenilen: Integer;
begin
  Result := FFYenilen - 7;
end;

function TfrmAnaEkran.GetFYenilenOdul: Integer;
begin
  Result := FFYenilenOdul - 9;
end;

procedure TfrmAnaEkran.SetFYenilenOdul(const Value: Integer);
begin
  FFYenilenOdul := Value + 9;
end;

procedure TfrmAnaEkran.DuraklatDevamEt;
begin
  tmrHareket.Enabled := (not tmrHareket.Enabled) and (tmrHareket.Tag = 0);
  if (not tmrHareket.Enabled) and (not pnlMesaj.Visible) then
  begin
    pnlMesaj.Caption := 'Oyun Duraklatýldý';
    pnlMesaj.Visible := True;
  end;
  FEkraniTemizle := 2;
end;

function TfrmAnaEkran.ifthen(aSart: Boolean; aTrueValue, aFalseValue: Variant): Variant;
begin
  if aSart then
    Result := aTrueValue
  else
    Result := aFalseValue;
end;

procedure TfrmAnaEkran.tmrHareketTimer(Sender: TObject);
begin
  //  Timer1.Enabled := False;
  EkranCiz2;
  FAktifYon := FKafa.yon;
end;

procedure TfrmAnaEkran.tmrMesajlarTimer(Sender: TObject);
begin
  try
    if tmrMesajlar.Interval = 2000 then
      with TMesajIslemleri.Create do
        try
          lMesajlar := MesajListesiGetir;
        finally
          Free;
        end;
    tmrMesajlar.Enabled := Length(lMesajlar) > 0;
    if tmrMesajlar.Enabled then
    begin
      lblMesaj.Caption := lMesajlar[fAktifMEsaj];
      fAktifMEsaj := (fAktifMEsaj + 1) mod Length(lMesajlar);
    end;
    tmrMesajlar.Interval := 10000;
  except
    tmrMesajlar.Enabled := false;
  end;
end;

procedure TfrmAnaEkran.YemekKontrol;
var
  I, j: Integer;
  OdulMu: Boolean;
begin
  OdulMu := (FKafa.x = FOdul.x) and (FKafa.y = FOdul.y) and prgOdul.Visible;
  if (((FKafa.x = FYem.x) and (FKafa.y = FYem.y)) or OdulMu) then
  begin
    for I := 1 to FGenislik do
      for j := 1 to FYukseklik do
        if grid[i, j].kalan > 0 then
          grid[i, j].kalan := grid[i, j].kalan + 1;
    FUzunluk := FUzunluk + 1;
    if OdulMu then
    begin
      FYenilenOdul := FYenilenOdul + 1;
      prgOdul.Position := prgOdul.Max;
    end;
    FYenilen := FYenilen + 1;
    if tmrHareket.Interval > 60 then
    begin
      tmrHareket.Interval := tmrHareket.Interval - 5;
      tmrHareket.Enabled := False;
      tmrHareket.Enabled := True;
    end;
    if True then
      if grid[FYem.x, FYem.y].kalan = 0 then
        Ekran[FYem.x, FYem.y] := -1;
    YemOlustur;
  end;
end;

procedure TfrmAnaEkran.YemOlustur;
begin
  if (FYenilen > 0) and ((FYenilen mod 10) = 0) then
  begin
    prgOdul.Visible := True;
    repeat
      FOdul.x := Random(FGenislik - 1) + 1;
      FOdul.y := Random(FYukseklik - 1) + 1;
    until AlanBosMu(FOdul.x, FOdul.y);
    prgOdul.Position := 0;
    prgOdul.Max := 75;
  end;

  repeat
    FYem.x := Random(FGenislik - 1) + 1;
    FYem.y := Random(FYukseklik - 1) + 1;
  until AlanBosMu(FYem.x, FYem.y);
end;

procedure TfrmAnaEkran.Yonlendir(aYon: TYon);
begin
  if (((ord(FAktifYon) + 4) - ord(aYon)) mod 2) = 1 then
    FKafa.yon := TYon(ord(aYon));
  if not tmrHareket.Enabled then
    DuraklatDevamEt;
end;

end.

