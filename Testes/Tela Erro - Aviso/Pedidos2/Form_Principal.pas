unit Form_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  System.ImageList, FMX.ImgList, FMX.Layouts, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.ScrollBox, FMX.Memo;

type
  TFrm_Principal = class(TForm)
    StyleBook1: TStyleBook;
    layout_tabs: TLayout;
    TabPedido: TLayout;
    TabCliente: TLayout;
    TabNotificacao: TLayout;
    TabMais: TLayout;
    lbl_tab_pedido: TLabel;
    img_tab_pedido: TImage;
    lbl_tab_cliente: TLabel;
    lbl_tab_notificacao: TLabel;
    lbl_tab_mais: TLabel;
    img_tab_cliente: TImage;
    img_tab_notificacao: TImage;
    img_tab_mais: TImage;
    circle_notificacao: TCircle;
    lbl_qtd_notif: TLabel;
    tab_pedido: TLayout;
    toolbar: TRectangle;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    edt_busca: TEdit;
    lv_pedido: TListView;
    Label2: TLabel;
    Image1: TImage;
    tab_cliente: TLayout;
    Rectangle1: TRectangle;
    Label3: TLabel;
    img_cad_cliente: TImage;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    edt_busca_cliente: TEdit;
    lv_cliente: TListView;
    tab_notificacao: TLayout;
    Rectangle4: TRectangle;
    Label4: TLabel;
    lv_notificacao: TListView;
    tab_mais: TLayout;
    Rectangle5: TRectangle;
    Label5: TLabel;
    Layout1: TLayout;
    Layout3: TLayout;
    img_cad_produto: TImage;
    lbl_cad_produto: TLabel;
    Image4: TImage;
    Label7: TLabel;
    Layout5: TLayout;
    Image5: TImage;
    Label8: TLabel;
    Image6: TImage;
    Label9: TLabel;
    Image7: TImage;
    Label10: TLabel;
    img_entregue: TImage;
    img_sinc: TImage;
    img_nao_sinc: TImage;
    img_busca_pedido: TImage;
    img_busca_cliente: TImage;
    img_no_cliente: TImage;
    img_no_notificacao: TImage;
    img_no_pedido: TImage;
    layout_menu_notif: TLayout;
    Rectangle6: TRectangle;
    Layout6: TLayout;
    Rectangle7: TRectangle;
    lbl_menu_lida: TLabel;
    lbl_menu_excluir: TLabel;
    Line4: TLine;
    Layout7: TLayout;
    Rectangle8: TRectangle;
    lbl_menu_cancelar: TLabel;
    img_mais_notif: TImage;
    procedure img_tab_pedidoClick(Sender: TObject);
    procedure img_tab_clienteClick(Sender: TObject);
    procedure img_tab_notificacaoClick(Sender: TObject);
    procedure img_tab_maisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure img_busca_pedidoClick(Sender: TObject);
    procedure img_busca_clienteClick(Sender: TObject);
    procedure lv_notificacaoUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_cad_produtoClick(Sender: TObject);
    procedure Editar_Campo(tipo_campo, titulo, texto_prompt, ind_obrigatorio,
                           texto_padrao: string; tam_maximo: integer);
    procedure Exibir_Mensagem(icone, tipo_mensagem, titulo, texto_msg,
                texto_btn1, texto_btn2 : string; cor_btn1, cor_btn2 : Cardinal);
    procedure img_cad_clienteClick(Sender: TObject);
    procedure lv_clienteItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lbl_menu_cancelarClick(Sender: TObject);
    procedure lv_notificacaoItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure lbl_menu_lidaClick(Sender: TObject);
    procedure lbl_menu_excluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Principal: TFrm_Principal;

implementation

{$R *.fmx}

uses DataModule, Form_Produto, Form_Editar, Form_Mensagem, Form_Cliente;

