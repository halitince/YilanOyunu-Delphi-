program YilanOyunu;

uses
  Forms,
  FrmAna in 'pas\FrmAna.pas' {frmAnaEkran},
  ufrmSkorlar in 'pas\ufrmSkorlar.pas' {frmSkorlar: TFrame},
  MesajIslemleri in 'pas\MesajIslemleri.pas',
  Yilans in 'pas\Yilans.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmAnaEkran, frmAnaEkran);
  Application.Run;
end.
