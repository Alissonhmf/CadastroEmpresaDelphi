program Projeto_cadEmpresa;

uses
  Vcl.Forms,
  unPrincipal in 'unPrincipal.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  unBuscar in 'unBuscar.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sapphire Kamri');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
