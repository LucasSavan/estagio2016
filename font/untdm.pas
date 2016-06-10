unit untdm;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBDatabase,
  IBX.IBQuery;

type
  Tdm = class(TDataModule)
    banco: TIBDatabase;
    IBTransaction: TIBTransaction;
    tbCliente: TIBDataSet;
    tbClienteID_CLIENTE: TIntegerField;
    tbClienteNOME_CLI: TIBStringField;
    tbClienteENDERE_O_CLI: TIBStringField;
    tbClienteFONE_CLI: TIBStringField;
    tbClienteCPF_CLI: TIBStringField;
    tbClienteDATA_NASC: TDateField;
    tbClienteDS_BAIRRO: TIBStringField;
    qryUltimo: TIBQuery;
    tbCidade: TIBDataSet;
    tbCidadeID_CIDADE: TIntegerField;
    tbCidadeNOME_CID: TIBStringField;
    tbCidadeUF_CID: TIBStringField;
    tbClienteID_CIDADE: TIntegerField;
    qryExecutar: TIBQuery;
    procedure tbClienteDATA_NASCSetText(Sender: TField; const Text: string);
    procedure tbClienteFONE_CLISetText(Sender: TField; const Text: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untCliente;

{$R *.dfm}

procedure Tdm.tbClienteDATA_NASCSetText(Sender: TField; const Text: string);
begin
    if Text = '  /  /    ' then
    Sender.Clear
  else
   try
     Sender.AsString := Text;
     frmCliente.erro:=0
   except on E: Exception do
     frmCliente.erro :=1;
   end;


   if ((frmCliente.erro = 1) and (Text <> '  /  /    ')) then
   begin
    frmCliente.dbDataNascimento.Color := $7280FA;

    abort;

   end;
end;

procedure Tdm.tbClienteFONE_CLISetText(Sender: TField; const Text: string);
begin
   if Text = '(  )    -    ' then
    Sender.Clear
  else
   try
     Sender.AsString := Text;
     frmCliente.erro:=0
   except on E: Exception do
     frmCliente.erro :=1;
   end;


   if ((frmCliente.erro = 1) and (Text <> '(  )    -    ')) then
   begin
    frmCliente.dbTelefone.Color := $7280FA;

    abort;

   end;
end;

end.
