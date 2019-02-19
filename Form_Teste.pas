unit Form_Teste;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListView,
  FMX.Controls.Presentation, FMX.StdCtrls, FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON, Data.FireDACJSONReflect, ClientModuleUnit1,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFrm_Teste = class(TForm)
    ListView1: TListView;
    FDMemTable1: TFDMemTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    Button1: TButton;
    FDMemTable1nome: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Teste: TFrm_Teste;

implementation

{$R *.fmx}

procedure TFrm_Teste.Button1Click(Sender: TObject);
var
  Ld: TFDJSONDataSets;
begin
  FDMemTable1.Active := false;
  Ld := ClientModule1.MetodosClient.ListarClientes();
  FDMemTable1.AppendData(TFDJSONDataSetsReader.GetListValue(Ld, 0));
  FDMemTable1.Open;
end;
end.
