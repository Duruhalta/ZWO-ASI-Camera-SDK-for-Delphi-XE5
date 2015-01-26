program ASI_Demo;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ASICamera2 in 'ASICamera2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
