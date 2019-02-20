unit Form_Editar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.ScrollBox,
  FMX.Memo;

type
  TFrm_Editar = class(TForm)
    Rectangle1: TRectangle;
    lbl_titulo: TLabel;
    img_salvar: TImage;
    img_voltar: TImage;
    layout_edit: TLayout;
    Rectangle2: TRectangle;
    edt_texto: TEdit;
    layout_memo: TLayout;
    Rectangle3: TRectangle;
    m_memo: TMemo;
    layout_valor: TLayout;
    lbl_valor: TLabel;
    Line1: TLine;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    lbl_tecla4: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    Layout12: TLayout;
    Layout13: TLayout;
    lbl_tecla7: TLabel;
    lbl_tecla8: TLabel;
    lbl_tecla9: TLabel;
    Label5: TLabel;
    lbl_tecla5: TLabel;
    lbl_tecla6: TLabel;
    lbl_tecla1: TLabel;
    lbl_tecla2: TLabel;
    lbl_tecla3: TLabel;
    lbl_tecla00: TLabel;
    lbl_tecla0: TLabel;
    img_backspace: TImage;
    procedure FormShow(Sender: TObject);
    procedure img_voltarClick(Sender: TObject);
    procedure img_salvarClick(Sender: TObject);
    procedure lbl_tecla0Click(Sender: TObject);
    procedure img_backspaceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ind_campo_obrigatorio : string;
    ind_cancelar : string;
    valor_selecionado : string;
    tipo : string;
  end;

var
  Frm_Editar: TFrm_Editar;

implementation

{$R *.fmx}

uses Form_Principal, Form_Mensagem;

procedure Tecla_Backspace();
var
        valor : string;
begin
        with Frm_Editar do
        begin
                valor := lbl_valor.Text;  // 5.200,00
                valor := StringReplace(valor, '.', '', [rfReplaceAll]); // 5200,00
                valor := StringReplace(valor, ',', '', [rfReplaceAll]); // 520000

                if Length(valor) > 1 then
                        valor := Copy(valor, 1, length(valor) - 1)
                else
                        valor := '0';

                lbl_valor.Text := FormatFloat('#,##0.00', StrToFloat(valor) / 100);
        end;
end;

procedure Tecla_Numero(lbl : TObject);
var
        valor : string;
begin
        with Frm_Editar do
        begin
                valor := lbl_valor.Text;
                valor := StringReplace(valor, '.', '', [rfReplaceAll]);
                valor := StringReplace(valor, ',', '', [rfReplaceAll]);

                valor := valor + TLabel(lbl).Text;

                lbl_valor.Text := FormatFloat('#,##0.00', StrToFloat(valor) / 100);
        end;
end;

procedure TFrm_Editar.FormShow(Sender: TObject);
begin
        ind_cancelar := 'S';
        layout_edit.Visible := false;
        layout_memo.Visible := false;
        layout_valor.Visible := false;

        if tipo = 'EDIT' then
                layout_edit.Visible := true;

        if tipo = 'MEMO' then
                layout_memo.Visible := true;

        if tipo = 'VALOR' then
                layout_valor.Visible := true;
end;

procedure TFrm_Editar.img_backspaceClick(Sender: TObject);
begin
        Tecla_Backspace();
end;

procedure TFrm_Editar.img_salvarClick(Sender: TObject);
begin
        ind_cancelar := 'N';

        if layout_edit.Visible then
                valor_selecionado := edt_texto.Text;

        if layout_memo.Visible then
                valor_selecionado := m_memo.lines.Text;

        if layout_valor.Visible then
                valor_selecionado := lbl_valor.Text;

        // Campos obrigatorios...
        if (ind_campo_obrigatorio = 'S') and (valor_selecionado = '') then
        begin
                Frm_Principal.Exibir_Mensagem('ALERTA', 'ALERTA', 'Aviso',
                                              'Esse campo é obrigatório. Informe um valor.',
                                              'OK', '', $FFABABAB, $FFABABAB);
                Frm_Mensagem.Show;
                exit;
        end;

        close;
end;

procedure TFrm_Editar.img_voltarClick(Sender: TObject);
begin
        valor_selecionado := '';
        ind_cancelar := 'S';
        close;
end;

procedure TFrm_Editar.lbl_tecla0Click(Sender: TObject);
begin
        Tecla_Numero(Sender);
end;

end.