procedure TFrm_Principal.Editar_Campo(tipo_campo, titulo, texto_prompt, ind_obrigatorio, texto_padrao: string; tam_maximo: integer);
begin
        if NOT Assigned(Frm_Editar) then
                Application.CreateForm(TFrm_Editar, Frm_Editar);

        with Frm_Editar do
        begin
                lbl_titulo.Text := titulo;
                Frm_Editar.ind_campo_obrigatorio := ind_obrigatorio;
                Frm_Editar.tipo := tipo_campo;

                if tipo_campo = 'EDIT' then
                begin
                        edt_texto.TextPrompt := texto_prompt;
                        edt_texto.MaxLength := tam_maximo;
                        edt_texto.Text := texto_padrao;
                end;

                if tipo_campo = 'MEMO' then
                begin
                        m_memo.MaxLength := tam_maximo;
                        m_memo.lines.Text := texto_padrao;
                end;

                if tipo_campo = 'VALOR' then
                        lbl_valor.Text := texto_padrao;


                //Frm_Editar.Show;
        end;
end;


{
icone: ALERTA, PERGUNTA, ERRO ou SUCESSO
tipo_mensagem: ALERTA ou PERGUNTA
cor: exemplo... $FFA0A0A0
}
procedure TFrm_Principal.Exibir_Mensagem(icone, tipo_mensagem, titulo, texto_msg, texto_btn1, texto_btn2 : string; cor_btn1, cor_btn2 : Cardinal);
begin
        if NOT Assigned(Frm_Mensagem) then
                Application.CreateForm(TFrm_Mensagem, Frm_Mensagem);

        with Frm_Mensagem do
        begin
                // Icone...
                if icone = 'ALERTA' then
                        img_icone.Bitmap := img_alerta.Bitmap
                else if icone = 'PERGUNTA' then
                        img_icone.Bitmap := img_pergunta.Bitmap
                else if icone = 'ERRO' then
                        img_icone.Bitmap := img_erro.Bitmap
                else
                        img_icone.Bitmap := img_sucesso.Bitmap;

                // Tipo mensagem...
                rect_btn2.Visible := false;
                if tipo_mensagem = 'PERGUNTA' then
                begin
                        rect_btn1.Width := 102;
                        rect_btn2.Width := 102;
                        rect_btn1.Align := TAlignLayout.Left;
                        rect_btn2.Align := TAlignLayout.Right;

                        rect_btn2.Visible := true;
                end
                else
                begin
                        rect_btn1.Width := 160;
                        rect_btn1.Align := TAlignLayout.Center;
                end;

                // Textos da Mensagem...
                lbl_titulo.Text := titulo;
                lbl_msg.Text := texto_msg;

                // Textos Botoes...
                lbl_btn1.Text := texto_btn1;
                lbl_btn2.Text := texto_btn2;

                // Cor Botoes...
                rect_btn1.Fill.Color := cor_btn1;
                rect_btn2.Fill.Color := cor_btn2;
        end;
end;

procedure Seleciona_Tab(tab : integer);
begin
        with Frm_Principal do
        begin
                img_tab_pedido.Opacity := 0.2;
                img_tab_cliente.Opacity := 0.2;
                img_tab_notificacao.Opacity := 0.2;
                img_tab_mais.Opacity := 0.2;

                lbl_tab_pedido.FontColor := $FFA0A0A0;
                lbl_tab_cliente.FontColor := $FFA0A0A0;
                lbl_tab_notificacao.FontColor := $FFA0A0A0;
                lbl_tab_mais.FontColor := $FFA0A0A0;

                tab_pedido.Visible := false;
                tab_cliente.Visible := false;
                tab_notificacao.Visible := false;
                tab_mais.Visible := false;


                if tab = 1 then
                begin
                        img_tab_pedido.Opacity := 1;
                        lbl_tab_pedido.FontColor := $FF4D7EC3;
                        tab_pedido.Visible := true;
                end;
                if tab = 2 then
                begin
                        img_tab_cliente.Opacity := 1;
                        lbl_tab_cliente.FontColor := $FF4D7EC3;
                        tab_cliente.Visible := true;
                end;
                if tab = 3 then
                begin
                        img_tab_notificacao.Opacity := 1;
                        lbl_tab_notificacao.FontColor := $FF4D7EC3;
                        tab_notificacao.Visible := true;
                end;
                if tab = 4 then
                begin
                        img_tab_mais.Opacity := 1;
                        lbl_tab_mais.FontColor := $FF4D7EC3;
                        tab_mais.Visible := true;
                end;
        end;
