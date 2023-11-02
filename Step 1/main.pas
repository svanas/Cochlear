unit main;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls;

type
  TStatus = (Idle, Running, Paused, Stopped);

  ICustomTask = interface
  ['{751969A6-EAB4-4D63-88F9-E1A28CA424F9}']
    function Pause: Boolean;
    function Start: Boolean;
    function Status: TStatus;
    function Stop: Boolean;
  end;

type
  TFrmMain = class(TForm)
    Label1: TLabel;
    btnStart1: TButton;
    btnStop1: TButton;
    Label2: TLabel;
    btnStart2: TButton;
    btnStop2: TButton;
    Label3: TLabel;
    btnStart3: TButton;
    btnStop3: TButton;
    Label4: TLabel;
    btnStart4: TButton;
    btnStop4: TButton;
    Label5: TLabel;
    btnStart5: TButton;
    btnStop5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    FTasks: array[0..4] of ICustomTask;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  System.Threading;

{ TCustomTask }

type
  TCustomTask = class(TTask, ICustomTask)
  strict private
    FPaused : Boolean;
    FStopped: Boolean;
  public
    function Pause: Boolean;
    function Start: Boolean;
    function Status: TStatus;
    function Stop: Boolean;
  end;

function TCustomTask.Pause: Boolean;
begin
  Result := True;
  case Self.Status of
    Idle   : Result := False; // cannot pause a task that is not running
    Running: FPaused := True;
    Paused : ;                // already paused, nothing to do
    Stopped: Result := False; // cannot pause a task that has already stopped
  end;
end;

function TCustomTask.Start: Boolean;
begin
  Result := True;
  case Self.Status of
    Idle   : inherited Start;  // begin running the task
    Running: ;                 // already started, nothing to do
    Paused : FPaused := False;
    Stopped: Result := False;  // cannot start a task that has already stopped
  end;
end;

function TCustomTask.Status: TStatus;
begin
  Result := Idle;
  if FStopped or (Self.GetStatus = TTaskStatus.Completed) then
    Result := Stopped
  else
    if Self.GetStatus in [TTaskStatus.WaitingToRun, TTaskStatus.Running] then
      if FPaused then
        Result := Paused
      else
        Result := Running;
end;

function TCustomTask.Stop: Boolean;
begin
  Result := True;
  case Self.Status of
    Idle   : Result := False;  // cannot stop a task that is not running
    Running: FStopped := True;
    Paused : FStopped := True; // stop the paused task
    Stopped: ;                 // already stopped, nothing to do
  end;
end;

{ TCochlearTask }

type
  TCochlearTask = class(TCustomTask)
  private
    FCallback: TProc<UInt64>;
  public
    constructor Create(const callback: TProc<UInt64>);
  end;

constructor TCochlearTask.Create(const callback: TProc<UInt64>);
begin
  inherited Create(nil, TNotifyEvent(nil), procedure
  begin
    var I := 0;
    repeat // until stopped
      // do work and call back into the creator thread if not paused
      if (TTask.CurrentTask as ICustomTask).Status <> Paused then
      begin
        Inc(I);
        with TTask.CurrentTask as TCochlearTask do if Assigned(FCallback) then FCallback(I);
      end;
      // suspend the execution of the thread for 500 miliseconds if not stopped
      if (TTask.CurrentTask as ICustomTask).Status <> Stopped then TThread.Sleep(500);
    until (TTask.CurrentTask as ICustomTask).Status = Stopped;
  end, TThreadPool.Default, nil);
  FCallback := callback;
end;

{ TFrmMain }

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FTasks[0] := TCochlearTask.Create(procedure(progress: UInt64)
  begin
    TThread.Synchronize(nil, procedure begin Label1.Caption := UIntToStr(progress) end);
  end);
  FTasks[1] := TCochlearTask.Create(procedure(progress: UInt64)
  begin
    TThread.Synchronize(nil, procedure begin Label2.Caption := UIntToStr(progress) end);
  end);
  FTasks[2] := TCochlearTask.Create(procedure(progress: UInt64)
  begin
    TThread.Synchronize(nil, procedure begin Label3.Caption := UIntToStr(progress) end);
  end);
  FTasks[3] := TCochlearTask.Create(procedure(progress: UInt64)
  begin
    TThread.Synchronize(nil, procedure begin Label4.Caption := UIntToStr(progress) end);
  end);
  FTasks[4] := TCochlearTask.Create(procedure(progress: UInt64)
  begin
    TThread.Synchronize(nil, procedure begin Label5.Caption := UIntToStr(progress) end);
  end);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  for var I := Low(FTasks) to High(FTasks) do FTasks[I].Stop;
end;

procedure TFrmMain.btnStartClick(Sender: TObject);
begin
  FTasks[(Sender as TComponent).Tag].Start;
end;

procedure TFrmMain.btnStopClick(Sender: TObject);
begin
  FTasks[(Sender as TComponent).Tag].Pause;
end;

end.
