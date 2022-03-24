program PedidoDeVenda;

uses
  Vcl.Forms,
  uPedidoVendaPrincipal in 'uPedidoVendaPrincipal.pas' {Form_PedidoVendaPrincipal},
  uDataModule in 'uDataModule.pas' {DataModule1: TDataModule},
  uListaPedidos in 'uListaPedidos.pas' {Form_ListaPedidos},
  uComentarios in 'uComentarios.pas' {Form_Comentarios};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_PedidoVendaPrincipal, Form_PedidoVendaPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
