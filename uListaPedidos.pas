unit uListaPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TForm_ListaPedidos = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid_ListaPedidos: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGrid_ListaPedidosDblClick(Sender: TObject);
    procedure DBGrid_ListaPedidosKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    Pedido: String;
    Cliente: String;
    { Public declarations }
  end;

var
  Form_ListaPedidos: TForm_ListaPedidos;

implementation

uses uDataModule;

{$R *.dfm}

procedure TForm_ListaPedidos.DBGrid_ListaPedidosDblClick(Sender: TObject);
begin
  Close;
  Pedido := DM.FDQuery_Select.FieldByName('numero').AsString;
  Cliente := DM.FDQuery_Select.FieldByName('cliente').AsString;
end;

procedure TForm_ListaPedidos.DBGrid_ListaPedidosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13  then
  begin
    Pedido := DM.FDQuery_Select.FieldByName('numero').AsString;
    Cliente := DM.FDQuery_Select.FieldByName('cliente').AsString;
    Close;
  end;
end;

procedure TForm_ListaPedidos.FormShow(Sender: TObject);
begin
  Pedido := '';
  with DM.FDQuery_Select do
  begin
    SQL.Text := 'select ' +
                'pedidos.numero, ' +
                'pedidos.dtemissao, ' +
                'pedidos.cliente, ' +
                'clientes.nome ' +
                'from ' +
                'pedidos ' +
                'inner join clientes on clientes.codigo = pedidos.cliente ' +
                'order by ' +
                'dtemissao ' +
                'desc';
    Open;
    DBGrid_ListaPedidos.SetFocus;
  end;
end;

end.
