{Author: Alexander Turenko}
program lists(INPUT, OUTPUT);
type list_type = integer; {Тип элементов списка}
     list = ^item;
     item = record
              elem:list_type;
              next:list;
              {pred:list} {Если двунаправленный}
            end;
var l1:list;

{Вернёт ссылку на новый элемент списка со значением e}
function newItem(e:list_type):list;
var l:list;
begin
  new(l);
  l^.elem:=e;
  newItem:=l;
end;

{Пустой ли список?}
function isEmpty(l:list):boolean;
begin
  isEmpty:=(l=nil)
end;

{Добавить в конец}
procedure add(var l:list; e:list_type);
var new_item:list;
begin
  new_item:=newItem(e);
  if (l<>nil) then
    l^.next:=new_item
  else l:=new_item;
end;

{Найти первый из элементов с данным значением и вернуть ссылку на него}
function search(l:list; e:list_type):list;
var searched:boolean;
begin
  search:=nil;
  searched:=false;
  while l<>nil do begin
    if ((l^.elem=e) and (not searched)) then begin
      search:=l;
      searched:=true;
    end else l:=l^.next;
  end;
end;

{Есть ли элемент с таким значением?}
function inList(l:list; e:list_type):boolean;
begin
  inList:=(search(l,e)<>nil);
end;

{Найти и удалить первый элемент с данным значением}
procedure remove(var l:list; e:list_type);
var pred_item,current_item:list;
    searched:boolean;
begin
  pred_item:=nil;
  current_item:=l;
  searched:=false;
  while current_item<>nil do begin
    if ((current_item^.elem=e) and (not searched)) then begin
      if (pred_item<>nil) then
         pred_item^.next:=current_item^.next
      else l:=current_item^.next;
      dispose(current_item);
      searched:=true;
    end else begin
      pred_item:=current_item;
      current_item:=current_item^.next;
    end;
  end;
end;

{Тут тесты всякие}
begin
l1:=newItem(5); {Сделали}
add(l1,6); {Понадобавляли}
add(l1,7);
writeln(inList(l1,4)); {Проверили}
writeln(inList(l1,5));
remove(l1,5); {Удалили}
writeln(inList(l1,5)); {Ещё раз проверили}
end.
