unit main;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Grids;

type
  TFrmMain = class(TForm)
    btnReadFromFile: TButton;
    btnGenerateRandomText: TButton;
    memo: TMemo;
    lblOr: TLabel;
    btnProcessText: TButton;
    grid: TStringGrid;
    procedure btnReadFromFileClick(Sender: TObject);
    procedure btnGenerateRandomTextClick(Sender: TObject);
    procedure btnProcessTextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  System.Character,
  System.SysUtils,
  Vcl.Dialogs;

// process the text and find all occurrences of two or more consecutive digits
function process(const text: string): TStringList;

  function add(const SL: TStringList; const digits: TArray<Integer>): string;
  begin
    Result := '';
    for var I := Low(digits) to High(digits) do Result := Result + IntToStr(digits[I]);
    const I = SL.IndexOf(Result);
    if I > -1 then
      SL.Objects[I] := TObject(Integer(SL.Objects[I]) + 1)
    else
      SL.AddObject(Result, TObject(1));
  end;

  function compare(SL: TStringList; Index1, Index2: Integer): Integer;
  begin
    // sort by number of occurrences (most frequent comes first)
    Result := Integer(SL.Objects[Index2]) - Integer(SL.Objects[Index1]);
    // in case two strings have the same number of occurrences, the one that represents a larger number should come first
    if Result = 0 then Result := StrToInt(SL[Index2]) - StrToInt(SL[Index1]);
  end;

begin
  Result := TStringList.Create;
  var digits: TArray<Integer>;
  for var I := Low(text) to High(text) do
    if text[I].IsDigit then
    begin
      const digit = StrToInt(text[I]);
      // the digits should be in ascending order and the sequence should not contain "gaps"
      if (Length(digits) > 0) and (digits[High(digits)] + 1 = digit) then
        digits := digits + [digit]
      else begin
        if Length(digits) > 1 then add(Result, digits);
        digits := [digit];
      end;
    end else begin
      if Length(digits) > 1 then add(Result, digits);
      digits := [];
    end;
  if Length(digits) > 1 then add(Result, digits);
  Result.CustomSort(@compare);
end;

{ TFrmMain }

procedure TFrmMain.btnReadFromFileClick(Sender: TObject);
begin
  const OD = TOpenDialog.Create(Self);
  try
    OD.InitialDir := ExtractFileDir(ParamStr(0));
    OD.DefaultExt := 'txt';
    OD.Filter := 'Text Files|*.txt';
    if OD.Execute then memo.Lines.LoadFromFile(OD.FileName);
  finally
    OD.Free;
  end;
end;

procedure TFrmMain.btnGenerateRandomTextClick(Sender: TObject);

  // generate random string of alphanumeric characters (warning: NOT cryptographically secure)
  function generate(const count: Integer): string;
  begin
    Randomize;
    repeat
      const I = Random(2); // digit or alpha
      if I = 0 then
        Result := Result + IntToStr(Random(10))  // [0..9]
      else
        Result := Result + Chr(97 + Random(26)); // ['a'..'z']
    until Length(Result) = count;
  end;

begin
  memo.Lines.Text := generate(400);
end;

procedure TFrmMain.btnProcessTextClick(Sender: TObject);
begin
  // output the list of found substrings and the number of their occurrences
  const SL = process(memo.Lines.Text.Trim);
  try
    grid.RowCount := SL.Count;
    for var I := 0 to Pred(SL.Count) do
    begin
      grid.Rows[I].Clear;
      grid.Rows[I].Add(SL[I]);
      grid.Rows[I].Add(IntToStr(Integer(SL.Objects[I])));
    end;
  finally
    SL.Free;
  end;
end;

end.
