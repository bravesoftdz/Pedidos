unit Form_Cliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrm_Cliente = class(TForm)
    Rectangle1: TRectangle;
    Label1: TLabel;
    img_salvar: TImage;
    img_voltar: TImage;
    Layout2: TLayout;
    Label3: TLabel;
    Image2: TImage;
    lbl_endereco: TLabel;
    Line1: TLine;
    Layout7: TLayout;
    img_excluir: TImage;
    Layout1: TLayout;
    Label2: TLabel;
    Image1: TImage;
    lbl_obs: TLabel;
    Line2: TLine;
    Layout3: TLayout;
    Label5: TLabel;
    Image3: TImage;
    lbl_cnpj: TLabel;
    Line3: TLine;
    Layout4: TLayout;
    Label7: TLabel;
    Image4: TImage;
    lbl_email: TLabel;
    Line4: TLine;
    Layout5: TLayout;
    Label9: TLabel;
    Image5: TImage;
    lbl_fone: TLabel;
    Line5: TLine;
    Layout6: TLayout;
    Label11: TLabel;
    Image6: TImage;
    lbl_nome: TLabel;
    Line6: TLine;
    VertScrollBox1: TVertScrollBox;
    procedure lbl_cnpjClick(Sender: TObject);
    procedure lbl_nomeClick(Sender: TObject);
    procedure lbl_foneClick(Sender: TObject);
    procedure lbl_emailClick(Sender: TObject);
    procedure lbl_enderecoClick(Sender: TObject);
    procedure lbl_obsClick(Sender: TObject);
    procedure img_excluirClick(Sender: TObject);
    procedure img_voltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure img_salvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    modo : string;
    cod_cliente : integer;
    ind_cancelar : string;
  end;

var
  Frm_Cliente: TFrm_Cliente;

implementation

{$R *.fmx}

uses Form_Principal, Form_Editar, DataModule, Form_Mensagem;

procedure TFrm_Cliente.FormShow(Sender: TObject);
begin
        ind_cancelar := 'S';
end;

procedure TFrm_Cliente.img_excluirClick(Sender: TObject);
begin
        try
                // Consistencia se pode excluir o cliente...
                dm.qry_cliente.Active := false;
                dm.qry_cliente.sql.Clear;
                dm.qry_cliente.sql.Add('SELECT * FROM TAB_PEDIDO WHERE COD_CLIENTE = :COD_CLIENTE');
                dm.qry_cliente.Params.ParamByName('COD_CLIENTE').Value := cod_cliente;
                dm.qry_cliente.Active := true;

                if dm.qry_cliente.RecordCount > 0 then
                begin
                        Frm_Principal.Exibir_Mensagem('ALERTA', 'ALERTA', 'Aviso',
                                                      'Esse cliente já está sendo usado um pedido',
                                                      'OK', '', $FFABABAB, $FFABABAB);
                        Frm_Mensagem.Show;
                        exit;
                end;




                // Mensagem de confirmacao...
                Frm_Principal.Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Exclusão',
                                              'Confirma a exclusão do cliente?',
                                              'Sim', 'Não', $FFdf5447, $FFABABAB);
                Frm_Mensagem.ShowModal(procedure (ModalResult: TModalResult)
                                       begin
                                                if Frm_Mensagem.retorno = '1' then
                                                begin
                                                        // Exclusao do cliente...
                                                        dm.qry_cliente.Active := false;
                                                        dm.qry_cliente.sql.Clear;
                                                        dm.qry_cliente.sql.Add('DELETE FROM TAB_CLIENTE WHERE COD_CLIENTE = :COD_CLIENTE');
                                                        dm.qry_cliente.Params.ParamByName('COD_CLIENTE').Value := cod_cliente;
                                                        dm.qry_cliente.ExecSQL;

                                                        ind_cancelar := 'N';
                                                        close;
                                                end;
                                       end);

        Except on ex:exception do
        begin
                Frm_Principal.Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', ex.Message, 'OK', '', $FFdf5447, $FFdf5447);
                Frm_Mensagem.Show;
        end;
        end;
end;

