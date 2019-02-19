program Pedidos;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form_Inicial in 'Form_Inicial.pas' {Frm_Inicial},
  Form_MenuPrincipal in 'Form_MenuPrincipal.pas' {Frm_MenuPrincipal},
  Form_Login in 'Form_Login.pas' {Frm_Login},
  Form_Principal in 'Form_Principal.pas' {Frm_Principal},
  Form_Teste in 'Form_Teste.pas' {Frm_Teste},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrm_MenuPrincipal, Frm_MenuPrincipal);
  Application.CreateForm(TFrm_Login, Frm_Login);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.CreateForm(TFrm_Inicial, Frm_Inicial);
  Application.Run;
end.
