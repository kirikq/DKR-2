program StaticLinkedListExample;

uses Crt;

const
  MaxNodes = 100; // Максимальное количество элементов в списке

type
  Node = record
    data: Integer;
    next: Integer;
  end;

var
  nodes: array[1..MaxNodes] of Node;
  head, freeIndex: Integer;

procedure InitializeList;
var
  i: Integer;
begin
  for i := 1 to MaxNodes do
  begin
    nodes[i].next := i + 1;
  end;
  nodes[MaxNodes].next := 0; // Последний элемент списка указывает на "свободный" индекс
  head := 0; // Голова списка пока пуста
  freeIndex := 1; // Начальный свободный индекс
end;

function GetNode: Integer;
var
  index: Integer;
begin
  index := freeIndex;
  freeIndex := nodes[freeIndex].next;
  nodes[index].next := 0; // Обнуляем указатель на следующий элемент
  GetNode := index;
end;

procedure ReleaseNode(index: Integer);
begin
  nodes[index].next := freeIndex;
  freeIndex := index;
end;

procedure AddNode(data: Integer);
var
  newNodeIndex, current: Integer;
begin
  newNodeIndex := GetNode;
  nodes[newNodeIndex].data := data;

  if head = 0 then
    head := newNodeIndex
  else
  begin
    current := head;
    while nodes[current].next <> 0 do
      current := nodes[current].next;
    nodes[current].next := newNodeIndex;
  end;
end;

procedure SubtractFromList(value: Integer);
var
  current, prev: Integer;
begin
  current := head;
  prev := 0;

  while current <> 0 do
  begin
    if nodes[current].data = value then
    begin
      if prev = 0 then
        head := nodes[current].next
      else
        nodes[prev].next := nodes[current].next;

      ReleaseNode(current);
      Break;
    end;

    prev := current;
    current := nodes[current].next;
  end;
end;

procedure PrintList;
var
  current: Integer;
begin
  current := head;
  while current <> 0 do
  begin
    Write(nodes[current].data, ' ');
    current := nodes[current].next;
  end;
end;

procedure SearchInList(value: Integer);
var
  current: Integer;
  found: Boolean;
begin
  current := head;
  found := False;

  while current <> 0 do
  begin
    if nodes[current].data = value then
    begin
      WriteLn('Число ', value, ' найдено в списке.');
      found := True;
      Break;
    end;
    current := nodes[current].next;
  end;

  if not found then
    WriteLn('Число ', value, ' не найдено в списке.');
end;

procedure DisplayMenu; //дописать блок схему
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
end.
