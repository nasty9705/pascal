{Author: Turenko Alexander}
program queues(INPUT, OUTPUT);
type queue_type = integer; {Тип элементов очереди}
     queue = ^item;
     item = record
              elem:queue_type;
              next:queue;
            end;
var q1:queue;
    empty:queue;
    x:queue_type;
    i:integer;
    err:boolean;

procedure error(n:integer);
begin
  err:=true;
  writeln('Error. Code: ',n);
end;

procedure clear(var q:queue); {Inicialization}
var tmp:queue;
begin
  new(empty);
  while (q<>nil) do begin
    tmp:=q^.next;
    dispose(q);
    q:=tmp;
  end;
  new(q);
  q:=empty;
end;

function isEmpty(q:queue):boolean;
begin
  if (q<>nil) then
    isEmpty:=(q=empty)
  else isEmpty:=true;
end;

procedure put(var q:queue; e:queue_type);
var new_item,current_item:queue;
begin
  new(new_item);
  new_item^.elem:=e;
  new_item^.next:=nil;
  if (not isEmpty(q)) then begin
    current_item:=q;
    while (current_item^.next<>nil) do
      current_item:=current_item^.next;
    current_item^.next:=new_item;
  end else q:=new_item;
end;

procedure get(var q:queue; var e:queue_type);
var tmp:queue;
begin
  if (not isEmpty(q)) then begin
    e:=q^.elem;
    tmp:=q;
    q:=q^.next;
    dispose(tmp);
  end else error(2);
end;

begin
  clear(q1);
  writeln(isEmpty(q1));
  err:=false;
  put(q1, 1);
  clear(q1);
  put(q1, 2);
  put(q1, 3);
  put(q1, 4);
  put(q1, 5);
  writeln(isEmpty(q1));
  for i:=1 to 7 do begin
    get(q1, x);
    if err then
      err:=false
    else writeln(x);
  end;
end.