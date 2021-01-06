unit uBookSourceBean;

interface

uses
  YxdJson, Classes, SysUtils, Math;

type
  TBookSourceItem = class(JSONObject)
  private
    function GetIndexValue(const Index: Integer): string;
    procedure SetIndexValue(const Index: Integer; const Value: string);
    function GetEnable: Boolean;
    function GetSerialNumber: Integer;
    function GetWeight: Integer;
    procedure SetEnable(const Value: Boolean);
    procedure SetSerialNumber(const Value: Integer);
    procedure SetWeight(const Value: Integer);
  public
    procedure AddGroup(const Name: string);
    procedure RemoveGroup(const Name: string);
    procedure ReplaceGroup(const Name, NewName: string);
    function GetGroupList(): TArray<string>;

    property bookSourceGroup: string index 0 read GetIndexValue write SetIndexValue;  // ��Դ����
    property bookSourceName: string index 1 read GetIndexValue write SetIndexValue;   // ��Դ����
    property bookSourceUrl: string index 2 read GetIndexValue write SetIndexValue;    // ��ԴURL
    property httpUserAgent: string index 3 read GetIndexValue write SetIndexValue;    // HttpUserAgent
    property loginUrl: string index 4 read GetIndexValue write SetIndexValue;         // ��¼URL
    property ruleBookAuthor: string index 5 read GetIndexValue write SetIndexValue;   // ���߹���
    property ruleBookContent: string index 6 read GetIndexValue write SetIndexValue;  // ���Ĺ���
    property ruleBookKind: string index 7 read GetIndexValue write SetIndexValue;     // �������
    property ruleBookLastChapter: string index 8 read GetIndexValue write SetIndexValue;  // �����½ڹ���
    property ruleBookName: string index 9 read GetIndexValue write SetIndexValue;     // ��������
    property ruleBookUrlPattern: string index 10 read GetIndexValue write SetIndexValue;  // �鼮����URL����
    property ruleChapterList: string index 11 read GetIndexValue write SetIndexValue;   // Ŀ¼�б����
    property ruleChapterName: string index 12 read GetIndexValue write SetIndexValue;   // �½����ƹ���
    property ruleChapterUrl: string index 13 read GetIndexValue write SetIndexValue;    // Ŀ¼URL����
    property ruleChapterUrlNext: string index 14 read GetIndexValue write SetIndexValue;  // Ŀ¼��һҳUrl����
    property ruleContentUrl: string index 15 read GetIndexValue write SetIndexValue;      // �����½�URL����
    property ruleContentUrlNext: string index 16 read GetIndexValue write SetIndexValue;  // ������һҳURL����
    property ruleCoverUrl: string index 17 read GetIndexValue write SetIndexValue;     // �������
    property ruleFindUrl: string index 18 read GetIndexValue write SetIndexValue;      // ���ֹ���
    property ruleIntroduce: string index 19 read GetIndexValue write SetIndexValue;      // ������
    property ruleSearchAuthor: string index 20 read GetIndexValue write SetIndexValue;    // ����������߹���
    property ruleSearchCoverUrl: string index 21 read GetIndexValue write SetIndexValue;    // ��������������
    property ruleSearchKind: string index 22 read GetIndexValue write SetIndexValue;         // ��������������
    property ruleSearchLastChapter: string index 23 read GetIndexValue write SetIndexValue;  // ������������½ڹ���
    property ruleSearchList: string index 24 read GetIndexValue write SetIndexValue;   // ��������б����
    property ruleSearchName: string index 25 read GetIndexValue write SetIndexValue;   // ���������������
    property ruleSearchNoteUrl: string index 26 read GetIndexValue write SetIndexValue;  // ��������鼮URL����
    property ruleSearchUrl: string index 27 read GetIndexValue write SetIndexValue;    // �������ַ

    property enable: Boolean read GetEnable write SetEnable;
    property serialNumber: Integer read GetSerialNumber write SetSerialNumber;
    property weight: Integer read GetWeight write SetWeight;
  end;

implementation

{ TBookSourceItem }

