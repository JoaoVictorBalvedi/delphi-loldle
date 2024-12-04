program loldleModule;

uses
  Vcl.Forms,
  Loldle in 'Loldle.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
