unit unPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Data.DB, Data.Win.ADODB, unBuscar;

type
  TForm1 = class(TForm)
    Pn1: TPanel;
    btnGravar: TButton;
    btnNovo: TButton;
    btnEditar: TButton;
    btnSair: TButton;
    pgCadastro: TPageControl;
    btnBuscar: TButton;
    btnCancelar: TButton;
    tsCadastro: TTabSheet;
    tsContador: TTabSheet;
    tsFiscal: TTabSheet;
    pnEmpresa: TPanel;
    lbCodigo: TLabel;
    edtCodigo: TEdit;
    lbRazaoSocial: TLabel;
    edtRazaoSocial: TEdit;
    lbFantasia: TLabel;
    edtFantasia: TEdit;
    edtCnpj: TEdit;
    lbCnpj: TLabel;
    edtIe: TEdit;
    lbInscricao: TLabel;
    lbEmail: TLabel;
    edtEmail: TEdit;
    edtTelefone: TEdit;
    lbTelefone: TLabel;
    edtCodCli: TEdit;
    lbCodCli: TLabel;
    edtCodFornec: TEdit;
    lbCodFornec: TLabel;
    edtNomeCli: TEdit;
    edtNomeFornec: TEdit;
    pn2: TPanel;
    lbEnderecoEmpresa: TLabel;
    edtEndereco: TEdit;
    lbEndereco: TLabel;
    lbBairro: TLabel;
    edtBairro: TEdit;
    lbCep: TLabel;
    edtCep: TEdit;
    edtComplemento: TEdit;
    lbComplemento: TLabel;
    edtCidade: TEdit;
    edtCodmunicipio: TEdit;
    lbCidade: TLabel;
    lbCodMunicipio: TLabel;
    lbCodMunicipi: TLabel;
    cbUf: TComboBox;
    lbNomeContador: TLabel;
    edtNomeContador: TEdit;
    lbCpfCnpjContador: TLabel;
    edtCpfCnpjContador: TEdit;
    lbCrcContador: TLabel;
    edtCrcContador: TEdit;
    pn3: TPanel;
    lbEnderecoContador: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    edtEnderecoContador: TEdit;
    edtBairroContador: TEdit;
    edtCepContador: TEdit;
    edtComplementoContador: TEdit;
    cbUfContador: TComboBox;
    lbEmailContador: TLabel;
    edtEmailContador: TEdit;
    edtTelefoneContador: TEdit;
    lbTelefoneContador: TLabel;
    edtProxNumNfe: TEdit;
    lbProxNumNota: TLabel;
    edtSerie: TEdit;
    edtPerProtege: TEdit;
    lbPerProtege: TLabel;
    lbSerie: TLabel;
    pn4: TPanel;
    lbDirTelas: TLabel;
    edtDirTelas: TEdit;
    lbTipoTribut: TLabel;
    cbTipoTribut: TComboBox;
    lbProxNumNfce: TLabel;
    edtProxNumNfce: TEdit;
    lbProxNumCte: TLabel;
    edtProxNumCte: TEdit;
    edtProxNumMdfe: TEdit;
    lbProxNumMdfe: TLabel;
    lbDirNfe: TLabel;
    edtDirNfe: TEdit;
    edtDirMdfe: TEdit;
    lbDirMdfe: TLabel;
    lbEnviaApp: TLabel;
    cbEnviarApp: TComboBox;
    cbTransportadora: TComboBox;
    lbTrasnportador: TLabel;
    lbUsaCredIcms: TLabel;
    cbUsaCredPisCofins: TComboBox;
    lbUsaCredPisCofins: TLabel;
    cbUsaCredIcms: TComboBox;
    lbProxCodCli: TLabel;
    edtProxCodCli: TEdit;
    edtProxCodFornec: TEdit;
    lbProxCodFornec: TLabel;
    edtProxCodProd: TEdit;
    lbProxCodProd: TLabel;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    cbBloqNfNContribEstadual: TComboBox;
    cbBloqNfNContribInter: TComboBox;
    lbBloqNfNContribInter: TLabel;
    lbBloqNfNContribEstadual: TLabel;
    cbBloqNfPfEstadual: TComboBox;
    lbBloqNfPfEstadual: TLabel;
    lbBloqNfPfInter: TLabel;
    cbBloqNfPfInter: TComboBox;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure LimparCampos;
    function ProxCodEmpresa: Integer;
    function MontaCamposValores: TStringList;
    procedure edtCodCliChange(Sender: TObject);
    procedure edtCodFornecChange(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure CarregarEmpresa(Codigo: Integer);
    procedure btnEditarClick(Sender: TObject);
    procedure InsertEmpresa(Lista: TStringList);
    procedure UpdateEmpresa(Lista: TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  quemChamou: String;

implementation

{$R *.dfm}


procedure TForm1.btnBuscarClick(Sender: TObject);
var
  Codigo: Integer;
begin
  with TForm2.Create(Self) do
  try
    Codigo := SelecionarEmpresa;
  finally
    Free;
  end;

  if Codigo > 0 then
    begin
    CarregarEmpresa(Codigo);
    btnEditar.Enabled:= True;
    end;




end;

procedure TForm1.CarregarEmpresa(Codigo: Integer);
var
  qryEmpresa,qryParam: TADOQuery;
begin
  qryEmpresa := TADOQuery.Create(nil);
  try
    qryEmpresa.Connection := ADOConnection1;
    qryEmpresa.SQL.Clear;
    qryEmpresa.SQL.Text :=
      'SELECT * FROM AC_CADASTRO_EMPRESA WHERE CODFILIAL = :CODFILIAL';
    qryEmpresa.Parameters.ParamByName('CODFILIAL').Value := Format('%.2d', [Codigo]); // <=== use o parâmetro
    qryEmpresa.Open;

    if qryEmpresa.IsEmpty then
    begin
      ShowMessage('Empresa não encontrada!');
      Exit;
    end;

    // -------- Identificação / cadastro --------
    edtCodigo.Text       := qryEmpresa.FieldByName('CODFILIAL').AsString;
    edtRazaoSocial.Text  := qryEmpresa.FieldByName('FILIAL').AsString;
    edtFantasia.Text     := qryEmpresa.FieldByName('NOMEFANTASIA').AsString;
    edtCnpj.Text         := qryEmpresa.FieldByName('CPFCNPJ').AsString;
    edtIe.Text           := qryEmpresa.FieldByName('IE').AsString;
    edtEmail.Text        := qryEmpresa.FieldByName('EMAIL').AsString;
    edtCodCli.Text       := qryEmpresa.FieldByName('CODCLI').AsString;
    edtCodFornec.Text    := qryEmpresa.FieldByName('CODFORNEC').AsString;
    edtTelefone.Text     := qryEmpresa.FieldByName('TELEFONE').AsString;

    // -------- Endereço da empresa --------
    edtEndereco.Text      := qryEmpresa.FieldByName('ENDERECO').AsString;
    edtBairro.Text        := qryEmpresa.FieldByName('BAIRRO').AsString;
    edtCidade.Text        := qryEmpresa.FieldByName('CIDADE').AsString;
    edtCep.Text           := qryEmpresa.FieldByName('CEP').AsString;
    edtComplemento.Text   := qryEmpresa.FieldByName('COMPLEMENTO').AsString;
    edtCodMunicipio.Text  := qryEmpresa.FieldByName('CODMUNICIPIO').AsString;
    cbUf.Text             := qryEmpresa.FieldByName('UF').AsString;

    // -------- Numeração / configurações fiscais --------
    edtProxNumNfe.Text    := qryEmpresa.FieldByName('PROXNUMNOTA').AsString;
    edtSerie.Text         := qryEmpresa.FieldByName('SERIE').AsString;
    cbTipoTribut.Text     := qryEmpresa.FieldByName('TIPOTRIBUT').AsString;
    edtProxNumNfce.Text   := qryEmpresa.FieldByName('PROXNUMNFCONSUMIDOR').AsString;
    edtDirNfe.Text        := qryEmpresa.FieldByName('DIRNFE').AsString;
    edtProxNumCte.Text    := qryEmpresa.FieldByName('PROXNUMCONHEC').AsString;
    edtProxNumMdfe.Text   := qryEmpresa.FieldByName('PROXNUMMDFE').AsString;
    edtDirMdfe.Text       := qryEmpresa.FieldByName('DIRMDFE').AsString;
    cbTransportadora.Text := qryEmpresa.FieldByName('TRANSPORTADORA').AsString;
    edtPerProtege.Text    := qryEmpresa.FieldByName('PER_PROTEGE').AsString;
    cbEnviarapp.Text      := qryEmpresa.FieldByName('DISP_APP').AsString;
    cbBloqNfNContribEstadual.Text  := qryEmpresa.FieldByName('BLOQ_NF_N_CONTRIB_ESTADUAL').AsString;
    cbBloqNfNContribInter.Text     := qryEmpresa.FieldByName('BLOQ_NF_N_CONTRIB_INTEREST').AsString;
    cbBloqNfPfEstadual.Text        := qryEmpresa.FieldByName('BLOQ_NF_PF_ESTADUAL').AsString;
    cbBloqNfPfInter.Text           := qryEmpresa.FieldByName('BLOQ_NF_PF_INTEREST').AsString;

    // -------- Dados do contador --------
    edtNomeContador.Text       := qryEmpresa.FieldByName('CONTADORNOME').AsString;
    edtCpfCnpjContador.Text    := qryEmpresa.FieldByName('CONTADORCPFCNPJ').AsString;
    edtCrcContador.Text        := qryEmpresa.FieldByName('CONTADORCRC').AsString;
    cbUfContador.Text          := qryEmpresa.FieldByName('CONTADORUF').AsString;
    edtCepContador.Text        := qryEmpresa.FieldByName('CONTADORCEP').AsString;
    edtEnderecoContador.Text   := qryEmpresa.FieldByName('CONTADORENDERECO').AsString;
    edtComplementoContador.Text:= qryEmpresa.FieldByName('CONTADORCOMPLEMENTO').AsString;
    edtBairroContador.Text     := qryEmpresa.FieldByName('CONTADORBAIRRO').AsString;
    edtTelefoneContador.Text   := qryEmpresa.FieldByName('CONTADORTELEFONE').AsString;
    edtEmailContador.Text      := qryEmpresa.FieldByName('CONTADOREMAIL').AsString;

  finally
    qryEmpresa.Free;
  end;

  qryParam := TADOQuery.Create(nil);
   try
    qryParam.Connection := ADOConnection1;
    qryParam.SQL.Clear;
    qryParam.SQL.Text :=
      'SELECT * FROM AC_CADASTRO_PARAMETRIZACAO';
    qryParam.Open;

   if qryParam.IsEmpty then
    begin
      ShowMessage('Falha ao abrir cadastro de parametrização!');
      Exit;
    end;


    // -------- Parametrizações / cadastro --------
    edtDirTelas.Text        := qryParam.FieldByName('DIRETORIO_TELAS').AsString;
    edtProxCodCli.Text      := qryParam.FieldByName('PROXCODCLI').AsString;
    edtProxCodFornec.Text   := qryParam.FieldByName('PROXCODFORNEC').AsString;
    edtProxCodProd.Text     := qryParam.FieldByName('PROXCODPROD').AsString;
    cbUsaCredIcms.Text      := qryParam.FieldByName('USACREDICM').AsString;
    cbUsaCredPisCofins.Text      := qryParam.FieldByName('USACREDPISCOFINS').AsString;

  finally
    qryParam.Free;
  end;
end;




procedure TForm1.btnCancelarClick(Sender: TObject);
var
I: integer;

begin

 btnBuscar.Enabled   := True;
 btnNovo.Enabled     := True;
 btnSair.Enabled     := True;
 btnCancelar.Enabled := False;
 btnGravar.Enabled   := False;
 btnEditar.Enabled   := False;

 tsCadastro.Enabled  := False;
 tsContador.Enabled  := False;
 tsFiscal.Enabled    := False;

 LimparCampos;

end;

procedure TForm1.btnEditarClick(Sender: TObject);
begin
 tsCadastro.Enabled:= True;
 tsContador.Enabled:= True;
 tsFiscal.Enabled:= True;

 btnBuscar.Enabled:= False;
 btnCancelar.Enabled:= True;
 btnGravar.Enabled:= True;
 btnNovo.Enabled:= False;

 quemChamou:= 'Editar';
end;

procedure TForm1.btnGravarClick(Sender: TObject);
var
  Lista: TStringList;
begin
  Lista := MontaCamposValores;
  try
    if quemChamou = 'Editar' then
      UpdateEmpresa(Lista)
    else if quemChamou = 'Novo' then
      InsertEmpresa(Lista);

    quemChamou := '';
  finally
    Lista.Free;
  end;

  btnCancelarClick(Sender);
end;



procedure TForm1.btnNovoClick(Sender: TObject);

var
proxCod: Integer;

begin

 LimparCampos;

 btnBuscar.Enabled:= False;
 btnNovo.Enabled:= False;
 btnSair.Enabled:= False;
 btnCancelar.Enabled:= True;
 btnGravar.Enabled:= True;

 tsCadastro.Enabled:= True;
 tsContador.Enabled:= True;
 tsFiscal.Enabled:= True;

 edtCodigo.Text:= ('0'+InttoStr(ProxCodEmpresa));

 quemChamou:= 'Novo';

 cbUsaCredIcms.ItemIndex := 0;
 cbEnviarApp.ItemIndex := 0;
 cbTransportadora.ItemIndex := 1;
 cbBloqNfNContribEstadual.ItemIndex := 1;
 cbBloqNfNContribInter.ItemIndex := 1;
 cbBloqNfPfEstadual.ItemIndex := 1;
 cbBloqNfPfInter.ItemIndex := 1;
 cbUsaCredPisCofins.ItemIndex := 0;


end;

procedure TForm1.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  cbUf.Items.Clear;
  cbUf.Items.AddStrings(['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA',
                              'MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN',
                              'RS','RO','RR','SC','SP','SE','TO']);

  cbUfContador.Items.Clear;
  cbUfContador.Items.AddStrings(['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA',
                              'MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN',
                              'RS','RO','RR','SC','SP','SE','TO']);

  cbTipoTribut.Items.Clear;
  cbtipotribut.Items.AddStrings(['1 - Simples Nacional','2 - Lucro Presumido', '3 - Lucro Real' ]);

  cbEnviarApp.Items.Clear;
  cbEnviarApp.Items.AddStrings(['S','N']);

  cbTransportadora.Items.Clear;
  cbTransportadora.Items.AddStrings(['S','N']);

  cbBloqNfNContribEstadual.Items.Clear;
  cbBloqNfNContribEstadual.Items.AddStrings(['S','N']);

  cbBloqNfNContribInter.Items.Clear;
  cbBloqNfNContribInter.Items.AddStrings(['S','N']);

  cbBloqNfPfEstadual.Items.Clear;
  cbBloqNfPfEstadual.Items.AddStrings(['S','N']);

  cbBloqNfPfInter.Items.Clear;
  cbBloqNfPfInter.Items.AddStrings(['S','N']);

  cbUsaCredPisCofins.Items.Clear;
  cbUsaCredPisCofins.Items.AddStrings(['S','N']);

  cbUsaCredIcms.Items.Clear;
  cbUsaCredIcms.Items.AddStrings(['S','N']);

end;

procedure TForm1.LimparCampos;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TEdit then
      (Components[i] as TEdit).Clear
    else if Components[i] is TComboBox then
      (Components[i] as TComboBox).ItemIndex := -1;
  end;
end;

function TForm1.ProxCodEmpresa: Integer;
var

proxCodEmpresa: Integer;

begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('SELECT MAX(CODFILIAL) AS CODFILIAL FROM AC_CADASTRO_EMPRESA');
    ADOQuery1.Open;

    if ADOQuery1.Fields[0].IsNull then
    begin
      proxCodEmpresa:= 1;

    end
    else
    begin
     proxCodEmpresa:= ADOQuery1.FieldByName('CODFILIAL').AsInteger + 1;
    end;

    result:= proxCodEmpresa;

end;

// Função que cria dinamicamente uma lista de "Campo=Valor"
// Isso centraliza a lógica de quais campos serão gravados
function TForm1.MontaCamposValores: TStringList;
begin
  Result := TStringList.Create;

  // -------- Identificação / cadastro --------
  if Trim(edtCodigo.Text) <> ''        then Result.Add('CODFILIAL='      + Trim(edtCodigo.Text));
  if Trim(edtRazaoSocial.Text) <> ''   then Result.Add('FILIAL='         + Trim(edtRazaoSocial.Text)); // Razão social
  if Trim(edtFantasia.Text) <> ''      then Result.Add('NOMEFANTASIA='   + Trim(edtFantasia.Text));
  if Trim(edtCnpj.Text) <> ''          then Result.Add('CPFCNPJ='        + Trim(edtCnpj.Text));
  if Trim(edtIe.Text) <> ''            then Result.Add('IE='             + Trim(edtIe.Text));
  if Trim(edtEmail.Text) <> ''         then Result.Add('EMAIL='          + Trim(edtEmail.Text));
  if Trim(edtCodCli.Text) <> ''        then Result.Add('CODCLI='         + Trim(edtCodCli.Text));
  if Trim(edtCodFornec.Text) <> ''     then Result.Add('CODFORNEC='      + Trim(edtCodFornec.Text));
  if Trim(edtTelefone.Text) <> ''      then Result.Add('TELEFONE='       + Trim(edtTelefone.Text));

  // -------- Endereço da empresa --------
  if Trim(edtEndereco.Text) <> ''      then Result.Add('ENDERECO='       + Trim(edtEndereco.Text));
  if Trim(edtBairro.Text) <> ''        then Result.Add('BAIRRO='         + Trim(edtBairro.Text));
  if Trim(edtCidade.Text) <> ''        then Result.Add('CIDADE='         + Trim(edtCidade.Text));
  if Trim(edtCep.Text) <> ''           then Result.Add('CEP='            + Trim(edtCep.Text));
  if Trim(edtComplemento.Text) <> ''   then Result.Add('COMPLEMENTO='    + Trim(edtComplemento.Text));
  if Trim(edtCodMunicipio.Text) <> ''  then Result.Add('CODMUNICIPIO='   + Trim(edtCodMunicipio.Text));

  // A tabela tem UF e ESTADO. Se você quiser espelhar o mesmo valor nos dois:
  if Trim(cbUf.Text) <> '' then
  begin
    Result.Add('UF='     + Trim(cbUf.Text));
    Result.Add('ESTADO=' + Trim(cbUf.Text)); // remova esta linha se ESTADO não for usado
  end;

  // -------- Numeração / configurações fiscais --------
  if Trim(edtProxNumNfe.Text) <> ''    then Result.Add('PROXNUMNOTA='           + Trim(edtProxNumNfe.Text));
  if Trim(edtSerie.Text) <> ''         then Result.Add('SERIE='                 + Trim(edtSerie.Text));
  //if Trim(cbTipoTribut.Text) <> ''     then Result.Add('TIPOTRIBUT='            + Trim(cbTipoTribut.Text));
  if Trim(edtProxNumNfce.Text) <> ''   then Result.Add('PROXNUMNFCONSUMIDOR='   + Trim(edtProxNumNfce.Text));
  if Trim(edtDirNfe.Text) <> ''        then Result.Add('DIRNFE='                + Trim(edtDirNfe.Text));
  if Trim(edtProxNumCte.Text) <> ''    then Result.Add('PROXNUMCONHEC='         + Trim(edtProxNumCte.Text));
  if Trim(edtProxNumMdfe.Text) <> ''   then Result.Add('PROXNUMMDFE='           + Trim(edtProxNumMdfe.Text));
  if Trim(edtDirMdfe.Text) <> ''       then Result.Add('DIRMDFE='               + Trim(edtDirMdfe.Text));
  if Trim(cbTransportadora.Text) <> '' then Result.Add('TRANSPORTADORA='        + Trim(cbTransportadora.Text));

  // -------- Dados do contador --------
  if Trim(edtNomeContador.Text) <> ''        then Result.Add('CONTADORNOME='        + Trim(edtNomeContador.Text));
  if Trim(edtCpfCnpjContador.Text) <> ''     then Result.Add('CONTADORCPFCNPJ='     + Trim(edtCpfCnpjContador.Text));
  if Trim(edtCrcContador.Text) <> ''         then Result.Add('CONTADORCRC='         + Trim(edtCrcContador.Text));
  if Trim(cbUfContador.Text) <> ''           then Result.Add('CONTADORUF='          + Trim(cbUfContador.Text));
  if Trim(edtCepContador.Text) <> ''         then Result.Add('CONTADORCEP='         + Trim(edtCepContador.Text));
  if Trim(edtEnderecoContador.Text) <> ''    then Result.Add('CONTADORENDERECO='    + Trim(edtEnderecoContador.Text));
  if Trim(edtComplementoContador.Text) <> '' then Result.Add('CONTADORCOMPLEMENTO=' + Trim(edtComplementoContador.Text));
  if Trim(edtBairroContador.Text) <> ''      then Result.Add('CONTADORBAIRRO='      + Trim(edtBairroContador.Text));
  if Trim(edtTelefoneContador.Text) <> ''    then Result.Add('CONTADORTELEFONE='    + Trim(edtTelefoneContador.Text));
  if Trim(edtEmailContador.Text) <> ''       then Result.Add('CONTADOREMAIL='       + Trim(edtEmailContador.Text));
end;


procedure TForm1.edtCodCliChange(Sender: TObject);
begin
  if edtCodigo.Text <> '' then
  begin
    try
      ADOQuery1.Close;
      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('SELECT CLIENTE FROM AC_CADASTRO_CLIENTES WHERE CODCLI = :codigobuscar');
      ADOQuery1.Parameters.ParamByName('codigobuscar').Value := edtCodCli.Text;
      ADOQuery1.Open;

      if not ADOQuery1.Fields[0].IsNull then
        edtNomeCli.Text := ADOQuery1.Fields[0].AsString
      else
        edtNomeCli.Clear;

    finally
      ADOQuery1.Close;
    end;
  end
  else
    edtNomeCli.Clear; // se apagar o código, limpa também o nome
end;

procedure TForm1.edtCodFornecChange(Sender: TObject);
begin
  if edtCodFornec.Text <> '' then
  begin
    try
      ADOQuery1.Close;
      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('SELECT FORNECEDOR FROM AC_CADASTRO_FORNECEDORES WHERE CODFORNEC = :codigobuscar');
      ADOQuery1.Parameters.ParamByName('codigobuscar').Value := edtCodFORNEC.Text;
      ADOQuery1.Open;

      if not ADOQuery1.Fields[0].IsNull then
        edtNomeFornec.Text := ADOQuery1.Fields[0].AsString
      else
        edtNomeFornec.Clear;

    finally
      ADOQuery1.Close;
    end;
  end
  else
    edtNomeFornec.Clear; // se apagar o código, limpa também o nome
end;

// Função responsável por inserir uma nova empresa no banco
procedure TForm1.InsertEmpresa(Lista: TStringList);
var
  qry: TADOQuery;
  Campos, Valores: string;
  i: Integer;
begin
  qry := TADOQuery.Create(nil);
  try
    qry.Connection := ADOConnection1;

    Campos := '';
    Valores := '';

    // Percorre a lista "CAMPO=VALOR" e monta duas strings:
    // uma só com os nomes dos campos e outra só com os valores
    for i := 0 to Lista.Count - 1 do
    begin
      Campos := Campos + Lista.Names[i] + ', ';
      Valores := Valores + QuotedStr(Lista.ValueFromIndex[i]) + ', ';
    end;

    // Remove a vírgula extra do final
    Delete(Campos, Length(Campos)-1, 2);
    Delete(Valores, Length(Valores)-1, 2);

    // Monta o SQL de insert
    qry.SQL.Text :=
      'INSERT INTO AC_CADASTRO_EMPRESA (' + Campos + ') ' +
      'VALUES (' + Valores + ')';

    qry.ExecSQL; // Executa o comando

    ShowMessage('Registro inserido com sucesso!');
  finally
    qry.Free;
  end;
end;


// Função responsável por atualizar os dados de uma empresa já existente
procedure TForm1.UpdateEmpresa(Lista: TStringList);
var
  qry: TADOQuery;
  Sets: string;
  i: Integer;
begin
  qry := TADOQuery.Create(nil);
  try
    qry.Connection := ADOConnection1;

    Sets := '';
    // Percorre a lista e cria os pares "CAMPO = VALOR"
    for i := 0 to Lista.Count - 1 do
    begin
      // Evita atualizar a chave primária (CODFILIAL)
      if UpperCase(Lista.Names[i]) <> 'CODFILIAL' then
        Sets := Sets + Lista.Names[i] + ' = ' + QuotedStr(Lista.ValueFromIndex[i]) + ', ';
    end;

    // Remove a vírgula extra
    Delete(Sets, Length(Sets)-1, 2);

    // Monta o SQL de update
    qry.SQL.Text :=
      'UPDATE AC_CADASTRO_EMPRESA SET ' + Sets +
      ' WHERE CODFILIAL = ' + QuotedStr(edtCodigo.Text);

    qry.ExecSQL;

    ShowMessage('Registro atualizado com sucesso!');
  finally
    qry.Free;
  end;
end;


end.