procedure TFrm_Cliente.img_salvarClick(Sender: TObject);
begin
        try
                dm.qry_cliente.Active := false;
                dm.qry_cliente.SQL.Clear;

                if modo = 'I' then
                begin
                        dm.qry_geral.Active := false;
                        dm.qry_geral.SQL.Clear;
                        dm.qry_geral.sql.Add('SELECT IFNULL(MAX(COD_CLIENTE), 0) AS COD_CLIENTE FROM TAB_CLIENTE ');
                        dm.qry_geral.Active := true;

                        cod_cliente := dm.qry_geral.FieldByName('COD_CLIENTE').AsInteger + 1;

                        dm.qry_cliente.sql.Add('INSERT INTO TAB_CLIENTE(COD_CLIENTE, CNPJ_CPF, NOME, FONE, EMAIL, ENDERECO, OBS)');
                        dm.qry_cliente.sql.Add('VALUES(:COD_CLIENTE, :CNPJ_CPF, :NOME, :FONE, :EMAIL, :ENDERECO, :OBS)');
                end
                else
                begin
                        dm.qry_cliente.sql.Add('UPDATE TAB_CLIENTE SET CNPJ_CPF = :CNPJ_CPF,');
                        dm.qry_cliente.sql.Add('NOME=:NOME, FONE=:FONE, EMAIL=:EMAIL, ENDERECO=:ENDERECO, OBS=:OBS');
                        dm.qry_cliente.sql.Add('WHERE COD_CLIENTE = :COD_CLIENTE');
                end;

                dm.qry_cliente.Params.ParamByName('COD_CLIENTE').Value := cod_cliente;
                dm.qry_cliente.Params.ParamByName('CNPJ_CPF').Value := lbl_cnpj.Text;
                dm.qry_cliente.Params.ParamByName('NOME').Value := lbl_nome.Text;
                dm.qry_cliente.Params.ParamByName('FONE').Value := lbl_fone.Text;
                dm.qry_cliente.Params.ParamByName('EMAIL').Value := lbl_email.Text;
                dm.qry_cliente.Params.ParamByName('ENDERECO').Value := lbl_endereco.Text;
                dm.qry_cliente.Params.ParamByName('OBS').Value := lbl_obs.Text;
                dm.qry_cliente.ExecSQL;

                ind_cancelar := 'N';
                close;

        Except on ex:exception do
        begin
                Frm_Principal.Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', ex.Message, 'OK', '', $FFdf5447, $FFdf5447);
                Frm_Mensagem.Show;
        end;
        end;
end;

procedure TFrm_Cliente.img_voltarClick(Sender: TObject);
begin
        ind_cancelar := 'S';
        close;
end;

procedure TFrm_Cliente.lbl_cnpjClick(Sender: TObject);
begin
        Frm_Principal.Editar_Campo('EDIT', 'CNPJ / CPF', 'Informe CNPJ ou CPF', 'S', lbl_cnpj.Text, 20);
        Frm_Editar.ShowModal(procedure(ModalResult: TModalResult)
                             begin
                                    if Frm_Editar.ind_cancelar = 'N' then
                                            lbl_cnpj.Text := Frm_Editar.valor_selecionado;
                             end);
end;

procedure TFrm_Cliente.lbl_emailClick(Sender: TObject);
begin
        Frm_Principal.Editar_Campo('EDIT', 'Email', 'Email do cliente', 'N', lbl_email.Text, 100);
        Frm_Editar.ShowModal(procedure(ModalResult: TModalResult)
                             begin
                                    if Frm_Editar.ind_cancelar = 'N' then
                                            lbl_email.Text := Frm_Editar.valor_selecionado;
                             end);
end;

procedure TFrm_Cliente.lbl_enderecoClick(Sender: TObject);
begin
        Frm_Principal.Editar_Campo('MEMO', 'Endereço Completo', '', 'S', lbl_endereco.Text, 500);
        Frm_Editar.ShowModal(procedure(ModalResult: TModalResult)
                             begin
                                    if Frm_Editar.ind_cancelar = 'N' then
                                            lbl_endereco.Text := Frm_Editar.valor_selecionado;
                             end);
end;

procedure TFrm_Cliente.lbl_foneClick(Sender: TObject);
begin
        Frm_Principal.Editar_Campo('EDIT', 'Telefone', 'Telefone do cliente', 'S', lbl_fone.Text,20);
        Frm_Editar.ShowModal(procedure(ModalResult: TModalResult)
                             begin
                                    if Frm_Editar.ind_cancelar = 'N' then
                                            lbl_fone.Text := Frm_Editar.valor_selecionado;
                             end);
end;

procedure TFrm_Cliente.lbl_nomeClick(Sender: TObject);
begin
        Frm_Principal.Editar_Campo('EDIT', 'Nome', 'Nome do cliente', 'S', lbl_nome.Text, 100);
        Frm_Editar.ShowModal(procedure(ModalResult: TModalResult)
                             begin
                                    if Frm_Editar.ind_cancelar = 'N' then
                                            lbl_nome.Text := Frm_Editar.valor_selecionado;
                             end);
end;

procedure TFrm_Cliente.lbl_obsClick(Sender: TObject);
begin
        Frm_Principal.Editar_Campo('MEMO', 'Observações', '', 'N', lbl_obs.Text, 1000);
        Frm_Editar.ShowModal(procedure(ModalResult: TModalResult)
                             begin
                                    if Frm_Editar.ind_cancelar = 'N' then
                                            lbl_obs.Text := Frm_Editar.valor_selecionado;
                             end);
end;

end.
