program DynamicLinkedListExample;

uses Crt;

type
  Node = record
    data: Integer;
    next: ^Node; // Используем указатель на следующий элемент
  end;

var
  head, current: ^Node; // Указатель на голову списка и текущий элемент

procedure InitializeList;
begin
  head := nil; // Инициализируем список как пустой
end;

function GetNode(data: Integer): ^Node;
var
  newNode: ^Node;
begin
  New(newNode);
  newNode^.data := data;
  newNode^.next := nil; // Новый узел указывает на nil (конец списка)
  GetNode := newNode;
end;

procedure AddNode(data: Integer);
var
  newNode, current: ^Node;
begin
  newNode := GetNode(data);

  if head = nil then
    head := newNode
  else
  begin
    current := head;
    while current^.next <> nil do
      current := current^.next;
    current^.next := newNode;
  end;
end;

procedure SubtractFromList(value: Integer);
var
  current, prev: ^Node;
begin
  current := head;
  prev := nil;

  while current <> nil do
  begin
    if current^.data = value then
    begin
      if prev = nil then
        head := current^.next
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
  current := head;
  while current <> nil do
  begin
    Write(current^.data, ' ');
    current := current^.next;
  end;
end;

procedure SearchInList(value: Integer);
var
  current: ^Node;
  found: Boolean;
begin
  current := head;
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

var
  choice, data, valueToSubtract, searchValue: Integer;

begin
  InitializeList;

  repeat
    ClrScr; // Очистка экрана перед выводом меню и списка
    DisplayMenu;
    WriteLn;
    Write('Выберите действие: ');
    ReadLn(choice);

    case choice of
      1:
      begin
        Write('Введите данные для нового элемента: ');
        ReadLn(data);
        AddNode(data);
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
      5: ; // Выход из цикла
    else
      WriteLn('Некорректный выбор. Попробуйте снова.');
      WriteLn('Нажмите Enter для продолжения...');
      ReadLn;
    end;

  until choice = 5;

  // Очистка памяти от всех узлов списка перед завершением программы
  while head <> nil do
  begin
    current := head;
    head := head^.next;
    Dispose(current);
  end;
end.
