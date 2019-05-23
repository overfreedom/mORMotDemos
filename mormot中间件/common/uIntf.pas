/// <author>cxg 2017-12-21</author>
/// websocket ½Ó¿Ú

unit uIntf;

interface

uses
  SysUtils,
  SynCommons,
  mORMot;

type
  IChatCallback = interface(IInvokable)
    ['{20579BB6-BD9B-4D28-AA70-526348B36DA5}']
    procedure NotifyMsg(const connid, msg: string);
  end;

  IChatService = interface(IServiceWithCallbackReleased)
    ['{A468FF15-1990-49A7-BF29-1A17ECF11B4B}']
    procedure Join(const connid: string; const callback: IChatCallback);
    procedure msg(const connid, msg: string);
  end;

implementation

initialization
  TInterfaceFactory.RegisterInterfaces([
    TypeInfo(IChatService),TypeInfo(IChatCallback)]);
end.
