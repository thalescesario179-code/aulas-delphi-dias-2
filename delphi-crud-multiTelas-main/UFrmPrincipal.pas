unit UFrmPrincipal;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Objects;
type
  TFrmPrincipal = class(TForm)
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    V: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    TabControl: TTabControl;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  FrmPrincipal: TFrmPrincipal;
implementation
{$R *.fmx}
uses UFrmCliente;

procedure TFrmPrincipal.Image1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCliente, FrmCliente);
  FrmCliente.Show;
end;

procedure TFrmPrincipal.Image2Click(Sender: TObject);
begin
 Close;
end;

end.
