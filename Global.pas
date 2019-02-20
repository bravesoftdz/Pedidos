unit Global;

interface

uses Form_Mensagem, FMX.Forms;

procedure ExibirMenssagem(icone, tipo_mensagem, titulo, texto_msg, texto_btn1,
  texto_btn2: string; cor_btn1, cor_btn2: Cardinal);

implementation

procedure ExibirMenssagem(icone, tipo_mensagem, titulo, texto_msg, texto_btn1,
  texto_btn2: string; cor_btn1, cor_btn2: Cardinal);
begin
  if NOT Assigned(Frm_Mensagem) then
    Application.CreateForm(TFrm_Mensagem, Frm_Mensagem);

  Frm_Mensagem.Exibir_Mensagem(icone, tipo_mensagem, titulo, texto_msg,
    texto_btn1, texto_btn2, cor_btn1, cor_btn2);
end;

end.
