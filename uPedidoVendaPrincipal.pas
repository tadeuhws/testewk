unit uPedidoVendaPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, StrUtils;

type
  TForm_PedidoVendaPrincipal = class(TForm)
    Panel_Pedido: TPanel;
    Panel_ItensPedido: TPanel;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ComboBox_Cliente: TComboBox;
    Edit_CodigoProduto: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit_DescricaoProduto: TEdit;
    Label3: TLabel;
    Edit_Quantidade: TEdit;
    Edit_ValorUnitario: TEdit;
    Label4: TLabel;
    Edit_Total: TEdit;
    Button_Incluir: TButton;
    Button_Cancelar: TButton;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    PanelConfirmar: TPanel;
    Panel1: TPanel;
    Button_GravarPedido: TButton;
    Label5: TLabel;
    Edit_TotalDoPedido: TEdit;
    Button_ListaPedidos: TButton;
    Button_ExcluirPedido: TButton;
    procedure FormShow(Sender: TObject);
    procedure ListaClientes;
    procedure LimparDados;
    procedure Button_CancelarClick(Sender: TObject);
    procedure Edit_CodigoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure RetornaDadosProduto(Codigo: String);
    procedure AtualizaTotalProduto;
    procedure IncluirPedido;
    procedure Edit_QuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_ValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure Button_IncluirClick(Sender: TObject);
    procedure Button_GravarPedidoClick(Sender: TObject);
    procedure AtualizaTotalPedido;
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure RetornaDadosPedido;
    procedure AlterarPedido;
    procedure ExcluirPedido(Pedido: String);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button_ListaPedidosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button_ExcluirPedidoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_PedidoVendaPrincipal: TForm_PedidoVendaPrincipal;
  UltimoPedido: String;
  Inclusao: Boolean;

implementation

{$R *.dfm}

uses uDataModule, uListaPedidos, uComentarios;

procedure TForm_PedidoVendaPrincipal.Button_CancelarClick(Sender: TObject);
begin
  Edit_CodigoProduto.Enabled := True;
  Button_Incluir.Caption := 'Incluir';
  LimparDados;
end;

procedure TForm_PedidoVendaPrincipal.Button_ExcluirPedidoClick(Sender: TObject);
begin
  if Inclusao then
    LimparDados
  else
  begin
     if (MessageDlg('Confirma a exclusão do Pedido?', mtConfirmation,  [mbYes, mbNo], 0) = mrYes) then
     begin
        ExcluirPedido(UltimoPedido);
        LimparDados;
        DM.ClientDataSet_ItensPedido.EmptyDataSet;
        Inclusao := True;
     end;
  end;
end;


procedure TForm_PedidoVendaPrincipal.ExcluirPedido(Pedido: String);
begin
  try
    with DM.FDQuery_Delete do
    begin
      DM.FDTransaction.StartTransaction;

      // Excluindo os itens
      SQL.Text := 'delete ' +
                  'from ' +
                  'pedidos_itens ' +
                  'where ' +
                  'pedido = :pedido';
      ParamByName('pedido').AsInteger := StrToInt(Pedido);
      ExecSQL;

      // Excluindo o Pedido
      SQL.Text := 'delete ' +
                  'from ' +
                  'pedidos ' +
                  'where ' +
                  'numero = :numero';
      ParamByName('numero').AsInteger := StrToInt(Pedido);
      ExecSQL;

    end;

    DM.FDTransaction.Commit;
    LimparDados;
    ComboBox_Cliente.ItemIndex := -1;
    UltimoPedido := Pedido;
  except on E: Exception do
    begin
      DM.FDTransaction.Rollback;
      ShowMessage('Ocorreu um erro ao tentar gravar o pedido. (' + E.Message + ')');
    end;
  end;
end;

