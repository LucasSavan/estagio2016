program estagio;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {FrmPrincipal},
  untdm in 'untdm.pas' {dm: TDataModule},
  untCidade in 'untCidade.pas' {frmCidade},
  untCliente in 'untCliente.pas' {frmCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmCidade, frmCidade);
  Application.CreateForm(TfrmCliente, frmCliente);
  Application.Run;
end.
