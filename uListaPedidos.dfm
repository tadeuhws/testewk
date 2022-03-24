object Form_ListaPedidos: TForm_ListaPedidos
  Left = 0
  Top = 0
  Caption = 'Pedidos'
  ClientHeight = 294
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 25
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 673
    Height = 294
    Align = alClient
    Caption = 'Pedidos'
    TabOrder = 0
    object DBGrid_ListaPedidos: TDBGrid
      Left = 2
      Top = 27
      Width = 669
      Height = 265
      Align = alClient
      DataSource = DM.DataSource_Select
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -21
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid_ListaPedidosDblClick
      OnKeyPress = DBGrid_ListaPedidosKeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'numero'
          Title.Caption = 'N'#250'mero'
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dtemissao'
          Title.Caption = 'Emiss'#227'o'
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Cliente'
          Width = 431
          Visible = True
        end>
    end
  end
end
