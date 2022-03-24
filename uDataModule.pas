unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, Data.DB,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI, Datasnap.DBClient;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQuery_Clientes: TFDQuery;
    FDQuery_Produtos: TFDQuery;
    DataSource_Clientes: TDataSource;
    FDQuery_Clientescodigo: TFDAutoIncField;
    FDQuery_Clientesnome: TStringField;
    FDQuery_Produtoscodigo: TFDAutoIncField;
    FDQuery_Produtosdescricao: TStringField;
    FDQuery_Produtosprecovenda: TSingleField;
    FDQuery_RetornaDadosProduto: TFDQuery;
    FDQuery_Insert: TFDQuery;
    FDTransaction: TFDTransaction;
    ClientDataSet_ItensPedido: TClientDataSet;
    ClientDataSet_ItensPedidocodigo: TIntegerField;
    ClientDataSet_ItensPedidodescricao: TStringField;
    ClientDataSet_ItensPedidoquantidade: TFloatField;
    ClientDataSet_ItensPedidovalorunitario: TFloatField;
    ClientDataSet_ItensPedidovalortotal: TFloatField;
    ClientDataSet_ItensPedidoid: TIntegerField;
    FDQuery_RetornaItensPedido: TFDQuery;
    FDQuery_Delete: TFDQuery;
    FDQuery_Select: TFDQuery;
    DataSource_Select: TDataSource;
    DataSource_ItensPedido: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uPedidoVendaPrincipal;

{$R *.dfm}

end.
