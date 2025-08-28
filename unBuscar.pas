unit unBuscar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Data.Win.ADODB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef,
  FireDAC.VCLUI.Wait;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    btnAbrir: TButton;
    Button1: TButton;
    DataSource1: TDataSource;
    FDQuery1: TFDQuery;
    FDConnection1: TFDConnection;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    FSelecionado: Integer;
  public
    function SelecionarEmpresa: Integer;
  end;

var
  Form2: TForm2;

implementation

uses unPrincipal;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

function TForm2.SelecionarEmpresa: Integer;
begin
  FSelecionado := -1;

  if ShowModal = mrOk then
    Result := FSelecionado
  else
    Result := -1;
end;


procedure TForm2.DBGrid1DblClick(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.IsEmpty then
  begin
    // Define o código selecionado
    FSelecionado := DBGrid1.DataSource.DataSet.FieldByName('CODFILIAL').AsInteger;

    // Seta o resultado modal para mrOk
    ModalResult := mrOk;

  end;
end;



end.