end;

procedure Add_Pedido_Lista(pedido, cliente, data_pedido, valor, ind_entregue, ind_sinc : string);
var
        item : TListViewItem;
        txt : TListItemText;
        img : TListItemImage;
begin
        with Frm_Principal do
        begin
                item := lv_pedido.items.add;

                with item do
                begin
                        // Numero Pedido...
                        txt := TListItemText(Objects.FindDrawable('Text1'));

                        if ind_sinc = 'S' then
                                txt.Text := 'Pedido #' + pedido
                        else
                                txt.Text := 'Orçamento';

                        // Cliente...
                        txt := TListItemText(Objects.FindDrawable('Text2'));
                        txt.Text := cliente;

                        // Data Pedido...
                        txt := TListItemText(Objects.FindDrawable('Text3'));
                        txt.Text := data_pedido;

                        // valor...
                        txt := TListItemText(Objects.FindDrawable('Text4'));
                        txt.Text := 'R$ ' + valor;

                        // Status...
                        img := TListItemImage(Objects.FindDrawable('Image5'));

                        if ind_sinc = 'S' then
                                img.Bitmap := img_sinc.Bitmap
                        else
                                img.Bitmap := img_nao_sinc.Bitmap;

                        // Entregue...
                        img := TListItemImage(Objects.FindDrawable('Image6'));

                        if ind_entregue = 'S' then
                        begin
                                img.Visible := true;
                                img.Bitmap := img_entregue.Bitmap;
                        end
                        else
                                img.Visible := false;


                end;
        end;
end;

procedure Add_Cliente_Lista(cod_cliente, nome, cidade, data_ult_pedido, valor_ult_pedido : string);
var
        item : TListViewItem;
        txt : TListItemText;
begin
        with Frm_Principal do
        begin
                item := lv_cliente.items.add;

                with item do
                begin
                        // Nome...
                        txt := TListItemText(Objects.FindDrawable('Text1'));
                        txt.Text := nome;
                        txt.TagString := cod_cliente;


                        // Cidade...
                        txt := TListItemText(Objects.FindDrawable('Text2'));
                        txt.Text := cidade;


                        // Data Ult. Pedido...
                        txt := TListItemText(Objects.FindDrawable('Text3'));

                        if data_ult_pedido = '30/12/1899' then
                                txt.Text := 'Última Compra: Nenhuma'
                        else
                                txt.Text := 'Última Compra: ' + data_ult_pedido + ' - R$ ' + valor_ult_pedido;
                end;
        end;
end;

procedure Add_Notificacao_Lista(cod_notificacao, data_notificacao, titulo, texto, ind_lido, ind_destaque : string);
var
        item : TListViewItem;
        txt : TListItemText;
        img : TListItemImage;
