object DM: TDM
  OldCreateOrder = False
  Height = 384
  Width = 579
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=teste'
      'User_Name=root'
      'Password=15975328'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 40
    Top = 16
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Teste\libmysql.dll'
    Left = 160
    Top = 16
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 288
    Top = 16
  end
  object FDQuery_Clientes: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select'
      'codigo,'
      'nome'
      'from'
      'clientes')
    Left = 48
    Top = 88
    object FDQuery_Clientescodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      DisplayFormat = '000000'
    end
    object FDQuery_Clientesnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 100
    end
  end
  object FDQuery_Produtos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select'
      'codigo,'
      'descricao,'
      'precovenda'
      'from'
      'produtos')
    Left = 160
    Top = 88
    object FDQuery_Produtoscodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery_Produtosdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 100
    end
    object FDQuery_Produtosprecovenda: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'precovenda'
      Origin = 'precovenda'
    end
  end
  object DataSource_Clientes: TDataSource
    DataSet = FDQuery_Clientes
    Left = 280
    Top = 88
  end
  object FDQuery_RetornaDadosProduto: TFDQuery
    Connection = FDConnection
    Left = 288
    Top = 160
  end
  object FDQuery_Insert: TFDQuery
    Connection = FDConnection
    Left = 64
    Top = 160
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 160
    Top = 160
  end
  object ClientDataSet_ItensPedido: TClientDataSet
    PersistDataPacket.Data = {
      8E0000009619E0BD0100000018000000060000000000030000008E0006636F64
      69676F04000100000000000964657363726963616F0100490000000100055749
      4454480200020064000A7175616E74696461646508000400000000000D76616C
      6F72756E69746172696F08000400000000000A76616C6F72746F74616C080004
      000000000002696404000100000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 224
    object ClientDataSet_ItensPedidocodigo: TIntegerField
      FieldName = 'codigo'
    end
    object ClientDataSet_ItensPedidodescricao: TStringField
      FieldName = 'descricao'
      Size = 100
    end
    object ClientDataSet_ItensPedidoquantidade: TFloatField
      FieldName = 'quantidade'
      DisplayFormat = '###,##0.00'
    end
    object ClientDataSet_ItensPedidovalorunitario: TFloatField
      FieldName = 'valorunitario'
      DisplayFormat = '###,##0.00'
    end
    object ClientDataSet_ItensPedidovalortotal: TFloatField
      FieldName = 'valortotal'
      DisplayFormat = '###,##0.00'
    end
    object ClientDataSet_ItensPedidoid: TIntegerField
      FieldName = 'id'
    end
  end
  object FDQuery_RetornaItensPedido: TFDQuery
    Connection = FDConnection
    Left = 216
    Top = 224
  end
  object FDQuery_Delete: TFDQuery
    Connection = FDConnection
    Left = 344
    Top = 224
  end
  object FDQuery_Select: TFDQuery
    Connection = FDConnection
    Left = 64
    Top = 296
  end
  object DataSource_Select: TDataSource
    DataSet = FDQuery_Select
    Left = 160
    Top = 288
  end
  object DataSource_ItensPedido: TDataSource
    DataSet = ClientDataSet_ItensPedido
    Left = 320
    Top = 288
  end
end
