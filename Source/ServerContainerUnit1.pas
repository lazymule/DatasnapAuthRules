unit ServerContainerUnit1;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSClientMetadata, Datasnap.DSHTTPServiceProxyDispatcher,
  Datasnap.DSProxyJavaAndroid, Datasnap.DSProxyJavaBlackBerry,
  Datasnap.DSProxyObjectiveCiOS, Datasnap.DSProxyCsharpSilverlight,
  Datasnap.DSProxyFreePascal_iOS,
  Datasnap.DSAuth, Datasnap.DSSession;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSAuthenticationManager1: TDSAuthenticationManager;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

function DSServer: TDSServer;
function DSAuthenticationManager: TDSAuthenticationManager;

implementation

{$R *.dfm}

uses Winapi.Windows, ServerMethodsUnit1, FormUnit1;

var
  FModule: TComponent;
  FDSServer: TDSServer;
  FDSAuthenticationManager: TDSAuthenticationManager;

function DSServer: TDSServer;
begin
  Result := FDSServer;
end;

function DSAuthenticationManager: TDSAuthenticationManager;
begin
  Result := FDSAuthenticationManager;
end;

constructor TServerContainer1.Create(AOwner: TComponent);
begin
  inherited;
  FDSServer := DSServer1;
  FDSAuthenticationManager := DSAuthenticationManager1;
end;

destructor TServerContainer1.Destroy;
begin
  inherited;
  FDSServer := nil;
  FDSAuthenticationManager := nil;
end;

procedure TServerContainer1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit1.TServerMethods1;
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
var
  session: TDSSession;
begin
  if Length(User) = 0 then
    valid := False
  else if User = Password then
  begin
    valid := True;      // Kullanýcýyý Kabul Et
    Session := TDSSessionManager.GetThreadSession;
    Session.PutData('username', user);
    if User = 'user' then
      UserRoles.Add('user')
    else if User = 'admin' then
      UserRoles.Add('admin')
    else
      UserRoles.Add('guest');

  end
  else
    valid := False;       // Kullanýcýyý red et
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthorize(
  Sender: TObject; EventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
var
  I: Integer;
begin
  // Kullanýnýn rolünün olayýn rölünde izni varmý bak varsa izin ver yoksa red et
  if EventObject.UserRoles <> nil then
    if EventObject.AuthorizedRoles <> nil then
    begin
      for I := 0 to EventObject.UserRoles.Count - 1 do
      begin
        if EventObject.AuthorizedRoles.IndexOf(EventObject.UserRoles[i]) >= 0
          then
        begin
          Form1.Memo1.Lines.Add(EventObject.UserName + ' - ' +
            EventObject.MethodAlias + ' - ' +
            'Ýzin Verildi');
          valid := True;
        end
        else
        begin
          Form1.Memo1.Lines.Add(EventObject.UserName + ' - ' +
            EventObject.MethodAlias + ' - ' + 'Red Edildi');
          valid := False;
        end;
      end;
    end
    else if EventObject.MethodAlias = 'DSAdmin.DescribeMethod' then
    begin
    // web ile alakalý bir durum kapatýlabilir
      Form1.Memo1.Lines.Add(EventObject.UserName + ' - ' +
        EventObject.MethodAlias + ' - ' + 'Ýzin Verildi');
      valid := True
    end
    else
    begin
      Form1.Memo1.Lines.Add(EventObject.UserName + ' - ' +
        EventObject.MethodAlias + ' - ' + 'Red Edildi');
      valid := False;
    end;
end;

initialization
  FModule := TServerContainer1.Create(nil);
finalization
  FModule.Free;
end.