begin
        with Frm_Principal do
        begin
                item := lv_notificacao.items.add;

                with item do
                begin
                        // Titulo...
                        txt := TListItemText(Objects.FindDrawable('Text1'));
                        txt.Text := titulo;
                        txt.TagString := ind_destaque;

                        if ind_destaque = 'S' then
                        begin
                                txt.Font.Style := [TFontStyle.fsBold];
                                txt.TextColor := $FFE25E5E;
                        end;


                        // Texto...
                        txt := TListItemText(Objects.FindDrawable('Text2'));
                        txt.Text := texto;
                        txt.WordWrap := true;

                        if ind_lido = 'N' then
                                txt.Font.Style := [TFontStyle.fsBold];


                        // Data...
                        txt := TListItemText(Objects.FindDrawable('Text3'));
                        txt.Text := data_notificacao;


                        // Imagem icone mais...
                        img := TListItemImage(Objects.FindDrawable('Image4'));
                        img.Bitmap := img_mais_notif.Bitmap;
                        img.TagFloat := cod_notificacao.ToDouble();
                        img.TagString := ind_lido;
                end;
        end;
end;

procedure Consulta_Pedido(busca : string; pagina : integer);
var
        x : integer;
begin
        try
                dm.qry_pedido.Active := false;
                dm.qry_pedido.SQL.Clear;
                dm.qry_pedido.sql.Add('SELECT P.*, C.NOME FROM TAB_PEDIDO P ');
                dm.qry_pedido.sql.Add('JOIN TAB_CLIENTE C ON (C.COD_CLIENTE = P.COD_CLIENTE)');

                if busca <> '' then
                begin
                        dm.qry_pedido.SQL.Add('WHERE (C.NOME LIKE ''%'' || :BUSCA || ''%'' ');
                        dm.qry_pedido.SQL.Add('       OR P.PEDIDO = :PEDIDO) ');
                        dm.qry_pedido.Params.ParamByName('BUSCA').Value := busca;
                        dm.qry_pedido.Params.ParamByName('PEDIDO').Value := busca;
                end;

                dm.qry_pedido.Active := true;


                // Limpar listagem...
                Frm_Principal.img_no_pedido.Visible := false;
                Frm_Principal.lv_pedido.Items.Clear;
                Frm_Principal.lv_pedido.BeginUpdate;


                // Loop nos pedidos...
                for x := 1 to dm.qry_pedido.RecordCount do
                begin
                        Add_Pedido_Lista(dm.qry_pedido.FieldByName('PEDIDO').AsString,
                                         dm.qry_pedido.FieldByName('NOME').AsString,
                                         FormatDateTime('dd/MM/yyyy', dm.qry_pedido.FieldByName('DATA').AsDateTime),
                                         FormatFloat('#,##0.00', dm.qry_pedido.FieldByName('VALOR_TOTAL').AsFloat),
                                         dm.qry_pedido.FieldByName('IND_ENTREGUE').AsString,
                                         dm.qry_pedido.FieldByName('IND_SINC').AsString);

                        dm.qry_pedido.Next;
                end;

                Frm_Principal.lv_pedido.EndUpdate;

                if Frm_Principal.lv_pedido.Items.Count = 0 then
                        Frm_Principal.img_no_pedido.Visible := true;

        Except on ex:exception do
        begin
                Frm_Principal.Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Ocorreu um erro ao carregar os pedidos', 'OK', '', $FFdf5447, $FFdf5447);
                Frm_Mensagem.Show;
        end;
        end;
end;

procedure Consulta_Cliente(busca : string; pagina : integer);
var
        x : integer;
