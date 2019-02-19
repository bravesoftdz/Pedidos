unit ClientModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit1, Datasnap.DSClientRest;

type
  TClientModule1 = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FMetodosClient: TMetodosClient;
    function GetMetodosClient: TMetodosClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property MetodosClient: TMetodosClient read GetMetodosClient write FMetodosClient;

end;

var
  ClientModule1: TClientModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TClientModule1.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule1.Destroy;
begin
  FMetodosClient.Free;
  inherited;
end;

function TClientModule1.GetMetodosClient: TMetodosClient;
begin
  if FMetodosClient = nil then
    FMetodosClient:= TMetodosClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FMetodosClient;
end;

end.