procedure TForm_PedidoVendaPrincipal.Button_GravarPedidoClick(Sender: TObject);
begin
  if ComboBox_Cliente.ItemIndex = - 1 then
  begin
    ShowMessage('Informe o cliente antes de gravar o pedido.');
    ComboBox_Cliente.SetFocus;
    Exit;
  end;

  if DM.ClientDataSet_ItensPedido.RecordCount = 0 then
  begin
    ShowMessage('Informe pelo menos um produto antes de gravar o pedido.');
    Edit_CodigoProduto.SetFocus;
    Edit_CodigoProduto.SelectAll;
    Exit;
  end;

  if (MessageDlg('Confirma a ' + IfThen(Inclusao, 'inclusão', 'alteração') + ' do Pedido?', mtConfirmation,  [mbYes, mbNo], 0) = mrYes) then
  begin
    if Inclusao then
      IncluirPedido
    else
      AlterarPedido;

    Inclusao := True;
    ComboBox_Cliente.ItemIndex := -1;
    DM.ClientDataSet_ItensPedido.EmptyDataSet;
    LimparDados;
    Edit_TotalDoPedido.Text := '0,00';
  end;
end;

procedure TForm_PedidoVendaPrincipal.RetornaDadosPedido;
begin
  // Procedure que retorna os dados do Pedido
  try
    with DM.FDQuery_RetornaItensPedido do
    begin
      SQL.Text := 'select ' +
                  'pedidos_itens.id, ' +
                  'pedidos_itens.produto, ' +
                  'produtos.descricao, ' +
                  'cast(pedidos_itens.quantidade as decimal(15,2)) as quantidade, ' +
                  'cast(pedidos_itens.vlrunitario as decimal(15,2)) as vlrunitario, ' +
                  'cast(pedidos_itens.vlrtotal as decimal(15,2)) as vlrtotal ' +
                  'from ' +
                  'pedidos_itens ' +
                  'inner join produtos on produtos.codigo = pedidos_itens.produto ' +
                  'where ' +
                  'pedidos_itens.pedido = :pedido';
      ParamByName('pedido').AsInteger := StrToInt(UltimoPedido);
      Open;
      DM.ClientDataSet_ItensPedido.EmptyDataSet;
      while not Eof do
      begin
        DM.ClientDataSet_ItensPedido.Insert;
        DM.ClientDataSet_ItensPedido.FieldByName('id').AsInteger :=  FieldByName('id').AsInteger;
        DM.ClientDataSet_ItensPedido.FieldByName('codigo').AsInteger :=  FieldByName('produto').AsInteger;
        DM.ClientDataSet_ItensPedido.FieldByName('descricao').AsString :=  FieldByName('descricao').AsString;
        DM.ClientDataSet_ItensPedido.FieldByName('valorunitario').AsFloat :=  FieldByName('vlrunitario').AsFloat;
        DM.ClientDataSet_ItensPedido.FieldByName('quantidade').AsFloat :=  FieldByName('quantidade').AsFloat;
        DM.ClientDataSet_ItensPedido.FieldByName('valortotal').AsFloat :=  FieldByName('vlrtotal').AsFloat;
        DM.ClientDataSet_ItensPedido.Post;
        Next;
      end;
      DM.ClientDataSet_ItensPedido.First;
      AtualizaTotalPedido;
    end;
  except on E: Exception do
    ShowMessage('Ocorreu um erro ao retornar os dados do pedido. (' + E.Message + ')');
  end;

end;

