object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 472
  Width = 368
  object conn: TFDConnection
    Params.Strings = (
      
        'Database=D:\Downloads\Mobile360\30 - Cadastro de Produtos - Salv' +
        'ando Dados Banco\Fontes\DB\pedidos.db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Left = 48
    Top = 16
  end
  object qry_geral: TFDQuery
    Connection = conn
    Left = 120
    Top = 16
  end
  object qry_pedido: TFDQuery
    Connection = conn
    Left = 192
    Top = 16
  end
  object qry_cliente: TFDQuery
    Connection = conn
    Left = 264
    Top = 16
  end
  object qry_notificacao: TFDQuery
    Connection = conn
    Left = 120
    Top = 72
  end
  object qry_produto: TFDQuery
    Connection = conn
    SQL.Strings = (
      'SELECT * FROM TAB_PRODUTO')
    Left = 192
    Top = 72
  end
end