const
  SKeyArray: array [0..27] of string = (
    'bookSourceGroup',
    'bookSourceName',
    'bookSourceUrl',
    'httpUserAgent',
    'loginUrl',
    'ruleBookAuthor',
    'ruleBookContent',
    'ruleBookKind',
    'ruleBookLastChapter',
    'ruleBookName',
    'ruleBookUrlPattern',
    'ruleChapterList',
    'ruleChapterName',
    'ruleChapterUrl',
    'ruleChapterUrlNext',
    'ruleContentUrl',
    'ruleContentUrlNext',
    'ruleCoverUrl',
    'ruleFindUrl',
    'ruleIntroduce',
    'ruleSearchAuthor',
    'ruleSearchCoverUrl',
    'ruleSearchKind',
    'ruleSearchLastChapter',
    'ruleSearchList',
    'ruleSearchName',
    'ruleSearchNoteUrl',
    'ruleSearchUrl'
  );
  SEnabled = 'enable';
  SSerialNumber = 'serialNumber';
  SWeight = 'weight';

procedure TBookSourceItem.AddGroup(const Name: string);
var
  S: string;
  List: TArray<string>;
  I: Integer;
begin
  S := Trim(bookSourceGroup);
  if S = '' then
    bookSourceGroup := Name
  else begin
    List := GetGroupList();
    for I := Low(List) to High(List) do begin
      if Trim(List[I]) = Name then
        Exit;
    end;
    bookSourceGroup := bookSourceGroup + '; ' + Name;
  end;
end;

function TBookSourceItem.GetEnable: Boolean;
begin
  Result := Self.B[SEnabled];
end;

function TBookSourceItem.GetGroupList: TArray<string>;
var
  S: string;
begin
  S := Trim(bookSourceGroup);
  Result := S.Split([',', ';', ':', '��', '��']);
end;

function TBookSourceItem.GetIndexValue(const Index: Integer): string;
begin
  Result := Self.S[SKeyArray[Index]];
end;

function TBookSourceItem.GetSerialNumber: Integer;
begin
  Result := Self.I[SSerialNumber];
end;

function TBookSourceItem.GetWeight: Integer;
begin
  Result := SElf.I[SWeight];
end;

procedure TBookSourceItem.RemoveGroup(const Name: string);
var
  S: string;
  List: TArray<string>;
  I, J: Integer;
  SB: TStringBuilder;
begin
  S := Trim(bookSourceGroup);
  if S <> '' then begin
    J := 0;
    List := GetGroupList();
    SB := TStringBuilder.Create(Length(bookSourceGroup) * 2);
    for I := Low(List) to High(List) do begin
      if Trim(List[I]) <> Name then begin
        if J > 0 then
          SB.Append('; ');
        SB.Append(Trim(List[I]));
        Inc(J);
      end;
    end;
    bookSourceGroup := SB.ToString;
  end;
end;

procedure TBookSourceItem.ReplaceGroup(const Name, NewName: string);
var
  S: string;
  List: TArray<string>;
  I, J: Integer;
  SB: TStringBuilder;
begin
  S := Trim(bookSourceGroup);
  if S <> '' then begin
    J := 0;
    List := GetGroupList();
    SB := TStringBuilder.Create(Length(bookSourceGroup) * 2);
    for I := Low(List) to High(List) do begin
      if Trim(List[I]) <> Name then begin
        if J > 0 then
          SB.Append('; ');
        SB.Append(Trim(List[I]));
        Inc(J);
      end else if NewName <> '' then begin
        if J > 0 then
          SB.Append('; ');
        SB.Append(Trim(NewName));
        Inc(J);
      end;
    end;
    bookSourceGroup := SB.ToString;
  end;
end;

procedure TBookSourceItem.SetEnable(const Value: Boolean);
begin
  Self.B[SEnabled] := Value;
end;

procedure TBookSourceItem.SetIndexValue(const Index: Integer;
  const Value: string);
begin
  Self.S[SKeyArray[Index]] := Value;
end;

procedure TBookSourceItem.SetSerialNumber(const Value: Integer);
begin
  Self.I[SSerialNumber] := Value;
end;

procedure TBookSourceItem.SetWeight(const Value: Integer);
begin
  Self.I[SWeight] := Value;
end;

end.