procedure TForm_PedidoVendaPrincipal.IncluirPedido;
var Pedido: String;
begin
  try
    with DM.FDQuery_Insert do
    begin
      DM.FDTransaction.StartTransaction;

      //Buscando o proximo numero do pedido
      Close;
      SQL.Text := 'select ' +
                  'coalesce(max(numero),0) + 1 as pedido ' +
                  'from ' +
                  'pedidos';
      Open;
      Pedido := FieldByName('pedido').AsString;


      // Inserindo o cabecalho do Pedido
      SQL.Text := 'insert ' +
                  'into ' +
                  'pedidos ' +
                  '(numero, dtemissao, cliente, vlrtotal) ' +
                  'values ' +
                  '(:numero, :dtemissao, :cliente, :vlrtotal)';
      ParamByName('numero').AsInteger  := StrToInt(Pedido);
      ParamByName('dtemissao').AsDate  := Now();
      ParamByName('cliente').AsInteger := StrToInt(ComboBox_Cliente.Items.Names[ComboBox_Cliente.ItemIndex]);
      ParamByName('vlrtotal').AsFloat  := StrToFloat(Edit_TotalDoPedido.Text);
      ExecSQL;

      DM.ClientDataSet_ItensPedido.First;
      while not DM.ClientDataSet_ItensPedido.Eof do
      begin

        // Inserindo os itens do pedido
        SQL.Text := 'insert ' +
                                  'into ' +
                                  'pedidos_itens ' +
                                  '(pedido, produto, quantidade, vlrunitario, vlrtotal) ' +
                                  'values ' +
                                  '(:pedido, :produto, :quantidade, :vlrunitario, :vlrtotal) ';
        ParamByName('pedido').AsInteger := StrToInt(Pedido);
        ParamByName('produto').AsInteger := DM.ClientDataSet_ItensPedido.FieldByName('codigo').AsInteger;
        ParamByName('quantidade').AsFloat := DM.ClientDataSet_ItensPedido.FieldByName('quantidade').AsFloat;
        ParamByName('vlrunitario').AsFloat := DM.ClientDataSet_ItensPedido.FieldByName('valorunitario').AsFloat;
        ParamByName('vlrtotal').AsFloat := DM.ClientDataSet_ItensPedido.FieldByName('valortotal').AsFloat;

        ExecSQL;

        DM.ClientDataSet_ItensPedido.Next;
      end;
    end;

    DM.FDTransaction.Commit;
    LimparDados;
    ComboBox_Cliente.ItemIndex := -1;
    UltimoPedido := Pedido;
  except on E: Exception do
    begin
      DM.FDTransaction.Rollback;
      ShowMessage('Ocorreu um erro ao tentar gravar o pedido. (' + E.Message + ')');
    end;
  end;
end;

procedure TForm_PedidoVendaPrincipal.AlterarPedido;
var Pedido: String;
    ItensExcluidos: String;
begin
  try
    with DM.FDQuery_Insert do
    begin
      DM.FDTransaction.StartTransaction;
      // Inserindo o cabecalho do Pedido
      SQL.Text := 'update ' +
                  'pedidos ' +
                  'set ' +
                  'cliente = :cliente, ' +
                  'vlrtotal = :vlrtotal ' +
                  'where ' +
                  'numero = :numero';
      ParamByName('cliente').AsInteger := StrToInt(ComboBox_Cliente.Items.Names[ComboBox_Cliente.ItemIndex]);
      ParamByName('vlrtotal').AsFloat  := StrToFloat(Edit_TotalDoPedido.Text);
      ParamByName('numero').AsInteger  := StrToInt(UltimoPedido);
      ExecSQL;

      DM.ClientDataSet_ItensPedido.First;
      ItensExcluidos := '';
      while not DM.ClientDataSet_ItensPedido.Eof do
      begin

        // Se existir o item atualiza se insere um novo item
        if DM.ClientDataSet_ItensPedidoid.AsInteger <> 0 then
        begin
          // Atualizando os itens do pedido
          SQL.Text := 'update ' +
                      'pedidos_itens ' +
                      'set ' +
                      'quantidade = :quantidade, ' +
                      'vlrunitario = :vlrunitario, ' +
                      'vlrtotal = :vlrtotal ' +
                      'where ' +
                      'id = :id';
          ParamByName('quantidade').AsFloat := DM.ClientDataSet_ItensPedido.FieldByName('quantidade').AsFloat;
          ParamByName('vlrunitario').AsFloat := DM.ClientDataSet_ItensPedido.FieldByName('valorunitario').AsFloat;
          ParamByName('vlrtotal').AsFloat := DM.ClientDataSet_ItensPedido.FieldByName('valortotal').AsFloat;
          ParamByName('id').AsInteger := DM.ClientDataSet_ItensPedido.FieldByName('id').AsInteger;

          ExecSQL;
        end else
        begin
          // Inserindo os itens do pedido
          SQL.Text := 'insert ' +
                      'into ' +
                      'pedidos_itens ' +
                      '(pedido, produto, quantidade, vlrunitario, vlrtotal) ' +
                      'values ' +
                      '(:pedido, :produto, :quantidade, :vlrunitario, :vlrtotal) ';
          ParamByName('pedido').AsInteger := StrToInt(UltimoPedido);
          ParamByName('produto').AsInteger := DM.ClientDataSet_ItensPedido.FieldByName('codigo').AsInteger;
          ParamByName('quantidade').AsFloat := DM.ClientDataSet_ItensPedido.FieldByName('quantidade').AsFloat;
          ParamByName('vlrunitario').AsFloat := DM.ClientDataSet_ItensPedido.FieldByName('valorunitario').AsFloat;
          ParamByName('vlrtotal').AsFloat := DM.ClientDataSet_ItensPedido.FieldByName('valortotal').AsFloat;

          ExecSQL;
        end;

        // Guardando os codigos dos itens
        ItensExcluidos := ItensExcluidos + DM.ClientDataSet_ItensPedido.FieldByName('codigo').AsString + ',';

        DM.ClientDataSet_ItensPedido.Next;
        end;
      // Depois de atualizar exclui os itens que foram excluidos na lista
      ItensExcluidos := Copy(ItensExcluidos,1,Length(ItensExcluidos)-1);

      SQL.Text := 'delete ' +
                  'from ' +
                  'pedidos_itens ' +
                  'where ' +
                  'produto not in (' + ItensExcluidos + ')';
      ExecSQL;
    end;

    DM.FDTransaction.Commit;
    LimparDados;
    ComboBox_Cliente.ItemIndex := -1;
    UltimoPedido := Pedido;
  except on E: Exception do
    begin
      DM.FDTransaction.Rollback;
      ShowMessage('Ocorreu um erro ao tentar gravar o pedido. (' + E.Message + ')');
    end;
  end;