begin
        try
                dm.qry_cliente.Active := false;
                dm.qry_cliente.SQL.Clear;
                dm.qry_cliente.sql.Add('SELECT C.* FROM TAB_CLIENTE C ');

                if busca <> '' then
                begin
                        dm.qry_cliente.SQL.Add('WHERE C.NOME LIKE ''%'' || :BUSCA || ''%'' ');
                        dm.qry_cliente.Params.ParamByName('BUSCA').Value := busca;
                end;

                dm.qry_cliente.Active := true;


                // Limpar listagem...
                Frm_Principal.img_no_cliente.Visible := false;
                Frm_Principal.lv_cliente.Items.Clear;
                Frm_Principal.lv_cliente.BeginUpdate;


                // Loop nos pedidos...
                for x := 1 to dm.qry_cliente.RecordCount do
                begin
                        Add_Cliente_Lista(dm.qry_cliente.FieldByName('COD_CLIENTE').AsString,
                                         dm.qry_cliente.FieldByName('NOME').AsString,
                                         dm.qry_cliente.FieldByName('ENDERECO').AsString,
                                         FormatDateTime('dd/MM/yyyy', dm.qry_cliente.FieldByName('DATA_ULT_COMPRA').AsDateTime),
                                         FormatFloat('#,##0.00', dm.qry_cliente.FieldByName('VALOR_ULT_COMPRA').AsFloat));

                        dm.qry_cliente.Next;
                end;

                Frm_Principal.lv_cliente.EndUpdate;

                if Frm_Principal.lv_cliente.Items.Count = 0 then
                        Frm_Principal.img_no_cliente.Visible := true;

        Except on ex:exception do
        begin
                Frm_Principal.Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Ocorreu um erro ao carregar os clientes', 'OK', '', $FFdf5447, $FFdf5447);
                Frm_Mensagem.Show;
        end;
        end;
end;

procedure Qtd_Notificacao(qtd : integer);
begin
        with Frm_Principal do
        begin
                if qtd > 0 then
                begin
                        circle_notificacao.Visible := true;
                        lbl_qtd_notif.Text := qtd.ToString;
                end
                else
                        circle_notificacao.Visible := false;
        end;
end;

procedure Consulta_Notificacao();
var
        x : integer;
        cont_notif : integer;
begin
        try
                cont_notif := 0;
                dm.qry_notificacao.Active := false;
                dm.qry_notificacao.SQL.Clear;
                dm.qry_notificacao.sql.Add('SELECT * FROM TAB_NOTIFICACAO ORDER BY DATA DESC ');
                dm.qry_notificacao.Active := true;


                // Limpar listagem...
                Frm_Principal.img_no_notificacao.Visible := false;
                Frm_Principal.lv_notificacao.Items.Clear;
                Frm_Principal.lv_notificacao.BeginUpdate;


                // Loop nos pedidos...
                for x := 1 to dm.qry_notificacao.RecordCount do
                begin
                        Add_Notificacao_Lista(dm.qry_notificacao.FieldByName('COD_NOTIFICACAO').AsString,
                                              FormatDateTime('dd/MM/yyyy', dm.qry_notificacao.FieldByName('DATA').AsDateTime),
                                              dm.qry_notificacao.FieldByName('TITULO').AsString,
                                              dm.qry_notificacao.FieldByName('TEXTO').AsString,
                                              dm.qry_notificacao.FieldByName('IND_LIDO').AsString,
                                              dm.qry_notificacao.FieldByName('IND_DESTAQUE').AsString);

                        if dm.qry_notificacao.FieldByName('IND_LIDO').AsString = 'N' then
                                cont_notif := cont_notif + 1;

                        dm.qry_notificacao.Next;
                end;

                Frm_Principal.lv_notificacao.EndUpdate;

                if Frm_Principal.lv_notificacao.Items.Count = 0 then
                        Frm_Principal.img_no_notificacao.Visible := true;

                Qtd_Notificacao(cont_notif);

        Except on ex:exception do
        begin
                Frm_Principal.Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Ocorreu um erro ao carregar as notificações',
                                              'OK', '', $FFdf5447, $FFdf5447);
                Frm_Mensagem.Show;
        end;
        end;
end;

procedure TFrm_Principal.FormCreate(Sender: TObject);
begin
        img_entregue.Visible := false;
        img_sinc.Visible := false;
        img_nao_sinc.Visible := false;
        img_mais_notif.Visible := false;
end;

procedure TFrm_Principal.FormShow(Sender: TObject);
begin
        img_no_pedido.Visible := false;
        img_no_cliente.Visible := false;
        img_no_notificacao.Visible := false;
        layout_menu_notif.Visible := false;

        Consulta_Pedido('', 0);
        Consulta_Cliente('', 0);
        Consulta_Notificacao();
        Seleciona_Tab(1);
