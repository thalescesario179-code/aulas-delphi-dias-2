unit UFrmCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Actions, FMX.ActnList, FMX.Layouts;

type
  TFrmCliente = class(TForm)
    TabControl1: TTabControl;
    TabConsulta: TTabItem;
    TabCadastro: TTabItem;
    Rectangle1: TRectangle;
    Image1: TImage;
    Rectangle2: TRectangle;
    Image2: TImage;
    Rectangle3: TRectangle;
    Label1: TLabel;
    EditNome: TEdit;
    Rectangle4: TRectangle;
    Label2: TLabel;
    EditCPF: TEdit;
    Rectangle5: TRectangle;
    Label3: TLabel;
    EditEmail: TEdit;
    Rectangle6: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Rectangle7: TRectangle;
    Label7: TLabel;
    ActionList1: TActionList;
    MudaAba: TChangeTabAction;
    VertCliente: TVertScrollBox;
    ImageReload: TImage;
    procedure Image1Click(Sender: TObject);
    procedure Rectangle7Click(Sender: TObject);
    procedure Rectangle6Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageReloadClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AtualizaCliente; // Ctrl + Shift + C
  end;

var
  FrmCliente: TFrmCliente;

implementation

{$R *.fmx}

uses UDMDados, UFrameCliente;

procedure TFrmCliente.AtualizaCliente;
var
  i: Integer;
  Frame: TFrameCliente;
begin
  // Responsável por atualizar os clientes cadastrados
  VertCliente.BeginUpdate;
  try
    // Limpar os itens do VertScrollBox (remover Frames de clientes)
    for i := VertCliente.Content.ChildrenCount - 1 downto 0 do
      if VertCliente.Content.Children[i] is TFrameCliente then
        VertCliente.Content.Children[i].DisposeOf;

    // Preencher com clientes do banco
    DMDados.QDados.Close;
    DMDados.QDados.SQL.Clear;
    DMDados.QDados.SQL.Add('SELECT * FROM CLIENTE ORDER BY NOME');
    DMDados.QDados.Open;

    while not DMDados.QDados.Eof do
    begin
      Frame := TFrameCliente.Create(nil);
      Frame.LabelCliente.Text := DMDados.QDados.FieldByName('NOME').AsString;
      Frame.LabelEMail.Text := DMDados.QDados.FieldByName('Email').AsString;
      Frame.Align := TAlignLayout.Top;
      // Outras configurações do frame, se necessário

      VertCliente.AddObject(Frame);

      DMDados.QDados.Next;
    end;
  finally
    VertCliente.EndUpdate;
  end;
end;

procedure TFrmCliente.FormShow(Sender: TObject);
begin
  TabControl1.ActiveTab := TabConsulta;
  TabControl1.TabPosition := TTabPosition.None;
  AtualizaCliente; // Atualiza a lista de clientes ao abrir o formulário
end;

procedure TFrmCliente.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmCliente.Image2Click(Sender: TObject);
begin
  MudaAba.Tab := TabConsulta;
  MudaAba.ExecuteTarget(Self);
end;

procedure TFrmCliente.ImageReloadClick(Sender: TObject);
begin
  AtualizaCliente;
end;

procedure TFrmCliente.Rectangle6Click(Sender: TObject);
begin
  // Validações para que o código pare em campos vazios
  if EditNome.Text = '' then
  begin
    ShowMessage('Preencha o nome');
    Exit;
  end;

  if EditEmail.Text = '' then
  begin
    ShowMessage('Preencha o email');
    Exit;
  end;

  if EditCPF.Text = '' then
  begin
    ShowMessage('Preencha o CPF');
    Exit;
  end;

  DMDados.QDados.Close;
  DMDados.QDados.SQL.Clear;
  DMDados.QDados.SQL.Add('INSERT INTO CLIENTE (NOME, EMAIL, CPF) VALUES (:NOME, :EMAIL, :CPF)');
  DMDados.QDados.ParamByName('NOME').Value := EditNome.Text;
  DMDados.QDados.ParamByName('EMAIL').Value := EditEmail.Text;
  DMDados.QDados.ParamByName('CPF').Value := EditCPF.Text;
  DMDados.QDados.ExecSQL;

  // Limpa os campos após inserir
  EditNome.Text := '';
  EditEmail.Text := '';
  EditCPF.Text := '';

  // Volta para aba de consulta e atualiza a lista de clientes
  MudaAba.Tab := TabConsulta;
  MudaAba.ExecuteTarget(Self);
  AtualizaCliente;
end;

procedure TFrmCliente.Rectangle7Click(Sender: TObject);
begin
  MudaAba.Tab := TabCadastro;
  MudaAba.ExecuteTarget(Self);
end;

end.