end;

procedure TForm_PedidoVendaPrincipal.Button_IncluirClick(Sender: TObject);
begin
  if Trim(Edit_CodigoProduto.Text) = '' then
  begin
    ShowMessage('Informe o código.');
    Edit_CodigoProduto.SetFocus;
    Exit;
  end else
  begin
    try
      StrToInt(Edit_CodigoProduto.Text);
    except;
      ShowMessage('Código do Produto Inválido.');
      Edit_CodigoProduto.SetFocus;
      Edit_CodigoProduto.SelectAll;
      Exit;
    end;
    RetornaDadosProduto(Edit_CodigoProduto.Text);
  end;


  if Trim(Edit_Quantidade.Text) = '' then
  begin
    ShowMessage('Informe o quantidade.');
    Edit_Quantidade.SetFocus;
    Exit;
  end else
  begin
    try
      StrToFloat(Edit_Quantidade.Text);
    except;
      ShowMessage('Quantidade do Produto Inválida.');
      Edit_Quantidade.SetFocus;
      Edit_Quantidade.SelectAll;
      Exit;
    end;
  end;

  if Trim(Edit_ValorUnitario.Text) = '' then
  begin
    ShowMessage('Informe o valor.');
    Edit_ValorUnitario.SetFocus;
    Exit;
  end else
  begin
    try
      StrToFloat(Edit_ValorUnitario.Text);
    except;
      ShowMessage('Valor Unitário do Produto Inválido.');
      Edit_ValorUnitario.SetFocus;
      Edit_ValorUnitario.SelectAll;
      Exit;
    end;
  end;

  if Trim(Edit_Total.Text) = '' then
  begin
    ShowMessage('Total inválido.');
    Edit_CodigoProduto.SetFocus;
    Exit;
  end;

  Edit_Total.Text := FormatFloat('###,##0.00', StrToFloat(Edit_Quantidade.Text) * StrToFloat(Edit_ValorUnitario.Text));

  try
    with DM.ClientDataSet_ItensPedido do
    begin
      if Button_Incluir.Caption = 'Incluir' then
        Append
      else
        Edit;
      FieldByName('id').AsInteger := 0;
      FieldByName('codigo').AsInteger := StrToInt(Edit_CodigoProduto.Text);
      FieldByName('descricao').AsString := Edit_DescricaoProduto.Text;
      FieldByName('quantidade').AsFloat := StrToFloat(Edit_Quantidade.Text);
      FieldByName('valorunitario').AsFloat := StrToFloat(Edit_ValorUnitario.Text);
      FieldByName('valortotal').AsFloat := StrToFloat(Edit_Total.Text);
      Post;
      Button_Incluir.Caption := 'Incluir';
      Edit_CodigoProduto.Enabled := True;
      AtualizaTotalPedido;
      LimparDados;
    end;
  except on E: Exception do
    ShowMessage('Ocorreu um erro ao incluir o produto. (' + E.Message + ')');
  end;
