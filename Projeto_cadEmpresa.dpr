program Projeto_cadEmpresa;

uses
  Vcl.Forms,
  unPrincipal in 'unPrincipal.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  unBuscar in 'unBuscar.pas' {Form2},
  UnAPI in 'UnAPI.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
