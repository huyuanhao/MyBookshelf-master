program BookSourceMgr;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {Form1},
  Themes,
  Styles,
  uFrmWait in 'uFrmWait.pas' {Form2},
  uBookSourceBean in 'uBookSourceBean.pas',
  uFrmEditSource in 'uFrmEditSource.pas' {frmEditSource},
  uFrmReplaceGroup in 'uFrmReplaceGroup.pas' {frmReplaceGroup};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '�Ķ���Դ������';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
