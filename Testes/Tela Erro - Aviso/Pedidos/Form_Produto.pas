unit Form_Produto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, Data.DB, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.MediaLibrary.Actions, FMX.StdActns;

type
  TFrm_Produto = class(TForm)
    Rectangle5: TRectangle;
    Label5: TLabel;
    img_add_produto: TImage;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    edt_busca_produto: TEdit;
    img_busca_produto: TImage;
    lv_produto: TListView;
    img_fechar: TImage;
    img_sem_foto: TImage;
    TabControl: TTabControl;
    TabConsulta: TTabItem;
    TabCadastro: TTabItem;
    ActionList1: TActionList;
    ActTabCadastro: TChangeTabAction;
    ActTabConsulta: TChangeTabAction;
    Rectangle1: TRectangle;
    Label1: TLabel;
    img_salvar: TImage;
    img_voltar: TImage;
    Layout1: TLayout;
    img_foto: TImage;
    Label2: TLabel;
    Layout2: TLayout;
    Label3: TLabel;
    Image2: TImage;
    lbl_descricao: TLabel;
    Line1: TLine;
    Layout3: TLayout;
    Label6: TLabel;
    Image3: TImage;
    lbl_valor: TLabel;
    Line2: TLine;
    Line3: TLine;
    layout_menu: TLayout;
    Rectangle2: TRectangle;
    Layout5: TLayout;
    Rectangle4: TRectangle;
    lbl_menu_camera: TLabel;
    Layout6: TLayout;
    Rectangle6: TRectangle;
    lbl_menu_cancelar: TLabel;
    lbl_menu_lib: TLabel;
    Line4: TLine;
    Image4: TImage;
    Image5: TImage;
    ActFotoLibrary: TTakePhotoFromLibraryAction;
    ActFotoCamera: TTakePhotoFromCameraAction;
    OpenDialog: TOpenDialog;
    Layout7: TLayout;
    img_excluir: TImage;
    procedure img_fecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure img_busca_produtoClick(Sender: TObject);
    procedure lv_produtoUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lv_produtoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_voltarClick(Sender: TObject);
    procedure img_salvarClick(Sender: TObject);
    procedure lbl_menu_cameraClick(Sender: TObject);
    procedure lbl_menu_libClick(Sender: TObject);
    procedure lbl_menu_cancelarClick(Sender: TObject);
    procedure img_fotoClick(Sender: TObject);
    procedure ActFotoLibraryDidFinishTaking(Image: TBitmap);
    procedure ActFotoCameraDidFinishTaking(Image: TBitmap);
    procedure lbl_descricaoClick(Sender: TObject);
    procedure img_add_produtoClick(Sender: TObject);
    procedure img_excluirClick(Sender: TObject);
    procedure lbl_valorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cod_prod : integer;
    modo : string;
  end;

var
  Frm_Produto: TFrm_Produto;

implementation

{$R *.fmx}

uses Form_Principal, DataModule, Form_Editar, Form_Mensagem;

procedure Add_Produto_Lista(cod_produto, descricao, valor : string; foto : TStream);
var
        item : TListViewItem;
        txt : TListItemText;
        img : TListItemImage;
        bmp : TBitmap;
begin
        with Frm_Produto do
        begin
                item := lv_produto.items.add;

                with item do
                begin
                        // Descricao...
                        txt := TListItemText(Objects.FindDrawable('Text2'));
                        txt.Text := descricao;
                        txt.TagString := cod_produto;


                        // Valor...
                        txt := TListItemText(Objects.FindDrawable('Text1'));
                        txt.Text := 'R$ ' + valor;


                        // Foto...
                        img := TListItemImage(Objects.FindDrawable('Image3'));

                        if foto <> nil then
                        begin
                                bmp := TBitmap.Create;
                                bmp.LoadFromStream(foto);
                                img.Bitmap := bmp;
                        end
                        else
                                img.Bitmap := img_sem_foto.bitmap;
                end;
        end;
end;


procedure Consulta_Produto(busca : string; pagina : integer);
var
        x : integer;
        foto : TStream;
