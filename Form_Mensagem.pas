unit Form_Mensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrm_Mensagem = class(TForm)
    rect_fundo: TRectangle;
    img_erro: TImage;
    img_alerta: TImage;
    img_sucesso: TImage;
    img_pergunta: TImage;
    rect_msg: TRectangle;
    lbl_titulo: TLabel;
    lbl_msg: TLabel;
    img_icone: TImage;
    layout_botao: TLayout;
    rect_btn1: TRectangle;
    lbl_btn1: TLabel;
    rect_btn2: TRectangle;
    lbl_btn2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lbl_btn1Click(Sender: TObject);
    procedure lbl_btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retorno: string;
    procedure Exibir_Mensagem(icone, tipo_mensagem, titulo, texto_msg,
      texto_btn1, texto_btn2: string; cor_btn1, cor_btn2: Cardinal);
  end;

var
  Frm_Mensagem: TFrm_Mensagem;

implementation

{$R *.fmx}

procedure TFrm_Mensagem.FormCreate(Sender: TObject);
begin
  img_erro.Visible := false;
  img_alerta.Visible := false;
  img_sucesso.Visible := false;
  img_pergunta.Visible := false;
end;

procedure TFrm_Mensagem.lbl_btn1Click(Sender: TObject);
begin
  retorno := '1';
  close;
end;

procedure TFrm_Mensagem.lbl_btn2Click(Sender: TObject);
begin
  retorno := '2';
  close;
end;

{
  icone: ALERTA, PERGUNTA, ERRO ou SUCESSO
  tipo_mensagem: ALERTA ou PERGUNTA
  cor: exemplo... $FFA0A0A0
}
procedure TFrm_Mensagem.Exibir_Mensagem(icone, tipo_mensagem, titulo, texto_msg,
  texto_btn1, texto_btn2: string; cor_btn1, cor_btn2: Cardinal);
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
  self.Show;
end;

end.