end;

procedure TFrm_Principal.img_busca_clienteClick(Sender: TObject);
begin
        Consulta_Cliente(edt_busca_cliente.Text, 0);
end;

procedure TFrm_Principal.img_busca_pedidoClick(Sender: TObject);
begin
        Consulta_Pedido(edt_busca.Text, 0);
end;

procedure TFrm_Principal.img_cad_clienteClick(Sender: TObject);
begin
        if NOT Assigned(Frm_Cliente) then
                Application.CreateForm(TFrm_Cliente, Frm_Cliente);

        Frm_Cliente.modo := 'I';
        Frm_Cliente.img_excluir.Visible := false;
        Frm_Cliente.cod_cliente := 0;

        Frm_Cliente.lbl_cnpj.Text := '';
        Frm_Cliente.lbl_nome.Text := '';
        Frm_Cliente.lbl_fone.Text := '';
        Frm_Cliente.lbl_email.Text := '';
        Frm_Cliente.lbl_endereco.Text := '';
        Frm_Cliente.lbl_obs.Text := '';

        Frm_Cliente.ShowModal(procedure (ModalResult: TModalResult)
                              begin
                                        if Frm_Cliente.ind_cancelar = 'N' then
                                        begin
                                                img_busca_clienteClick(Sender);
                                        end;
                              end);

end;

procedure TFrm_Principal.img_cad_produtoClick(Sender: TObject);
begin
        if NOT Assigned(Frm_Produto) then
                Application.CreateForm(TFrm_Produto, Frm_Produto);

        Frm_Produto.Show;
end;

procedure TFrm_Principal.img_tab_clienteClick(Sender: TObject);
begin
        Seleciona_Tab(2);
end;

procedure TFrm_Principal.img_tab_maisClick(Sender: TObject);
begin
        Seleciona_Tab(4);
end;

procedure TFrm_Principal.img_tab_notificacaoClick(Sender: TObject);
begin
        Seleciona_Tab(3);
end;

procedure TFrm_Principal.img_tab_pedidoClick(Sender: TObject);
begin
        Seleciona_Tab(1);
end;

procedure TFrm_Principal.lbl_menu_cancelarClick(Sender: TObject);
begin
        layout_menu_notif.Visible := false;
end;

procedure TFrm_Principal.lbl_menu_excluirClick(Sender: TObject);
begin
        try
                dm.qry_notificacao.Active := false;
                dm.qry_notificacao.SQL.Clear;
                dm.qry_notificacao.sql.Add('DELETE FROM TAB_NOTIFICACAO ');
                dm.qry_notificacao.sql.Add('WHERE COD_NOTIFICACAO = :COD_NOTIFICACAO');
                dm.qry_notificacao.Params.ParamByName('COD_NOTIFICACAO').Value := lbl_menu_excluir.TagString;
                dm.qry_notificacao.ExecSQL;

                Consulta_Notificacao();

                layout_menu_notif.Visible := false;

        except on ex:exception do
        begin
                Frm_Principal.Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao excluir a notificação', 'OK', '', $FFdf5447, $FFdf5447);
                Frm_Mensagem.Show;
        end;
        end;
end;

procedure TFrm_Principal.lbl_menu_lidaClick(Sender: TObject);
var
        ind_lido : string;
begin
        if lbl_menu_lida.Text = 'Marcar como lida' then
                ind_lido := 'S'
        else
                ind_lido := 'N';

        try
                dm.qry_notificacao.Active := false;
                dm.qry_notificacao.SQL.Clear;
                dm.qry_notificacao.sql.Add('UPDATE TAB_NOTIFICACAO SET IND_LIDO = :IND_LIDO');
                dm.qry_notificacao.sql.Add('WHERE COD_NOTIFICACAO = :COD_NOTIFICACAO');
                dm.qry_notificacao.Params.ParamByName('IND_LIDO').Value := ind_lido;
                dm.qry_notificacao.Params.ParamByName('COD_NOTIFICACAO').Value := lbl_menu_lida.TagString;
                dm.qry_notificacao.ExecSQL;

                Consulta_Notificacao();
                layout_menu_notif.Visible := false;

        except on ex:exception do
        begin
                Frm_Principal.Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao alterar notificação', 'OK', '', $FFdf5447, $FFdf5447);
                Frm_Mensagem.Show;
        end;
        end;