begin
        dm.qry_produto.Active := false;
        dm.qry_produto.SQL.Clear;
        dm.qry_produto.sql.Add('SELECT * FROM TAB_PRODUTO ');

        if busca <> '' then
        begin
                dm.qry_produto.SQL.Add('WHERE DESCRICAO LIKE ''%'' || :BUSCA || ''%'' ');
                dm.qry_produto.Params.ParamByName('BUSCA').Value := busca;
        end;

        dm.qry_produto.sql.Add('ORDER BY DESCRICAO ');
        dm.qry_produto.Active := true;


        // Limpar listagem...
        Frm_Produto.lv_produto.Items.Clear;
        Frm_Produto.lv_produto.BeginUpdate;


        // Loop nos pedidos...
        for x := 1 to dm.qry_produto.RecordCount do
        begin
                if dm.qry_produto.FieldByName('FOTO').AsString <> '' then
                        foto := dm.qry_produto.CreateBlobStream(dm.qry_produto.FieldByName('FOTO'), TBlobStreamMode.bmRead)
                else
                        foto := nil;

                Add_Produto_Lista(dm.qry_produto.FieldByName('COD_PRODUTO').AsString,
                                 dm.qry_produto.FieldByName('DESCRICAO').AsString,
                                 FormatFloat('#,##0.00', dm.qry_produto.FieldByName('VALOR').AsFloat),
                                 foto
                                 );

                dm.qry_produto.Next;
        end;

        Frm_Produto.lv_produto.EndUpdate;
end;



procedure TFrm_Produto.ActFotoCameraDidFinishTaking(Image: TBitmap);
begin
        img_foto.Bitmap := Image;
        layout_menu.Visible := false;
end;

procedure TFrm_Produto.ActFotoLibraryDidFinishTaking(Image: TBitmap);
begin
        img_foto.Bitmap := Image;
        layout_menu.Visible := false;
end;

procedure TFrm_Produto.FormCreate(Sender: TObject);
begin
        img_sem_foto.Visible := false;
        TabControl.TabPosition := TTabPosition.None;
end;

procedure TFrm_Produto.FormShow(Sender: TObject);
begin
        layout_menu.Visible := false;
        TabControl.ActiveTab := TabConsulta;
        Consulta_Produto('', 0);
end;

procedure TFrm_Produto.img_add_produtoClick(Sender: TObject);
begin
        cod_prod := 0;
        modo := 'I';

        lbl_descricao.Text := 'Nenhuma';
        lbl_valor.Text := '0,00';
        img_foto.Bitmap := img_sem_foto.Bitmap;
        img_excluir.Visible := false;

        ActTabCadastro.ExecuteTarget(Sender);
end;

procedure TFrm_Produto.img_busca_produtoClick(Sender: TObject);
begin
        Consulta_Produto(edt_busca_produto.Text, 0);
end;

procedure TFrm_Produto.img_excluirClick(Sender: TObject);
begin
        // Consistencia se pode excluir o produto...



        // Mensagem de confirmacao...
        Frm_Principal.Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Exclusão',
                                      'Confirma a exclusão do produto?',
                                      'Sim', 'Não', $FFdf5447, $FFABABAB);
        Frm_Mensagem.ShowModal(procedure (ModalResult: TModalResult)
                               begin
                                        if Frm_Mensagem.retorno = '1' then
                                        begin
                                                // Exclusao do produto...
                                                dm.qry_produto.Active := false;
                                                dm.qry_produto.sql.Clear;
                                                dm.qry_produto.sql.Add('DELETE FROM TAB_PRODUTO WHERE COD_PRODUTO = :COD_PRODUTO');
                                                dm.qry_produto.Params.ParamByName('COD_PRODUTO').Value := cod_prod;
                                                dm.qry_produto.ExecSQL;

                                                img_busca_produtoClick(Sender);

                                                ActTabConsulta.ExecuteTarget(Sender);
                                        end;
                               end);
end;

procedure TFrm_Produto.img_fecharClick(Sender: TObject);
begin
        ModalResult := mrCancel;
        Close;
end;

procedure TFrm_Produto.img_fotoClick(Sender: TObject);
begin
        {$IFDEF MSWINDOWS}
                if OpenDialog.Execute then
                        img_foto.Bitmap.LoadFromFile(OpenDialog.FileName);
                exit;
        {$ENDIF}

        layout_menu.Visible := true;
end;

procedure TFrm_Produto.img_salvarClick(Sender: TObject);
var
        valor : string;