end;

procedure TForm_PedidoVendaPrincipal.Button_ListaPedidosClick(Sender: TObject);
begin
  Application.CreateForm(TForm_ListaPedidos, Form_ListaPedidos);
  Form_ListaPedidos.ShowModal;
  if Form_ListaPedidos.Pedido <> '' then
  begin
    UltimoPedido := Form_ListaPedidos.Pedido;
    ComboBox_Cliente.ItemIndex := ComboBox_Cliente.Items.IndexOfName(FormatFloat('000000', StrToFloat(Form_ListaPedidos.Cliente)));
    Inclusao := False;
    RetornaDadosPedido;
    Edit_CodigoProduto.SetFocus;
  end;
end;

procedure TForm_PedidoVendaPrincipal.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then
  begin
    if (MessageDlg('Confirma a exclusão do Produto?', mtConfirmation,  [mbYes, mbNo], 0) = mrYes) then
      DM.ClientDataSet_ItensPedido.Delete;
  end;
end;

procedure TForm_PedidoVendaPrincipal.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    with DM.ClientDataSet_ItensPedido do
    begin
      Edit_CodigoProduto.Text := FormatFloat('000000', FieldByName('codigo').AsInteger);
      Edit_DescricaoProduto.Text := FieldByName('descricao').AsString;
      Edit_Quantidade.Text := FormatFloat('###,##0.00', FieldByName('quantidade').AsFloat);
      Edit_ValorUnitario.Text := FormatFloat('###,##0.00', FieldByName('valorunitario').AsFloat);
      Edit_Total.Text := FormatFloat('###,##0.00', FieldByName('valortotal').AsFloat);
      Button_Incluir.Caption := 'Atualizar';
      Edit_CodigoProduto.Enabled := False;
      Edit_Quantidade.SetFocus;
      Edit_Quantidade.SelectAll;
    end;
  end;
end;

procedure TForm_PedidoVendaPrincipal.FormActivate(Sender: TObject);
begin
  Application.CreateForm(TForm_Comentarios, Form_Comentarios);
  Form_Comentarios.ShowModal;
end;

procedure TForm_PedidoVendaPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm_PedidoVendaPrincipal.FormShow(Sender: TObject);
begin
  // Abrindo a conexa com o Banco e as tabelas de cadastros
  DM.FDConnection.Connected := True;
  DM.FDQuery_Clientes.Active := True;
  DM.FDQuery_Produtos.Active := True;
  DM.ClientDataSet_ItensPedido.Open;
  // Carregando no Combo de Clientes o cadatro
  ListaClientes;
  Inclusao := True;
end;

procedure TForm_PedidoVendaPrincipal.ListaClientes;
begin
  ComboBox_Cliente.Clear;
  with DM.FDQuery_Clientes do
  begin
    First;
    while not Eof do
    begin
      ComboBox_Cliente.Items.Add(FormatFloat('000000',DM.FDQuery_Clientescodigo.AsInteger) + '=' + DM.FDQuery_Clientesnome.AsString);
      Next;
    end;
  end;
end;


