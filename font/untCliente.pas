unit untCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  Data.DB, Vcl.Mask, Vcl.DBCtrls, Vcl.ImgList, Vcl.ExtCtrls;

type
  TfrmCliente = class(TForm)
    Label1: TLabel;
    dsCliente: TDataSource;
    Label2: TLabel;
    dbCidade: TDBEdit;
    Label3: TLabel;
    dbNome: TDBEdit;
    Label4: TLabel;
    dbEndereco: TDBEdit;
    Label5: TLabel;
    dbTelefone: TDBEdit;
    Label6: TLabel;
    dbCPF: TDBEdit;
    Label7: TLabel;
    dbDataNascimento: TDBEdit;
    Label8: TLabel;
    dbBairro: TDBEdit;
    ToolBar1: TToolBar;
    btnExcluir: TButton;
    btnCadastrar: TButton;
    btnSalvar: TButton;
    btnCancelar: TButton;
    ImageList: TImageList;
    edtCodigo: TEdit;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbCPFExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure dbNomeKeyPress(Sender: TObject; var Key: Char);
    procedure dbTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure dbCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbCPFKeyPress(Sender: TObject; var Key: Char);
    procedure dbEnderecoKeyPress(Sender: TObject; var Key: Char);
    procedure dbBairroKeyPress(Sender: TObject; var Key: Char);
    procedure dsClienteStateChange(Sender: TObject);
    procedure dbDataNascimentoExit(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    erro : integer;
  end;

var

  frmCliente: TfrmCliente;
  n1,n2,n3,n4,n5,n6,n7,n8,n9: integer;
       d1,d2: integer;
       digitado, calculado: string;

implementation

{$R *.dfm}

uses untdm, untCidade, untPrincipal;

procedure TfrmCliente.btnCancelarClick(Sender: TObject);
begin
  dm.tbCliente.Cancel;
  edtCodigo.Enabled := True;
  edtCodigo.SetFocus;
  dbEndereco.Color := clWindow;
  dbNome.Color := clWindow;
  dbTelefone.Color := clWindow;
end;

procedure TfrmCliente.btnCadastrarClick(Sender: TObject);
begin
  dm.tbCliente.Insert;
  edtCodigo.Enabled := False;
  dbNome.SetFocus;
end;

procedure TfrmCliente.btnSalvarClick(Sender: TObject);
begin
    if(dbDataNascimento.text <> '  /  /    ')then
   begin
     try
       strToDate(dbDataNascimento.text);
       erro := 0;
     except on E: Exception do
       erro := 1;
   end;
   end
  else
  begin
    erro := 0;
  end;

  if (dsCliente.State = dsInsert) then
   begin
     dm.qryUltimo.Close;
     dm.qryUltimo.SQL.Clear;
     dm.qryUltimo.SQL.Add('SELECT MAX(ID_CLIENTE) AS ULTIMO FROM CLIENTE');
     dm.qryUltimo.Open;

     dm.tbClienteID_CLIENTE.AsInteger := dm.qryUltimo.FieldByName('ULTIMO').AsInteger + 1;

     if (dbNome.Text = '') or (dbEndereco.Text = '') or (dbTelefone.Text = '(  )    -    ')  then
        begin
          if (dbNome.Text = '') then
             begin
                dbNome.Color :=$7280FA;
                dbNome.SetFocus;
             end;
          if (dbEndereco.Text = '') then
              begin
                dbEndereco.Color :=$7280FA;
                dbEndereco.SetFocus;
              end;
         if dbTelefone.Text = '(  )    -    'then
              begin
                dbTelefone.Color:=$7280FA;
                dbTelefone.SetFocus;
              end;
      exit;
end;

end;
  dm.tbCliente.Post;
  dm.IBTransaction.CommitRetaining;

  edtCodigo.Enabled := True;
  edtCodigo.SetFocus;
end;

procedure TfrmCliente.btnExcluirClick(Sender: TObject);
begin
  dm.tbCliente.Delete;
end;
function Cpf(CPF_Text: string): boolean;
var n1,n2,n3,n4,n5,n6,n7,n8,n9: integer;
       d1,d2: integer;
       digitado, calculado: string;

begin
if ((CPF_Text = '00000000000') or (CPF_Text = '11111111111') or (CPF_Text = '22222222222')
or (CPF_Text = '33333333333') or (CPF_Text = '44444444444') or (CPF_Text = '55555555555')
or (CPF_Text = '66666666666') or (CPF_Text = '77777777777') or (CPF_Text = '88888888888') or
(CPF_Text = '99999999999'))then
begin
   Cpf := false;

end
 else
 begin
 if (trim(CPF_Text).Length= 11) then
 begin

   n1:=StrToInt(CPF_Text[1]);
   n2:=StrToInt(CPF_Text[2]);
   n3:=StrToInt(CPF_Text[3]);
   n4:=StrToInt(CPF_Text[4]);
   n5:=StrToInt(CPF_Text[5]);
   n6:=StrToInt(CPF_Text[6]);
   n7:=StrToInt(CPF_Text[7]);
   n8:=StrToInt(CPF_Text[8]);
   n9:=StrToInt(CPF_Text[9]);
                     d1:=n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1:=11-(d1 mod 11);
   if d1>=10 then d1:=0;
        d2:=d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
    d2:=11-(d2 mod 11);
    if d2>=10 then
       d2:=0;
    calculado:=inttostr(d1)+inttostr(d2);
   digitado:=CPF_Text[10]+CPF_Text[11];
   if calculado=digitado then
       Cpf:=true
   else
       Cpf:=false;
 end;
 end;
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
 dm.tbCliente.Open;

end;

procedure TfrmCliente.dbBairroKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['A'..'Z',#8, #32]) and not (Key in['a'..'z',#8, #32]) and not ( Key in ['0'..'9',#13,#8] )then
  Key := #0;
end;

procedure TfrmCliente.dbCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if not ( Key in ['0'..'9',#13,#8] ) then
   Key := #0;
end;

procedure TfrmCliente.dbCPFExit(Sender: TObject);
begin
  If trim(dbCPF.Text)<>'' Then
    If Cpf(dbCPF.Text)=False Then
    Begin
      dbCPF.SetFocus;
      dbCPF.Color := $7280FA;
      exit;
    End
    else if Cpf(dbCPF.Text) = True then
    begin
      dbCPF.Color := clGreen;
      
    end
    else
    begin
    dbcpf.Color := clWindow;
    
    end;


end;

procedure TfrmCliente.dbCPFKeyPress(Sender: TObject; var Key: Char);
begin
  if not ( Key in ['0'..'9',#13,#8] ) then
   Key := #0;
end;



procedure TfrmCliente.dbDataNascimentoExit(Sender: TObject);
begin
    if dbDataNascimento.Text < '01/01/1916' then
     begin
        if (dbDataNascimento.Text = '  /  /    ') then
          begin
            dbDataNascimento.Color := clWindow;
            exit;
          end;
     dbDataNascimento.Color := $7280FA;
    end;

end;

procedure TfrmCliente.dbEnderecoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['A'..'Z',#8, #32]) and not (Key in['a'..'z',#8, #32]) and not ( Key in ['0'..'9',#13,#8] )then
  Key := #0;
end;

procedure TfrmCliente.dbNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['A'..'Z',#8, #32]) and not (Key in['a'..'z',#8, #32]) then
  Key := #0;
end;

procedure TfrmCliente.dbTelefoneKeyPress(Sender: TObject; var Key: Char);
begin
  if not ( Key in ['0'..'9',#13,#8] ) then
   Key := #0;

end;

procedure TfrmCliente.dsClienteStateChange(Sender: TObject);
begin
  if (dsCliente.State in [dsInsert, dsEdit]) then
   begin
      btnCadastrar.Visible  := False;
      btnSalvar.Visible   := True;
      btnExcluir.Visible  := False;
      btnCancelar.Visible := True;
   end
  else
   begin
    btnCadastrar.Visible  := True;
    btnSalvar.Visible   := False;
    btnExcluir.Visible  := True;
    btnCancelar.Visible := False;
   end;
end;

procedure TfrmCliente.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if not ( Key in ['0'..'9',#13,#8] ) then
   Key := #0;
end;

end.
