//
// Created by the DataSnap proxy generator.
// 16/02/2019 13:01:07
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TMetodosClient = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FListarClientesCommand: TDSRestCommand;
    FListarClientesCommand_Cache: TDSRestCommand;
    FValidaLoginCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function ListarClientes(const ARequestFilter: string = ''): TFDJSONDataSets;
    function ListarClientes_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function ValidaLogin(Email: string; Senha: string; const ARequestFilter: string = ''): Boolean;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TMetodos_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TMetodos_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TMetodos_ListarClientes: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TMetodos_ListarClientes_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TMetodos_ValidaLogin: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'Email'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

function TMetodosClient.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TMetodos.EchoString';
    FEchoStringCommand.Prepare(TMetodos_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TMetodosClient.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TMetodos.ReverseString';
    FReverseStringCommand.Prepare(TMetodos_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TMetodosClient.ListarClientes(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FListarClientesCommand = nil then
  begin
    FListarClientesCommand := FConnection.CreateCommand;
    FListarClientesCommand.RequestType := 'GET';
    FListarClientesCommand.Text := 'TMetodos.ListarClientes';
    FListarClientesCommand.Prepare(TMetodos_ListarClientes);
  end;
  FListarClientesCommand.Execute(ARequestFilter);
  if not FListarClientesCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FListarClientesCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FListarClientesCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FListarClientesCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TMetodosClient.ListarClientes_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FListarClientesCommand_Cache = nil then
  begin
    FListarClientesCommand_Cache := FConnection.CreateCommand;
    FListarClientesCommand_Cache.RequestType := 'GET';
    FListarClientesCommand_Cache.Text := 'TMetodos.ListarClientes';
    FListarClientesCommand_Cache.Prepare(TMetodos_ListarClientes_Cache);
  end;
  FListarClientesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FListarClientesCommand_Cache.Parameters[0].Value.GetString);
end;

function TMetodosClient.ValidaLogin(Email: string; Senha: string; const ARequestFilter: string): Boolean;
begin
  if FValidaLoginCommand = nil then
  begin
    FValidaLoginCommand := FConnection.CreateCommand;
    FValidaLoginCommand.RequestType := 'GET';
    FValidaLoginCommand.Text := 'TMetodos.ValidaLogin';
    FValidaLoginCommand.Prepare(TMetodos_ValidaLogin);
  end;
  FValidaLoginCommand.Parameters[0].Value.SetWideString(Email);
  FValidaLoginCommand.Parameters[1].Value.SetWideString(Senha);
  FValidaLoginCommand.Execute(ARequestFilter);
  Result := FValidaLoginCommand.Parameters[2].Value.GetBoolean;
end;

constructor TMetodosClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TMetodosClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TMetodosClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FListarClientesCommand.DisposeOf;
  FListarClientesCommand_Cache.DisposeOf;
  FValidaLoginCommand.DisposeOf;
  inherited;
end;

end.