procedure TForm_PedidoVendaPrincipal.LimparDados;
begin
  if DM.ClientDataSet_ItensPedido.State in [dsInsert] then
    DM.ClientDataSet_ItensPedido.Cancel;

  Edit_CodigoProduto.Clear;
  Edit_DescricaoProduto.Clear;
  Edit_Quantidade.Clear;
  Edit_ValorUnitario.Clear;
  Edit_Total.Clear;
  Edit_CodigoProduto.SetFocus;
end;

procedure TForm_PedidoVendaPrincipal.Edit_CodigoProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    if Trim(Edit_CodigoProduto.Text) = '' then
    begin
      ShowMessage('Informe o código do Produto');
      Edit_CodigoProduto.SetFocus;
    end else
    begin
      RetornaDadosProduto(Edit_CodigoProduto.Text);
      Edit_Quantidade.SetFocus;
      Edit_Quantidade.SelectAll;
      AtualizaTotalProduto;
    end;
  end;
end;

procedure TForm_PedidoVendaPrincipal.Edit_QuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    if Trim(Edit_Quantidade.Text) = '' then
      Edit_Quantidade.Text := '1,00'
    else
    begin
      Edit_ValorUnitario.SetFocus;
      Edit_ValorUnitario.SelectAll;
      AtualizaTotalProduto;
    end;
  end;

end;

procedure TForm_PedidoVendaPrincipal.Edit_ValorUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    if Trim(Edit_ValorUnitario.Text) = '' then
      ShowMessage('Informe um valor para o produto.')
    else
    begin
      Button_Incluir.SetFocus;
      AtualizaTotalProduto;
    end;
  end;

  if Key = #127 then
  begin
    if (MessageDlg('Confirma a exclusão do Produto?', mtConfirmation,  [mbYes, mbNo], 0) = mrYes) then
    begin
      DM.ClientDataSet_ItensPedido.Delete;
      AtualizaTotalPedido;
    end;
  end;
  
end;

procedure TForm_PedidoVendaPrincipal.RetornaDadosProduto(Codigo: String);
begin
  // Retorna os dados do cadastro de produtos;
  // Aqui poderia ser usando o proprio dataset do cadastro com a funcao Locate mas estou usando sql para fins de demonstracao
  with Form_PedidoVendaPrincipal do
  begin
    with DM.FDQuery_RetornaDadosProduto do
    begin
      SQL.Text :=  'select  ' +
                   'codigo, ' +
                   'descricao, ' +
                   'cast(precovenda as decimal(15,2)) as precovenda ' +
                   'from ' +
                   'produtos ' +
                   'where ' +
                   'codigo = :codigo';
      ParamByName('codigo').AsInteger := StrToInt(Codigo);
      Open;
      if Eof then
        ShowMessage('Produto não encontrado.')
      else
      begin
        Edit_CodigoProduto.Text := FormatFloat('000000',FieldByName('codigo').AsInteger);
        Edit_DescricaoProduto.Text := FieldByName('descricao').AsString;
        Edit_Quantidade.Text := '1,00';
        Edit_ValorUnitario.Text := FormatFloat('###,##0.00', FieldByName('precovenda').AsFloat);
        Edit_Total.Text := FormatFloat('###,##0.00', FieldByName('precovenda').AsFloat * 1.00);
      end;
    end;
  end;

end;

procedure TForm_PedidoVendaPrincipal.AtualizaTotalProduto;
begin
  Edit_Total.Text := FormatFloat('###,##0.00', StrToFloat(Edit_Quantidade.Text) * StrToFloat(Edit_ValorUnitario.Text));
end;

procedure TForm_PedidoVendaPrincipal.AtualizaTotalPedido;
var Recno: Integer;
    Total: Double;
begin
  with DM.ClientDataSet_ItensPedido do
  begin
    DisableControls;
    Recno := Recno;
    First;
    Total := 0;
    while not Eof do
    begin
      Total := Total + FieldByName('valortotal').AsFloat;
      Next;
    end;
    EnableControls;
    Recno := Recno;
  end;

  Edit_TotalDoPedido.Text := FormatFloat('###,##0.00', Total);

end;

end.

