unit Form_Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Layouts,
  System.Actions, FMX.ActnList, FMX.Gestures;

type
  TFrm_Login = class(TForm)
    Image1: TImage;
    TabControl: TTabControl;
    TabLogin: TTabItem;
    TabCadastro: TTabItem;
    lblRodape: TLabel;
    Layout1: TLayout;
    Image2: TImage;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    Edit1: TEdit;
    StyleBook1: TStyleBook;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    edtSenha: TEdit;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    lblAcessar: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Layout5: TLayout;
    Image3: TImage;
    Layout6: TLayout;
    Rectangle4: TRectangle;
    edtNomeCad: TEdit;
    Layout7: TLayout;
    Rectangle5: TRectangle;
    edtSenhaCad: TEdit;
    Layout8: TLayout;
    Rectangle6: TRectangle;
    lblCriarNovaConta: TLabel;
    Layout9: TLayout;
    Rectangle7: TRectangle;
    edtEmailCad: TEdit;
    ActionList1: TActionList;
    actTabLogin: TChangeTabAction;
    actTabCadastro: TChangeTabAction;
    GestureManager1: TGestureManager;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblRodapeClick(Sender: TObject);
    procedure lblAcessarClick(Sender: TObject);
    procedure lblCriarNovaContaClick(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Frm_Login: TFrm_Login;

implementation

{$R *.fmx}

uses Form_Principal, ClientModuleUnit1, Global;

procedure TFrm_Login.FormCreate(Sender: TObject);
begin
  TabControl.TabPosition := TTabPosition.None;
end;

procedure TFrm_Login.FormShow(Sender: TObject);
begin
  if TabControl.ActiveTab = TabLogin then
    lblRodape.Text := 'Não tem cadastro? Criar nova conta.'
  else
    lblRodape.Text := 'Já tem uma conta? Faça o login aqui.';

end;

procedure TFrm_Login.lblAcessarClick(Sender: TObject);
begin
  if not ClientModule1.MetodosClient.ValidaLogin(Edit1.Text, edtSenha.Text) then
    ExibirMenssagem('ERRO', 'ALERTA', 'Erro', 'Email ou senha inválidos', 'OK',
      '', $FFDF5447, $FFDF5447)
  else
  begin
    Application.CreateForm(TFrm_Principal, Frm_Principal);
    Frm_Principal.show;
  end;
end;

procedure TFrm_Login.lblCriarNovaContaClick(Sender: TObject);
begin

  try
    if ClientModule1.MetodosClient.ValidaLogin(edtEmailCad.Text, edtSenhaCad.Text) then
    begin
      ExibirMenssagem('ERRO', 'ALERTA', 'Erro', 'Email ou senha já cadastrados',
        'OK', '', $FFDF5447, $FFDF5447);
      actTabLogin.ExecuteTarget(Sender);

    end
    else
    begin

      ClientModule1.MetodosClient.CadastraUsuario(edtEmailCad.Text,
        edtSenhaCad.Text, edtNomeCad.Text);

      Application.CreateForm(TFrm_Principal, Frm_Principal);
      Frm_Principal.show;
    end;
  except
    ExibirMenssagem('ALERTA', 'ALERTA', 'Aviso',
      'Não foi possível fazer o cadastro do usuário.', 'OK', '', $FFABABAB,
      $FFABABAB);
  end;
end;

procedure TFrm_Login.lblRodapeClick(Sender: TObject);
begin
  if TabControl.ActiveTab = TabLogin then
  begin
    actTabCadastro.ExecuteTarget(Sender);
    lblRodape.Text := 'Já tem uma conta? Faça o login aqui.';
  end
  else
  begin
    actTabLogin.ExecuteTarget(Sender);
    lblRodape.Text := 'Não tem cadastro? Criar nova conta.'
  end;
end;

end.