begin
        dm.qry_produto.Active := false;
        dm.qry_produto.SQL.Clear;

        if modo = 'I' then
        begin
                dm.qry_geral.Active := false;
                dm.qry_geral.SQL.Clear;
                dm.qry_geral.sql.Add('SELECT IFNULL(MAX(COD_PRODUTO), 0) AS COD_PRODUTO FROM TAB_PRODUTO ');
                dm.qry_geral.Active := true;

                cod_prod := dm.qry_geral.FieldByName('COD_PRODUTO').AsInteger + 1;

                dm.qry_produto.sql.Add('INSERT INTO TAB_PRODUTO(COD_PRODUTO, DESCRICAO, VALOR, FOTO)');
                dm.qry_produto.sql.Add('VALUES(:COD_PRODUTO, :DESCRICAO, :VALOR, :FOTO)');
        end
        else
        begin
                dm.qry_produto.sql.Add('UPDATE TAB_PRODUTO SET DESCRICAO = :DESCRICAO, VALOR = :VALOR, FOTO = :FOTO');
                dm.qry_produto.sql.Add('WHERE COD_PRODUTO = :COD_PRODUTO');
        end;

        valor := StringReplace(lbl_valor.Text, '.', '', [rfReplaceAll]);
        valor := StringReplace(valor, ',', '', [rfReplaceAll]);


        dm.qry_produto.Params.ParamByName('COD_PRODUTO').Value := cod_prod;
        dm.qry_produto.Params.ParamByName('DESCRICAO').Value := lbl_descricao.Text;
        dm.qry_produto.Params.ParamByName('VALOR').Value := StrToFloat(valor) / 100;
        dm.qry_produto.Params.ParamByName('FOTO').Assign(img_foto.Bitmap);
        dm.qry_produto.ExecSQL;

        img_busca_produtoClick(Sender);

        ActTabConsulta.ExecuteTarget(Sender);
end;

procedure TFrm_Produto.img_voltarClick(Sender: TObject);
begin
        ActTabConsulta.ExecuteTarget(Sender);
end;

procedure TFrm_Produto.lbl_descricaoClick(Sender: TObject);
begin
        Frm_Principal.Editar_Campo('EDIT', 'Descrição', 'Descrição do produto', 'S', lbl_descricao.Text, 200);
        Frm_Editar.ShowModal(procedure(ModalResult: TModalResult)
                             begin
                                    if Frm_Editar.ind_cancelar = 'N' then
                                            lbl_descricao.Text := Frm_Editar.valor_selecionado;
                             end);
end;

procedure TFrm_Produto.lbl_menu_cameraClick(Sender: TObject);
begin
        ActFotoCamera.ExecuteTarget(Sender);
end;

procedure TFrm_Produto.lbl_menu_cancelarClick(Sender: TObject);
begin
        layout_menu.Visible := false;
end;

procedure TFrm_Produto.lbl_menu_libClick(Sender: TObject);
begin
        ActFotoLibrary.ExecuteTarget(Sender);
end;

procedure TFrm_Produto.lbl_valorClick(Sender: TObject);
begin
        Frm_Principal.Editar_Campo('VALOR', 'Valor Unitário', '', 'S', lbl_valor.Text, 0);
        Frm_Editar.ShowModal(procedure(ModalResult: TModalResult)
                             begin
                                    if Frm_Editar.ind_cancelar = 'N' then
                                            lbl_valor.Text := Frm_Editar.valor_selecionado;
                             end);
end;

procedure TFrm_Produto.lv_produtoItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
        txt : TListItemText;
        foto : TStream;
begin
        with AItem do
        begin
                // Descricao...
                txt := TListItemText(Objects.FindDrawable('Text2'));
                cod_prod := txt.TagString.ToInteger;
                modo := 'A';
                img_excluir.Visible := true;


                // Buscar os dados do produto selecionado...
                dm.qry_produto.Active := false;
                dm.qry_produto.SQL.Clear;
                dm.qry_produto.sql.Add('SELECT * FROM TAB_PRODUTO WHERE COD_PRODUTO = :COD_PRODUTO');
                dm.qry_produto.Params.ParamByName('COD_PRODUTO').Value := cod_prod;
                dm.qry_produto.Active := true;

                if dm.qry_produto.RecordCount > 0 then
                begin
                        lbl_descricao.Text := dm.qry_produto.FieldByName('DESCRICAO').AsString;
                        lbl_valor.Text := FormatFloat('#,##0.00', dm.qry_produto.FieldByName('VALOR').AsFloat);

                        if dm.qry_produto.FieldByName('FOTO').AsString <> '' then
                        begin
                                foto := TStream.Create;
                                foto := dm.qry_produto.CreateBlobStream(dm.qry_produto.FieldByName('FOTO'), TBlobStreamMode.bmRead);
                                img_foto.Bitmap.LoadFromStream(foto);
                        end
                        else
                                img_foto.Bitmap := img_sem_foto.Bitmap;



                        ActTabCadastro.ExecuteTarget(Sender);
                end
                else
                        showmessage('Produto não encontrado');

        end;
end;

procedure TFrm_Produto.lv_produtoUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
        txt : TListItemText;
begin
        with AItem do
        begin
                // Descricao...
                txt := TListItemText(Objects.FindDrawable('Text2'));
                txt.WordWrap := true;
        end;
end;

end.
