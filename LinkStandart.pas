program DynamicStaticLinkedListExample;

uses Crt;

type
  Node = record
    data: Integer;
    next: ^Node;
  end;
//Описать как хранятся данные и как к ним обращаются
var
  headDynamic, headStatic: ^Node;
  isDynamic: Boolean;

procedure AddNodeDynamic(data: Integer);
var
  newNode, current: ^Node;
begin
  New(newNode);
  newNode^.data := data;
  newNode^.next := nil;

  if headDynamic = nil then
    headDynamic := newNode
  else
  begin
    current := headDynamic;
    while current^.next <> nil do
      current := current^.next;
    current^.next := newNode;
  end;
end;

procedure AddNodeStatic(data: Integer);
var
  newNode, current: ^Node;
begin
  New(newNode);
  newNode^.data := data;
  newNode^.next := nil;

  if headStatic = nil then
    headStatic := newNode
  else
  begin
    current := headStatic;
    while current^.next <> nil do
      current := current^.next;
    current^.next := newNode;
  end;
end;

procedure SubtractFromList(value: Integer);
var
  current, prev, temp: ^Node;
begin
  if isDynamic then
    current := headDynamic
  else
    current := headStatic;

  prev := nil;

  while current <> nil do
  begin
    if current^.data = value then
    begin
      if prev = nil then
      begin
        if isDynamic then
          headDynamic := current^.next
        else
          headStatic := current^.next;
      end
      else
        prev^.next := current^.next;

      Dispose(current);
      Break;
    end;

    prev := current;
    current := current^.next;
  end;
end;

procedure PrintList;
var
  current: ^Node;
begin
  if isDynamic then
    current := headDynamic
  else
    current := headStatic;

  while current <> nil do
  begin
    Write(current^.data, ' ');
    if isDynamic then
      current := current^.next
    else
      current := current^.next;
  end;
end;

procedure SearchInList(value: Integer);
var
  current: ^Node;
  found: Boolean;
begin
  if isDynamic then
    current := headDynamic
  else
    current := headStatic;

  found := False;

  while current <> nil do
  begin
    if current^.data = value then
    begin
      WriteLn('Число ', value, ' найдено в списке.');
      found := True;
      Break;
    end;

    current := current^.next;
  end;

  if not found then
    WriteLn('Число ', value, ' не найдено в списке.');
end;

procedure DisplayMenu;
begin
  WriteLn('1. Добавить элемент в список');
  WriteLn('2. Вывести содержимое списка');
  WriteLn('3. Вычесть число из списка');
  WriteLn('4. Поиск числа в списке');
  WriteLn('5. Выход');
end;

procedure ChooseDataTypeMenu;
begin
  WriteLn('Выберите тип данных:');
  WriteLn('1. Динамический');
  WriteLn('2. Статический');
  WriteLn;
  Write('Ваш выбор: ');
end;

var
  choice, data, valueToSubtract, searchValue, dataTypeChoice: Integer;

begin
  isDynamic := False; // По умолчанию выбран статический тип данных

  ChooseDataTypeMenu;
  ReadLn(dataTypeChoice);

  case dataTypeChoice of
    1: isDynamic := True; // Выбран динамический тип данных
    2: isDynamic := False; // Выбран статический тип данных
  else
    begin
      WriteLn('Некорректный выбор типа данных. Используется статический тип данных по умолчанию.');
      isDynamic := False; // Используется статический тип данных по умолчанию при некорректном вводе
    end;
  end;

  if isDynamic then // Инициализация головы в зависимости от выбранного типа данных
    headDynamic := nil
  else
    headStatic := nil;

  repeat
    ClrScr;
    DisplayMenu;
    WriteLn;
    Write('Выберите действие: ');
    ReadLn(choice);

    case choice of
      1:
      begin
        Write('Введите данные для нового элемента: ');
        ReadLn(data);
        if isDynamic then
          AddNodeDynamic(data)
        else
          AddNodeStatic(data);
      end;
      2:
      begin
        Write('Linked List: ');
        PrintList;
        WriteLn;
        WriteLn('Нажмите Enter для продолжения...');
        ReadLn;
      end;
      3:
      begin
        Write('Введите число для вычитания из списка: ');
        ReadLn(valueToSubtract);
        SubtractFromList(valueToSubtract);
      end;
      4:
      begin
        Write('Введите число для поиска в списке: ');
        ReadLn(searchValue);
        SearchInList(searchValue);
        WriteLn('Нажмите Enter для продолжения...');
        ReadLn;
      end;
      5: ;
    else
      WriteLn('Некорректный выбор. Попробуйте снова.');
      WriteLn('Нажмите Enter для продолжения...');
      ReadLn;
    end;

  until choice = 5;
end.