end;

procedure TFrm_Principal.lv_clienteItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
        txt : TListItemText;
        foto : TStream;
begin
        with AItem do
        begin
                // Descricao...
                txt := TListItemText(Objects.FindDrawable('Text1'));



                // Buscar os dados do cliente selecionado...
                dm.qry_cliente.Active := false;
                dm.qry_cliente.SQL.Clear;
                dm.qry_cliente.sql.Add('SELECT * FROM TAB_CLIENTE WHERE COD_CLIENTE = :COD_CLIENTE');
                dm.qry_cliente.Params.ParamByName('COD_CLIENTE').Value := txt.TagString;
                dm.qry_cliente.Active := true;

                if dm.qry_cliente.RecordCount > 0 then
                begin
                        if NOT Assigned(Frm_Cliente) then
                                Application.CreateForm(TFrm_Cliente, Frm_Cliente);

                        Frm_Cliente.modo := 'A';
                        Frm_Cliente.img_excluir.Visible := true;
                        Frm_Cliente.cod_cliente := txt.TagString.ToInteger;

                        Frm_Cliente.lbl_cnpj.Text := dm.qry_cliente.FieldByName('CNPJ_CPF').AsString;
                        Frm_Cliente.lbl_nome.Text := dm.qry_cliente.FieldByName('NOME').AsString;
                        Frm_Cliente.lbl_fone.Text := dm.qry_cliente.FieldByName('FONE').AsString;
                        Frm_Cliente.lbl_email.Text := dm.qry_cliente.FieldByName('EMAIL').AsString;
                        Frm_Cliente.lbl_endereco.Text := dm.qry_cliente.FieldByName('ENDERECO').AsString;
                        Frm_Cliente.lbl_obs.Text := dm.qry_cliente.FieldByName('OBS').AsString;

                        Frm_Cliente.ShowModal(procedure (ModalResult: TModalResult)
                                              begin
                                                        if Frm_Cliente.ind_cancelar = 'N' then
                                                        begin
                                                                img_busca_clienteClick(Sender);
                                                        end;
                                              end);

                end
                else
                        showmessage('Cliente não encontrado');

        end;
end;



procedure TFrm_Principal.lv_notificacaoItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
        cod_notificacao, ind_lido : string;
begin
        if TListView(Sender).Selected <> nil then
        begin
                if ItemObject is TListItemImage then
                begin
                        cod_notificacao := TListItemImage(ItemObject).TagFloat.ToString;
                        ind_lido := TListItemImage(ItemObject).TagString;

                        lbl_menu_lida.TagString := cod_notificacao;
                        lbl_menu_excluir.TagString := cod_notificacao;


                        if ind_lido = 'N' then
                                lbl_menu_lida.Text := 'Marcar como lida'
                        else
                                lbl_menu_lida.Text := 'Marcar como não lida';

                        layout_menu_notif.Visible := true;
                end;
        end;
end;


procedure TFrm_Principal.lv_notificacaoUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
        txt : TListItemText;
begin
        with AItem do
        begin
                // Marcar mensagem como destaque...
                txt := TListItemText(Objects.FindDrawable('Text1'));

                if txt.TagString = 'S' then
                        txt.TextColor := $FFE25E5E;


                // Quebra de linha automatica...
                txt := TListItemText(Objects.FindDrawable('Text2'));
                txt.WordWrap := true;
        end;
end;

end.
