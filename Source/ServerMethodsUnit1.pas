unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json, DSServer,
  Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter, Datasnap.DSSession;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    [TRoleAuth('user,admin,guest')]
    function GetUserName: string;
    [TRoleAuth('admin', 'user,guest')]
      function AdminEcho(Value: string): string;
    [TRoleAuth('user,admin', 'guest')]
      function UserEcho(Value: string): string;
    [TRoleAuth('user,admin,guest')]
      function EchoString(Value: string): string;
    [TRoleAuth('user,admin,guest')]
      function ReverseString(Value: string): string;
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses System.StrUtils;

function TServerMethods1.AdminEcho(Value: string): string;
begin
  Result := 'Admin - ' + Value;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetUserName: string;
var
  Session: TDSSession;
begin
  Session := TDSSessionManager.GetThreadSession;
  Result := Session.GetData('username') + ':' + Session.Username;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.UserEcho(Value: string): string;
begin
  Result := 'User - ' + Value;
end;

end.

