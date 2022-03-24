object Form_PedidoVendaPrincipal: TForm_PedidoVendaPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste T'#233'cnico'
  ClientHeight = 655
  ClientWidth = 1066
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_Pedido: TPanel
    Left = 0
    Top = 0
    Width = 1066
    Height = 321
    Align = alTop
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 89
      Width = 1064
      Height = 231
      Align = alClient
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        1064
        231)
      object Label1: TLabel
        Left = 11
        Top = 31
        Width = 71
        Height = 25
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 11
        Top = 67
        Width = 115
        Height = 25
        Caption = 'Quantidade:'
      end
      object Label3: TLabel
        Left = 11
        Top = 106
        Width = 55
        Height = 25
        Caption = 'Valor:'
      end
      object Label4: TLabel
        Left = 11
        Top = 145
        Width = 53
        Height = 25
        Caption = 'Total:'
      end
      object Edit_CodigoProduto: TEdit
        Left = 145
        Top = 28
        Width = 129
        Height = 33
        TabOrder = 0
        OnKeyPress = Edit_CodigoProdutoKeyPress
      end
      object Edit_DescricaoProduto: TEdit
        Left = 280
        Top = 28
        Width = 769
        Height = 33
        Anchors = [akLeft, akTop, akRight]
        Enabled = False
        TabOrder = 1
      end
      object Edit_Quantidade: TEdit
        Left = 145
        Top = 67
        Width = 129
        Height = 33
        TabOrder = 2
        OnKeyPress = Edit_QuantidadeKeyPress
      end
      object Edit_ValorUnitario: TEdit
        Left = 145
        Top = 106
        Width = 129
        Height = 33
        TabOrder = 3
        OnKeyPress = Edit_ValorUnitarioKeyPress
      end
      object Edit_Total: TEdit
        Left = 145
        Top = 145
        Width = 129
        Height = 33
        Enabled = False
        TabOrder = 6
      end
      object Button_Incluir: TButton
        Left = 769
        Top = 176
        Width = 137
        Height = 41
        Anchors = [akRight]
        Caption = 'Incluir'
        TabOrder = 4
        OnClick = Button_IncluirClick
      end
      object Button_Cancelar: TButton
        Left = 912
        Top = 176
        Width = 137
        Height = 41
        Anchors = [akRight]
        Caption = 'Cancelar'
        TabOrder = 5
        OnClick = Button_CancelarClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 1064
      Height = 88
      Align = alTop
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        1064
        88)
      object ComboBox_Cliente: TComboBox
        Left = 11
        Top = 32
        Width = 1038
        Height = 33
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object Panel_ItensPedido: TPanel
    Left = 0
    Top = 321
    Width = 1066
    Height = 205
    Align = alClient
    TabOrder = 1
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 1064
      Height = 203
      Align = alClient
      Caption = 'Itens do Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 2
        Top = 27
        Width = 1060
        Height = 174
        Align = alClient
        DataSource = DM.DataSource_ItensPedido
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = DBGrid1KeyDown
        OnKeyPress = DBGrid1KeyPress
        Columns = <
          item
            Expanded = False
            FieldName = 'codigo'
            Title.Caption = 'C'#243'digo'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -21
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = []
            Width = 136
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Title.Caption = 'Descri'#231#227'o'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -21
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = []
            Width = 410
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Title.Caption = 'Quantidade'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -21
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = []
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valorunitario'
            Title.Caption = 'Valor Unit'#225'rio'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -21
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = []
            Width = 169
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valortotal'
            Title.Caption = 'Valor Total'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -21
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = []
            Width = 138
            Visible = True
          end
          item
            Expanded = False
            Visible = True
          end>
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 636
    Width = 1066
    Height = 19
    Panels = <>
  end
  object PanelConfirmar: TPanel
    Left = 0
    Top = 526
    Width = 1066
    Height = 55
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      1066
      55)
    object Label5: TLabel
      Left = 688
      Top = 11
      Width = 153
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Total do Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit_TotalDoPedido: TEdit
      Left = 847
      Top = 8
      Width = 203
      Height = 33
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '0,0'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 581
    Width = 1066
    Height = 55
    Align = alBottom
    TabOrder = 4
    DesignSize = (
      1066
      55)
    object Button_GravarPedido: TButton
      Left = 832
      Top = 8
      Width = 218
      Height = 41
      Anchors = [akRight]
      Caption = 'Gravar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button_GravarPedidoClick
    end
    object Button_ListaPedidos: TButton
      Left = 3
      Top = 6
      Width = 218
      Height = 41
      Anchors = [akLeft]
      Caption = 'Lista de Pedidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button_ListaPedidosClick
    end
    object Button_ExcluirPedido: TButton
      Left = 227
      Top = 6
      Width = 218
      Height = 41
      Anchors = [akLeft]
      Caption = 'Excluir Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button_ExcluirPedidoClick
    end
  end
end
