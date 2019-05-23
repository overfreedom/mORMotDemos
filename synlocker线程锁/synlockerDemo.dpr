program synlockerDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  SynCommons,
  mORMot;

type
  TMyclass = class(TSynAutoCreatefields)

  end;

var
  fsafe2: Tsynlocker;

procedure ThreadSafeProcedure;
begin
  fsafe2.ProtectMethod;
  // thread-safe code

end;

procedure ThreadTest;
var
  fsafe: TSynLocker;
  a,b: Integer;
begin
  fsafe.Init;
  fsafe.Lock;
  try
    Inc(a);
    Inc(b);
  finally
    fsafe.UnLock;
  end;

  fsafe2.Init;
  ThreadSafeProcedure;// 这个方法这样调用是线程安全的。
  fsafe2.Done;

  with fsafe.ProtectMethod do // calls fSafe.Lock and return IUnknown local instance
  begin
    Inc(a);         // thread-safe code
    Inc(b);
  end;     //local hidden IUnknown will release the lock for the method

  fsafe.Done;
end;


begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

