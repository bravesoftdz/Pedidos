program Pedidos;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form_Inicial in 'Form_Inicial.pas' {Frm_Inicial},
  Form_Login in 'Form_Login.pas' {Frm_Login},
  Form_Principal in 'Form_Principal.pas' {Frm_Principal},
  DataModule in 'DataModule.pas' {dm: TDataModule},
  Form_Produto in 'Form_Produto.pas' {Frm_Produto},
  Form_Editar in 'Form_Editar.pas' {Frm_Editar},
  Form_Mensagem in 'Form_Mensagem.pas' {Frm_Mensagem},
  Form_Cliente in 'Form_Cliente.pas' {Frm_Cliente};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrm_Principal, Frm_Principal);
  Application.CreateForm(TFrm_Login, Frm_Login);
  Application.CreateForm(TFrm_Inicial, Frm_Inicial);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrm_Produto, Frm_Produto);
  Application.CreateForm(TFrm_Editar, Frm_Editar);
  Application.CreateForm(TFrm_Mensagem, Frm_Mensagem);
  Application.CreateForm(TFrm_Cliente, Frm_Cliente);
  Application.Run;
end.
